# Integrated File System (IFS)


<figure align="center">
	<img src="./additional/misc/_assets/ifs-01.PNG" alt="IFS" />
</figure>


## Light Introduction 

I apologize ahead of time, but I don't know very much about the history of the IFS.


In the past, IBM i only used its traditional file system to store data.
At some point, the **Integrated File System (IFS)** was introduced which provided a UNIX like file system on IBM i.
This provided a more user friendly approach to viewing and organizing files.


## Accessing the IFS within ACS

Within Access Client Solutions there is an IFS browser located at ```General > Integrated File System```.


After signing in again, you are brought to your user's home directory by default at ```/home/YOURUSER```. 


Within this menu you can fully manage files as you normally would in a UNIX file system.

<figure align="center">
	<img src="./additional/misc/_assets/ifs-02.PNG" alt="IFS" />
</figure>


## Accessing the IFS with SSH

Open a command prompt and enter ```YOURUSER@YOURBOX```.
You should be prompted for your password and you will be redirected to ```/home/YOURUSER```

<figure align="center">
	<img src="./additional/misc/_assets/ifs-04.PNG" alt="IFS" />
</figure>


## Navigating IBM i File System

Within an IFS browser, navigate to ```/QSYS.LIB``` and you will see all of the libraries on IBM i.


Navigate to ```/QSYS.LIB/YOURLIB.LIB``` and you will see all of the files within your library.

<figure align="center">
	<img src="./additional/misc/_assets/ifs-05.PNG" alt="IFS" />
</figure>

<br>

Navigate to ```QSYS.LIB/YOURLIB.LIB/QRPGLESRC.FILE``` and you will see all of the source members within your RPGLE source physical file.

<figure align="center">
	<img src="./additional/misc/_assets/ifs-06.PNG" alt="IFS" />
</figure>
