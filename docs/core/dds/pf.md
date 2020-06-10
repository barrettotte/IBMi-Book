# Physical Files (PF)

Physical files are database files. They are described by a DDS source member and contain queryable data.
Each physical file holds a record format to provide information about how it's data is structured.
Before SQL was widely used on IBMi, this was the primary method of defining tables (database files).


## Source Physical Files
The source physical files we use to hold our source members are a special type of physical file.
Each line of a source program is a record in a source physical file. 
In a later section, I will show you how to query some source code using SQL.


## Terminology
At this point, I think its important to get some terminology out of the way.
IBMi folks use some different terms that might sound a little strange at first.
But, this is just because these terms have been around long before what is currently used today.

| Term          | Explanation     |
| ------------- | --------------- |
| File          | A table         |
| Field         | A table column  |
| Record        | A table row     |
| Record Format | A definition of columns in a row |



## Ordering
The order of declaring DDS records for a physical file matter.
The order has to be the following, but not all are necessary:
* File level records
* Record level records
* Field level records
* Key field level records

This will make more sense after looking at the example DDS below.


## Example DDS
I will show a basic DDS for a physical file and explain what's going on. Just like CL and RPG(LE), DDS is also promptable with **F4** in SEU.


<figure align="center">
  <img src="./core/dds/_assets/pf-01.png" alt="PF"/>
</figure>
<br>

* Each record in a DDS source member can start with **A** in **column 6**. 
I think that it might be optional, but I always include it anyway so that SEU prompting works correctly.
* **Line 1** shows how to do a comment with an asterisk in **column 7**. This is exactly the same as how RPGLE fixed comments work.
* **Line 5** has an **R** in **column 17**, this signals that we are going to be expressing a record format with name **PERSONFMT** in the following records.
* At the end of **line 5**, we use a keyword called **TEXT** to leave ourselves a comment about what this line is doing (this is optional).
* **Lines 8-11** are declaring fields in our record format. This uses a similar format that RPGLE fixed uses for data types.
* **Line 14** is specifying a primary key constraint on the field named **PERSONID**


## Viewing a Physical File
There are a couple cool commands that we can use to view a physical file and its contents.

For a description of a physical file's fields we can use ```DSPFFD FILE(BOLIB/PERSON)``` (Display File Field Description).
Using this command you get to see a bunch of cool stuff about the physical file.

<figure align="center">
  <img src="./core/dds/_assets/pf-02.png" alt="DSPFFD"/>
</figure>
<figure align="center">
  <img src="./core/dds/_assets/pf-03.png" alt="DSPFFD"/>
</figure>
<br>


We can also use ```DSPFD FILE(BOLIB/PERSON)``` (Display File Description) to view some high level information about the file.
I don't think I've ever used this command personally, but I'm sure there is some good stuff in here to look at.

<figure align="center">
  <img src="./core/dds/_assets/pf-04.png" alt="DSPFD"/>
</figure>
<br>


## Querying a Physical File
I haven't touched on DB2 SQL yet, but I figured I should show a basic example while we're here.
In a later section, I will be going more in depth with how to use **Run SQL Scripts** to run SQL instead of the 5250 emulator.

To start an SQL session use ```STRSQL```. This gives you a bunch of lines to write SQL queries on.

<figure align="center">
  <img src="./core/dds/_assets/pf-05.png" alt="STRSQL"/>
</figure>
<br>

Run ```select * from bolib/person```. We don't have any data, but there are the columns that were defined in the DDS.
<figure align="center">
  <img src="./core/dds/_assets/pf-06.png" alt="SELECT"/>
</figure>
<br>


Let's insert some records real quick with ```insert into bolib/person values (1,'Barrett','Otte',24), (2,'First','Last',123)```
<figure align="center">
  <img src="./core/dds/_assets/pf-07.png" alt="INSERT"/>
</figure>
<br>

And run the query ```select * from bolib/person``` again. Now that looks a little more interesting.
<figure align="center">
  <img src="./core/dds/_assets/pf-08.png" alt="SELECT"/>
</figure>
<br>

Again, I want to emphasize that using ```STRSQL``` is not the ideal way to run SQL queries. We will be revisiting SQL shortly.


## Display File Utility
I will not be covering **Data File Utility (DFU)**, this is an insecure legacy utility that is no longer best practice.
I have messed around with it a little bit, but I don't think its worth learning anymore.


DFU allows you to essentially create a quick and dirty CRUD interface over a database file called a DFUPGM.
However, this program is very insecure and can lead to some catastrophic errors. 
So to reiterate, I don't recommend using it as a production application.

If you still feel inclined to mess around with DFU, use the command ```STRDFU```.
After creating a DFUPGM, it can be started with ```DFUPGM(MYDFUPGM)```.



## Conclusion
There is a lot more you can do with DDS for physical files, but this is just a general introduction.
I included some links to IBM documentation for a full list of functions you can use in physical files and some more detailed column definitions.

This gets a lot more interesting when we get RPGLE and SQL into the mix, we'll get there soon.


## IBM Documentation

* DDS for Physical and Logical files - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzakb/kickoff.htm
* Keywords for Physical and Logical files - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzakb/rzakbmstlfkeyw.htm
* Defining a Physical File Using DDS - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzakb/dphydds.htm