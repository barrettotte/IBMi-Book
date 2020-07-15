# Introduction to DB2 for i

One of the most important features of IBMi is its builtin database, DB2 for i.
Its worth noting that DB2 for i differs slightly from other flavors of DB2.

When searching for snippets or documentation its important to qualify your search with something like 'IBMi'.
Its worth noting that DB2 SQL is constantly getting new system views and functions with every IBMi update.
So pay close attention to what version of OS you are using when searching around.

On this page, I will go over the basics of some of the tools included in Access Client Solutions.


## Run SQL Scripts
From the Access Client Solutions menu, click **Run SQL Scripts** under the **Database** heading.
This gives you a nice and simple SQL window to run queries.

For example, I will run a simple query to get some IBMi system tables:
```sql
select *
from QSYS2.SYSTABLES
where TABLE_SCHEMA='QSYS'
  and TABLE_OWNER='QSYS'
limit 50;
```

To run this query, I usually use **CTRL + R**. This will execute the statement that your cursor is currently positioned in.

<figure align="center">
  <img src="./core/db2/_assets/index.png" alt="DB2 index"/>
</figure>



## Schemas Tool
Another tool that might be worth remembering is the Schemas tool.
From the Access Client Solutions menu, click **Schemas** under the **Database** heading.

This gives you an interface to look at various database objects. 

<figure align="center">
  <img src="./core/db2/_assets/acs-schemas.png" alt="schemas"/>
</figure>



## IBM Documentation
As always, IBM's documentation is going to be better than my writing.

* DB2 for i SQL Reference - https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_72/db2/rbafzintro.htm