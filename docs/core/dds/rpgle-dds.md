# RPGLE and Files

Now that some background knowledge of files has been provided. 
I can show some very basic examples of file operations in RPGLE.

I only outline how to open a physical file, but the same technique will apply to logical files.


## Example DDS
This is the DDS for a physical file I will use for all the examples below.

```php
     A          R INVRECFMT                 TEXT('Inventory Record')
     A*                                                             
     A            ITEMID         5S 0       COLHDG('ITEM ID')       
     A            ITEMNAME      16A         COLHDG('ITEM NAME')     
     A            ITEMCNT        3S 0       COLHDG('ITEM COUNT')    
     A*                                                             
     A          K ITEMID                                            
```


## Reading Records
This is an example of a basic read loop over records in a file.

```php
**free                                                      
                                                            
dcl-f inventory; // implicitly opened, closed with *INLR=*on
                                                            
read INVRECFMT;                                             
dow not %eof;                                               
  dsply (%char(ITEMID) + ' - ' + ITEMNAME + ' (' + %char(ITEMCNT) + ')');                     
  read INVRECFMT;                                           
enddo;                                                      
                                                            
*INLR = *on;                                                
return;                                                     
```


## Searching For a Record. the Hard way
This is an example of how searching records was typically done at an earlier point in time of RPG's life.
```SETLL``` (set lower limit) is used to set the file pointer to the first occurrence of a record with the matching key.
```READE``` (read equal key) is used to read a matching record and advances the file pointer.

I wouldn't suggest using this to write new RPGLE, but you may come across some older code like this.

```php
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
```


## Searching for a Record, the Easier Way
File chains are a really easy way to search a file for a certain key.

It's worth noting that this is not the only way to search a file by key.
There is also a concept known as 'KEYFIELDS', but I will not be covering it.

```php
**free                          
                                
dcl-f inventory keyed;          
                                
dcl-s id like(ITEMID);          
                                
id = 1;                         
chain (id) INVRECFMT;           
                                
if not %found;                  
  dsply ('Record not found');   
else;                           
  dsply ('Did not find record');
endif;                          
                                
*inlr = *on;                    
return;
```