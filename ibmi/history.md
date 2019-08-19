# History of the IBMi


This section will be an attempt to lightly describe the history of this machine without boring the reader too much.


<figure align="center">
	<img src="_assets/ibmi-03.PNG" alt="IBM 400 series Accounting machine" />
	<figcaption align="center">
		<a href="http://www.bitsavers.org/pdf/ibm/punchedCard/AccountingMachine/224-1614-13_402-403-419.pdf">
			[ Image Source ]
		</a>
	</figcaption>
</figure>


## IBMi Ancestry

**History of Punched-Card IBM Machines**:
* 1880 **Hollerith Census Tabulator** → Only capable of counting
* 1928 **Hollerith Type IV Tabulator** → First appearance of 80-column card
* mid 1930s-1950s **IBM 400 series accounting machines**
* 1959 **IBM 1400 series** → RPG I
* 1969-1977 **IBM System/3** → RPG II, First appearance of 96-column card
* 1978 **IBM System/38** → RPG III
* 1988 **Application System/400 (AS/400)** → RPG 400/IV
* 2000 iSeries (renamed from AS/400)
* 2006 System i (renamed from iSeries)
* 2008 IBM Power Systems generation replaces IBM System i

The naming of the IBMi gets a little confusing when you google things. You'll see IBMi, AS/400, iSeries, IBM System i, etc.
**All that said, I will refer to the box as the IBMi from here onwards.**


## RPG's Evolution

<figure align="center">
	<img src="_assets/ibmi-04.jpg" alt="96 Column Card" />
	<figcaption align="center">
		96 Column Card
		<a href="https://www.flickr.com/photos/tubetime/3492103709/in/photostream/">
			[ Image Source ]
		</a>
	</figcaption>
</figure>

<br><br>

**Report Program Generator** (RPG) was developed to replicate punching 80-column cards on the IBM 1400 series as 
a programming language used for generating reports. Understandably the language is columnar and looks pretty gross as a result.

As time went on and the IBMi (AS/400) evolved, the language evolved with it. It gained various features and improvements along with
the system it ran on. The current version of RPG (RPGIV) allows for "free-format" code, breaking its ties to its columnar ancestors.
Modern RPGIV can be considered a general purpose programming language, although I'd be careful who you said that to.

In this book, I will briefly go over fixed-format RPG. But, the main focus will be on either completely free-format
or mixed format.


#### Hello World in fixed-format RPG III

<script src="https://embed.cacher.io/d8513cd10a31f941a1a245c10d7f1bf5235afb10.js?a=d6ff662387b87f72743a3071772e16d8&t=github_gist"></script>


#### Hello world in fixed-format RPG IV

<script src="https://embed.cacher.io/d25169d60e67f843aca941920b2c19f47f5dfd12.js?a=3f1696dc0713ee878e17fbbb600d9cf1&t=github_gist"></script>


#### Hello world in free-format RPG IV

<script src="https://embed.cacher.io/d80569830c30fc43aaf840c55f7b12af2b0ea943.js?a=7a41de3f55d2c3783ffe602ba90d7133&t=github_gist"></script>



<br>
As you can see, free-format RPG IV looks pretty readable. I think its worthwhile to be able to read fixed-format RPG III. But,
a majority of effort should be put on RPG IV free and mixed-format.


By no means is this a complete history. There's much more about the IBMi that I skipped over. 
I think that this level of knowledge is sufficient to start learning this machine.


## References / Additional Reading
* Columbia University Computing History - http://www.columbia.edu/cu/computinghistory/
  * Hollerith Census Tabulator - http://www.columbia.edu/cu/computinghistory/census-tabulator.html
  * IBM 402 - http://www.columbia.edu/cu/computinghistory/402.html
* Tabulating Machine - https://en.wikipedia.org/wiki/Tabulating_machine
* IBM Accounting Machine Manual - http://www.bitsavers.org/pdf/ibm/punchedCard/AccountingMachine/224-1614-13_402-403-419.pdf



