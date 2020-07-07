**free                                         
                                               
dcl-f inventory keyed;                         
                                               
dcl-s id like(ITEMID);                         
id = 1;                                        
                                               
// set file pointer                            
setll (id) INVRECFMT;                          
                                               
// read equal key, advance file pointer to next
reade (id) INVRECFMT;                          
                                               
if not %found;                                 
  dsply ('Record not found');                  
else;    
  dsply ('Did not find record');
endif;                          
                                
*inlr = *on;                    
return; 