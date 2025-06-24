const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/article', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = 30;
  const offset = (page - 1) * limit;

  const seriesTab = 'SELECT * FROM series_tab';

  // 전체 데이터 개수
  const countQuery = `
    SELECT COUNT(*) AS totalCount
    FROM series_contents sc
    INNER JOIN contents_title ct ON sc.title_id = ct.title_id
    WHERE sc.content_type = 'article'
  `;

  // 시리즈 슬라이드랑 같음, 아티클은 묶지 않음, 전체 데이터
  const articleSeries = `
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
    WHERE sc.content_type = 'article'
    ORDER BY ct.title_id, sc.contents_id
    LIMIT ? OFFSET ?`;

  connection.query(seriesTab, (err, seriesResult) => {
    if (err) {
      console.error('Tab에러:', err.message);
      return res.status(500).send('Database error');
    }

    connection.query(countQuery, (err, countResult) => {
      if (err) {
        console.error('count 에러: ', err.message);
        return res.status(500).send('Database error (count)');
      }
      const totalCount = countResult[0]?.totalCount || 0;

      connection.query(articleSeries, [limit, offset], (err, articleResult) => {
        if (err) {
          console.error('아티클 에러:', err.message);
          return res.status(500).send('Database error');
        }

        res.json({
          seriesTab: seriesResult,
          articleSeries: articleResult,
          page,
          limit,
          totalCount,
        });
      });
    });
  });
});

module.exports = router;
