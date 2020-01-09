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

Begin the checkout process by taking an option **1** for **Work with objects by release**.

Optionally, you can quickly search for an object by typing into the ```Position to``` field at the top of the screen.

Take an option **3** on your target object to checkout to your local environment.

<br>

<figure align="center">
	<img src="./additional/misc/_assets/aldon-02.PNG" alt="aldon" />
</figure>


<br>

If needed, enter a task number. 
In my shop's case someone made a utility in JIRA to create JIRA tickets in LMi (sorry can't share it).

**F3** back to the Aldon main menu and take an option **2** for **Work with objects by developer**.

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


## Dealing with Failed Creations

There's probably multiple ways to do this, but I'm going to write the way I do it.
After a failed creation, I enter the command ```wrksbmjob``` to find my latest job
with the name **ACMSCREATE**.

Take an option **8** for **Work with Spooled Files**

Now any of the spooled files can be viewed with option **5**.


## View Object Log

Additionally, you can view the log of an object by taking an option **7** while 
inside of the **Work with objects by release** menu.

Here you can see each time an object was checked out or promoted.

<figure align="center">
	<img src="./additional/misc/_assets/aldon-04.PNG" alt="aldon" />
</figure>

<br>


## Retiring an SQL Function Object
To preface, I just added this section for my own personal notes, may not be useful to anyone.

I made this pretty cool SQL function, but I eventually needed to use some dynamic SQL and error handling.
So I had to retire my SQL function and replace it with a procedure. It should be super easy like always; just take an option **25**, right?

<figure align="center">
	<img src="./additional/misc/_assets/aldon-retire-sqlfunc4.PNG" alt="aldon" />
</figure>

Oh.

I guess not.

Regular objects are a lot easier to retire, but retiring an SQL function is pretty ugly for some reason.
I can't take credit for figuring this out, my coworker Dawn was the one who sat on the phone
with Rocket and documented the whole process.


First, create a new release object with **F6** from within the **Work with Objects by Release** menu with the same attributes as the object that should be retired.
However, in the **Release**, **Application**, and **Group** fields needs to be set to ```ZZLMIBLOCK```. 
All I know is that this is some LMi black magic and it makes everything work behind the scenes.

<figure align="center">
	<img src="./additional/misc/_assets/aldon-retire-sqlfunc.PNG" alt="aldon" />
</figure>

<figure align="center">
	<img src="./additional/misc/_assets/aldon-retire-sqlfunc2.PNG" alt="aldon" />
</figure>

<br>

After creating the **blocking object**, it needs to be promoted to the ZZMLIBLOCK release's production environment.
From Aldon's main menu, press **F22** to edit user default's. Change **Release**, **Application**, and **Group**
fields to ```ZZLMIBLOCK``` (be sure to write them down if you won't remember them).

<figure align="center">
	<img src="./additional/misc/_assets/aldon-retire-sqlfunc5.PNG" alt="aldon" />
</figure>

<br>

Next, take an option **1** **Work with Objects by Release** and find the blocking object that was created.
Promote it to production environment with option **7** and it should be good to go.
Finally, press **F22** and restore your previous **Release**, **Application**, and **Group** values.

Now its finally time to retire the object. At Aldon's main menu, take an option **1** **Work with Objects by Release**
and locate the object to be retired. Take an option **25** on it and the previously created blocking object can now be used.

<figure align="center">
	<img src="./additional/misc/_assets/aldon-retire-sqlfunc3.PNG" alt="aldon" />
</figure>

<br>

Now the SQL function can be successfully retired. 
To double check it was successful, enter the command ```WRKOBJ *ALL/SOMEOBJECT``` and verify the results.

