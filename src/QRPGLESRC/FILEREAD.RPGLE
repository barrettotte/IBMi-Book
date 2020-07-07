**free                                                      
                                                            
dcl-f inventory; // implicitly opened, closed with *INLR=*on
                                                            
read INVRECFMT;                                             
dow not %eof;                                               
  dsply (%char(ITEMID) + ' - ' + ITEMNAME +                 
          ' (' + %char(ITEMCNT) + ')');                     
  read INVRECFMT;                                           
enddo;                                                      
                                                            
*INLR = *on;                                                
return;                                                     