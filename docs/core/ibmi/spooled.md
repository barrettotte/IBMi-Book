# Spooled Files


Each time a job is ran it can generate what is known as a spooled file.
To put it simply, this is just an output file that contains information like job diagnostics, errors, etc.

One of the most valuable times to look at a spooled file is for compile listings.
When you submit a job to compile a program it generates a handful of spooled files.
One of the spooled files will be the compile listing where it details warnings, errors, etc.
This is very useful for trying to figure out why your program won't compile.

TODO: Picture of a spooled file
TODO: Picture of a spooled file with errors


## Control Commands
A lot of the time, viewing a spooled file is really annoying because
you have to keep moving left and right due to the screen constraints.

There are a few commands that will make things easier to read.
Input commands in the **Control** field at the top of the screen.

| Command | Description                           |
| ------- | ------------------------------------- |
| T       | Top of file                           |
| B       | Bottom of file                        |
| n       | (number) put n lines at top of screen |
| Pn      | (Page number) go to page n            |
| Wn      | Put n columns on left side of screen  |
| W+n     | Move screen right n times             |
| W-n     | Move screen left n times              |

<br>
<figure align="center">
	<img src="./core/ibmi/_assets/splf-01.PNG" alt="control field" />
</figure>



