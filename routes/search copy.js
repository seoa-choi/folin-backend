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

  const keywordParam = keyword || '';
  const likeKeyword = `%${keywordParam}%`;

  // const contentsParams = [
  //   keywordParam, // ? = ''
  //   likeKeyword, // k.name LIKE ?
  //   likeKeyword, // ct.title LIKE ?
  //   likeKeyword, // sc.sub_title LIKE ?
  //   likeKeyword, // sc.linkers LIKE ?
  //   limit,
  //   offset,
  // ];
  const isKeyword = keyword.trim().length > 0;

  const contentsParams = isKeyword
    ? [likeKeyword, likeKeyword, likeKeyword, likeKeyword, limit, offset]
    : [limit, offset];

  const contentsNoLimitParams = [keywordParam, likeKeyword, limit, offset];
  const linkerParams = [keywordParam, likeKeyword, limit, offset];
  const proposalParams = [keywordParam, likeKeyword, limit, offset];
  // ${keyword ? 'WHERE k.name = ?' : ''}
  // ${keyword ? 'WHERE k.name LIKE CONCAT("%", ?, "%")' : ''}
  const contentsDb = `
SELECT
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
WHERE ? = '' OR (
  k.name LIKE ? OR
  ct.title LIKE ? OR
  sc.sub_title LIKE ? OR
  sc.linkers LIKE ?
)
GROUP BY sc.contents_id
LIMIT ? OFFSET ?
`;

  const contentsDbNoLimit = `SELECT 
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
WHERE ? = '' OR (
  k.name LIKE ? OR
  ct.title LIKE ? OR
  sc.sub_title LIKE ? OR
  sc.linkers LIKE ?
)
GROUP BY sc.contents_id`;

  const linkerDb = `SELECT l.linker_id,
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
WHERE ? = '' OR (
  k.name LIKE ? OR
  l.comment LIKE ? OR
  l.author LIKE ? OR
  l.affiliation LIKE ?
)
      GROUP BY l.linker_id
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
WHERE ? = '' OR (
  k.name LIKE ? OR
  ct.title LIKE ? OR
  p.for_whom1 LIKE ? OR
  p.why LIKE ?
)
    LIMIT ? OFFSET ?`;

  connection.query(contentsDb, contentsParams, (err, contentsResult) => {
    if (err)
      return res.status(500).json({
        error: 'contents error',
        contentsDb: [],
        contentsDbNoLimit: [],
        linkerDb: [],
        proposalDb: [],
        counts: {
          total: 0,
          contents: 0,
          linker: 0,
          proposal: 0,
          vod: 0,
          seminar: 0,
        },
        tabOps,
      });

    connection.query(
      contentsDbNoLimit,
      contentsNoLimitParams,
      (err, noLimitcts) => {
        if (err)
          return res.status(500).json({
            error: 'contentsNoLimit error',
            contentsDb: [],
            contentsDbNoLimit: [],
            linkerDb: [],
            proposalDb: [],
            counts: {
              total: 0,
              contents: 0,
              linker: 0,
              proposal: 0,
              vod: 0,
              seminar: 0,
            },
            tabOps,
          });

        connection.query(linkerDb, linkerParams, (err, linkerResult) => {
          if (err)
            return res.status(500).json({
              error: 'linkers error',
              contentsDb: [],
              contentsDbNoLimit: [],
              linkerDb: [],
              proposalDb: [],
              counts: {
                total: 0,
                contents: 0,
                linker: 0,
                proposal: 0,
                vod: 0,
                seminar: 0,
              },
              tabOps,
            });

          connection.query(
            proposalDb,
            proposalParams,
            (err, proposalResult) => {
              if (err)
                return res.status(500).json({
                  error: 'proposal error',
                  contentsDb: [],
                  contentsDbNoLimit: [],
                  linkerDb: [],
                  proposalDb: [],
                  counts: {
                    total: 0,
                    contents: 0,
                    linker: 0,
                    proposal: 0,
                    vod: 0,
                    seminar: 0,
                  },
                  tabOps,
                });

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
            }
          );
        });
      }
    );
  });
});

module.exports = router;
