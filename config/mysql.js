const mysql = require('mysql2');

const connection = mysql.createPool({
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '1234',
  database: process.env.DB_NAME || 'folin_db',
  // 커넥션 풀이 가득차면 추가요청을 쌓고 기다림
  waitForConnections: true,
  // 최대 연결 수
  connectionLimit: 10,
  // 커넥션 풀이 가득차도 무제한 대기 허용
  queueLimit: 0,
});

connection.getConnection((err) => {
  if (err) console.error('mysql connection error : ' + err);
  console.log('mysql connected successfully');
});

module.exports = connection;
