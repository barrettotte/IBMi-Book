# CL Basics and Syntax

An overview of syntax and some of the basics in CL.

**IMPORTANT NOTE**: Not all features of modern CL were included in previous versions.


## Casing and Formatting
As you will see in this section and future sections, casing doesn't really matter.

Some people like the format of ```SNDUSRMSG``` and others like ```SndUsrMsg```.

The most important thing is to just be consistent with whatever you pick.


## Comments
```php
/* I am a comment in CL         */
/* Don't be fooled, this is not */
/*   a multi-lined comment.     */
```


## Variables
Declare with ```DCL VAR(&MyString) TYPE(*CHAR) LEN(8)``` or using positional parameters ```DCL &MyString *CHAR 8```

In this example, the ```DCL``` command accepts some named parameters **VAR**, **TYPE**, **LEN**

**An important note, a CL variable should begin with '&'**.

<br>


**Variable Types:**

| Type  | Name              |
| ----- | ----------------- |
| *DEC  | Decimal (packed)  |
| *CHAR | Character         |
| *LGL  | Logical (boolean) |
| *INT  | Integer           |
| *UINT | Unsigned Integer  |
| *PTR  | Pointer           |

<br>

To update a variable's value, you use the **CHGVAR** command. ```CHGVAR VAR(&MyString) VALUE('Hello')```


## Operators
CL has the expected operators you would find in most languages; with the addition of some weird ones.

* ```* / - +``` - standard arithmetic operators
* ```*EQ *GT *LT *GE *LE *NE *NG *NL``` - relational operators 
* ```= > < >= <=``` - relational operators
* ```*AND *OR *NOT``` - logical operators

There are three different string concatentation operators. 
Typically I like to use ```||``` for standard concat and ```*BCAT *TCAT``` for the others.
Its easier for me to remember that way, but do whatever works. 

| Operator | Alternative | Name    | Example     | Result     |
| -------- | ----- | --------------- | -------------------------------------------------------- | ---------------------- |
| *CAT     | \|\|  | Concat          | ```CHGVAR VAR(&MyStr) VALUE('hello' *CAT 'world')```     | &MyStr = 'helloworld'  |
| *BCAT    | \|\>  | Concat Blank    | ```CHGVAR VAR(&MyStr) VALUE('hello' \|> 'world')```      | &MyStr = 'hello world' |
| *TCAT    | \|\<  | Concat Truncate | ```CHGVAR VAR(&MyStr) VALUE('   hello' *TCAT 'world')``` | &MyStr = 'hello world' |

<br>



## Control Structures

If statements are also commands that have their own parameters (**COND** and **THEN**).


```php
/* If Example - Named parameters */
IF COND(&MyString = 'Hello')  +
  THEN(DSPUSRPRF)
```   


```php
/* If Else Example */
IF (&MyNum = 5) THEN( +
  CHGVAR VAR(&MyNum) VALUE('AAA'))
ELSE (CHGVAR VAR(&MyNum) VALUE('BBB'))
```


```php
/* Nested If Example */
IF (&MyStr1 = 'A') THEN( +
  IF (&MyStr2 = 'B') THEN( +
    SNDUSRMSG MSG('Hello')))
```


Do loops work pretty much the same
```php
/* Do Loop Example */
DCL VAR(&MyNum) TYPE(*INT) VALUE(3)

DOUNTIL (&MyNum *GE 10)
  SNDUSRMSG MSG('Doing')
  CHGVAR &MyNum &MyNum-1
ENDDO
```


For loop
```php
/* Do For Loop Example */
DCL VAR(&idx) TYPE(*INT) VALUE(1)

DOFOR VAR(&idx) FROM(1) TO(10) BY(1)
  SNDUSRMSG MSG('FOR')
ENDDO
```


## Built in functions
A few built in functions:
* ```%BINARY(&x)``` or ```%BIN(&x)``` - Convert character to binary integer
* ```%SUBSTRING(&MyStr 1 2)``` or ```%SST(&MyStr 1 2)``` - Substring from 1 to 2
* ```%UPPER(&MyStr)``` - Convert string to uppercase, LOWER also exists.
* ```%TRIM(&MyStr)``` - trim blanks, TRIMR and TRIML also exist.

A full list can be found at https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rbam6/rbam6builtinfunc.htm


## Labels and Go To
Just like in BASIC and assembly, CL has labels and a ```GOTO``` command.
If you are unfamiliar, a label has no functionality by itself, it just points to a place in code.
Using ```GOTO MYLABEL``` would move execution (program counter) to the label MYLABEL (memory address).
**In modern IBM i development, GOTO statements should be avoided!**
```php
PGM
  SNDUSRMSG MSG('Hello')
  GOTO SKIP

  SNDUSRMSG MSG('I was skipped over')

  SKIP:
  SNDUSRMSG MSG('World')
ENDPGM
```


## Subroutines
I don't have too much experience with subroutines.
But, they are very useful for reusing blocks of code and managing program flow.
```php
PGM
  CALLSUBR SUBR(SAYHELLO)

  SUBR SUBR(SAYHELLO)
    SNDUSRMSG MSG('Hello')
  ENDSUBR

ENDPGM
```


## Message Monitoring
Another thing I don't have experience with is ```MONMSG```.
But, this is essentially the CL equivalent of a try/catch block.

When a program fails at runtime, the error ID is given.
This is pretty much the equivalent of a try/catch for an error with the ID of MCH3601 (parm undefined).

```php
/* Pretend a line that could generate MCH3601 error is here instead */

MONMSG MSGID(MCH3601) EXEC(SNDUSRMSG('An error occurred :('))
```


## CL Program
A CL program begins with the command ```PGM``` and ends with the ```ENDPGM``` command.
Here is an example of a simple CL program. Don't worry about copying this into PDM.
```php
/* Input text and return it as msg */
PGM
  DCL &VAR1 *CHAR 48
  SNDUSRMSG MSG('Input something') +
        MSGTYPE(*INQ) Msgrpy(&VAR1)
  SNDUSRMSG MSG(&VAR1)
ENDPGM
```


## Parameters (parms)
A CL program can also accept parameters in its invocation using ```PARM```.
A parameter coming in must be declared in the CL program in order to be used.

```php
PGM PARM(&name)
  DCL VAR(&name) TYPE(*CHAR) LEN(10)
  
  SNDUSRMSG MSG('Hello' *BCAT &name)
ENDPGM
```


## Packed Decimal Parameters
One of the more screwy things in CL is trying to pass a packed decimal parm to a program.
```php
/* Pass 2 */
CALL PGM(MYPGM) PARM(X'2F')

/* Pass 10, notice the added '0' */
CALL PGM(MYPGM) PARM(X'010F')
```
* The parm including 'F' must be even number of positions
* If len(parm + 'F') is odd, add a leading zero to parm
* 'F' = positive, 'D' = negative
* If a packed decimal size is not specified, it defaults to PACKED(15:5) -> 000000012345000 (123.45)

