# Introduction to Commands

Commands are kind of just a thin wrapper over a compiled program.
They seem to be underused by many, but its still a worthwhile tool to have in the toolbox.


You can create your own commands (**CMD**s) which can be invoked using the syntax ```MyCmd```.
Making a CMD offers some benefits:
* Parameter type and bound enforcing.
* Intuitive prompting with **F4** parameter labels.
* Can be used with ILE languages (CL, RPGLE, C, etc.)


## Building a Fizzbuzz Command
For extra practice, we're going to make a fizzbuzz command as a wrapper for our previously created ```CLFIZZBUZZ``` program.

First, let's make a CMD source member in QCMDSRC. 
Run ```WRKMBRPDM YOURLIB/QCMDSRC``` and press **F6**.

<figure align="center">
	<img src="./core/cl/_assets/cl-15.PNG" alt="cmd create" />
</figure>

<br>

This command is super simple. We just make a wrapper for the iterations parameter as a character type and non-blank.
```php
CMD  PROMPT('FIZZBUZZ')

            PARM       KWD(ITER) TYPE(*CHAR) LEN(10) MIN(1) +
                         PROMPT('ITERATIONS')
```

<br>

Take an option **14** on the ```FIZZBUZZ``` source member.
To finish creating the command enter ```CRTCMD``` and press **F4**.

Fill out the following information to create the command:

<figure align="center">
	<img src="./core/cl/_assets/cl-16.PNG" alt="cmd create" />
</figure>

<br>

To run the new command, enter ```FIZZBUZZ('5')``` and it should behave the exact same way as running ```CALL CLFIZZBUZZ PARM('5')```.

<figure align="center">
	<img src="./core/cl/_assets/cl-17.PNG" alt="cmd" />
</figure>

<br>

<figure align="center">
	<img src="./core/cl/_assets/cl-18.PNG" alt="cmd exec" />
</figure>
