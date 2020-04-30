# Introduction to RPGLE Fixed


I will preface this with the fact that I haven't really done much RPGLE fixed format programming.
In this section I will mostly focus on the basics of translating and understanding fixed format in reference to free format.
In a bonus section, I will mess around with a little bit of legacy **RPG II, RPG III, and RPG/400**.

Fixed format RPGLE is a little scary to look at at first, but having a brief background on RPRGLE free format will make it tolerable.
Honestly, the most valuable part of learning a bit of fixed format RPGLE is for improved google searches.
There is a ton of material in IBM's documentation and other websites that is mostly fixed format.
With a background in fixed format RPGLE, you could more easily understand and convert example programs to free format.

If you know you are going to be working with an existing codebase, this section will not be enough and further reading needs to be done.
I will only be covering the basics of C and D spec conversion which is nowhere near enough knowledge.
There are also utilities out there that will convert fixed to free format for you.


## RPGLE Fixed Format Template
Here is a shell of an RPGLE fixed format program.
Format specifications always show up in this order, but may not always be included.

```php
H* Control specifications    
 *                           
F* File specifications       
 *                           
D* Definition specifications       
 *                           
I* Input specifications      
 *                           
C* Calculation specifications
 *                           
O* Output specifications     
 *                           
P* Procedure specifications  
 *                           
```


## Coding in RPGLE Fixed Format
As you saw on the last section, fixed format RPGLE is very dependent upon format specifications and column positions.
When I first started learning RPG I actually thought that people memorized all of the column positions.

If you for some reason really need to write fixed format, remember to use prompting.
By scrolling to a line and hitting **F4**, it brings up a prompt based on the format specification (Prompt type . . .   C).

<figure align="center">
  <img src="./core/rpgle/_assets/rpgle01.PNG" alt="RPGLE prompting" />
  <figcaption align="center">
	Prompting an RPGLE C spec
  </figcaption>
</figure>

<br>

Inside of this prompt, you can do additional prompting on each field with **F1** (help).
For example, hitting **F1** on the **Operation** field displays a list of opcodes I can put in.

<figure align="center">
  <img src="./core/rpgle/_assets/rpgle02.PNG" alt="RPGLE prompting" />
  <figcaption align="center">
	Operation and Extender - Help
  </figcaption>
</figure>



## Example C Spec Conversion
A C spec (calculation specification) is used to perform calculations (no way?!).
This spec has a format that is somewhat easy to remember, I just never really remember what the column ranges are for each field.

```php
/* C Spec general format (not column position accurate) */
C     Factor 1    Operation    Factor 2     Result
```

```php
C* Hello world in fixed format RPGLE                                   
C*                                                                     
C     'Hello World' DSPLY                                              
C                   RETURN                                                                                      
```

Referencing line 3 in the hello world program above, it has **Factor 1** = ```'Hello World'``` and **Operation** = ```DSPLY```.
Line 4 just has **Operation** = ```RETURN```.

The equivalent in RPGLE free format, would be

```php
// Hello world in free format RPGLE
//
dsply ('Hello World');
return;
```
As you can see, its just slightly different. For the most part, all fixed format can be converted to free format.
Some things are definitely trickier than others and this was a very trivial example.


## Example D Spec Conversion
A D spec (Definition specification) is used to define standalone fields, data structures, etc.
D specs were used for quite a while when developers were mixing free and fixed format RPGLE.
So, you are most likely to come across D-specs still in use.


First, I'll show how to convert a standalone field from fixed to free.

```php
D* Standalone fields
DUsername          S            64A   VARYING
```

<br>

In SEU, if we hit **F4** to prompt the D-spec, we get way more useful information.

<figure align="center">
  <img src="./core/rpgle/_assets/rpgle03.PNG" alt="RPGLE D spec prompt" />
  <figcaption align="center">
	Prompting a D-Spec
  </figcaption>
</figure>

With this information, the equivalent statement in free format would be

```php
// My standalone fields
dcl-s Username varchar(64);
```

* The **Name** field is pretty self explantory.
* **Declaration Type** will tell us what type of ```dcl``` opcode to use. In this case its **'S'** (standalone), so ```dcl-s``` should be used.
* **Length** is also pretty self explanatory.
* **Internal Data Type** is the field type. In this case its **'A'**, which corresponds to **char** data type.
* **Keywords** are additional modifiers on the field. Since this is a **char** field, the keywords ```VARYING``` allows us to use the variable type of **varchar** instead of **char**.


## Using Free and Fixed Together
Its definitely still very common to see fixed and free format used together.
At least in my work experience, its more rare to see fully free format.


Here's an example of bouncing between fixed and free format for no apparent reason.
This is just to show that you can change formats anywhere as long as ```**free``` hasn't been declared.
Its pretty ugly isn't it?

Its worth noting that free format has to start at a certain column position still.
This is probably how the compiler decides on what format to compile your line of code as.

```php
H/TITLE Messing around with fixed and free format                  
H*                                                                 
D*                                                                 
DNum1             S              6P 0 INZ(4)                                        
  dcl-s Num2 packed(6) inz(10); // free format in the middle of fixed                               
DResult           S              6P 0 INZ(*zeros)                  
C*                                                    
C     Num1          ADD       Num2          Result                 
C     Result        DSPLY                                          
C*                                                                 
  // some quick free format                                        
  result = num1 * num2;                                            
  dsply (%char(result));                                           
C*                       
C* Wait lets go back to fixed format to end this                                          
C                   SETON                                        LR
```



## Learning More
This isn't really too great of a section because I haven't really used fixed format all that much myself.
If you want to learn more about fixed format, head to [Go4AS400](http://www.go4as400.com/default.aspx).
That is where I learned the basics of RPGLE.

