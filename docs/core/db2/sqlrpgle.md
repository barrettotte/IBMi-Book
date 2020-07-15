# SQLRPGLE

One of the coolest things about RPGLE is that you can embed DB2 SQL right in your RPGLE program.
I will walkthrough the basics of interacting with DB2 easily from an RPGLE program.



## Embedding SQL
This functionality requires some slightly different compilation than regular RPGLE.
The source member type changes from **RPGLE** to **SQLRPGLE**.
When using option **14** on a source member in PDM, the source member type tells which base compile command to use.


**SQLRPGLE** uses a different compile command that invokes a SQL precompiler on the RPGLE source member.
When the SQL precompiler comes across a statement starting with ```EXEC SQL```, it essentially translates the embedded SQL statement into the RPGLE equivalent.

This is very useful because concise and clean SQL can be written instead of RPGLE.
SQL should be written as much as possible when writing new programs.


Here is an example of the syntax:
```php
exec SQL
  select col1
  into :my_var
  from sometable
  where col2=:my_condition;
```

The really cool part about this is that RPGLE variables (standalone fields and data structures) can be accessed right from the SQL statement.
This also permits the use of ```SELECT INTO``` statements into RPGLE variables.



## Example
As an example, I am going to query a system view called **SYSTABLES** located in the schema **QSYS2**.
This schema contains a bunch of handy views for all kinds of information about IBMi.

After fetching one record, I will just output a few of it's fields.

Before running the example, I setup a little table to mess around with.

```sql
create table otteb1/things (
  id int NOT NULL,
  name varchar(32) NOT NULL
);

insert into otteb1/things values
  (1, 'Breadboard'),
  (2, 'Resistor'),
  (3, 'Capacitor')
;
```


```php
**free                                                      
                                                            
ctl-opt main(main);                                         
ctl-opt option(*srcstmt:*nodebugio:*nounref) dftActGrp(*no);
                                                            
dcl-pr main extpgm('SQLEXAMPLE') end-pr;                    
                                                            
                                                            
dcl-proc main;                                              
                                                            
  dcl-ds thing qualified;                                   
    id   int(5);                                            
    name varchar(32);                                       
  end-ds;                                                   
                                                            
  dcl-s thingCount int(5) inz(*zero);                       
  dcl-s i int(5) inz(*zeros);                   
                                                
  // get size of table                          
  exec SQL                                      
    select count(*)                             
    into :thingCount                            
    from things;                                
                                                
  // this whole thing could be a cursor !       
  for i = 1 to thingCount;                         
    exec SQL                                       
      select *                                     
      into :thing                                  
      from things                                  
      where id=:i;                                 
                                                   
    dsply (%char(thing.id) + ' - ' + thing.name);  
  endfor;       
                                   
  *INLR = *on;
  return;     
end-proc;     
```

The program outputs the following:
<figure align="center">
  <img src="./core/db2/_assets/sqlrpgle-01.png" alt="sqlrpgle"/>
</figure>


As I commented, cursors are also available and definitely used quite a bit.
I just wanted to show a basic SQLRPGLE example for now. 


Hopefully, I get around to showing a more complex example in the future.
