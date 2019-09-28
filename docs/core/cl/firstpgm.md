# Your First CL Program


Writing, compiling, and running your first CL program.

The program will be a simple ECHO program. It receives input and echos it back to the user.


## CL Source Physical File

To start, enter the command ```WRKOBJPDM YOURLIB```

In order to start writing CL programs, you need to make sure you have a CL source physical file (QCLLESRC).
In the previous chapter a CL source physical file was created while learning about SEU.
If you don't have it, please revisit that section.


## CL Source Member

Enter the command ```WRKMBRPDM YOURLIB/QCLLESRC```.


To create a new CL source member press **F6**
and populate the prompt as shown.


TODO: Picture of CL member create


Press enter and you are brought to SEU.


## Your First Program

At the top of each program I try to put a couple sentence summary of what it does.
So I entered
```php
/* Prompt for user input and echo it back as a message */
```

<br>

Next, create the CL program shell
```php
/* Prompt for user input and echo it back as a message */  
PGM                                               
                                    
ENDPGM
```

<br>

Within our program we need to store user input, so a CHAR type variable needs to be declared. 
Any length will do so I set it to 64 characters long.
```php                                                               
  DCL VAR(&in) TYPE(*CHAR) LEN(64)                                        
```

<br>

To prompt for user input, we send a message to the user with a special message type of ```*INQ``` (inquiry).
This allows us to store the message reply in our variable specified by ```MSGRPY(&in)```.
```php
SNDUSRMSG MSG('Input Something') +
    MSGTYPE(*INQ) MSGRPY(&in)      
```

<br>

and finally, we output the input back to the user as another message
```php                                 
SNDUSRMSG MSG(&in)
```

<br>

## Complete Source
```php
/* Prompt for user input and echo it back as a message */  
PGM                                 
                                    
  DCL VAR(&in) TYPE(*CHAR) LEN(64)  
                                    
  SNDUSRMSG MSG('Input Something') +
     MSGTYPE(*INQ) MSGRPY(&in)      
                                    
  SNDUSRMSG MSG(&in)                
                                    
ENDPGM                              
```


## Compilation
TODO: setting up batch compilation
TODO: picture of setting up batch compile
TODO: picture of compilation


## Running
TODO: picture of prompt
TODO: picture of response


## Errors and WRKSPLF
TODO: Edit program and make obvious error
TODO: Picture of failed compile
TODO: WRKSPLF
TODO: Picture of WRKSPLF screen
TODO: Picture of error

