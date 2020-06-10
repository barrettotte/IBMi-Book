# Logical Files (LF)


Logical files do not contain any data. They are described by a DDS source member and are dependent on physical files.
A logical file is essentially a dynamic database file that does not exist until queried and uses record formats to retrieve the appropriate records.

Logical files are the SQL equivalent of views/indexes.



## Non-Join Logical File
The only type of logical file I have any experience with is a non-join logical file.
This type of logical file can use various record formats (from physical files) to create a dynamic record selection.
Each record format uses a single read operation to retrieve the records.

Unlike SQL views, non-join logical files can actually be updated (insert, update, etc), although I don't think it is best practice anymore.
I guess join logical files would actually be the closest comparison.
When updating a logical file, it matches each record format with the corresponding physical file for a particular field.


## Join Logical File
A join logical file allows you to combine multiple physical files into a single record format.
This allows you to retrieve records in a single read operation since there's only one record format.

I think that at one point in time using join logical files was critical to squeeze out more performance in an application.
But, I think that machines that run IBMi are so fast now that this is becoming less of a necessity.


Unlike a non-join logical, join logical files cannot be updated.
I haven't used these very much, so here is a page from [IBM documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/dbp/rbafox2phyf.htm)


## Example DDS
For simplicity, I will only be showing a simple non-join logical file with a single record format.
This logical will be built off of the physical **PERSON** that was created in the previous section on physical files.

<figure align="center">
  <img src="./core/dds/_assets/lf-01.png" alt="LF"/>
</figure>
<br>

* **Line 1** specifies the new record format **PERSLFMT** for this logical
* **Line 1** also specifies that it is being created over the physical (PFILE) **BOLIB/PERSON**
* **Lines 2-4** are specifying the records we want to use in the **PERSLFMT** record format. Notice how **LASTNAME** has been excluded from selection.
* **Line 5** specifies a key constraint, just like in **BOLIB/PERSON**. But, it could be specified on a different field.
* **Line 6** specifies records that should be omitted (O). In this case, if the **AGE** field is ```LT 20``` the record will not be included in the record selection.



## Querying a Logical File
Just like a physical file, we can use SQL to query for records.

Start an SQL session with ```STRSQL``` and enter the SQL ```select * from bolib/personlf```.
Here you can see a slightly thinner record selection (no **LASTNAME field**) and it only contains records that have an age greater than 20.


<figure align="center">
  <img src="./core/dds/_assets/lf-02.png" alt="LF query"/>
</figure>
<br>



## Conclusion
Just as I said with physical files, you can do some other cool things. So, I also included more IBM documentation links.
To reiterate, this gets a lot more interesting when we get RPGLE and SQL into the mix, we'll get there soon.


## IBM Documentation
* DDS for Physical and Logical files - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzakb/kickoff.htm
* Keywords for Physical and Logical files - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzakb/rzakbmstlfkeyw.htm
* Defining a Logical File Using DDS - https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_73/rzakb/ldef.htm

