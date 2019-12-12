# Small CL Project

The best way to learn CL is getting your hands dirty.
We will be building the classic Fizzbuzz program to demonstrate CL concepts.
For fun, the program will also output your current username before running the typical fizzbuzz.

This is definitely super ugly, but it at least introduces you to subroutines, parameters, and conditionals.
This program is completely useless, but practice is practice.


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

<br>

And just to see an actual implementation, here's a simple java implementation.
```java
// java implementation

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

<figure align="center">
	<img src="./core/cl/_assets/cl-11.PNG" alt="CL create member" />
</figure>

<br>

To start editing the new source member take an option **2** on it.


## Source Walkthrough

First let's make the program "shell". 
This program will take in one parameter as the number of fizzbuzz iterations to run.

For simplicity, the parameter will come in as a string (**&inIter**) and needs to be converted to
a numeric (**&iter**) using ```%INT```.

We will monitor a couple possible error messages involving the parameter using ```MONMSG```.
Additionally, we will use labels to handle program flow when an error occurs using ```GOTO```.
When an error message is encountered, program execution will jump to the label ```BADPARM:```,
inform the user that an error occurred, and fall to the end of the program.

```php
/* CLFIZZBUZZ */

PGM PARM(&inIter)
	
	/* Variable Declarations */
	DCL VAR(&inIter) TYPE(*CHAR) LEN(10)
	DCL VAR(&iter)   TYPE(*DEC)  LEN(2 0) VALUE(1)

    /* Convert input char to correct data type */
    CHGVAR VAR(&iter) VALUE(%INT(&inIter))
    MONMSG MSGID(CPF0818) EXEC(GOTO BADPARM) /* Failed convert */
    MONMSG MSGID(MCH3601) EXEC(GOTO BADPARM) /* Missing param  */


	GOTO END


BADPARM: SNDUSRMSG MSG('Bad iteration parameter passed.') +
            MSGTYPE(*INFO)

END:     SNDUSRMSG MSG('Done') MSGTYPE(*INFO)


ENDPGM
```

<br>

Next, we will declare a few more variables and output some things to the screen for sanity checking.
The username printing and sanity checking aren't needed at all.
But, its just a little more practice in writing CL.

* **&curIter** will be used to hold the current iteration the program is on. 
* **&uname** will be used to hold the username of the current user. It will be fetched using the CL command ```RTVUSRPRF```.
* **&outMsg** is a temp variable used to hold a string to output as a message for various places in the program.

```php
/* CLFIZZBUZZ */

PGM PARM(&inIter)

    /* Variable Declarations */
    DCL VAR(&inIter)  TYPE(*CHAR) LEN(10)
    DCL VAR(&iter)    TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&curIter) TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&uname)   TYPE(*CHAR) LEN(10)
	DCL VAR(&outMsg)  TYPE(*CHAR) LEN(64) 


	/* Convert input char to correct data type */
    CHGVAR VAR(&iter) VALUE(%INT(&inIter))
    MONMSG MSGID(CPF0818) EXEC(GOTO BADPARM) /* Failed convert */
	MONMSG MSGID(MCH3601) EXEC(GOTO BADPARM) /* Missing param  */


	/* Fetch username of current user */
    RTVUSRPRF USRPRF(*CURRENT) RTNUSRPRF(&uname)


    /* Output greeting message with username */
    CHGVAR VAR(&outMsg) VALUE('Hello' *BCAT &uname)
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    /* Simple sanity check message (optional) */
    CHGVAR VAR(&outMsg) VALUE('Running Fizzbuzz for' +
       *BCAT %CHAR(&iter) *BCAT 'iteration(s)')
	SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)
	

	GOTO END


BADPARM: SNDUSRMSG MSG('Bad iteration parameter passed.') +
            MSGTYPE(*INFO)

END:     SNDUSRMSG MSG('Done') MSGTYPE(*INFO)
	

ENDPGM
```

<br>

Since CL doesn't have a modulus operator, we will be making our own using a subroutine.
Implementing this subroutine requires a few more variable declarations to hold temp values
and a modulus expression.

* **&modLft** holds the left side of the modulus expression.
* **&modRgt** holds the right side of the modulus expression.
* **&modRes** helper for modulus operation, not used outside of subroutine.
* **&modTmp** helper for modulus operation, not used outside of subroutine.
* **&modRem** holds the final result of the modulus operation of &modLft and &modRgt.

```php
/* CLFIZZBUZZ */

