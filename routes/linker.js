const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

// GET /linker
router.get('/linker', (req, res) => {
  // const query = 'SELECT * FROM linker';

  connection.query(
    `SELECT 
    l.linker_id, l.comment, l.author, l.affiliation, l.created_at,
    o.occupation,
    ld.image_url, ld.author_info
FROM linker l
LEFT JOIN occupation o ON l.occupation_id = o.occupation_id
LEFT JOIN linker_details ld ON l.linker_id = ld.linker_id`,
    (err, result) => {
      if (err) {
        console.error('에러', err.message);
        // 500: 서버 내부 에러
        return res.status(500).send('Database error');
      }
      res.json(result);
    }
  );
});

module.exports = router;
