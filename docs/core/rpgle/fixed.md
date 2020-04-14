# Introduction to RPGLE Fixed


I will preface this with the fact that I haven't really done much RPGLE fixed format programming.
In this section I will mostly focus on the basics of translating and understanding fixed format in reference to free format.
In a bonus section, I will mess around with a little bit of legacy **RPG II, RPG III, and RPG/400**.

Fixed format RPGLE is a little scary to look at at first, but having a brief background on RPRGLE free format will make it tolerable.
Honestly, the most valuable part of learning a bit of fixed format RPGLE is for improved google searches.
There is a ton of material in IBM's documentation and other websites that is mostly fixed format.
With a background in fixed format RPGLE, you could more easily understand and convert example programs to free format.

If you know you are going to be working with an existing codebase, this section will not be enough and further reading needs to be done.
I will only be covering the basics of C and D spec translation which is nowhere near enough knowledge.


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



## Example C Spec Translation
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
As you can see, its just slightly different. For the most part, all fixed format can be translated to free format.
Some things are definitely trickier than others and this was a very trivial example.


## Example D Spec Translation
A D spec (Definition specification) is used to define standalone fields, data structures, etc.
D specs were used for quite a while when developers were mixing free and fixed format RPGLE.

TODO: standalone field
TODO: data structure

```php

```