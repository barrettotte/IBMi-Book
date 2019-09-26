# Integrated File System (IFS)


TODO: Picture of IFS window


## Light Introduction 

I apologize ahead of time, I don't know very much about the history of the IFS.


In the past, the IBMi only used its ancient file system to store data.
At some point, the Integrated File System (IFS) was introduced which provided a UNIX like file system on the IBMi.

This was an awesome feature because it makes storing and retrieving files on the IBMi much easier.
Additionally, it provided a more user friendly approach to viewing and organizing files.



## Accessing the IFS within ACS

Within Access Client Solutions there is an IFS browser at General > Integrated File System.

TODO: Picture of ACS with IFS highlighted


After signing in again, you are brought to your user's home directory by default at **/home/YOURUSER**. 

TODO: Picture of user directory with right click menu open


Within this menu you can fully manage files as you normally would in a UNIX file system.


## Accessing the IFS with SSH

Open a command prompt and enter ```YOURUSER@YOURBOX```.
You should be prompted for your password and you will be redirected to **/home/YOURUSER**

TODO: Picture of ssh window with user directory



## Navigating IBMi File System

Within an IFS browser, navigate to **/QSYS.LIB** and you will see all of the libraries on your IBMi.

TODO: Picture of libraries


Navigate to **/QSYS.LIB/YOURLIB.LIB** and you will see all of the files within your library.

TODO: Picture of files


Navigate to **QSYS.LIB/YOURLIB.LIB/QRPGLESRC.FILE** and you will see all of the source members within your RPGLE source physical file.

TODO: Picture of members