PGM PARM(&inIter)

    /* Variable Declarations */
    DCL VAR(&inIter)  TYPE(*CHAR) LEN(10)
    DCL VAR(&iter)    TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&curIter) TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&uname)   TYPE(*CHAR) LEN(10)
    DCL VAR(&outMsg)  TYPE(*CHAR) LEN(64)


    /* Only used in modulus subroutine */
    DCL VAR(&modLft)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRgt)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRes)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modTmp)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRem)  TYPE(*DEC)  LEN(2 0)


    /* Convert input char to correct data type */
    CHGVAR VAR(&iter) VALUE(%INT(&inIter))
    MONMSG MSGID(CPF0818) EXEC(GOTO BADPARM) /* Failed convert */
    MONMSG MSGID(MCH3601) EXEC(GOTO BADPARM) /* Missing param  */


    /* Fetch username of current user */
    RTVUSRPRF USRPRF(*CURRENT) RTNUSRPRF(&uname)


    /* Output greeting message with username */
    CHGVAR VAR(&outMsg) VALUE('Hello' *BCAT &uname)
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    /* Simple sanity check message (optional) */
    CHGVAR VAR(&outMsg) VALUE('Running Fizzbuzz for' +
       *BCAT %CHAR(&iter) *BCAT 'iteration(s)')
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    GOTO END


BADPARM: SNDUSRMSG MSG('Bad iteration parameter passed.') +
            MSGTYPE(*INFO)

END:     SNDUSRMSG MSG('Done') MSGTYPE(*INFO)


/*********************************************************************/
/*                        SUBROUTINES                                */
/*********************************************************************/


    /* Since CL doesn't have a modulus op, let's make one */
    SUBR     SUBR(MOD)
             CHGVAR VAR(&modRes) VALUE(&modLft / &modRgt)
             CHGVAR VAR(&modTmp) VALUE(&modRes * &modRgt)
             CHGVAR VAR(&modRem) VALUE(&modLft - &modTmp)
	ENDSUBR
	

ENDPGM
```

<br>


Finally, we implement the fizzbuzz logic. 

To start, we add a while loop iterating from 1 to **&iter**.
At the start of the loop, we also load **&curIter** into **&modLft** so that we can use it in our modulus subroutine.
Next, we call the main subroutine **FZBZ** which is essentially the first conditional in the fizzbuzz pseudocode at the start of this page.
Finally, we increment **&curIter** using ```CHGVAR``` since CL doesn't have a **++** operator.


Since CL also does not have multiline if blocks, we will use subroutines to mimic the behavior.
I'm sure this could be done in a better way, but let's get some more practice with subroutines.


* **SUBR(FZBZ)** - The first conditional in pseudocode,  ```IF I MOD 15 = 0 -> PRINT 'FIZZBUZZ'```.
* **SUBR(BUZZ)** - The second conditional in pseudocode, ```ELSE IF I MOD 5 = 0 -> PRINT 'BUZZ'```.
* **SUBR(FIZZ)** - The third conditional in pseudocode, ```ELSE IF I MOD 3 = 0 -> PRINT 'FIZZ'```.
* **SUBR(PRNT)** - Util subroutine for printing the contents of **&outMsg** and **&curIter**.


```php
/* CLFIZZBUZZ */

