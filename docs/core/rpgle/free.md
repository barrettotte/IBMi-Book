# Introduction to RPGLE Free

There might be a lot of bells and whistles specific to IBMi, but RPGLE is just another general purpose programming language.
If you can learn Java, C or C#, you can learn RPGLE. If you already know C, you'll probably notice a lot of similarities.

In my opinion, I think its easier for a newer developer to learn mainly free format with a bit of fixed format for legacy code and general understanding.
New code should be written in fully free form if possible. 
New routines or procedures in existing fixed format code should be attempted to be written with free format.

Before starting this behemoth of a section, I feel obligated to say that this probably won't do a lot for you.
I learned the most by screwing around with random programs and looking at references.
My hope is that this page will be a good cheatsheet to refer to while learning the syntax and some of the fun
stuff you can do in this language.

If you can hold out a little while longer, you will get acquainted with SQLRPGLE in a future section.
To summarize, SQLRPGLE is a way to embed DB2 SQL straight into your RPGLE code.
After I got a basic understanding of SQLRPGLE, I began to love the language. 
**Just hang in there, it does get fun.**



## Free Format Preprocessor Commands
To use free format RPGLE, you have to include some preprocessor commands so the compiler knows to compile the correct format.

In older code, you could only do a mix of fixed and free formats using two preprocessor commands.
To mix fixed and free format, use ```/free``` to start a free format code block and ```/end-free``` to end it.
```php
D* (D spec comment)

/free
  // RPGLE free code goes here!
  //
  // NOTE: Don't worry about the code
  //       above or below yet
/end-free

C* (C spec comment)
```

<br>

I'm assuming IBM was still developing their compiler for awhile, but now there is the option to compile using only free format.
To specify only free format, include ```**free``` on the first line of the file. 
```php
**free

// Only RPGLE free format code is allowed in this file!
//
// Fixed format will not compile!

```
<br>

From this point on I will only be using fully free RPGLE for easier understanding of the language and its quirks. 
The next page will explain a bit about fixed format in comparison to free format.


## Naming
**Important note: naming in RPGLE is not case sensitive**
However, naming should be consistent to avoid confusion.
I don't think there's really any standard case that should be used.


## Comments
Comments in RPGLE free are single lined.
```php
// I am a comment
```


## Control Specifications
Control specifications allow you to specify information that should be used to compile or execute your program.
This includes date/time formats, usage of the RPG cycle, activation group configuration, and debug options.

Control specifications are the equivalent of **H specs** or **Header specifications**, more on this in a later section.
They need to be included directly under the ```**free``` preprocessor command and any other code.

Here are some common control specifications that I usually include in my programs.
```php
**free

ctl-opt main(main);
ctl-opt option(*srcstmt:*noDebugIO:*nounref) dftActGrp(*no);
```
<br>

```ctl-opt main(main);``` specifies that I will be using a **linear main**, I will **not** be using the RPG cycle mentioned previously.
This control option allows your program to behave a lot like you would expect it to like in C, Java, or Python.
In this case, the program will execute a subroutine named **main** first.


```ctl-opt option(*srcstmt);``` specifies the generated program to use source statement line numbers. 
When this program errors, you can go straight to the line number it occurred.


```ctl-opt option(*noDebugIO);``` specifies to not generate breakpoints for files' fields.
If this is not included, when you debug your program a breakpoint will be automatically generated at each field in each file.


```ctl-opt option(*nounref);``` specifies to not generate unreferenced fields and variables.


```ctl-opt dftActGrp(*no);``` okay ... time to come clean. I don't know a lot about activation groups yet (sorry).
I will hopefully come back to this when I have more knowledge.
I just kind of blindly include this in most of my programs and nothing has gone wrong...yet.


Its worth noting that the usage of **' : '** in ```ctl-opt option(*srcstmt:*noDebugIO:*nounref);``` is the way that RPGLE
separates parameters.


More about control specifications can be read at https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzasd/conspe9.htm



## Simple Data Types
Before learning how to declare a variable, the simple data types should be defined.

