## Navigation

Luckily, a lot of the screens on the IBM i handle the same way.
So, I'm going to walk through some basic navigation by calling a command in a few different ways.


## Basic Input
The top section specifies valid options that can be entered into the **Opt** column.
The bottom section specifies valid function keys that can be used in this context.
Small note, to access **F13**-**F24** hold **SHIFT**. (F17 = F5+SHIFT)

Above the bottom section is the command line, we will use it below.

<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-13.PNG" alt="Input" />
</figure>


## Running Your First CL Command

Here you are going to run a simple Control Language (CL) command to display your user profile.
I'll cover more on CL programming in the next chapter, but for now position the cursor to the command line and type in the command
```DSPUSRPRF``` and press **ENTER** or **F4** (F4=Prompt)

<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-04.PNG" alt="Main Menu CL" />
</figure>


## The Command Prompt

So, here is the command prompt **screen** presented when calling the ```DSPUSRPRF``` command with no parameters. The system is waiting for you to enter the required parameters.
1. The command description and name
2. Parameter description
3. Parameter value
4. Parameter possible values
5. Function keys
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-05.PNG" alt="DSPUSRPRF" />
</figure>


## Getting More Information

If you are unsure of what to do, the individual parameters can be prompted.
Position the cursor in the input field for User Profile and press **F4**.
Now, a more detailed prompt for the individual parameter can be seen.
This may or may not help, but the more information the better.
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-07.PNG" alt="DSPUSRPRF" />
</figure>


One of the most valuable parts of IBM i is the integrated help menu.
If you position the cursor over the description for User Profile and press **F1**
a help popup will appear with more information about the parameter you need to fill.
In general if I get confused about something I just start pressing **F1** on random things like a mad man.
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-08.PNG" alt="DSPUSRPRF" />
</figure>


## The Command Result
Finally, a bunch of user profile values can be seen displayed for your user.
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-06.PNG" alt="DSPUSRPRF" />
</figure>


## Calling the Command with No Prompt
If you know the parameters you need already, you can call the command with its required parameters.
Following the last example, you can type ```DSPUSRPRF USRPRF(YOURUSER)``` to get to the same result as before.
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-09.PNG" alt="DSPUSRPRF" />
</figure>


## Searching for the Command
Positioning the cursor in the command entry line and pressing **F4** will display a menu for
selecting a command group. We will choose the option for ```SLTCMD``` using its index of 1.
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-10.PNG" alt="DSPUSRPRF" />
</figure>

You are presented with a command prompt for the ```SLTCMD``` command and should just press **ENTER**.
Now you can see a screen displaying all of the CL commands you can execute (around 2000). 
To do a quick search we can position ourselves using **F17**.
This popup takes in a string to quickly position yourself to what your searching for.
Type in ```DSP``` and hit **ENTER**
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-11.PNG" alt="DSPUSRPRF" />
</figure>

There are quite a few display commands, but after scrolling down you can select ```DSPUSRPRF``` by
populating the **Opt** column with a 1. 
After pressing **ENTER**, we are at the same command prompt as earlier.
<figure align="center">
	<img src="./core/ibmi/_assets/ibmi-12.PNG" alt="DSPUSRPRF" />
</figure>