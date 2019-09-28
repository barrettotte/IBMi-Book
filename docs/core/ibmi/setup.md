# Setup Library

To finish this chapter and continue in this book, we need to setup a library and some files.
Hopefully, your user profile that was setup has the permissions necessary to do this.
If not, ask your nearest IBMi disciple.


## Creating a Test Library
You will be running another **Control Language (CL)** command, ```CRTLIB``` to create a **library object**.

**F3** back to the main menu, type ```CRTLIB``` into the command line, and press **F4** (prompt)


<figure align="center">
	<img src="./core/ibmi/_assets/setup-01.PNG" alt="setup 01" />
</figure>

<br>

Name your library, set the library type to ***TEST**, optionally fill out a description, and press **ENTER**.

<figure align="center">
	<img src="./core/ibmi/_assets/setup-02.PNG" alt="setup 02" />
</figure>

<br>

Now to double check it worked, execute the command ```WRKLIBPDM YOURLIB``` 
and you should see your library and a sneak peek at PDM.

<figure align="center">
	<img src="./core/ibmi/_assets/setup-03.PNG" alt="setup 03" />
</figure>


