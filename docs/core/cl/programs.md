## Small Example Programs

Since I'm probably awful at teaching, here is where I leverage the good ole "learn by example" tactic.

I'll gradually add more as I create them.



## Basic Job / Network Information

This program shows off a couple of useful commands, 
**RTVJOBA** (Retrieve Job Attributes) and **RTVNETA** (Retrieve Network Attributes) that expose a lot of cool data.

In this case I grab job name, user id, job number, and system name with two commands.
For a prettier output, I concatenate job name, user id, and job number to the format **12345/SOMEUSER/SOMEJOB**.
Finally, all I do is output everything I gathered to the console.

Nothing special, but I thought it was a good example to kick around.

More information on these commands can be found here:
  * RTVJOBA - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_71/cl/rtvjoba.htm
  * RTVNETA - https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/cl/rtvneta.htm

```php
PGM                                                     
  DCL VAR(&username) TYPE(*CHAR) LEN(10)                 
  DCL VAR(&jobname)  TYPE(*CHAR) LEN(10)                 
  DCL VAR(&jobnum)   TYPE(*CHAR) LEN(6)                  
  DCL VAR(&jobtype)  TYPE(*CHAR) LEN(1)                  
  DCL VAR(&sysname)  TYPE(*CHAR) LEN(8)                  
                                                        
  /* Job type:  0=batch, 1=interactive */    
  RTVJOBA JOB(&jobname) CURUSER(&username) NBR(&jobnum) +
    TYPE(&jobtype) 

  RTVNETA SYSNAME(&sysname)                              
                                                        
  SNDUSRMSG MSG(&jobnum   *TCAT '/' +                    
            || &username *TCAT '/' +                    
            || &jobname)       
                               
  SNDUSRMSG MSG(&jobtype)                               
  SNDUSRMSG MSG(&sysname)       
                                                    
ENDPGM
```
