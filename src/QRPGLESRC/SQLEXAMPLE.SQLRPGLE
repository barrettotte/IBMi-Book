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