| Type             | Size (bytes)   | Fixed Format Type | Free Format Example         |
| ---------------- | -------------- | ----------------- | --------------------------- |
| Pointer          | 16             | *                 | ```dcl-s x pointer;```      |
| Character        | 1 - 65535      | A                 | ```dcl-s x char(10);```     |
| Varchar          | ?              | A VARYING         | ```dcl-s x varchar(55);```  |
| Binary           | 2, 4           | B                 | ```dcl-s x bindec(9);```    |
| Date             | 6, 8, 10       | D                 | ```dcl-s x date;```         |
| Float            | 4, 8           | F                 | ```dcl-s x float(8);```     |
| Graphic (DBCS)   | 32766          | G                 | ```dcl-s x graph(10);```    |
| Integer          | 1, 2, 4, 8     | I                 | ```dcl-s x int(10);```      |
| Indicator        | 1              | N                 | ```dcl-s x ind;```          |
| Packed           | 1 - 31         | P                 | ```dcl-s x packed(15:2);``` |
| Time             | 8              | T                 | ```dcl-s x time;```         |
| Unsigned Integer | 1, 2, 4, 8     | U                 | ```dcl-s x uns(10);```      |
| Timestamp        | 26             | Z                 | ```dcl-s x timestamp;```    |

**Other things of note**:
* DBCS - Double byte character set
* Integer declaration - int(digits)
  * int(3) = 1 byte(s)
  * int(5) = 2 byte(s)
  * int(10) = 4 byte(s)
  * int(20) = 8 byte(s)


## Indicators
An indicator is used just like a boolean, they can be set to 1, 0, *ON, *OFF.
There are various dedicated indicators in RPG, but there's really only one that I care to remember.
In RPGLE, the **last record indicator** needs to be set to *ON in your main function.

Truthfully, I don't think this is entirely necessary anymore with fully free RPG.
But, I've had a couple instances of using display files (more on this later) where I needed to use it to get things working properly.
For sanity's sake, I just include it; its one line of code extra.
```php
*INLR = *ON;
```


## Definition Statements
Definitions begin with opcode ```dcl-?``` and if needed end with ```end-?```.
More details on definition statements can be read at https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/freedatadef.htm

Definition statements have optional keywords that can further define the field.
More information on definition statement keywords can be read at https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/dskwd.htm


## Defining a Standalone Field
The definition opcode ```dcl-s``` is for defining a standalone field (variable).

Side note: String literals in RPGLE use single quotes instead of double quotes.

```php
// Simple examples of variable declaration:

dcl-s myString  varchar(64);
dcl-s myString2 varchar(50) inz('Hello World');
dcl-s myString3 char(50) inz('I am a fixed size');

dcl-s myNum int(10) inz(1234);
dcl-s myDecimal packed(8);
```

The ```inz``` keyword is used to initialize a variable.


## Defining a Named Constant
The definition opcode ```dcl-c``` is used to define a named constant.

```php
dcl-c myConst const(1234); // Using keyword
dcl-c myConst2 5;          // Define directly
```


## Defining a Data Structure
A data structure definition begins with the opcode ```dcl-ds``` and ends with ```end-ds```.
If you are comfortable with structs in C, data structures in RPGLE feel very familiar.

Each field in a data structure definition is defined like a standalone field,
except the ```dcl-s``` opcode is not included.

```php
// A qualified data structure
// Qualified forces the data structure to
//  be used in order to access fields
//
// Fields are accessed by:  myDs.myNum
dcl-ds myDs qualified;
  myNum int(5);
  myStr char(32);
end-ds;

// A qualified template data structure
// Used to provide a common template for
//  other data structure definitions
dcl-ds person qualified template;
  firstName char(16);
  lastName  char(16);
  age int(3);
end-ds;

// A data structure defined using a template
// likeds(person) -> Like data structure named person
dcl-ds friend likeds(person);

// Data structures are very useful for 
// dealing with indicators in display files 
// (more on this later) ->  if dspf.refresh ...
dcl-ds dspf qualified;
  exit      ind pos(3);
  refresh   ind pos(5);
end-ds;

// Also useful for just organizing constants
// such as SQL states ->  if sqlStates.success ...
dcl-ds sqlStates qualified;
  success char(2) inz('00');
  warning char(2) inz('01');
  noData  char(2) inz('02');
end-ds;

// Lastly, there are special data structures
// that can be accessed for various data.
// For example, this data structure has access
// to a ton of program information (PSDS).

dcl-ds pgmDs PSDS qualified;
  procName *proc; // Name of program
end-ds;
```

This is a very high level overview of data structures,
more can be read about them here https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzasd/freedatastructure.htm


## Arrays and Data Structure Arrays
Declaring an array is the same as declaring a standalone field (with ```dcl-s```), but to make it an array you include the keyword ```dim```.
I will only be covering the regular fixed sized arrays (runtime arrays).

In IBMi 7.4, there will be variable sized arrays similar to Lists in Java. 
But, I will not be covering this since I don't have a box running it (I'm on 7.3).

