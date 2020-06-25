# Calling IBM i with Node

Node can also use a simple ODBC connection to connect to IBM i.


## Node Packages
For this simple example, the only package we need is **odbc**.

To install with NPM, ```npm install odbc```


## Example Program
To demonstrate communicating with IBM i, we will be making a very simple node script. It will connect to IBM i, run a DB2 SQL statement, output the results, and close the connection.

This just gives a basic example to screw around with and verify the ODBC driver was successfully installed.

For this example, I just made a little JSON config file to read in my credentials. Obviously, you should never keep plaintext credentials sitting around.

```javascript
// config.json
{
  "host": "SOMEHOST",
  "user": "OTTEB"
  "pwd": ""
}
```

```javascript
// import odbc and load config json
const odbc = require('odbc');
const config = require('./config.json');

async function main(){
  const conn = `Driver=IBM i Access ODBC Driver;` +
    `System=${config['host']};UID=${config['user']};Password=${config['pwd']}`;

  // setup a pool using ODBC connection string
  const pool = await odbc.pool(conn);

  try{
    // execute the query
    const rs = await pool.query(`
      SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE 
      FROM QSYS2.SYSPARTITIONSTAT WHERE TABLE_SCHEMA = 'OTTEB1'
      ORDER BY TABLE_PARTITION
    `);

    // output the result set
    console.log(rs);

  } catch(e){
    console.log(e);
    console.error('Error occurred executing query.');
  }
}

main();

```

## Result
After executing ```node index.js```, the result set will look something like this:
```javascript
[
  {
    TABLE_SCHEMA: 'OTTEB1',
    TABLE_NAME: 'QDDSSRC',
    TABLE_PARTITION: 'ALDSPF',
    SOURCE_TYPE: 'DSPF'
  },
  {
    TABLE_SCHEMA: 'OTTEB1',
    TABLE_NAME: 'QRPGLESRC',
    TABLE_PARTITION: 'ANILIST',
    SOURCE_TYPE: 'RPGLE'
  },
  {
    TABLE_SCHEMA: 'OTTEB1',
    TABLE_NAME: 'QCLLESRC',
    TABLE_PARTITION: 'CLFIZZBUZZ',
    SOURCE_TYPE: 'CLLE'
  },
  {
    TABLE_SCHEMA: 'OTTEB1',
    TABLE_NAME: 'QCLLESRC',
    TABLE_PARTITION: 'ECHO',
    SOURCE_TYPE: 'CLLE'
  },
  {
    TABLE_SCHEMA: 'OTTEB1',
    TABLE_NAME: 'QCLLESRC',
    TABLE_PARTITION: 'FIRSTCL',
    SOURCE_TYPE: 'CLLE'
  },
  ...
]
```