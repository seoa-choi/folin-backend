// routes/index.js
const express = require('express');
const router = express.Router();

router.get('/', (req, res) => {
  res.send('서버 정상 작동 중 ✅');
});

module.exports = router;
