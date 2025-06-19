const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

// GET /linker
router.get('/linker', (req, res) => {
  const occupation = req.query.occupation || '전체';
  // 페이지 번호
  const page = parseInt(req.query.page) || 1;
  // 한 페이지 데이터 개수
  const limit = 12;
  // 페이지네이션 오프셋 계산
  const offset = (page - 1) * limit;

  // occupation 값이 전체 아닐 경우 WHERE 조건 적용
  const totalCountSql =
    occupation && occupation !== '전체'
      ? `
      SELECT COUNT(*) AS totalCount
      FROM linker l
      LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
      LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
      WHERE o.occupation = ?;
    `
      : `
      SELECT COUNT(*) AS totalCount
      FROM linker l
      LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
      LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id;
    `;

  // 코멘트 있는 데이터 가져오기
  const sqlWithComment = `SELECT l.*, o.occupation, ld.image_url, ld.author_info
FROM linker l
LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
WHERE l.comment IS NOT NULL AND LENGTH(TRIM(l.comment)) > 0
ORDER BY l.created_at DESC;`;

  // 코멘트 없는 데이터 가져오기
  const sqlNoComment =
    occupation && occupation !== '전체'
      ? `
      SELECT l.*, o.occupation, ld.image_url, ld.author_info
      FROM linker l
      LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
      LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
      WHERE o.occupation = ? AND (l.comment IS NULL OR LENGTH(TRIM(l.comment)) = 0)
      ORDER BY l.created_at DESC
      LIMIT ? OFFSET ?;
    `
      : `
      SELECT l.*, o.occupation, ld.image_url, ld.author_info
      FROM linker l
      LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
      LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id
      WHERE (l.comment IS NULL OR LENGTH(TRIM(l.comment)) = 0)
      ORDER BY l.created_at DESC
      LIMIT ? OFFSET ?;
    `;

  // SQL 실행 전에 occupation 값 확인
  console.log('Executing SQL:', sqlWithComment);
  console.log(
    'Values for SQL:',
    occupation !== '전체' ? [occupation, limit, offset] : [limit, offset]
  );

  connection.query(
    totalCountSql,
    occupation && occupation !== '전체' ? [occupation] : [],
    (err, totalResult) => {
      if (err) {
        console.error('Query Execution Error:', err);
        return res.status(500).json({ error: 'Query Error', details: err });
      }

      const totalCount = totalResult[0]?.totalCount || 0;

      connection.query(
        sqlWithComment,
        occupation && occupation !== '전체'
          ? [occupation, limit, offset]
          : [limit, offset],
        (err, withCommentResult) => {
          if (err) {
            console.error('Query Execution Error:', err);
            return res.status(500).json({ error: 'Query Error', details: err });
          }

          connection.query(
            sqlNoComment,
            occupation && occupation !== '전체'
              ? [occupation, limit, offset]
              : [limit, offset],
            (err, noCommentResult) => {
              if (err) {
                console.error('Query Execution Error:', err);
                return res
                  .status(500)
                  .json({ error: 'Query Error', details: err });
              }

              res.json({
                withComment: withCommentResult || [],
                noComment: noCommentResult || [],
                totalCount,
              });
            }
          );
        }
      );
    }
  );
});

module.exports = router;
