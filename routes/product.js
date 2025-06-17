const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

// GET /product
router.get('/product', (req, res) => {
  const query = 'SELECT * FROM product ORDER BY created_at DESC';

  connection.query(query, (err, result) => {
    if (err) {
      console.error('제품정보 가져오기 에러:', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
