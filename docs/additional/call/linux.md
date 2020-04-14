# IBMi ODBC on Linux

I found that the setup on Linux for me was a little odd.
Truthfully, I just screwed around with config files for an hour until I figured out what I was supposed to do...


For reference, I am using ```Ubuntu 18.04.4 LTS```.
I am assuming that setup on other distros would be similar.


## Downloads
* Install unix ODBC manager ```apt-get install unixodbc unixodbc-dev```
* Install ```ACS Linux App Pkg``` from http://ibm.biz/ibmi-odbc-download


## Verify Driver
I already had Access Client Solutions installed, but I couldn't find the right driver name to use.
This very well could have just been user error...but go ahead and verify if you feel like it.

* Find config file - ```odbcinst -j``` (mine was located at ```/etc/odbcinst.ini```)
* View config file - ```cat /etc/odbcinst.ini```

When setting up ODBC connection string, use the driver name located in the square braces.


## Example
I struggled with this in my C# implementation most recently, so I guess it will be the example.

The connection I used was defined in ```/etc/odbcinst.ini``` as:
```
[IBM i Access ODBC Driver]
Description=IBM i Access for Linux ODBC Driver
Driver=/opt/ibm/iaccess/lib/libcwbodbc.so
Setup=/opt/ibm/iaccess/lib/libcwbodbcs.so
Driver64=/opt/ibm/iaccess/lib64/libcwbodbc.so
Setup64=/opt/ibm/iaccess/lib64/libcwbodbcs.so
Threading=0
DontDLClose=1
UsageCount=1
```

So I setup an ODBC connection string as :
```cs
var conn = new OdbcConnection("Driver={IBM i Access ODBC Driver};" + String.Format(
    "System={0};Uid={1};Pwd={2}", host, user, pwd));
```

<br>

For what it's worth, I also for some reason had this link copied down:
https://www.ibm.com/support/knowledgecenter/en/SSEPGG_10.5.0/com.ibm.db2.luw.apdv.cli.doc/doc/t0061216.html



