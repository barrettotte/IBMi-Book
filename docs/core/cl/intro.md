# Introduction to CL Programming


Control Language (CL) programming can be compared to Bash or Microsoft Batch programming.
CL is a programming language meant for running system commands, not database interaction or complex logic programs.
For more complex tasks using RPG, SQL, or COBOL would be a better tool.

CL commands can be run in the command prompt or grouped together and compiled into a CL program.
Pretty much everything run on IBM i is triggered through some kind of CL command(s).


## Before Continuing
I will pass over a lot of stuff because both you and I are going to get bored of reading/typing everything CL has to offer.

When in doubt google things.
This is also a pretty good reference to have handy https://www.ibm.com/support/knowledgecenter/en/ssw_ibm_i_71/rbam6/clpro.htm .

Say what you want about IBM, but their documentation is pretty good for beginners.



## Verbs and Subjects

To IBM's credit, CL commands follow a pretty intuitive syntax. 
Each command is comprised of a **verb** (usually 3 characters) and a **subject**.
For example, in the last chapter the command ```DSPUSRPRF``` is comprised of the verb **DSP** (display) and the subject **USRPRF** (user profile). This makes it pretty easy to remember commands over repetitive usage.


Verb examples:


| Verb      | CL   |
| --------- | ---- |
| Copy      | CPY  |
| Change    | CHG  |
| Declare   | DCL  |
| Retrieve  | RTV  |
| Work with | WRK  |


<br>

Subject examples:


| Subject   |  CL  |
| --------- | ---- |
| Command   | CMD  |
| File      | F    |
| Job       | JOB  |
| Library   | LIB  |
| Program   | PGM  |


## Adjectives
Just like English, in a CL command a subject can have an **adjective** attached to it.
This allows a more specific CL command to be executed.

The command for creating an RPG program would be:

```CRTRPGPGM``` = CRT (verb) + RPG (adjective) + PGM (subject)


The command for creating a Physical File (PF) would be:

```CRTPF``` = CRT (verb) + P (adjective) + F (subject)


## Parameters
Additionally, some commands have required or optional parameters that can be
specified in the prompt or included in the command invocation.

When parameters are included with the command call, they can be entered as named or positional.

For example, the CHGCURLIB has a parameter for current library CURLIB.

To specify it as a **named parameter**: ```CHGCURLIB CURLIB(YOURLIB)```

To specify it as a **positional parameter**: ```CHGCURLIB YOURLIB```




