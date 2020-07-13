# Display Files (DSPF)


Display files are a way to describe an interactive screen using DDS.
Functionality on these screens can vary from a basic data entry program to a complicated "subfile".
I will attempt to briefly go over some basics of DSPFs on this page.


## Comparison to Modern Web Development
When I was first starting, comparing the IBMi stack to a modern web development stack helped me get a better handle on things.
On IBMi, RPGLE is your backend just like Java/Python/C#/Node/etc. is the backend in a web stack.

A simple web frontend consists of HTML, JS, and CSS. On IBMi, DSPFs are your frontend.
A DSPF can trigger backend RPGLE logic, provide simple data validation, display data with different colors, and much more.


## Example
This is an example of a simple DSPF defined with DDS that I threw together.
Don't worry about copying this source, this is just a dumb example I made.

<figure align="center">
  <img src="./core/dds/_assets/dspf-02.png" alt="DSPF"/>
</figure>
<br>



* **line 1** is a regular DDS comment, just like in PFs and LFs.
* **line 2** allows the use of an indicator area with ```INDARA```. This allows the use of indicators between DSPF (frontend) and RPGLE (backend).
* **line 3** defines a record format for the display file. This works just like in the RPGLE + DDS examples.
* **lines 4 and 5** define commands for **F3** and **F5** keys. These will be indicators 3 and 5 in RPGLE.
* **line 6** is simple text display. ```6  4``` means it will be located at the 6th row and 4th column of the screen.
* **line 7** defines a 16 character(A) field. **B** means it is used for both input and output.
* **line 8** defines a 79 character(A) field. **O** means it is only used for output. ```DSPATR(HI)``` changes the appearance of the field.
* **lines 9 and 10** display some text to show what the commands do for this screen. Using ```COLOR(BLU)```, the text is displayed in blue.

Its worth noting that the field/record format names do not need to start with '#'. This is just a convention that I use.
Like other things, just be consistent with what you use.


<br>

Sorry, this looks pretty scuffed. But, I think it works.
After entering a name into the name field (**#1NAME**) and pressing enter, a message is displayed in the message field (**#1MSG**) at the bottom of the screen.

Additionally, pressing **F3** ends the program and **F5** will refresh the screen by clearing all the fields.
I will show how to do all of this in RPGLE later.

<figure align="center">
  <img src="./core/dds/_assets/dspf-01.png" alt="DSPF"/>
</figure>
<br>


## Screen Design Aid (SDA)
Since the DSPFs I make are generally very simple, I do not have much experience using SDA.
SDA is a neat tool to create display files in a more visual way.

To start SDA, use the command ```STRSDA```. 

This tool is worth mentioning, but not required. If you feel like messing around with it, more power to you.



## IBM Documentation
DSPFs have a ton of things that I am not familiar with, so its better to link some IBM documentation

* [DDS for display files](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzakc/kickoff.htm)
* [DDS keywords](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzakc/rzakcmstkeyent.htm)
* [System i Programming DDS for display files](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_71/rzakc/rzakc.pdf)
