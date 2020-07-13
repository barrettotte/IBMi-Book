# RPGLE and DSPFs

Now that DSPFs have been introduced, I will show a basic example of using RPGLE and DSPFs together.


## DSPF (Frontend)
This DSPF will be very similar to the one shown in the example, but with some extra stuff.
Most of the attention in this section should be given to the RPGLE program.

At the top of the screen, I added the current date and the RPGLE program name.

```
     A* PERSON ENTRY                                          
     A*                                                                
     A                                      INDARA                     
     A*=============================================================== 
     A*                                                                
     A          R #PRSRCD1                   TEXT('MAIN RECORD FORMAT')
     A* COMMANDS...................................................... 
     A                                      CA03(03 'EXIT')            
     A                                      CA05(05 'REFRESH')         
     A* FIELDS........................................................ 
     A*                                                                
     A* PGM NAME                                                       
     A            ##PGM         10A     1  2TEXT('*PROGRAM')           
     A                                      COLOR(BLU)                 
     A* DATE                                                           
     A                                  1 63DATE                       
     A                                      EDTWRD('  /  /  ') 
     A* SCREEN TITLE                                           
     A                                  2 32'PERSON ENTRY'     
     A                                      DSPATR(HI)         
     A* NAME                                                   
     A                                  6  4'NAME............' 
     A            #1NAME        16A  B  6 24TEXT('NAME')       
     A* AGE                                                    
     A                                  7  4'AGE.............' 
     A            #1AGE          3D  B  7 24TEXT('AGE')                
     A* MESSAGE                                                        
     A            #1MSG         79A  O 24  1DSPATR(HI)                 
     A*                                                                
     A*=============================================================== 
     A                                 23  2'F3=EXIT  F5=REFRESH '     
     A                                      COLOR(BLU)                 
     A*                                                                
```


## RPGLE (Backend)
I use a template similar to this for every DSPF program I do at work. For the most part, it works out well.

The RPGLE program does the following:
* Opens display file
* Loops in display file, accepting commands (F3,F5,etc)
* Processes the input
* Closes display file

Additionally, I use PSDS to fill out the DSPF's program name field. This is very useful for determining which program is linked to a DSPF.


```php
**free                                                      
                                                            
ctl-opt main(main);                                         
ctl-opt option(*srcstmt:*nodebugio:*nounref) dftActGrp(*no);
                                                            
dcl-f PERSONDSPF workstn indDs(dspf) usropn;                

dcl-ds dspf qualified;                                      
  exit    ind pos(3);                                       
  refresh ind pos(5);                                       
end-ds;                                                     
                                                            
dcl-ds pgmDs PSDS qualified;                                
  procName *proc;                                           
end-ds;                                                     
                                                                 
dcl-pr main extpgm('DSPFPGM2') end-pr;                           
                                                                 
dcl-proc main;                                                   
  monitor;                                                       
    open PERSONDSPF;                                             
    dspfHandler();                                               
    close PERSONDSPF;                                            
  on-error *file;                                                
    dsply ('Error opening display file.');                       
  endmon;                                                        
                                                                 
  *INLR = *on;                                                   
  return;                                                        
end-proc;                                                        
                                                                 
                                                                 
// display file loop                                             
dcl-proc dspfHandler;                                            
                                                                  
  monitor;                                                        
    ##PGM = pgmDs.procName;                                       
    resetScreen();                                                
                                                                  
    doU (dspf.exit);                                              
      exfmt #PRSRCD1;                                             
                                                                  
      if (dspf.exit);                                             
        resetScreen();                                            
        leave;                                                    
      elseif (dspf.refresh);                                      
        resetScreen();                                            
      elseif (#1NAME <> *blanks and #1AGE <> *blanks);            
        #1MSG = 'Entered person: "' + %trim(#1NAME) + '"';        
      else;                                                       
        #1MSG = 'Please fill out all fields';                     
      endif;                                                      
    enddo;                                                        
  on-error;                                                       
    #1MSG = 'Unexpected error occurred handling display file';    
  endmon;                                                         
end-proc;                                                         
                                                                  
                                                                  
// reset fields on screen and any other reset logic                                    
dcl-proc resetScreen;     
  clear #1MSG;                                                         
  clear #1AGE;                                                         
  clear #1NAME;                                                        
end-proc;                                                              
                                                                                                               
```


## Compilation
A quick note on compiling. Every time the DSPF is recompiled, the RPGLE that uses it must also be recompiled.
If you don't recompile the RPGLE, you might get a "level check" error or something similar.


## Using the Program
Try not to laugh too much at how scuffed this screen looks. IBMi veterans could probably make a much better example program.
I just wanted to throw something together to show basic RPGLE interaction.

Upon calling our RPGLE program, this is the initial screen.

<figure align="center">
  <img src="./core/dds/_assets/dspf-03.png" alt="DSPF"/>
</figure>
<br>


If enter is pressed with no input, we get a message telling the user to enter data.
<figure align="center">
  <img src="./core/dds/_assets/dspf-04.png" alt="DSPF"/>
</figure>
<br>

If I try to enter anything other than a numeric in the age field, I get a message:
<figure align="center">
  <img src="./core/dds/_assets/dspf-06.png" alt="DSPF"/>
</figure>
<br>

After entering both fields, pressing enter gives us a confirmation message.

<figure align="center">
  <img src="./core/dds/_assets/dspf-05.png" alt="DSPF"/>
</figure>
<br>


Pressing F3 leaves the program and pressing F5 clears all fields.


## Conclusion
This is a very shallow introduction to the world of DSPFs. There is much much more to learn, but this is a decent start for now.
