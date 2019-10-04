# Small CL Project

The best way to learn CL is getting your hands dirty.
We will be building the classic Fizzbuzz program to demonstrate CL concepts.
For fun, the program will also output your current username before running the typical fizzbuzz.

This is definitely super ugly, but it at least introduces you to subroutines, parameters, and conditionals.
We shouldn't get too fancy with CL until you have some exposure to RPGLE.


## Pseudocode
If you are unfamiliar with fizzbuzz, its just a simple program to introduce conditionals, operators, and looping in
any programming language. 
Some implementations end up being prettier than others and this one is most definitely on the uglier side.
```
// Basic Fizzbuzz

LOOP I=1 TO N
  IF       I MOD 15 = 0 -> PRINT 'FIZZBUZZ'
  ELSE IF  I MOD  5 = 0 -> PRINT 'BUZZ'
  ELSE IF  I MOD  3 = 0 -> PRINT 'FIZZ'
  ELSE                  -> PRINT I
END LOOP
```


```java
// Basic java implementation

for(int i = 0; i < 100; i++){
	if(i % 15 == 0){
	    System.out.println("FIZZBUZZ");
    } else if(i % 5 == 0){
	    System.out.println("BUZZ");
    } else if(i % 3 == 0){
		System.out.println("FIZZ");
	} else {
		System.out.println(i);
	}
}
```


## Setup
We need to create a new CL source member, so first run ```WRKMBRPDM YOURLIB/QCLLESRC```.
Press **F6** and fill out the new member's fields. In my case I named this source member **CLFIZZBUZZ** 
(warning, we're going to be doing this program again in RPG).

TODO: Picture of source member create

<br>

To start editing the new source member take an option **2** on it.


## Walkthrough
TODO:



## Complete Source
```php
```
Also found at https://github.com/barrettotte/IBMi-Book/blob/master/QCLLESRC/CLFIZZBUZZ.CLP
