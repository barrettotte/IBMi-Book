const odbc = require('odbc');
const config = require('./config.json');

async function main(){
  const conn = `Driver=IBM i Access ODBC Driver;` +
    `System=${config['host']};UID=${config['user']};Password=${config['pwd']}`;

  const pool = await odbc.pool(conn);

  try{
    const rs = await pool.query(`
      SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE 
      FROM QSYS2.SYSPARTITIONSTAT WHERE TABLE_SCHEMA = 'OTTEB1'
      ORDER BY TABLE_PARTITION
    `);
    console.log(rs);
  } catch(e){
    console.log(e);
    console.error('Error occurred executing query.');
  }
}

main();
