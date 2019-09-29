# Aldon and LMi

A brief set of notes on using **Rocket Aldon Lifecycle Manager IBM i Edition (LMi)**.
I don't really know too much since I've only used it a few times, but I can at least write down a couple of things.

Unfortunately, it doesn't seem like there's a lot of information out there and I have minimal knowledge using this tool.
I barely know how to do the Aldon equivalent of tying your shoes.


## What is it?
LMi is kind of like a version control and continuous deployment tool built into one.
It manages changes, application releases, deployments, and version control.

More can be read here https://www.rocketsoftware.com/products/rocket-aldon/rocket-aldon-lifecycle-manager-ibm-i-edition


## Environments
Environment naming is slightly different than you'd expect, but still intuitive.

* DEV - Local development
* ITG - Integration - development
* QUA - QA Testing environment
* PRD - Production


## A Basic Checkout

To begin, launch **LMi** using the command ```STRLMI```

<figure align="center">
	<img src="./additional/misc/_assets/aldon-01.PNG" alt="aldon" />
</figure>

<br>

Begin the checkout process by taking an option **1** for ```Work with objects by release```.

Optionally, you can quickly search for an object by typing into the ```Position to``` field at the top of the screen.

Take an option **3** on your target object to checkout to your local environment.

<br>

<figure align="center">
	<img src="./additional/misc/_assets/aldon-02.PNG" alt="aldon" />
</figure>


<br>

If needed, enter a task number. 
In my shop's case someone made a utility in JIRA to create JIRA tickets in LMi (sorry can't share it).

**F3** back to the Aldon main menu and take an option **2** for ```Work with objects by developer```.

Now this object can be edited, compiled, etc. in this local environment (**DEV**) separate from everything.

<figure align="center">
	<img src="./additional/misc/_assets/aldon-03.PNG" alt="aldon" />
</figure>


## A Basic Deploy

To promote an object up to the next environment (**ITG**), take an option **7**.
Everytime I've used LMi (Maybe like 10 times) I use all of the defaults on the next few screens.
This same process can be done to promote from **ITG** to **QUA** to **PRD**.


From what I've heard **deploying a view in Aldon is very janky**. 
I found this out the hard way and had to get a lot of help.


## View Object Log

Additionally, you can view the log of an object by taking an option **7** while 
inside of the ```Work with objects by release``` menu.

Here you can see each time an object was checked out or promoted.

<figure align="center">
	<img src="./additional/misc/_assets/aldon-04.PNG" alt="aldon" />
</figure>

<br>

