# CL Basics and Syntax

An overview of syntax and some of the basics in CL.


## Variables
Declare with ```DCL VAR(&MyString) TYPE(*CHAR) LEN(8)```

or using positional parameters ```DCL &MyString *CHAR 8```

In this example, the ```DCL``` command accepts some named parameters **VAR**, **TYPE**, **LEN**

**An important note, a CL variable should begin with '&'**.


Types:

| Type  | Name              |
| ----- | ----------------- |
| *DEC  | Decimal (packed)  |
| *CHAR | Character         |
| *LGL  | Logical (boolean) |
| *INT  | Integer           |
| *UINT | Unsigned Integer  |
| *PTR  | Pointer           |

<br>

To update a variable's value, you use the **CHGVAR** command.


```CHGVAR VAR(&MyString) VALUE('Hello')```


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
IF (&MyNum = 1) DO
  SNDUSRMSG MSG('Doing')
ENDDO
```


## Built in functions
* ```%BINARY(&x)``` or ```%BIN(&x)``` - Convert character to binary integer
* ```%SUBSTRING(&MyStr 1 2)``` or ```%SST(&MyStr 1 2)``` - Substring from 1 to 2
* Reference: https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rbam6/rbam6builtinfunc.htm