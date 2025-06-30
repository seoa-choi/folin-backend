const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

// 메인에 필요한 데이터, 상단에 둬야 id로 인식 안함
router.get('/article/main', (req, res) => {
  const pDetail = `SELECT
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
    ORDER BY ct.title_id, p.proposal_id;`;

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
    ORDER BY ct.title_id, sc.contents_id`;

  connection.query(pDetail, (err, result) => {
    if (err) {
      console.error('error', err.message);
      return res.status(500).send('Database error');
    }

    connection.query(articleSeries, (err, articleResult) => {
      if (err) {
        console.error('error', err.message);
        return res.status(500).send('Database error');
      }
      res.json({ result, articleResult });
    });
  });
});

router.get('/article/:articleId', (req, res) => {
  const articleSeries = `
SELECT
  ct.title_id,
  ct.title AS series_title,
  sc.contents_id,
  sc.sub_title,
  sc.img_url,
  sc.created_at,
  cd.sentence1,
  cd.sentence2,
  cd.sentence3,
  cd.h3,
  cd.p,
  l.linker_id,
  l.author,
  l.affiliation,
  ld.image_url AS linker_details_img_url
FROM contents_title ct
JOIN series_contents sc ON ct.title_id = sc.title_id
LEFT JOIN contents_linker_map clm ON sc.contents_id = clm.contents_id
LEFT JOIN linker l ON clm.linker_id = l.linker_id
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
LEFT JOIN contents_detail cd ON sc.contents_id = cd.contents_id
WHERE sc.content_type = 'article'
ORDER BY ct.title_id, sc.contents_id, l.linker_id;`;

  connection.query(articleSeries, (err, result) => {
    if (err) {
      console.error('error', err.message);
      return res.status(500).send('Database error');
    }
    const grouped = {};

    result.forEach((row) => {
      const id = row.contents_id;

      if (!grouped[id]) {
        grouped[id] = {
          contents_id: id,
          sub_title: row.sub_title,
          img_url: row.img_url,
          created_at: row.created_at,
          series_title: row.series_title,
          detail: {
            sentence1: row.sentence1,
            sentence2: row.sentence2,
            sentence3: row.sentence3,
            h3: row.h3,
            p: row.p,
          },
          linkers: [],
        };
      }

      // 중복 링커 방지
      if (
        row.linker_id &&
        !grouped[id].linkers.some((l) => l.linker_id === row.linker_id)
      ) {
        grouped[id].linkers.push({
          linker_id: row.linker_id,
          author: row.author,
          affiliation: row.affiliation,
          image_url: row.linker_details_img_url,
        });
      }
    });

    const finalList = Object.values(grouped);

    res.json(finalList);
  });
});

// router.get('/article/:articleId', (req, res) => {
//   const articleSeries = `
//     SELECT
//     ct.title_id,
//     ct.title AS series_title,
//     sc.contents_id,
//     sc.sub_title,
//     sc.linkers,
//     sc.img_url,
//     sc.content_type,
//     sc.created_at
//     FROM series_contents sc
//     INNER JOIN contents_title ct ON sc.title_id = ct.title_id
//     WHERE sc.content_type = 'article'
//     ORDER BY ct.title_id, sc.contents_id`;

//   connection.query(articleSeries, (err, result) => {
//     if (err) {
//       console.error('error', err.message);
//       return res.status(500).send('Database error');
//     }
//     res.json(result);
//   });
// });

//
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
