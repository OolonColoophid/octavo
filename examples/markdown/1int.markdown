---
title: "MPSMD2RES Workshop 1: Measures of Central Tendency, Association and Difference"
title-meta: "MPSMD2RES Workshop 1, Measures of Central Tendency, Associaton and Difference"
author: "Dr Ian Hocking, Psychology Programme"
date: "September 2016 to April 2017"
version: 1.0
headimage: "$HOME/Dropbox/CCCU/text/deploy/media/2res/tufteHeadImageCompass"
headquote: "Research is creating new knowledge."
headquoteauthor: "Neil Armstrong"
httpdestination: "http://cccupsychology.com/deployIh/2res/workshops/"
remotedirectory: "2res/workshops/"
deployto: "$HOME/Dropbox/CCCU/text/2res/deploy/workshops"
formats: "all"
preview: ""
ftpdeploy: "yes"
spokendeploy: "yes"
refreshcalendar: "no"
customfilterone: "pandoc-csv2table"
customfiltertwo: "pandoc-crossref"
papersize: A4
toc-depth: 1
toc: 1
colorlinks: 1
boxlinks: true
linespread: "1.3"
numbersections: "yes"
citation-style: "https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl"
link-citations: false
solariseddarkon: false 
solariseddarkoff: true
mdfivehashset: "yes"
redact: "no"
...

# Overview{#overview}

-----------------------  -------------------------------------
*Data files required*    None           

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop is designed to get you back up to speed with some basics. It revises some important concepts from MPSMD1RES. If I were you, I would keep your notes from that module handy while you're learning new things on MPSMD2RES. Remember that you should still have access to the MPSMD1RES module Blackboard.