PGM PARM(&inIter)

    /* Variable Declarations */
    DCL VAR(&inIter)  TYPE(*CHAR) LEN(10)
    DCL VAR(&iter)    TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&curIter) TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&uname)   TYPE(*CHAR) LEN(10)
    DCL VAR(&outMsg)  TYPE(*CHAR) LEN(64)


    /* Only used in modulus subroutine */
    DCL VAR(&modLft)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRgt)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRes)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modTmp)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRem)  TYPE(*DEC)  LEN(2 0)


    /* Convert input char to correct data type */
    CHGVAR VAR(&iter) VALUE(%INT(&inIter))
    MONMSG MSGID(CPF0818) EXEC(GOTO BADPARM) /* Failed convert */
    MONMSG MSGID(MCH3601) EXEC(GOTO BADPARM) /* Missing param  */


    /* Fetch username of current user */
    RTVUSRPRF USRPRF(*CURRENT) RTNUSRPRF(&uname)


    /* Output greeting message with username */
    CHGVAR VAR(&outMsg) VALUE('Hello' *BCAT &uname)
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    /* Simple sanity check message (optional) */
    CHGVAR VAR(&outMsg) VALUE('Running Fizzbuzz for' +
       *BCAT %CHAR(&iter) *BCAT 'iteration(s)')
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    /* Fizzbuzz loop */
    DOUNTIL (&curIter *GT &iter)
       CHGVAR VAR(&modLft) VALUE(&curIter)
       CALLSUBR SUBR(FZBZ)
       CHGVAR VAR(&curIter) VALUE(&curIter + 1)
    ENDDO

    GOTO END


BADPARM: SNDUSRMSG MSG('Bad iteration parameter passed.') +
            MSGTYPE(*INFO)

END:     SNDUSRMSG MSG('Done') MSGTYPE(*INFO)



/*********************************************************************/
/*                        SUBROUTINES                                */
/*********************************************************************/


	/* Output contents of &outMsg along with &curIter */
    SUBR     SUBR(PRNT)
             SNDUSRMSG MSG(%CHAR(&curIter) *BCAT '-' *BCAT &outMsg) +
                MSGTYPE(*INFO)
    ENDSUBR


	/* IF I MOD 15 = 0 -> PRINT 'FIZZBUZZ' */
    SUBR     SUBR(FZBZ)
             CHGVAR VAR(&outMsg) VALUE('FIZZBUZZ')
             CHGVAR VAR(&modRgt) VALUE(15)
             CALLSUBR SUBR(MOD)
             IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
             ELSE (CALLSUBR SUBR(BUZZ))
    ENDSUBR


	/* ELSE IF I MOD 5 = 0 -> PRINT 'BUZZ' */
    SUBR     SUBR(BUZZ)
             CHGVAR VAR(&outMsg) VALUE('BUZZ')
             CHGVAR VAR(&modRgt) VALUE(5)
             CALLSUBR SUBR(MOD)
             IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
             ELSE (CALLSUBR SUBR(FIZZ))
    ENDSUBR


	/* ELSE IF I MOD 3 = 0 -> PRINT 'FIZZ' */
    SUBR     SUBR(FIZZ)
             CHGVAR VAR(&outMsg) VALUE('FIZZ')
             CHGVAR VAR(&modRgt) VALUE(3)
             CALLSUBR SUBR(MOD)
             IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
             ELSE (SNDUSRMSG MSG(%CHAR(&curIter)))
    ENDSUBR


    /* Since CL doesn't have a modulus op, let's make one */
    SUBR     SUBR(MOD)
             CHGVAR VAR(&modRes) VALUE(&modLft / &modRgt)
             CHGVAR VAR(&modTmp) VALUE(&modRes * &modRgt)
             CHGVAR VAR(&modRem) VALUE(&modLft - &modTmp)
    ENDSUBR


ENDPGM
```

<br>


## Compilation and Execution
Now that the CL source has been entered, its time to compile it to a program. Take an option **14** on ```CLFIZZBUZZ``` to begin the compilation.

If a compilation error occurs, refer back to [Your First CL Program](https://barrettotte.github.io/IBMi-Book/#/core/cl/firstpgm?id=compile-errors-and-wrksplf).


<figure align="center">
	<img src="./core/cl/_assets/cl-12.PNG" alt="compile" />
</figure>

<br>

Now that the program has been created, let's call it with ```CALL CLFIZZBUZZ PARM('5')```.
Alternatively, you could type in ```CALL CLFIZZBUZZ```, press **F4**, and enter ```'5'``` into the field.

**WARNING**: This outputs a message for each iteration. 
Don't pass in a large number or you're going to be sitting there hitting **ENTER** for a while.

<figure align="center">
	<img src="./core/cl/_assets/cl-13.PNG" alt="prompt" />
</figure>

<br>

If all goes well, you should see something around the following output.

<figure align="center">
	<img src="./core/cl/_assets/cl-14.PNG" alt="output" />
</figure>

<br>

## Complete Source
Also found at https://github.com/barrettotte/IBMi-Book/blob/master/QCLLESRC/CLFIZZBUZZ.CLP

```php
/*********************************************************************/
/*                      Fizzbuzz in CL                               */
/*                                                                   */
/*   Call using CMD    FIZZBUZZ(10)                                  */
/*   Call using  CL    CALL CLFIZZBUZZ PARM('10')                    */
/*                                                                   */
/*********************************************************************/


