---
title: "MPSMD2RES Workshop 2: Issues of Significance"
title-meta: "MPSMD2RES Workshop 2, Issues of Significance"
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
tblPrefix: "Table"
eqnPrefix: "Equation"
...

# Overview

-----------------------  -------------------------------------
*Data files required*    None           

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives


This workshop is designed to build upon the basic concepts of central tendency, difference, and relationship that you revised last week. 

This week, you will not need to use SPSS. Use pen and paper (or Word) and a calculator.

- In the section [Effect Size](#effect), you'll compute a standard effect size by hand;

- Next, in [Power](#power), you'll perform a power calculation to determine the likelihood that the effect of an intervention will be successfully detected; you'll also work out how many participants you'll need for a given level of power;

- Lastly, in [Confidence Interval](#confidence), which you might not have time to do in the seminar, you will look at estimating the mean of a population (with a confidence of 95%)

&& 2resWorkshopBookletHeader

# Workshop




# Effect Size{#effect}

The <span class="inlineKeyword">standard effect size</span> is an important, portable measure of difference or relationship.

A researcher creates three interventions that are supposed to help people become better problem solvers: intervention A, intervention B and intervention C. She trains three separate groups of 15 people on these interventions and then runs a pre- vs. post-intervention analysis on their creative problem solving scores. See [@tbl:interventionData].

|        | Intervention A |  ..  | Intervention B |  ..  | Intervention C |  ..  |
|--------|----------------|------|----------------|------|----------------|------|
|        | *Mean*         | *SD* | *Mean*         | *SD* | *Mean*         | *SD* |
| *Pre*  | 56.6           | 7.5  | 62.8           | 6.5  | 72.0           | 6.9  |
| *Post* | 62.5           | 7.7  | 75.8           | 6.8  | 74.1           | 7.5  |

  : Showing mean and standard deviation (SD) in creative problem solving score pre-intervention and post-intervention {#tbl:interventionData}

She is interested in calculating the effect size for each intervention. To do this, she uses [@eq:cohensD] to find Cohen's *D*[^1]:

$$ d=\frac{\bar{x}_{1}-\bar{x}_{2}}{s}  $$ {#eq:cohensD}

[^1]: Technically, because this is a *repeated* design---the same participants must be used the *pre* and *post* conditions---you should use a more complicated calculation for the standard deviation that accounts for the correlation between samples. However, the simpler calculation is still useful for learning about power.

<div latex="true" class="highlight" id="Remember">

Effect size can be thought of as the difference between the two means, but why do we divide by the standard deviation? The difference between the means is a number that won't be comparable to other sets of data because it is expressed in the units of the scale used for the experiment. When we divide it by standard deviation, a standard measure, we're effectively transforming to standard, or 'universal', units. This is not much different from converting a score like 22 out of 43 (where 22 only makes sense as a score if you know that the maximum is 43) to a percentage: (100 / 43) * 22 = 51%. Because everyone knows a percentage is a proportion of 100, percentages are portable and comparable. In this way, so is Cohen's *D* (and related standard measures of effect size).

</div>

<div latex="true" class="task" id="Task"> 

1. Use [@eq:cohensD] to work out the effect size of each of the interventions (A, B and C). One thing to remember: you want the absolute difference between means irrespective of its sign, so make sure the difference itself is a positive number.

</div>

<div latex="true" class="answer" id="Answer"> 

Intervention A

- (56.6 - 62.5) / ((7.5 + 7.7)/2) = -5.9 / 7.6 = 5.9 / 7.6 = 0.77

Intervention B

- (62.8 - 75.8) / ((6.5 + 6.8)/2) = -13 / 6.65 = 13 / 6.65 = 1.95

Intervention C

- (72 - 74.1) / ((6.9 + 7.5)/2) = -2.1 / 7.2 = 2.1 / 7.2 = 0.29

</div>

Having performed these calculations, you might have noticed something about the relationship between the mean 'pooled' standard deviation and the difference between the group means. Because this is a fraction, you divide the bottom by the top when converting it to a decimal. So, as the pooled standard deviation gets smaller (i.e. variability is reduced), and as the mean difference gets bigger, the effect size gets larger. The next time you look at a table of means and standard deviations, note the ratio between the pooled standard deviation and the mean differences; you can get a rough idea of what the effect size will be, and how seriously to take the result.

<div latex="true" class="journal" id="Journal">

1. According to Cohen's (1988) guidelines, how would you interpret the size of these effects? (The guidelines are include in this week's lecture slides.)

</div>

<div latex="true" class="answer" id="Answer"> 

The guidelines are:

> Small = 0.2

> Medium = 0.5

> Large = 0.8

Intervention A

- 0.77: medium-to-large

Intervention B

- 1.95: very large

Intervention C

- 0.29: small

</div>

# Power{#power}

The same researcher decides she would like to know the <span class="inlineKeyword">power level</span> of the test conducted on intervention C. She will use [@eq:delta] to identify $\delta$, which she'll then look up in a [table](#powerTable) to determine the power level:

$$ \delta = \gamma \sqrt{N} $$ {#eq:delta}

Note [@eq:delta] uses the term $\gamma$ (*gamma*) for effect size, which is the equivalent of Cohen's *D* in this case.

<div latex="true" class="task" id="Task"> 

2. Calculate the power for intervention C. Remember that you'll need to look up the value of $\delta$ in the [table from Howell](#powerTable). Assume that your alpha level is 5% and your test is two-tailed.

</div>

<div latex="true" class="answer" id="Answer"> 

$\delta$ = 0.29 * square root of 15 = 0.29 * 3.87 = 1.12

Looking in Appendix Power in Howell (1992) you can see that a $\delta$ of 1.10 (we are rounding to the nearest value) with alpha of 0.05 (two-tailed) gives a power value of .20, which is a 20% chance of finding an effect. This is quite low power.  

</div>

The researcher wants to run intervention C again. This time, she is interested in working out beforehand how many participants she would need for a power level of 80%---in other words, she wants an 80% likelihood that she will detect the effect of intervention C if it exists.

<div latex="true" class="task" id="Task"> 

3. Look up a power level of .8 in the [table from Howell](#powerTable) for a two-tailed test with an alpha of 0.05. What is the $\delta$ required?

</div>

<div latex="true" class="answer" id="Answer"> 

$\delta$ is 2.8

</div>

<div latex="true" class="task" id="Task"> 

4. Now that you have the $\delta$, it can be plugged into [@eq:delta]. However, what we really want to do is solve this equation for *N*, so that we can determine how many people to sample. We can use normal algebraic shifting to express [@eq:delta] as [@eq:N]:

$$ N = \frac{\delta^{2}}{\gamma^{2}} $$ {#eq:N}

(Remember that $\gamma$ is Cohen's *D* in this case.)

Use the above equation to determine how many participants (*N*) are needed.

</div>

<div latex="true" class="answer" id="Answer"> 

N = (2.80 * 2.80) / (0.29 * 0.29) = 7.84 / 0.0841 = 93.22

Since we can't have .22 of a person, we can round this up to 94.

</div>

# Confidence Interval{#confidence}

This is a bonus section. You might not have time to do it in the seminar, but it will be useful practise to do it afterwards.

The previous seminar, you looked at data involving verbal scores produced by male and female participants. We'll now return to these data.

<div latex="true" class="task" id="Task"> 

5. [Download these data](https://www.dropbox.com/s/wagmart9ngea7cf/1intDifferenceBetween.sav?dl=0)

As before, run the T-test.

</div>

<div latex="true" class="answer" id="Answer"> 

- Select *Analyse - Compare Means - Independent Samples T-test*

- Set your *Test Variable(s)* as *Verbal score*

- Set your *Grouping Variable* as *gender* 

- Set *Define groups* as *User specified values*, with *Group 1* as *1* and *Group 2* as *2*  

- Hit *OK*

</div>

<div latex="true" class="journal" id="Journal">

2. You'll see that your output contains the lower and upper bound (i.e. the range, from the lower edge to the higher edge) of the confidence interval.

Note down the test results in APA style, including the confidence interval. (You'll see an example of how to do this in this week's lecture slides.)

</div>

<div latex="true" class="answer" id="Answer"> 

*t*(34) = 2.32, *p* < .05, 95% CI [1.47, 21.86]

</div>

<div latex="true" class="journal" id="Journal">

3. In plain English, explain what this confidence interval means.

</div>

<div latex="true" class="answer" id="Answer"> 

This means, precisely, that if we were to repeat the T-test many times, the difference between the two means would be between 1.47 and 21.86 95% of the time.

</div>

<div latex="true" class="highlight" id="Remember">

In this booklet, you've worked through effect size, power, and the confidence interval.

</div>

# Supporting Materials

# Power Table{#powerTable}

If the graphic of the power table is too small, [download a larger one](https://www.dropbox.com/s/3m57mz6mwwaaydn/2sigHowell.jpg?dl=0).

![Power Appendix from Howell](support/2sigHowell.jpg "Power Appendix from Howell (1995) or late editions")

# Versions {#versions}

& deployments &
