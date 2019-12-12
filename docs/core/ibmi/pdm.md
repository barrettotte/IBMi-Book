# Programming Development Manager (PDM)

Using PDM and SEU are the "classic" way of developing in IBM i.
If you can learn how to code in the green screen, you can learn how to code in a more advanced tool.
So, I will be using PDM and SEU for the rest of this book.


## Creating a Source Physical File
To mess around in PDM, we will make a source physical file.
The first source physical file we need in the next chapter is **QCLLESRC** to hold our control language (CL) programs.

For now, we will use the menu driven approach to getting to the right command to mix it up a bit.
To change to our previously created library: In the command line, execute the command ```CHGCURLIB YOURLIB```

Now, we'll start PDM to work with objects in our library. Execute the command ```WRKOBJPDM YOURLIB```

Press **F6** to start creating a file.

<figure align="center">
	<img src="./core/ibmi/_assets/pdm-01.PNG" alt="wrklibpdm" />
</figure>

<br>

This is the **CMDCRT** menu. IF you scroll down, you will find **164. Create Source Physical File**

To start the command, either type ```164``` or ```CRTSRCPF``` and **ENTER**.

<figure align="center">
	<img src="./core/ibmi/_assets/pdm-02.PNG" alt="cmdcrt" />
</figure>

<br>

For consistency, I suggest naming your CLLE Source Physical File (SPF) **QCLLESRC**.
Since we switched to our library, we can use the value ***CURLIB** in the library field.
The member field will contain the source type we will use, in this case it will be ***CLLE**
<figure align="center">
	<img src="./core/ibmi/_assets/pdm-03.PNG" alt="cmdcrt" />
</figure>

<br>

To test the SPF creation, execute the command ```WRKMBRPDM YOURLIB/QCLLESRC```
and you should see the newly created SPF.
<figure align="center">
	<img src="./core/ibmi/_assets/pdm-04.PNG" alt="wrkmbrpdm" />
</figure>


## PDM Commands
So far we've used three PDM commands.
* ```WRKLIBPDM``` - Work with libraries using PDM
* ```WRKOBJPDM``` - Work with objects using PDM
* ```WRKMBRPDM``` - Work with members using PDM

You can probably also start to see the pattern of CL commands, but we'll cover that next chapter.
