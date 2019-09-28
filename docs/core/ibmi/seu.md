# Source Entry Utility (SEU)

Say hello to your new code editor.
As soon as I started messing around with SEU I got traumatic flashbacks
of when I tried to use only Vim for a month straight of side projects.
SEU is definitely rough, but I encourage only using this editor
throughout this book; it will build character.


## Creating a Source Member

To get started, switch to the previously created CLLE SPF, execute the command ```WRKMBRPDM YOURLIBRARY/QCLLESRC```. Next, press **F6** to start SEU.

Fill in a program name into the source member field, I recommend **FIRSTCL** for this.
Since we are within the context of a CLLE SPF the source type can remain ***SAME** and it will be
implied as ***CLLE**. Finally, press **ENTER** to reveal your new editor.
<figure align="center">
	<img src="./core/ibmi/_assets/seu-01.PNG" alt="strseu" />
</figure>


## SEU Line Commands
At first, this will seem pretty janky and that's because it is.
Within the scope of this book, you don't have to memorize these,
they will come with time and frustration.

* 'A' - Paste lines after
* 'B' - Paste lines before
* 'C' - Copy a line
* 'CC' - Start/end a block to copy
* 'D' - Delete line
* 'DD' - Start/end a block to delete
* 'I' - Insert line
* 'M' - Move line
* 'MM' - Start/end a block to move

Additionally, A,B,C,D,I can be used with a numeric.
For example, I5 would insert 5 lines.


## Writing Your First CL Program
I apologize, but you will have to wait until next chapter to learn more about CL.
For now, please just copy the code and follow along with the commands.
With each line that you enter, pressing **ENTER** will advance to the next line.
This program will be something you've seen before, a CL program to display your user profile.
```
PGM
  DSPUSRPRF OTTEB
ENDPGM
```

<br>

After entering this program, you have to save the contents (records).
Press **F3** and you can see the exit prompt. 
Be sure to switch **Change/create member** to **Y** and **Return to editing** to **N**
<figure align="center">
	<img src="./core/ibmi/_assets/seu-02.PNG" alt="save" />
</figure>


## Compiling Your First Program
After saving the source member, it has to be compiled to a **PGM** object.
There is a command for this, but for now the easiest way is to fill in **14** for compile in the **Opt** (option) column for the source member **FIRSTCL**.
<figure align="center">
	<img src="./core/ibmi/_assets/seu-03.PNG" alt="compile" />
</figure>

<br>

Confirm the compile by changing **Delete existing object** to **Y**
<figure align="center">
	<img src="./core/ibmi/_assets/seu-04.PNG" alt="compile confirm" />
</figure>

<br>

To reference a few pages back, this compilation is a **batch job** submitted to a **job queue**.
It is only executed when resources are available for it, so execution time can vary.
In my case, my job's ID was 543172 and what we are viewing is a message sent back
indicating that the compile was successful.
<figure align="center">
	<img src="./core/ibmi/_assets/seu-05.PNG" alt="compile complete" />
</figure>


## Running Your First Program
The compilation produces a **PGM** object in your library that you can call.

Execute the command ```WRKOBJPDM YOURLIB``` and you can see the list of objects within your library.
Something worth looking at is that there is no file with a **CLLE** type here.
That is because our CL program is a source member within **QCLLESRC** and not a standalone object.
However, you can see that our **PGM** object has an attribute of **CLLE**.

To call this program, enter a **C** in the **Opt** column for **FIRSTCL**.
Alternatively, you can call this program by entering the command ```CALL YOURLIB/FIRSTCL```.
Using 'C' on a PGM is essentially a shortcut if your PGM doesn't need any parameters.
<figure align="center">
	<img src="./core/ibmi/_assets/seu-06.PNG" alt="call cl" />
</figure>

<br>

We see the familiar output equivalent to just running ```DSPUSRPRF```
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-06.PNG" alt="DSPUSRPRF" />
</figure>

