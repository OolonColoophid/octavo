# octavo

Create a series of documents, in different formats, from a single Markdown source. This tool has some features for teachers who wish to produce handouts and workshop booklets. It has been developed on MacOS but should be easily portable to other UNIX-like operating systems such as Linux.

## Features

*Octavo* is a tool for multiple document deployment.

### Ready-to-use templates

Here you will find my own templates, all of which cater for different types of student.

- *Tufte PDF* is the canonical template, based on the design philosophy of Edward Tufte (check this).

and contains all the bells and whistles


<!-- Put thumbnails for each here -->

## Features

### Hyperlinks to other versions of the file

Insert the following:

~~~

& deployments &

~~~

This will insert a 'smart' paragraph telling the reader that other versions of the file are available. The alternative versions are hyperlinked.

### Version

Insert the version number (specified using the *version* variable in the Yaml).

~~~
& version &
~~~

### Arbitrary commands

Enclose as follows, and the standard output of the command will be piped into the document:

~~~
&cmd date +%D cmd&
~~~

### Include text from external sources

Mark the line with the ampersand character to have Octavo fetch external text using the following text as the filename. Look at the example below.

~~~

&& ianHockingContact

~~~

This will insert the text contents of the file *ianHockingContact.markdown*. The path to *include* files is contained in ~/.octavoConfig.sh

### PopOut

To emphasise individual words, use the PopOut class.

~~~
The deadline for this is <span class="inlinePopout">25 Novemeber 2016</span>.
~~~

### Answer Box, Task, Journal, and Highlight

To place special formatting around an *answer box*, *task*, *journal* or *highlight*, use the following:

~~~
<div latex="true" class="answer" id="Answer">

Text here

</div>
~~~

Octavo will create the necessary Latex for PDF documents, while at the same time pre-processing the *div* into an appropriate format (creating a subheader based on the class; these are hardcoded in Octavo.zsh) for docx and html formats.

The *id* tag above provides an emphasised text element above the text ('Text here' in the example) for simplified PDF layouts.

## Tables

Octavo uses the [pandoc-tabletocsv](https://github.com/baig/pandoc-csv2table) filter to create tables from csv.


## Issues

At the moment, it isn't possible to use Markdown images within \<div\> tags because Latex figures can't be contained within \\tcolorbox environments.

Docx and HTML can't be produced in redacted versions at the moment because I haven't figured out a way to make them conditionally skip 'answer' DIV classes.


## To do

- Create a installer for Homebrew

## Why is there nothing here?

This code is working in toy form on my computer right now. It'll be a while before I can share it. I'm pretty new to git, so I'm setting up this repository to get properly oriented with how repositories etc. work.

## Dependencies

Pandoc

iCalBuddy

---

Ian Hocking, July 2016
