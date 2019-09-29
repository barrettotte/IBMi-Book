# CL Basics and Syntax

An overview of syntax and some of the basics in CL.


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

| Operator      | Category   | Name     | Example                               | Result      |
| ------------- | ---------- | -------- | ------------------------------------- | ----------- |
| *             | Arithmetic | Multiply | ```CHGVAR VAR(&MyNum) VALUE(4 * 6)``` | &MyNum = 24 |
| /             | Arithmetic | Divide   | ```CHGVAR VAR(&MyNum) VALUE(8 / 2)``` | &MyNum = 4  |
| -             | Arithmetic | Subtract | ```CHGVAR VAR(&MyNum) VALUE(3 - 1)``` | &MyNum = 2  |
| +             | Arithmetic | Add      | ```CHGVAR VAR(&MyNum) VALUE(2 + 2)``` | &MyNum = 4  |
| *CAT or \|\|  | Character  | Concat   | ```CHGVAR VAR(&MyStr) VALUE('hello' *CAT 'world')``` | &MyStr = 'helloworld' |
| *BCAT or \|\> | Character  | Concat Blank | ```CHGVAR VAR(&MyStr) VALUE('hello' \|> 'world')``` | &MyStr = 'hello world' |
| *TCAT or \|\< | Character  | Concat Truncate | ```CHGVAR VAR(&MyStr) VALUE('   hello' *TCAT 'world')``` | &MyStr = 'hello world' |
| *EQ or =      | Relational | Equality | | |
| *GT or >      | Relational | Greater Than | | |
| *LT or <      | Relational | Less Than | | |
| *GE or >=     | Relational | Greater Than or Equal | | |
| *LE or <=     | Relational | Less Than or Equal | | |
| *NE           | Relational | Not Equal to | | | 
| *NG           | Relational | Not Greater Than | | |
| *NL           | Relational | Not Less Than | | |
| *AND          | Logical    | Logical And | | |
| *OR           | Logical    | Logical Or  | | |
| *NOT          | Logical    | Logical Not | | |

<br>


**Additional Notes:**
* ```*BCAT``` concatenates strings with a blank space between
* ```*TCAT``` concatenates strings and trims blanks of the first string



## Control Structure

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


## Built in functions
* ```%BINARY(&x)``` or ```%BIN(&x)``` - Convert character to binary integer
* ```%SUBSTRING(&MyStr 1 2)``` or ```%SST(&MyStr 1 2)``` - Substring from 1 to 2
* Reference: https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rbam6/rbam6builtinfunc.htm


## Labels and Go To
Just like in BASIC and assembly, CL has labels and a ```GOTO``` command.
If you are unfamiliar, a label has no functionality by itself, it just points to a place in code.
Using ```GOTO MYLABEL``` would move execution to the label MYLABEL.
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
But, this is essentially the CL equivalent of a Try/Catch.

When a program fails at runtime, the error ID is given.
This is essentially a catch for an error with the ID of MCH3601.

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


## Parameters
A CL program can also accept parameters in its invocation using the ```PARM``` command.
A parameter coming in must be declared in the CL program in order to be used.

```php
PGM PARM(&name)
  DCL VAR(&name) TYPE(*CHAR) LEN(10)
  
  SNDUSRMSG MSG('Hello' *BCAT &name)
ENDPGM
```
