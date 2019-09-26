# Aldon and LMi

A Brief set of notes on using Rocket Aldon Lifecycle Manager IBM i Edition (LMi).
I don't really know too much since I've only used it a few times.


## What is it?
LMi is kind of like a version control and continuous deployment tool built into one.
It manages changes, application releases, deployments, and version control.

More can be read here https://www.rocketsoftware.com/products/rocket-aldon/rocket-aldon-lifecycle-manager-ibm-i-edition

Unfortunately, it doesn't seem like there's a lot of information out there and I have minimal knowledge using this tool.


## Environments
* DEV - Local development
* ITG - Integration - development
* QUA - QA Testing environment
* PRD - Production


## The Basics

<br>

To begin, launch **LMi** using the command ```STRLMI```

<figure align="center">
	<img src="./additional/misc/_assets/aldon-01.PNG" alt="aldon" />
</figure>

<br>

Begin checkout process by taking an option **1** for 'Work with objects by release'.

Optional: Search for an object using the 'Position to' field

Select object with option **3** to checkout

<figure align="center">
	<img src="./additional/misc/_assets/aldon-02.PNG" alt="aldon" />
</figure>


<br>

Enter a task number (in my shop's case it is a JIRA ticket number)


**F3** back to main Aldon menu and take an option **2** for 'Work with objects by developer'

<figure align="center">
	<img src="./additional/misc/_assets/aldon-03.PNG" alt="aldon" />
</figure>


<br>

Now this object can be edited, compiled, etc. in this local environment (**DEV**).
To promote it up to the next environment (**ITG**), take an option **7**.


<br>

Everytime I've used LMi (Maybe like 10 times) I use all of the defaults on the following screens.


<br>


The same process can be done to promote from **ITG** to **QUA** to **PRD**.


## View Object Log

Additionally, you can view the log of an object by taking an option **7** while 
inside of the 'Work with objects by release' menu.

Here you can see each time an object was checked out or promoted.

<figure align="center">
	<img src="./additional/misc/_assets/aldon-04.PNG" alt="aldon" />
</figure>

<br>

