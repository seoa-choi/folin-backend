const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/article_info', (req, res) => {
  const sql = `
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
  l.affiliation
FROM series_contents sc
JOIN contents_title ct ON sc.title_id = ct.title_id
JOIN contents_detail cd ON sc.contents_id = cd.contents_id
JOIN contents_linker_map clm ON sc.contents_id = clm.contents_id
JOIN linker l ON clm.linker_id = l.linker_id
WHERE sc.content_type = 'article'
ORDER BY sc.contents_id, l.linker_id;
  `;

  connection.query(sql, (err, results) => {
    if (err) {
      console.error('DB 오류:', err.message);
      return res.status(500).send('DB error');
    }

    const contentsById = {};

    results.forEach((row) => {
      const id = row.contents_id;
      if (!contentsById[id]) {
        contentsById[id] = {
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

      if (
        !contentsById[id].linkers.some(
          (linker) => linker.linker_id === row.linker_id
        )
      ) {
        contentsById[id].linkers.push({
          linker_id: row.linker_id,
          author: row.author,
          affiliation: row.affiliation,
        });
      }
    });

    const finalList = Object.values(contentsById);
    res.json(finalList);
  });
});

module.exports = router;
