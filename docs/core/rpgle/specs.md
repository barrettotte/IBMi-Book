# RPGLE Format Specifications

Each line of an RPG program has a specification assigned to it. This specification dictates both format and meaning of the source statement. Specifications only apply to fixed-format RPGLE.

RPG IV specifications differ from RPG II and RPG III specifications.
The main differences being additional specification types and more columns to work with.

Do not waste your time memorizing these specifications, you will see why in a later section.


All specifications are optional, but must be defined in the order below.

Note: RPGLE does not have E(File Extension) or L(Line Counter) specifications.


These tables are from [The Modern RPG IV Language](https://www.amazon.com/Modern-RPG-IV-Language/dp/1583470646/ref=sr_1_3) 
and [IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/rpgspec.htm)



## H Specification - Header (Control)
Used to give instructions to the RPG compiler.
This includes program name, date format, debug mode, etc.

| Column | Name      | Value(s) | Description                    |
| ------ | --------- | -------- | ------------------------------ |
| 6      | Form Type | H        | Mark statement as header spec  |
| 7      | Comment   | BLANK    | Process statement as normal    |
|        |           | *        | Mark statement as comment      |
| 7-80   | Functions | Keyword  | [Keywords](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/cscokw.htm#cscokw) to control settings |

[Traditional H Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/conspss.htm)


## F Specification - File Description
Used to declare all files used in the program.

| Column | Name                 | Value(s)     | Description                                                          |
| ------ | -------------------- | ------------ | -------------------------------------------------------------------- |
| 6      | Form Type            | F            | Mark statement as file description spec                              |
| 7-16   | File Name            | (BLANK)      | Statement is a file continuation                                     |
|        |                      | Name         | Name of file                                                         |
| 17     | File Type            | I            | File is opened for input                                             |
|        |                      | O            | File is opened for output                                            |
|        |                      | U            | File is opened for update (read, change, delete)                     |
|        |                      | C            | File is opened for combined (read, write) (WORKSTN files only)       |
| 18     | File Designation     | (BLANK)      | File is an output file                                               |
|        |                      | P            | File is a primary file. (Only one primary file in each RPG program)  |
|        |                      | S            | File is a secondary file                                             |
|        |                      | R            | File is a record daddress (ADDROUT) file                             |
|        |                      | T            | File is a pre-runtime table                                          |
|        |                      | F            | File is a full-procedural file. (Only read through RPG file ops)     |
| 19     | End of File          | (BLANK)      | If all files have BLANK, all records in all files get processed before the RPG cycle sets LR indicator |
|        |                      | E            | When all records of this file are processed, RPG cycle sets LR indicator. (primary or secondary files) |
| 20     | File Addition        | (BLANK)      | For I,U types no records can be added. Compile error if write operation is used              |
|        |                      | A            | For I,U types write operation allowed. Output files ignore this column                       |
| 21     | Sequence             | (BLANK) or A | Sequence for matching record fields is ascending order                                       |
|        |                      | D            | Sequence for matching record fields is descending order                                      |
| 22     | Format               | F            | File is program described (internal). I specs are used to define record format               |
|        |                      | E            | File is externally described. RPG compiler imports record format for file                    |
| 23-27  | Record Length        | (BLANK)      | Valid for externally described file. Compiler imports record length when unspecified         |
|        |                      | 1 to 32766   | Length for file. RPG pads or truncates record as required                                    |
| 28     | Processing Mode      | (BLANK)      | Mode of processing controlled by file designation and record address type                    |
|        |                      | L            | Mode of processing is sequential within limits (it is an ADDROUT file)                       |
| 29-33  | Length of Key Fields | (BLANK)      | Key is externally described or file is not keyed                                             |
|        |                      | 1 to 2000    | Length of key for program described file                                                     |
| 34     | Record Address Type  | (BLANK)      | File processing is sequential or by relative record number                                   |
|        |                      | A            | Key to file is a character value (program described files only)                              |
|        |                      | P            | Key to file is a packed decimal value (program described files only)                         |
|        |                      | G            | Graphics keys (DBCS keyed database file)                                                     |
|        |                      | K            | Keyed file (externally described files only)                                                 |
|        |                      | D            | Key to file is a date value                                                                  |
|        |                      | F            | Key to file is a floating point value                                                        |
|        |                      | T            | Key to file is a time value                                                                  |
|        |                      | Z            | Key to file is a timestamp value                                                             |
| 35     | File Organization    | (BLANK)      | File is not keyed (program described files). Externally described files must have a blank    |
|        |                      | I            | Program described file is indexed (its a keyed file)                                         |
|        |                      | T            | Program described file is a record address file (ADDROUT)                                    |
| 36-42  | Device Type          | DISK         | File is a database file                                                                      |
|        |                      | PRINTER      | File is a printer file and can be written to                                                 |
|        |                      | WORKSTN      | File is an interactive workstation                                                           |
|        |                      | SEQ          | File a sequential file that is processed by read, write, open, and close operations          |
|        |                      | SPECIAL      | File is processed using a special device driver (another RPG program).                       |
| 43     | (Reserved)           | (BLANK)      | Unused                                                                                       |
| 44     | File Keywords        | (BLANK)      | Normal F spec processing                                                                     |
|        |                      | Keyword      | [Keywords](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/fdsent.htm#fdsent) |

[Traditional F Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/fdsent.htm#fdsent)


## D Specification - Definition
Used to declare all variables used in the program.

| Column | Name                      | Value(s)     | Description                                                                          |
| ------ | ------------------------- | ------------ | ------------------------------------------------------------------------------------ |
| 7-21   | Name                      | Name         | Name assigned to definition                                                          |
| 22     | Externally Described      | (BLANK)      | Definition is not externally described                                               |
|        |                           | E            | Definition is externally described                                                   |
| 23     | Data Area                 | (BLANK)      | Data structure is not a data area                                                    |
|        |                           | U            | Data structure is also a data area                                                   |
| 24-25  | Data Set Type             | (BLANK)      | Definition is a data structure subfield                                              |
|        |                           | DS           | Definition is a data structure                                                       |
|        |                           | S            | Definition is a standalone field                                                     |
|        |                           | C            | Definition is a constant                                                             |
|        |                           | PI           | Definition is a procedure interface definition                                       |
|        |                           | PR           | Definition is a procedure prototype                                                  |
| 26-32  | Starting Location         | (BLANK)      | Length notation is used                                                              |
|        | From/To Notation          | 1 to 65535   | Starting location (within DS) of the DS subfield being declared                      |
| 33-39  | Ending Location or Length | (BLANK)      | DS (sum of length of subfields), Constant must be blank                              |
|        | From/To Notation          | 1 to 65535   | If starting position, this is ending location. Else, its the field's length          |
|        | Length Notation           | 1 to 65535   | Length of item being defined                                                         |
| 40     | Data Type                 | (BLANK)      | Data type is implied by other definition properties                                  |
|        |                           | A            | (CHARACTER) character field                                                          |
|        |                           | B            | (NUMERIC) binary field                                                               |
|        |                           | C            | UCS-2 (Unicode), character field (2 bytes/character)                                 |
|        |                           | D            | (DATE) date field                                                                    |
|        |                           | F            | (NUMERIC) floating point numeric                                                     |
|        |                           | G            | (GRAPHIC) double-byte character set (DBCS) field                                     |
|        |                           | I            | (NUMERIC) integer field                                                              |
|        |                           | N            | (CHARACTER) named indicator field                                                    |
|        |                           | O            | (OBJECT) instantiation of a class object                                             |
|        |                           | P            | (NUMERIC) packed decimal field                                                       |
|        |                           | S            | (NUMERIC) zoned decimal                                                              |
|        |                           | T            | (TIME) time field                                                                    |
|        |                           | U            | (NUMERIC) unsigned integer field                                                     |
|        |                           | Z            | (TIMESTAMP) timestamp field                                                          |
|        |                           | *            | (POINTER) pointer field                                                              |
| 41-42  | Decimal Positions         | (BLANK)      | Field is non-numeric                                                                 |
|        |                           | 0 to 30      | Field is numeric                                                                     |
| 43     | (Reserved)                | (BLANK)      | Unused                                                                               |
| 44-80  | Functions                 | (BLANK)      | No additional properties specified                                                   |
|        |                           | Keyword      | [Keywords](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/d4480.htm) |

[Traditional D Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/dsent.htm)


## I Specification - Input
Used to declare program-described file formats and rename externally described file fields.

[I Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/inspec.htm)


## C Specification - Calculation
Used to write instructions to run when program is executed.

| Column | Name                    | Value(s)        | Description                                                                             |
| ------ | ----------------------- | --------------- | --------------------------------------------------------------------------------------- |
| 6      | Form Type               | C               | Mark statement as a calculation specification                                           |
| 7      | Control Code            | *               | Statement is a comment                                                                  |
|        |                         | /               | Statement contains a compiler or preprocessor directive                                 |
|        |                         | +               | Statement is a preprocessor continuation specification                                  |
| 7-8    | Control Level Indicator | (BLANK)         | Statement is a normal statement                                                         |
|        |                         | AN/OR           | Indicator conditioning on previous statement is continued on this line                  |
|        |                         | L0              | Total time calculation. Level zero (L0) is always on                                    |
|        |                         | L1 to L9        | Total time calculation. Control level indicators are tested at total time (level break) |
|        |                         | LR              | Total time and last record processing. Statement performed during total time processing after LR is set on |
|        |                         | SR              | Optional notation to indicate subroutine statement. (typically first and last of subroutine) |
| 9-11   | Conditioning Indicators | (BLANK)         | No conditioning indicators are used to control if statement is processed.               |
|        |                         | Any indicator   | Indicator to control running this calculation statement                                 |
| 12-25  | Factor 1                | (BLANK)         | No factor 1 specified                                                                   |
|        |                         | Any characters  | Entry to be used in operation. Must be left justified                                   |
| 26-35  | Operation Code          | OPCODE          | RPG instruction that should be performed. Some operations can be extended               |
| 36-49  | Factor 2                | (BLANK)         | No factor 2 specified                                                                   |
|        |                         | Any characters  | Entry to be used in operation. Must be left justified                                   |
| 36-80  | Extended Factor 2       | Any characters  | Any expression, can span multiple lines                                                 |
| 50-63  | Result Field            | (BLANK)         | No result field specified                                                               |
|        |                         | Variable name   | Target of operation. Must be left justified.                                            |
| 64-68  | Result Field Length     | (BLANK)         | Defined somewhere else in program or not definable.                                     |
|        |                         | 1 to 30         | For numeric fields                                                                      |
|        |                         | 1 to 65535      | For character fields                                                                    |
| 69-70  | Decimal Positions       | (BLANK)         | -                                                                                       |
|        |                         | 0 to 30         | Number of decimal positions for result field                                            |
| 71-76  | Resulting Indicators    | (BLANK)         | No indicators are set on as a result of this operation                                  |
|        |                         | Any indicator   | Resulting indicators set according to result of operation. All can be set except 1P,MR  |
| 77-80  | (Reserved)              | (BLANK)         | Not used                                                                                |               

[Traditional C Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/calss.htm#calss)


## O Specification - Output
Used to define the output of the program.

[O Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/outspe9.htm)


## P Specification - Procedure
Used to declare the bounds of a subprocedure.

| Column | Name                      | Value(s)     | Description                                                                          |
| ------ | ------------------------- | ------------ | ------------------------------------------------------------------------------------ |
| 6      | Form Type                 | P            | Mark statement as a procedure specification                                          |
| 7-21   | Procedure Name            | Name         | Name of procedure being defined                                                      |
| 24     | Marker                    | (BLANK)      | Statement within a subprocedure block                                                |
|        |                           | B            | Beginning of subprocedure                                                            |
|        |                           | E            | End of subrprocedure                                                                 |
| 44-80  | Functions                 | Keywords     | [Keywords](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/p4480.htm) |

[Traditional P Spec IBM Documentation](https://www.ibm.com/support/knowledgecenter/ssw_ibm_i_72/rzasd/psent.htm)

