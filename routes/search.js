const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/search', (req, res) => {
  const keyword =
    typeof req.query.keyword === 'string' ? req.query.keyword.trim() : '';
  const page = parseInt(req.query.page) || 1;
  const limit = 15;
  const offset = (page - 1) * limit;

  const params = keyword ? [keyword, limit, offset] : [limit, offset];

  const contentsDb = `SELECT sc.*
FROM series_contents sc
JOIN content_keywords_map ckm ON sc.title_id = ckm.contents_id
JOIN keywords k ON ckm.keyword_id = k.keyword_id
${keyword ? 'WHERE k.name = ?' : ''}
    LIMIT ? OFFSET ?
`;

  const linkerDb = `SELECT l.* FROM linker l
JOIN linker_keywords_map lkm ON l.linker_id = lkm.linker_id
JOIN keywords k ON lkm.keyword_id = k.keyword_id
${keyword ? 'WHERE k.name = ?' : ''}
    LIMIT ? OFFSET ?`;

  const proposalDb = `SELECT p.*
FROM proposal p
JOIN proposal_keywords_map pkm ON p.proposal_id = pkm.proposal_id
JOIN keywords k ON pkm.keyword_id = k.keyword_id
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
        });
      });
    });
  });
});

module.exports = router;
