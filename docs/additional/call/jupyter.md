# Calling IBM i with Jupyter Notebooks

This will be very similar to the Python example I wrote.
The only thing that's different is setting up a basic utility notebook.
This example is based off of a DEV post I did, [Jupyter Notebooks + IBMi](https://dev.to/barrettotte/jupyter-notebooks-ibmi-547g)

**This page assumes you are at least a little familiar with Jupyter Notebooks**.


## ODBC
This example uses the **pyodbc** module, which requires the **IBM i Access ODBC Driver** to be setup on your operating system. I made the pages **Windows ODBC** and **Linux ODBC** to go over setting up the ODBC driver in this section. Please read through them if you have not setup your IBMi ODBC driver yet.


## Connection String
In a notebook you can setup a pyodbc connection as expected.

This is slightly different than a lot of the google searches you'll find when trying to setup DB2 + python.
If you already read the page **With Python** in this section, this should look familiar.

```
conn = pyodbc.connect(driver='{IBM i Access ODBC Driver}', system=host, uid=user, pwd=pwd)
```


## Small Utility Notebook
To make it even easier to work with IBMi on Jupyter I made a little utility notebook at https://github.com/barrettotte/IBMi-Jupyter. I encourage you to steal this code and make something awesome with it.


The utility notebook adds **cell magic** to call DB2 for i; invoked using ```%%ibmi```.
To use the utility notebook in another notebook use ```%run <path-to>/IBMi.ipynb```

This utility also takes care of logging in
<figure align="center">
	<img src="./additional/call/_assets/jupyter-03.png" alt="jupyter login" />
</figure>
<br>


## Example 1
```
%%ibmi

select TABLE_SCHEMA || '/' || TABLE_NAME as TABLE_NAME, TABLE_TEXT
from QSYS2.SYSTABLES
where TABLE_SCHEMA='QSYS'
limit 10;
```

<figure align="center">
	<img src="./additional/call/_assets/jupyter-01.png" alt="jupyter example 1" />
</figure>
<br>


## Example 2
```
%%ibmi -plotpie

select SOURCE_TYPE, count(SOURCE_TYPE) as TOTAL
from QSYS2.SYSPARTITIONSTAT
where TABLE_SCHEMA='BOLIB'
    and SOURCE_TYPE is not null
group by SOURCE_TYPE;
```

<figure align="center">
	<img src="./additional/call/_assets/jupyter-02.png" alt="jupyter example 2" />
</figure>
<br>