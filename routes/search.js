const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');
const tabOps = require('../data/tab_ops.json');

router.get('/search', (req, res) => {
  const keyword =
    typeof req.query.keyword === 'string' ? req.query.keyword.trim() : '';
  const page = parseInt(req.query.page) || 1;
  const limit = 15;
  // 페이지네이션 계산 (예: 2페이지면 15 * (2 - 1) = 15)
  const offset = (page - 1) * limit;

  const params = keyword ? [keyword, limit, offset] : [limit, offset];

  const contentsDb =
    keyword !== 'undefined' && keyword
      ? `SELECT 
  sc.contents_id,
  ct.title,
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  GROUP_CONCAT(k.name SEPARATOR ', ') AS keywords
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.contents_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id
JOIN contents_title ct ON sc.title_id = ct.title_id
${keyword ? 'WHERE k.name = ?' : ''}
GROUP BY sc.contents_id
    LIMIT ? OFFSET ?
`
      : `SELECT 
  sc.contents_id,
  ct.title,
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  GROUP_CONCAT(k.name SEPARATOR ', ') AS keywords
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.contents_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id
JOIN contents_title ct ON sc.title_id = ct.title_id
GROUP BY sc.contents_id
    LIMIT ? OFFSET ?`;

  const contentsDbNoLimit =
    keyword !== 'undefined' && keyword
      ? `SELECT 
  sc.contents_id,
  ct.title,
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  GROUP_CONCAT(k.name SEPARATOR ', ') AS keywords
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.contents_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id
JOIN contents_title ct ON sc.title_id = ct.title_id
${keyword ? 'WHERE k.name = ?' : ''}
GROUP BY sc.contents_id`
      : `SELECT 
  sc.contents_id,
  ct.title,
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  GROUP_CONCAT(k.name SEPARATOR ', ') AS keywords
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.contents_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id
JOIN contents_title ct ON sc.title_id = ct.title_id
GROUP BY sc.contents_id`;

  const linkerDb = keyword
    ? `SELECT l.linker_id,
              ANY_VALUE(l.comment) AS comment,
              ANY_VALUE(l.author) AS author,
              ANY_VALUE(l.affiliation) AS affiliation,
              ANY_VALUE(ld.image_url) AS image_url,
              ANY_VALUE(ld.author_info) AS author_info,
              ANY_VALUE(ld.created_at) AS created_at,
              GROUP_CONCAT(k.name SEPARATOR ', ') AS keywords
      FROM linker l
      JOIN linker_details ld ON l.linker_id = ld.linker_id
      JOIN linker_keywords_map lkm ON l.linker_id = lkm.linker_id
      JOIN keywords k ON lkm.keyword_id = k.keyword_id
      WHERE k.name = ?
      GROUP BY l.linker_id
      LIMIT ? OFFSET ?`
    : `SELECT l.linker_id,
              ANY_VALUE(l.comment) AS comment,
              ANY_VALUE(l.author) AS author,
              ANY_VALUE(l.affiliation) AS affiliation,
              ANY_VALUE(ld.image_url) AS image_url,
              ANY_VALUE(ld.author_info) AS author_info,
              ANY_VALUE(ld.created_at) AS created_at,
              GROUP_CONCAT(k.name SEPARATOR ', ') AS keywords
      FROM linker l
      JOIN linker_details ld ON l.linker_id = ld.linker_id
      JOIN linker_keywords_map lkm ON l.linker_id = lkm.linker_id
      JOIN keywords k ON lkm.keyword_id = k.keyword_id
      GROUP BY l.linker_id
      LIMIT ? OFFSET ?`;

  const proposalDb =
    keyword !== 'undefined' && keyword
      ? `SELECT 
  p.proposal_id,
  ct.title,
  p.created_at,
  p.for_whom1,
  p.for_whom2,
  p.for_whom3,
  p.title_id,
  p.why,
  GROUP_CONCAT(DISTINCT k.name SEPARATOR ', ') AS keywords
FROM proposal p
JOIN proposal_keywords_map pkm ON p.proposal_id = pkm.proposal_id
JOIN keywords k ON pkm.keyword_id = k.keyword_id
JOIN contents_title ct ON ct.title_id = p.title_id
GROUP BY p.proposal_id, ct.title, p.created_at, p.for_whom1, p.for_whom2, p.for_whom3, p.title_id, p.why
${keyword ? 'WHERE k.name = ?' : ''}
    LIMIT ? OFFSET ?`
      : `SELECT 
  p.proposal_id,
  ct.title,
  p.created_at,
  p.for_whom1,
  p.for_whom2,
  p.for_whom3,
  p.title_id,
  p.why,
  GROUP_CONCAT(DISTINCT k.name SEPARATOR ', ') AS keywords
FROM proposal p
JOIN proposal_keywords_map pkm ON p.proposal_id = pkm.proposal_id
JOIN keywords k ON pkm.keyword_id = k.keyword_id
JOIN contents_title ct ON ct.title_id = p.title_id
GROUP BY p.proposal_id, ct.title, p.created_at, p.for_whom1, p.for_whom2, p.for_whom3, p.title_id, p.why
    LIMIT ? OFFSET ?`;

  connection.query(contentsDb, params, (err, contentsResult) => {
    if (err) return res.status(500).send('contents error');

    connection.query(contentsDbNoLimit, params, (err, noLimitcts) => {
      if (err) return res.status(500).send('noLimit error');

      connection.query(linkerDb, params, (err, linkerResult) => {
        if (err) return res.status(500).send('linkers error');

        connection.query(proposalDb, params, (err, proposalResult) => {
          if (err) return res.status(500).send('proposal error');

          res.json({
            contentsDb: contentsResult,
            contentsDbNoLimit: noLimitcts,
            linkerDb: linkerResult,
            proposalDb: proposalResult,
            counts: {
              total:
                contentsResult.length +
                linkerResult.length +
                proposalResult.length,
              contents: contentsResult.length,
              linker: linkerResult.length,
              proposal: proposalResult.length,
              vod: 0,
              seminar: 0,
            },
            tabOps,
          });
        });
      });
    });
  });
});

module.exports = router;
