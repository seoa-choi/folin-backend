const express = require('express');
const router = express.Router();
const connection = require('../config/mysql');

router.get('/search', (req, res) => {
  const keyword = req.query.keyword;
  const page = parseInt(req.query.page) || 1;
  const limit = 15;
  const offset = (page - 1) * limit;
});