- In this booklet, the section [mean, median and standard deviation](#centralTendency) will reacquaint you with measures of central tendency---which tell us something about the central point in a given set of data---as well as <span class="inlineKeyword">standard deviation</span>, which tells us something about the dispersion of a set of data;

- You'll look at the *r* statistic in [simple correlation](#correlation);

- The section on [between-subjects differences](#differenceBetweenGroups) will remind you how to test for differences between two groups of data that are not correlated;

- Finally, the section [within-subjects differences](#differencesWithinGroups) will take you through testing for differences between two groups of data that *are* correlated.

&& 2resWorkshopBookletHeader

# Workshop

For these exercises, use <span class="inlineKeyword">SPSS</span>.

# Measures of Central Tendency and Variance{#centralTendency}

<span class="inlineKeyword">Central tendency</span> is all about describing the central or typical value of a set of data. It attempts to find a conceptual middle. Typically, we talk about the <span class="inlineKeyword">mean</span>, <span class="inlineKeyword">mode</span> and <span class="inlineKeyword">median</span>.

By contrast, we also want a measure of <span class="inlineKeyword">dispersion</span>. This tells us, in a value, something about the spread of data. One such value is <span class="inlineKeyword">standard deviation</span>.

Calculating the (arithmetic) mean and median goes like this:

- Mean: Add all the values together and divide by the number of values

- Median: Order the values and take the middle one

For standard deviation (in its simplest form):

  - Calculate the mean

  - Subtract each data point from the mean, and square these values. Call this *deviation*

  - Take the mean of the *deviation*. This is called <span class="inlineKeyword">variance</span>

  - Take the square root of the *variance*. This is called <span class="inlineKeyword">standard deviation</span>

Look at the following example. A group of 18 female participants takes part in a visuo-spatial memory task and produces the following scores:

![Visuo-spatial scores for each female participant. mn](support/1intCentralTendency.csv)

In summarising these data, we want to get a sense of central tendency and dispersion of the sample.

<div latex="true" class="task" id="Task"> 

1. Using SPSS, compute the mean, median and standard deviation scores.

</div>

<div latex="true" class="journal" id="Journal">

1. Note these in your Research Journal

</div>

<div latex="true" class="answer" id="Answer"> 

Mean is *16.50*

Median is *19*

Standard deviation is *6.47*

---

The SPSS Syntax for these [data](https://www.dropbox.com/s/qxuun9p0czwuqg6/1intCentralTendency.sav?dl=0) is as follows:

~~~
EXAMINE VARIABLES=visuoSpatialScore
  /STATISTICS DESCRIPTIVES
  /NOTOTAL.
~~~

</div>

# Measures of Association{#correlation}

Lets look at an effect measure called <span class="inlineKeyword">correlation</span>. The female participants from the memory task also completed a verbal comprehension test and produced the following range of scores:

![Verbal scores for each female participant. mn](support/1intAssociation.csv)

<div latex="true" class="task" id="Task"> 

2. Use SPSS to conduct an analysis assessing whether there is an association in performance on the two tasks (visuo-spatial and verbal).

</div>

<div latex="true" class="journal" id="Journal">

2. Make a note of your answer using APA style.

</div>

<div latex="true" class="answer" id="Answer"> 

There is a significant negative correlation between performance on the visual task and the verbal task, *r*(18) = -.972, *p* < .001.

---

The SPSS Syntax for these [data](https://www.dropbox.com/s/acf0vncasatyix8/1intAssocation.sav?dl=0) is as follows:

~~~
CORRELATIONS
  /VARIABLES=verbalScore visuoSpatialScore
  /PRINT=TWOTAIL NOSIG
  /MISSING=PAIRWISE.
~~~


</div>

<div latex="true" class="journal" id="Journal">

3. What conclusion(s) can you draw from your answer?

</div>

<div latex="true" class="answer" id="Answer"> 

That females who are good at the visual task are poor at the verbal task.

</div>


## Difference Between Two Groups{#differenceBetweenGroups}

We've just looked at correlation, which, using the sample, tries to estimate what the <span class="inlineKeyword">population</span> correlation might be. 

Now we'll consider difference.

<div latex="true" class="highlight" id="Remember">

When comparing the means of two groups of data, you will always find that they are not the same. This means that you have a difference between your two samples. This difference is, in a sense, trivial, because you're very likely to find it. We are much more interested in when this mean difference is said to be significant. Why? Because this tells us there is probably a true difference between the two groups. In other words, while we always have a sample difference, we only sometimes have a population difference. The population difference is the one you should declare in your results. For many researchers, writing 'A difference was found between the two groups' is synonymous with 'A *population* difference was found between the two groups'.

</div>

Now, researchers thought that gender may be influencing performance on the verbal task so they had a separate group of 18 males complete the verbal comprehension test, producing the following scores:

![Verbal scores for each male participant. mn](support/1intDifferenceBetween.csv)

<div latex="true" class="task" id="Task"> 

3. Conduct a statistical test to ascertain whether there is a significant difference in performance of the females vs. the males on the verbal comprehension test. 

</div>

<div latex="true" class="journal" id="Journal">

4. Note your results in APA format.

</div>

<div latex="true" class="answer" id="Answer"> 

Females scored significantly higher on the verbal comprehension test compared to the males (means of 54.9 and 43.2 respectively), *t*(34) = 2.326, *p* < .05. 

---

The SPSS Syntax for these [data](https://www.dropbox.com/s/wagmart9ngea7cf/1intDifferenceBetween.sav?dl=0) is as follows:

~~~
T-TEST GROUPS=gender(1 2)
  /MISSING=ANALYSIS
  /VARIABLES=verbalScore
  /CRITERIA=CI(.95).
~~~


</div>

# Difference Between Two Related Groups{#differencesWithinGroups}

In the above example, the two groups had different people in each. We'll now turn to another example where the same people were tested on two occasions. Because the same people are now involved in both conditions, we can expect the data to be correlated, since each person will, to some extent, have stable individual characteristics.

The researchers, surprised at the poor performance of the males on the verbal task, took them away and gave them a week’s training on verbal skill. Following a delay of one week they tested the men again and they produced the following scores: 

![Verbal scores for each male participant after training. mn](support/1intDifferenceWithin.csv)

<div latex="true" class="task" id="Task"> 

4. Conduct a statistical test to ascertain whether there is any significant improvement in the verbal scores of the males. 

</div>

<div latex="true" class="journal" id="Journal">

5. Note your results in APA format.

</div>

<div latex="true" class="answer" id="Answer"> 

Males scores on the verbal comprehension test improved significantly from time 1 to time 2 (means of 43.2 and 57.9 respectively), *t*(18) = 5.438, *p* < .001. 

---

The SPSS Syntax for these [data](https://www.dropbox.com/s/imvt8e24yd6qmr5/1intDifferenceWithin.sav?dl=0) is as follows:

~~~

T-TEST PAIRS=verbalScoreMenT1 WITH verbalScoreMenT2 (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

~~~


</div>

# Follow-up Analyses

If you've managed the above and want to try something more advanced outside of the seminar, keep reading.

<div latex="true" class="journal" id="Journal">

A1. What are *skewness* and *kurtosis*?

</div>

<div latex="true" class="answer" id="Answer"> 

*Skewness* is a value representing (i) the degree of asymmetry and (ii) direction of asymmetry in a distribution. For example, a skewness of 0 is a symmetrical distribution. Negative skew pushes the tail of the distribution to the left. Positive skew pushes it towards the right.

*Kurtosis* is the degree of peakedness or flatness of a distribution.

</div>

<div latex="true" class="task" id="Task"> 

A1. Calculate skewness and kurtosis for the data on the original 18 females undertaking the visuo-spatial memory task in the section [measures of central tendency](#centralTendency)

</div>

<div latex="true" class="answer" id="Answer"> 

Skewness *-0.8*

Kurtosis *-0.546*

---

The SPSS syntax is:

~~~
EXAMINE VARIABLES=visuoSpatialScore
  /STATISTICS DESCRIPTIVES
  /NOTOTAL.
~~~


</div>

<div latex="true" class="journal" id="Journal">

A2. What do the skewness and kurtosis tell us about our sample?

</div>

<div latex="true" class="answer" id="Answer"> 

The thing to remember about measures of *skew* and *kurtosis* is that they relate to our sample. Even if our sample is non-normal, this doesn't mean that the population we are sampling from is non-normal.

Interpreting skew (following Bulmer, M. G. 1979. *Principles of Statistics*. Dover.):

- If skewness is less than −1 or greater than +1, the distribution is highly skewed

- If skewness is between −1 and −0.5 or between 0.5 and 1, the distribution is moderately skewed

- If skewness is between -0.5 and 0.5, the distribution is approximately symmetric

In this case, our skew is moderate.

---

Interpreting kurtosis:

- When kurtosis is around 3, the distribution is approximately normal

- When kurtosis is less than 3, it starts to get *platykurtic* (flat)

- When kurtosis is greater than 3, it begins to get *leptokurtic* (peaky)

Our sample, then, is reasonably flat.

</div>

<div latex="true" class="highlight" id="Remember">

In this booklet, you've revised mean, median and standard deviation; you've calculated a parametric statistic of association, *r*; you've calculated a parametric statistic of difference, *t*, for between-group designs and within-group designs. You've also reported these in APA style. 

</div>

# Versions {#versions}

& deployments &
