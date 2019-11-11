# Calling IBM i with ColdFusion

Against my better judgement, I will show how to call IBM i with Adobe ColdFusion 11.
This was the language I used when I first communicated with IBM i, so I figured I'd give it a little respect
even though I despise working with it.

**This assumes that you have a ColdFusion environment setup and somewhat know what you're doing with it**.


## Example Program
To demonstrate communicating with IBM i, we will be making a very simple CFML page.
It will connect to IBM i, run a DB2 SQL statement, and output the results.

The SQL execution will return a resultset of source members found in all PFs within a targeted library.

This uses the JT400 jar and **Adobe Coldfusion 11**.

I assume that this will be very similar if not the same in **Lucee** or later Adobe Coldfusion versions. 
However, on the rest of this page I am in an Adobe ColdFusion context.


## Setup
Welp, sorry I don't really want to go into detail about setting up a ColdFusion server.
Not because I can't, but because I simply don't want to (I'm not a fan of ColdFusion at all).

Download the JT400 jar from http://jt400.sourceforge.net/

To make sure you can use a JDBC connection with IBM i, make sure you place the JT400 jar in
whatever directory you use for your local ColdFusion server. In my case it was ```ColdFusion11/MyUser/lib/```.


Configure your ColdFusion admin datasource at ```yourserver/CFIDE/administrator/index.cfm```.
Go to ```DATA & SERVICES > Data Sources```, click **Add**, and fill out something similar to the following:
<figure align="center">
	<img src="./additional/call/_assets/cf-01.PNG" alt="cf admin" />
</figure>
<br>

Now you should be able to click **Submit** and hopefully that's all the setup you need.

If not, well... god speed.


## CFML Page
So I don't stay in ColdFusion any longer than I have to, I will just be dumping the result of IBM i call to the screen
in a simple CFML file ```index.cfm```.

I'm not going to go into too much detail since its fairly basic. 
The hardest part is going to be setting up the ColdFusion server to work correctly.

```html
<!-- index.cfm -->

<html>
    <body>
        <h2>Calling IBM i with ColdFusion</h2>
        <hr>
        <cfscript>
            local.sql = "
                SELECT TABLE_SCHEMA, TABLE_NAME, TABLE_PARTITION, SOURCE_TYPE
                FROM QSYS2.SYSPARTITIONSTAT
                WHERE TABLE_SCHEMA = 'YOURLIB' -- CHANGE ME
                ORDER BY TABLE_PARTITION
            ";

            local.query = new Query();
            local.query.setDataSource("IBMi");
            local.result = local.query.execute(sql=local.sql);

            writeDump(local.result);
        </cfscript>
    </body>
</html>
```

## Result
Depending on the ColdFusion version you're using you'll probably see something different.
But, it should roughly return something like this:

<figure align="center">
	<img src="./additional/call/_assets/cf-02.PNG" alt="cf result" />
</figure>

