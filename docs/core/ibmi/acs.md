# Access Client Solutions (ACS)

<br>

**ATTENTION!**
The rest of this book assumes that you gained the trust of a wise IBM i developer
and they set you up with a user profile and a user library. 


## Installation

Since this is already documented in IBM documentation, I will not be retyping it here.
Hopefully, this page doesn't go anywhere in the near future https://www.ibm.com/support/pages/obtaining-ibm-i-access-client-solutions


If for some reason this page disappears, I'll update this book with the missing information.


## Getting Started

Upon launching Access Client Solutions, you are greeted with this screen.


<figure align="center">
	<img src="./core/ibmi/_assets/acs-01.PNG" alt="ACS Startup Screen" />
</figure>


## Setting up a System Connection

In order to do anything here, a system connection has to be configured.
Click on **Management** > **System Configurations** > **New** . Enter the **server name** and optionally a **description**.

<figure align="center">
	<img src="./core/ibmi/_assets/acs-02.PNG" alt="ACS Connection" />
</figure>

<br>

Click on the **Connection** tab. This is personal preference, but I set **Prompt for user name and password every time**
<br>

<figure align="center">
	<img src="./core/ibmi/_assets/acs-03.PNG" alt="ACS Connection" />
</figure>

<br>

Click **Ok** > **Close** and now the connection can be selected here

<figure align="center">
	<img src="./core/ibmi/_assets/acs-04.PNG" alt="ACS Setup" />
</figure>

<br>



## Custom Border in Run SQL Scripts
I would suggest setting this up now if you are going to be working in different IBM i environments.
I will show you how to easily tell that you are running a SQL statement in a **production** environment using a border.

Go into **Run SQL Scripts** > **View** > **Custom Border Settings**

<figure align="center">
	<img src="./core/ibmi/_assets/acs-05.png" alt="Custom border settings" />
</figure>
<br>

I personally like this configuration, but set anything you want in here that makes sense.

<figure align="center">
	<img src="./core/ibmi/_assets/acs-06.png" alt="Custom border settings" />
</figure>
<br>

Now you can easily tell what environment you're in just by seeing the scary red border.

<figure align="center">
	<img src="./core/ibmi/_assets/acs-07.png" alt="Run SQL Scripts with Border" />
</figure>
<br>



As the book goes on, I'll touch on a bit more of ACS roughly in the following sections:

* **5250 Emulator** - This chapter
* **Schemas** and **Run SQL Scripts** - DB2 SQL
* **Integrated File System** - Additional Content


I should probably learn how to use some of the other sections, but I haven't gotten around to it yet.

