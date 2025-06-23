const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/series', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = 10;
  const offset = (page - 1) * limit;

  const seriesTab = 'SELECT * FROM series_tab';

  const gridSeries = `
    SELECT
    ct.title_id,
    ct.title AS series_title,
    sc.contents_id,
    sc.sub_title,
    sc.linkers,
    sc.img_url,
    sc.content_type,
    sc.created_at
    FROM series_contents sc
    INNER JOIN contents_title ct ON sc.title_id = ct.title_id
    ORDER BY ct.title_id, sc.contents_id`;

  connection.query(seriesTab, (err, seriesResult) => {
    if (err) {
      console.error('에러:', err.message);
      return res.status(500).send('Database error');
    }

    connection.query(gridSeries, [limit, offset], (err, gridResult) => {
      if (err) {
        console.error('에러:', err.message);
        return res.status(500).send('Database error');
      }

      // 시리즈 타이틀 기준으로 묶기
      const grouped = {};
      gridResult.forEach((item) => {
        const title = item.series_title;
        if (!grouped[title]) {
          grouped[title] = [];
        }
        grouped[title].push({
          contents_id: item.contents_id,
          sub_title: item.sub_title,
          linkers: item.linkers,
          img_url: item.img_url,
          content_type: item.content_type,
          created_at: item.created_at,
        });
      });

      const groupedSeries = Object.entries(grouped).map(([title, items]) => ({
        series_title: title,
        items: items.map((item) => ({
          ...item,
          series_title: title,
        })),
      }));

      const paginatedSeries = groupedSeries.slice(offset, offset + limit);

      res.json({
        seriesTab: seriesResult,
        gridSeries: paginatedSeries,
        page,
        limit,
        totalCount: groupedSeries.length,
      });
    });
  });
});

module.exports = router;
