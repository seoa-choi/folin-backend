const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

// GET /linker
router.get('/occupation', (req, res) => {
  // const query = 'SELECT * FROM linker';

  connection.query('SELECT * FROM occupation', (err, result) => {
    if (err) {
      console.error('에러', err.message);
      // 500: 서버 내부 에러
      return res.status(500).send('Database error');
    }
    res.json(result);
  });
});

module.exports = router;
