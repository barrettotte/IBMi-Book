# IBM i Concepts

So, IBM i has a lot to it.
I will go over some of the basics needed to be prepared for learning IBM i.
Don't expect to fully understand everything at first, everything will get clearer
once you get your hands dirty.

I truthfully skipped over a lot of the operating system concepts when I decided to start learning.
After coding around in IBM i for a little while, the concepts are learned by accident.


I also have holes in my knowledge when it comes to things such as journaling, user/group profiles, and printing.
If I end up learning some missing information, I will add it to this section.


## Object
Anything on IBM i that has a name is considered an object.
Each object has its own **object type**, to dictate how it is used by the system.
Examples of object types:
* *USRPRF - user profiles
* *PGM - program
* *LIB - library


## Library
Objects are stored in directory-like objects called libraries.
A library is a way to logically organize objects.

Users can create libraries, but there are also special system libraries shipped with the OS.
Libraries that start with 'Q' are often system objects.
Here are a few of them:
* QSYS - Essential system objects
* QSYS2 - Additional system objects
* QHLPSYS - Help information
* QUSRSYS


## Library List
A library list is a list of library references that the system uses to locate objects.
When referencing an object, the system looks in each library within the library list
for the object until the first result is found.

Example of looking for an object named MYOBJ:
* ABCLIB - [WASD,QWERTY]
* MYLIB - [HELLO,MYOBJ] **FOUND IT**
* OTHERLIB - [MYOBJ]

To guarantee the reference to an object, you can use the **qualified name** to specify which library it is in.
For example, if you want the object MYOBJ in library MYLIB, the qualified name would be MYLIB.MYOBJ


## Job
* **Interactive job** - A job that runs within a user's session.
* **Batch job** - A job that runs "headless", no need for a user to be signed in. It will wait in a queue for system resources as needed.

Batch jobs are submitted to a **job queue** until they are run by the system.
Sometimes there aren't enough resources to start the job, so it must wait for the resources to be freed up.


## Subsystems
A subsystem is a segmented environment with its own resource pool and workflow.
All jobs are run within a specified subsystem.
There are more subsystems than these, but here are some basics:
* QBATCH - Subsystem for batch jobs
* QINTER - Subsystem for interactive jobs
* QSPL - Spooling subsystem for reading and writing jobs

I believe you can also create your own subsystems, but I don't know anything about it.
So, I will not be covering anything about it in this book.


## Files
* **Physical File** - A file to contain data with a predefined format.
* **Source Physical File** - A physical file for containing source members. 
* **Logical File** - A file that does not occupy any memory. 

The idea of a physical versus a logical file will start to make more sense
when DB2 SQL is introduced. (spoiler: table vs view)


Obviously more information will be learned as you go through this book,
but these are some concepts we can work with in the rest of this chapter and the next one.