There are also compile time arrays, which I have never used personally and will not be covering.

**Important Note** - Arrays in RPGLE are **one-indexed** (indexing starts at one and not zero).
Additionally, indexing an array uses parentheses instead of square braces.

Data structure arrays are defined in a similar fashion as regular arrays, just include the ```dim``` keyword on the definition.

```php
dcl-s myArray char(16) dim(40);    // Define a char array with 40 elements

dcl-ds myDs qualified;
  myArray int(3) dim(10);          // Arrays can also be defined in data structures
end-ds;

dcl-ds myDsArr dim(25) qualified;  // Data structure arrays are declared in a similar way
  field1 char(99);
  field2 int(5);
  field3 ind;
  field4 int(3) dim(10);           // Array in a data structure array
end-ds;

myArray(1) = 'Hello World';        // To reiterate, arrays are one-indexed
myDs.myArray(3) = 'Woah';          // Parentheses instead of square braces

myDsArr(10).field1 = 'Awesome';    // Data structure arrays are accessed as expected
myDsArr(10).field2 = 100;
myDsArr(10).field3 = *ON;
myDsArr(10).field4(5) = 1234;
```


## Operators
Operators in RPGLE are slightly different than languages like Java or C.

| Name                  | Operator | Type          | Example                   |
| --------------------- | -------- | ------------- | ------------------------- |
| Addition              | +        | Arithmetic    | ```x = 1 + 1;``` -> 2     |
| Subtraction           | -        | Arithmetic    | ```x = 1 - 1;``` -> 0     |
| Multiplication        | *        | Arithmetic    | ```x = 1 * 1;``` -> 1     |
| Division              | /        | Arithmetic    | ```x = 1 / 1;``` -> 1     |
| Exponentation         | -        | Arithmetic    | ```x = 2 ** 4;``` -> 16   |
| Equality              | =        | Relational    | ```1 = 1``` -> true       |
| Inequality            | <>       | Relational    | ```1 <> 1``` -> false     |
| Greater Than          | >        | Relational    | ```1 > 2``` -> false      |
| Greater Than or Equal | >=       | Relational    | ```1 >= 1``` -> true      |
| Less Than             | <        | Relational    | ```1 < 5``` -> true       |
| Less Than or Equal    | <=       | Relational    | ```2 <= 4``` -> true      |
| Logical And           | AND      | Logical       | ```1=1 and 2=2``` -> true |
| Logical Or            | OR       | Logical       | ```1=1 or 2=5``` -> true  |
| Assignment            | =, +=, -=, *=, /=, **=   | Assignment | ```x = 4; x += 2;``` |
| Unary Plus            | +        | Unary         | ```x = +3```              |
| Unary Minus           | -        | Unary         | ```x = -x```              |
| Logical Negation      | NOT      | Unary/Logical | ```x = not x;```          |

As you can see its just slightly different than a normal set of operators that everyone is used to.


## Conditional Statements
RPGLE has the standard conditionals you would expect in a general purpose language.

Blocks of statements in RPGLE all follow a similar pattern of ending with a specfic opcode.
For example, if blocks end with 'endif' and data structure blocks end with 'end-ds'.

```php
  if (st = 'A');
    dsply ('IF');
  elseif (st = 'B');
    dsply ('ELSE IF');
  else;
    dsply ('ELSE');
  endif;
```
Its worth a small note that the parenthesis are optional on a conditional statement.
However, I strongly suggest using them just to match other languages' syntax.

RPGLE also has something called a select that works similar to a switch statement.
```php
  select;
    when someValue = 1;
      dsply ('Case A');
    when someValue = 2;
      dsply ('Case B');
    when someValue = 3;
      dsply ('Case C');
    other;
      dsply ('Default Case');
  endsl;
```

## Looping Statements
For and Do loops are a staple of any language. There are two types of do loops, do while and do until.
```php
dcl-s num int(10) inz(0);

// Do while
dow num < 10;
  if (num = 5);
    iter;  // skip 5th iteration
  endif;

  dsply (%char(num));
  num += 1;
enddo;

// Do until
num = 0;

dou num < 10;
  if (num = 5);
    leave;  // leave a loop early
  endif;

  dsply (%char(num));
  num += 1;
enddo;
```

A for loop has some optional/alternative syntax to control increment size and direction.
```php
dcl-s num int(10);

// For loop counting up by 1
for num = 1 to 3;
  dsply (%char(num));
endfor;

// For loop counting down by 1
for num = 5 downto 1 by 1;
  dsply (%char(num));
endfor;
```
