const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/series/main', (req, res) => {
  // 시리즈로 보기 슬라이드
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

  // 시리즈로 보기 리스트
  const listSeries = `SELECT
    ct.title_id,
    ct.title AS series_title,
    p.proposal_id,
    p.why,
    p.for_whom1,
    p.for_whom2,
    p.for_whom3,
    p.created_at
    FROM proposal p
    INNER JOIN contents_title ct ON p.title_id = ct.title_id
    ORDER BY ct.title_id, p.proposal_id`;

  connection.query(gridSeries, (err, gridResult) => {
    if (err) return res.status(500).send('gridSeries error');

    connection.query(listSeries, (err, listResult) => {
      if (err) return res.status(500).send('listSeries error');

      // 그룹핑 (gridSeries)
      const grouped = {};
      gridResult.forEach((item) => {
        const title = item.series_title;
        if (!grouped[title]) grouped[title] = [];
        grouped[title].push({ ...item });
      });

      const groupedGridSeries = Object.entries(grouped).map(
        ([title, items]) => ({
          series_title: title,
          items: items.map((item) => ({
            ...item,
            series_title: title,
          })),
        })
      );

      res.json({
        gridSeries: groupedGridSeries,
        listSeries: listResult,
      });
    });
  });
});

// router.get('/series/:seriesId', (req, res) => {
//   const pDetail = `SELECT
//     ct.title_id,
//     ct.title AS series_title,
//     p.proposal_id,
//     p.why,
//     p.for_whom1,
//     p.for_whom2,
//     p.for_whom3,
//     p.created_at
//     FROM proposal p
//     INNER JOIN contents_title ct ON p.title_id = ct.title_id
//     ORDER BY ct.title_id, p.proposal_id;`;

//   connection.query(pDetail, (err, result) => {
//     if (err) {
//       console.error('error', err.message);
//       return res.status(500).send('Database error');
//     }
//     res.json(result);
//   });
// });

router.get('/series/:seriesId', (req, res) => {
  const query = `SELECT
    contents_id,
    p.title_id,
    p.proposal_id,
    ct.title,
    sc.sub_title,
    sc.linkers,
    sc.img_url,
    sc.content_type,
    p.why,
    p.for_whom1,
    p.for_whom2,
    p.for_whom3,
    sc.created_at,
    p.created_at
    FROM
    proposal p
    LEFT JOIN series_contents sc ON p.title_id = sc.title_id
    LEFT JOIN contents_title ct ON p.title_id = ct.title_id;`;

  connection.query(query, (err, result) => {
    if (err) {
      console.error('error', err.message);
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

router.get('/series', (req, res) => {
  const page = parseInt(req.query.page) || 1;
  const limit = 10;
  const offset = (page - 1) * limit;

  const seriesTab = 'SELECT * FROM series_tab';

  // 시리즈로 보기 슬라이드
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

  // 시리즈로 보기 리스트
  const listSeries = `SELECT
    ct.title_id,
    ct.title AS series_title,
    p.proposal_id,
    p.why,
    p.for_whom1,
    p.for_whom2,
    p.for_whom3,
    p.created_at
    FROM proposal p
    INNER JOIN contents_title ct ON p.title_id = ct.title_id
    ORDER BY ct.title_id, p.proposal_id`;

  connection.query(seriesTab, (err, seriesTabResult) => {
    if (err) return res.status(500).send('seriesTab error');

    connection.query(gridSeries, [limit, offset], (err, gridResult) => {
      if (err) return res.status(500).send('gridSeries error');

      connection.query(listSeries, [limit, offset], (err, listResult) => {
        if (err) return res.status(500).send('listSeries error');

        // 그룹핑 (gridSeries)
        const grouped = {};
        gridResult.forEach((item) => {
          const title = item.series_title;
          if (!grouped[title]) grouped[title] = [];
          grouped[title].push({ ...item });
        });

        const groupedGridSeries = Object.entries(grouped).map(
          ([title, items]) => ({
            series_title: title,
            items: items.map((item) => ({
              ...item,
              series_title: title,
            })),
          })
        );

        const paginatedGrid = groupedGridSeries.slice(offset, offset + limit);

        res.json({
          seriesTab: seriesTabResult,
          gridSeries: paginatedGrid,
          listSeries: listResult,
          page,
          limit,
          totalGridCount: groupedGridSeries.length,
          totalListCount: listResult.length,
        });
      });
    });
  });
});

module.exports = router;