PGM PARM(&inIter)

    /* Variable Declarations */
    DCL VAR(&inIter)  TYPE(*CHAR) LEN(10)
    DCL VAR(&iter)    TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&curIter) TYPE(*DEC)  LEN(2 0) VALUE(1)
    DCL VAR(&uname)   TYPE(*CHAR) LEN(10)
    DCL VAR(&outMsg)  TYPE(*CHAR) LEN(64)


    /* Only used in modulus subroutine */
    DCL VAR(&modLft)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRgt)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRes)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modTmp)  TYPE(*DEC)  LEN(2 0)
    DCL VAR(&modRem)  TYPE(*DEC)  LEN(2 0)


    /* Convert input char to correct data type */
    CHGVAR VAR(&iter) VALUE(%INT(&inIter))
    MONMSG MSGID(CPF0818) EXEC(GOTO BADPARM) /* Failed convert */
    MONMSG MSGID(MCH3601) EXEC(GOTO BADPARM) /* Missing param  */


    /* Fetch username of current user */
    RTVUSRPRF USRPRF(*CURRENT) RTNUSRPRF(&uname)


    /* Output greeting message with username */
    CHGVAR VAR(&outMsg) VALUE('Hello' *BCAT &uname)
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    /* Simple sanity check message (optional) */
    CHGVAR VAR(&outMsg) VALUE('Running Fizzbuzz for' +
       *BCAT %CHAR(&iter) *BCAT 'iteration(s)')
    SNDUSRMSG MSG(&outMsg) MSGTYPE(*INFO)


    /* Fizzbuzz loop */
    DOUNTIL (&curIter *GT &iter)
       CHGVAR VAR(&modLft) VALUE(&curIter)
       CALLSUBR SUBR(FZBZ)
       CHGVAR VAR(&curIter) VALUE(&curIter + 1)
    ENDDO

    GOTO END


BADPARM: SNDUSRMSG MSG('Bad iteration parameter passed.') +
            MSGTYPE(*INFO)

END:     SNDUSRMSG MSG('Done') MSGTYPE(*INFO)



/*********************************************************************/
/*                        SUBROUTINES                                */
/*********************************************************************/


    SUBR     SUBR(PRNT)
             SNDUSRMSG MSG(%CHAR(&curIter) *BCAT '-' *BCAT &outMsg) +
                MSGTYPE(*INFO)
    ENDSUBR


    SUBR     SUBR(FZBZ)
             CHGVAR VAR(&outMsg) VALUE('FIZZBUZZ')
             CHGVAR VAR(&modRgt) VALUE(15)
             CALLSUBR SUBR(MOD)
             IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
             ELSE (CALLSUBR SUBR(BUZZ))
    ENDSUBR


    SUBR     SUBR(BUZZ)
             CHGVAR VAR(&outMsg) VALUE('BUZZ')
             CHGVAR VAR(&modRgt) VALUE(5)
             CALLSUBR SUBR(MOD)
             IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
             ELSE (CALLSUBR SUBR(FIZZ))
    ENDSUBR


    SUBR     SUBR(FIZZ)
             CHGVAR VAR(&outMsg) VALUE('FIZZ')
             CHGVAR VAR(&modRgt) VALUE(3)
             CALLSUBR SUBR(MOD)
             IF (&modRem *EQ 0) THEN(CALLSUBR SUBR(PRNT))
             ELSE (SNDUSRMSG MSG(%CHAR(&curIter)))
    ENDSUBR


    /* Since CL doesn't have a modulus op, let's make one */
    SUBR     SUBR(MOD)
             CHGVAR VAR(&modRes) VALUE(&modLft / &modRgt)
             CHGVAR VAR(&modTmp) VALUE(&modRes * &modRgt)
             CHGVAR VAR(&modRem) VALUE(&modLft - &modTmp)
    ENDSUBR


ENDPGM
```
