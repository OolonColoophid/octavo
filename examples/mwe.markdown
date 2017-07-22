---
title:             "Minimal Working Example, Tufte Style"
title-meta:        "Minimal Working Example, Tufte Style"
date:              ""
version:           1.0 
headimage:         ""
headquote:         ""
headquoteauthor:   ""
httpdestination:   "http://cccupsychology.com/deployIh/scratch/"
remotedirectory:   "scratch/"
deployto:          "$octavoPath/examples"
formats:           "octavoTuftePdf"
preview:           ""
ftpdeploy:         "no"
ftppath:           "deployIh/scratch"
spokendeploy:      "no"
bibliography:      ""
mdfivehashset:     false
redact:            false
customfilters:     "" 
includeyaml:       "$octavoPath/templates/documentDefault.yml"
toc:               false
toc-depth:         0
---

# Basic Extended Markup Offered by Octavo

Create a task box like this (without spaces in the word 'task'):

~~~

< t a s k > Run the analysis < / t a s k >

~~~

<task>Run the analysis</task>

For a journal instruction:

~~~

< j o u r n a l > Put the answer in your journal < / j o u r n a l >

~~~

<journal>Put the answer in your journal</journal>

An answer box provides an answer, and will disappear if you enter <do>redact: true</do> in the Yaml.

~~~

< a n s w e r > Here is an answer < / a n s w e r > 

~~~

<answer>Here is an answer</answer>

The following will produce a highlight:

~~~

< r e m e m b e r > Here is a highlight < / r e m e m b e r >

~~~

<remember>Here is a highlight</remember>

This next one I call 'do':

~~~

< d o > Something to be done < / d o >

~~~

<do>Something to be done</do>

And this will make text pop out:

~~~

< p o p > Something to pop out < / p o p >

~~~

<pop>Something to pop out</pop>

This one is 'keyword':

~~~

< k e y > Keyword < / k e y >

~~~

<key>Keyword</key>

# A More Complex Example

For a complete handout using figures, tables and equations, look at [sandbox/1art.markdown](https://www.dropbox.com/s/rhbyx502ti8qojb/1art_10a86e56a2b3f0ef0d14620b5fa20125octavoTuftePdf.pdf?dl=0).
