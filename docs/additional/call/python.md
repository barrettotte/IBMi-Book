# Calling IBM i with Python

Python can use a simple ODBC connection to connect to IBM i.


## Python Module(s)
The only required module for this example program, is **pyodbc**.
This is a generic ODBC module for Python. Read more at https://github.com/mkleehammer/pyodbc/wiki

To install with pip, ```pip3 install pyodbc```.


## Example Program
To demonstrate communicating with IBM i, we will be making a very simple python script.
It will connect to IBM i, run a DB2 SQL statement, output the results, and close the connection.

This just gives a basic example to screw around with and verify the ODBC driver was successfully installed.

I usually make a basic **config.json** to hold my host/user properties and I input my password each time.
```javascript
// config.json

{
  "host": "SOMEHOST",
  "user": "OTTEB"
}
```


```python
# example.py

import os, json, getpass, pyodbc

# Get credentials
with open(os.path.abspath('config.json'), 'r') as f:
    config = json.load(f)
    host = config['host'] if 'host' in config else input("Enter host: ")
    user = config['user'] if 'user' in config else input("Enter user: ")
    pwd  = getpass.getpass('Enter password: ')

# Init ODBC connection and cursor
conn = pyodbc.connect(driver='{IBM i Access ODBC Driver}', system=host, uid=user, pwd=pwd)
csr = conn.cursor()
try:
    # Execute SQL string
    csr.execute(' '.join([
        "SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE",
        "FROM QSYS2.SYSPARTITIONSTAT WHERE TABLE_SCHEMA = 'BOLIB'",
        "ORDER BY TABLE_PARTITION"
    ]))
    # Output result set
    for row in csr: 
        print(row)

except Exception as e:
    print('Error occurred with DB2 query\n  ' + str(e))
finally:
    # Close cursor and ODBC connection
    csr.close()
    conn.close()

```

## Result
Executing with ```python3 example.py```, I get my expected result set.
```
('BOLIB', 'QCLLESRC', 'BASHTEST', 'CLLE')
('BOLIB', 'QCLLESRC', 'CLPOPUP', 'CLLE')
('BOLIB', 'QRPGLESRC', 'FIZZBUZZ', 'RPGLE')
('BOLIB', 'QSQDSRC', 'GENINSJSON', None)
('BOLIB', 'QSQDSRC', 'GETDSPFFD', None)
('BOLIB', 'QRPGSRC', 'HELLORPG', 'RPG')
('BOLIB', 'QSQLSRC', 'INVENTORY', 'SQL')
('BOLIB', 'QMISRC', 'MI01', 'MI')
('BOLIB', 'MYTABLE', 'MYTABLE', None)
('BOLIB', 'QDDSSRC', 'PERSON', 'PF')
('BOLIB', 'QDDSSRC', 'PERSONL1', 'LF')
('BOLIB', 'QDDSSRC', 'PERSONL2', 'LF')
('BOLIB', 'QDDSSRC', 'PERSONL3', 'LF')
('BOLIB', 'QRPGLESRC', 'PGMCALL', 'RPGLE')
('BOLIB', 'QCLLESRC', 'SYSINFO', 'CLLE')
('BOLIB', 'QCLSRC', 'TESTMI01', 'CLP')
('BOLIB', 'QCLLESRC', 'TESTPCCMD', 'CLLE')
('BOLIB', 'QRPGLESRC', 'TESTPOPUP', 'RPGLE')
('BOLIB', 'TODOLIST', 'TODOLIST', None)
('BOLIB', 'QDDSSRC', 'TODOLIST', None)
('BOLIB', 'QDDSSRC', 'TODO00S', None)
```
