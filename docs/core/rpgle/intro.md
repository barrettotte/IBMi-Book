# Introduction to RPGLE Programming


I'm going to do my best on covering the basics of this language. 
But, nothing I write is going to beat an actual book from IBM themselves.


**Download this now!** https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_71/rzasd/sc092508.pdf



## History
As I stated in a previous [section](https://barrettotte.github.io/IBMi-Book/#/core/ibmi/history), **Report Program Generator** (RPG) was developed as a programming language used for generating reports.
RPG was first written on 80-column punchcards.
Understandably the language is columnar and looks relatively gross as a result.

Since this language was meant to mimic early electromechanical machines, it has quite a few quirks that seem strange to a modern programmer. Over time, the language evolved and added various features.


The current iteration of RPG is **RPGLE** or **RPG IV**. I'm not really intending to get into "ILE" concepts too much in this book. But, I thought I should state that RPGLE and RPG IV for my intent are synonymous.


## RPG Cycle
Back in the mid 1930s-1950s there were various electromechanical tabulator and accounting machines that tabulated punch cards. In other words, a stack of punch cards (data) were read and loaded into a machine faster than a human would be able to read and input. This automatic reading/writing punchcards can be referred to as a machine cycle or fixed processing cycle.
This isn't the complete picture, but its hopefully sufficient for the next paragraph.

In RPG, there is a core concept known as the **RPG cycle** which is basically the same idea as a machine cycle.
The RPG cycle automatically reads through each record in a data file while also executing various subroutines.
RPG was widely adopted due to its simplistic handling of data files. 
Inputting a data file and outputting a report did not require a bunch of complex instructions.

This concept is critical for older RPG and RPGLE programming,
but I believe its still important to know about.

<br>
<figure align="center">
	<img src="./core/rpgle/_assets/rpglcyc.gif" alt="RPG cycle" />
    <figcaption align="center">
		RPG Logic Cycle
		<a href="https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_74/rzasd/gencyc.htm">
			[Image Source]
		</a>
	</figcaption>
</figure>


## Indicators
Indicators are pretty much just switches. They are a set of continuous single bytes in memory.
If you couldn't tell, indicators are also a remnant of RPG's origin.

There are 99 indicators (01-99) that you can use throughout a program.

The most important indicator to remember is the **LR (Last Record) indicator**.
This indicator is used to signal that the RPG cycle is finished processing.

There are a couple other sets of indicators that I've never messed with:
* Halt indicators(H0-H9) - will halt the program before reading next record
* Overflow indicators(OA-OG,OV)



## Specifications
Each line of an RPG program has a specification assigned to it. This specification dictates both format and meaning of the source statement.

In the a few sections, I will list out the specifications for fixed format RPG IV (RPGLE).


