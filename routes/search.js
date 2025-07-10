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

  const contentsDb = `SELECT 
  sc.contents_id,
  ct.title,                 
  sc.sub_title,
  sc.linkers,
  sc.img_url,
  sc.content_type,
  k.name AS keyword        
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.contents_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id
JOIN contents_title ct ON sc.title_id = ct.title_id
${keyword ? 'WHERE k.name = ?' : ''}
    LIMIT ? OFFSET ?
`;

  const linkerDb = `SELECT l.* FROM linker l
JOIN linker_keywords_map lkm ON l.linker_id = lkm.linker_id
JOIN keywords k ON lkm.keyword_id = k.keyword_id
${keyword ? 'WHERE k.name = ?' : ''}
    LIMIT ? OFFSET ?`;

  const proposalDb = `SELECT 
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
    LIMIT ? OFFSET ?`;

  connection.query(contentsDb, params, (err, contentsResult) => {
    if (err) return res.status(500).send('contents error');

    connection.query(linkerDb, params, (err, linkerResult) => {
      if (err) return res.status(500).send('linkers error');

      connection.query(proposalDb, params, (err, proposalResult) => {
        if (err) return res.status(500).send('proposal error');

        res.json({
          contentsDb: contentsResult,
          linkerDb: linkerResult,
          proposalDb: proposalResult,
          tabOps,
        });
      });
    });
  });
});

module.exports = router;
