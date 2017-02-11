---
title: "MPSMD2RES Workshop 3: One-Way ANOVA"
title-meta: "MPSMD2RES Workshop 3, One-Way ANOVA"
author: "Dr Ian Hocking, Psychology Programme"
date: "September 2016 to April 2017"
version: 1.1
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
customfilterthree: "pandoc-citeproc"
Papersize: A4
toc-depth: 1
toc: 1
colorlinks: 1
boxlinks: true
linespread: "1.3"
numbersections: "yes"
bibliography: "$HOME/Dropbox/CCCU/text/biblio/handbooks/2res.bib"
citation-style: "https://raw.githubusercontent.com/citation-style-language/styles/master/apa.csl"
link-citations: false
solariseddarkon: false 
solariseddarkoff: true
mdfivehashset: "yes"
redact: "no"
tblPrefix: "Table"
eqnPrefix: "Equation"
figPrefix: "Figure"
...

# Overview

-----------------------  -------------------------------------
*Data files required*    [Activity after therapy](https://www.dropbox.com/s/k62wolc7h7hdqal/3sigTherapy.sav?dl=0),
                         [Driving errors after alcohol](https://www.dropbox.com/s/vd5x9k2057jzcpo/3sigDriving.sav?dl=0)

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop introduces you to the <span class="inlineKeyword">Analysis of Variance</span> (ANOVA), which is a statistical technique designed to help analyse designs with multiple groups.

- You'll begin by performing an ANOVA on group data where *different* people have contributed data to each group. This is known as a <span class="inlineKeyword">between-groups ANOVA</span> analysis (sometimes a <span class="inlineKeyword">between-subjects</span> analysis).

- You'll then carry out a second ANOVA using data where the *same* people have contributed data to each group. This is a <span class="inlineKeyword">within-groups ANOVA</span> or a <span class="inlineKeyword">within-subjects ANOVA</span>.

&& 2resWorkshopBookletHeader

# Workshop

Analysis of variance or ‘ANOVA’ is a statistical technique that allows us to look at the differences between mean scores when there are more than two conditions. Basically, it compares the variance between the groups with the variance within the groups. The bigger the differences between the groups compared to within the groups, the more likely we are to get a significant result. 

# Between-Groups ANOVA

We'll begin with a one-way between-groups ANOVA in SPSS, and interpret the result.

<div latex="true" class="highlight" id="Remember">

- *One-way* means that the ANOVA has one 'factor', which translates as 'basis on which we have created groups'. Typically, it is the thing we have manipulated.

- This is a *between* or *independent* ANOVA because the people in the groups are different. In other words, the group data are not correlated.

</div>

<div latex="true" class="answer" id="Answer"> 

[Download the complete SPSS syntax](https://www.dropbox.com/s/w5tw5nz83zqcxs0/3sigTherapy.sps?dl=0)

[Download the complete SPSS output](https://www.dropbox.com/s/kbsatbm4v1nibtm/3sigTherapy.spv?dl=0)

</div>

## Our Scenario

> A clinical psychologist was interested in the effect of ‘sunshine therapy’ on the activity levels of depressed patients. The therapy involved sitting in an empty room with artificial sunlight filtered through. She took a group of 300 depressed out-patients at a psychiatric hospital and split them into three sub-groups. She gave one sub-group a 3-hour session of sunshine therapy; the second sub-group received 3 hours of traditional Cognitive Behavioural Therapy (CBT); the third group received no therapy. After a series of sessions all the participants got together for an hour to socialise and support each other. During this session, they were observed and the amount of time during which each patient engaged in social activities was recorded.


## Step One: Obtain the Data

<div latex="true" class="task" id="Task"> 

1. Open [Activity after therapy](https://www.dropbox.com/s/k62wolc7h7hdqal/3sigTherapy.sav?dl=0). 

</div>

Note that you have two columns. The first is 'group' and the second 'activity'. 'Group' represents type of therapy (no therapy, CBT, and sunshine). 'Activity' represents social activity level following the treatment.


## Step Two: Run the Descriptive Statistics

Before we carry out the ANOVA (or any other statistical test) it is always good practice to get an idea of what is going on with the data. So, calculate the scores for the three groups. Whereas before you've used the *Descriptives* function, we need to tell SPSS that we'd like means for one variable ('activity') as classified by the value of another ('group').

<div latex="true" class="task" id="Task"> 

2. Go to *Analyze > Compare means > Means*. Put the dependent variable in ‘dependent’ box and the independent variable into the ‘independent’ box. Now click *OK*.

</div>

<div latex="true" class="journal" id="Journal">

1. What are the mean activity ratings for the three groups?

</div>

<div latex="true" class="answer" id="Answer"> 

- *No therapy*: 1

- *CBT*: 2.8

- *Sunshine therapy*: 2.1

---

SPSS Syntax:

~~~

MEANS TABLES=activity BY group
  /CELLS=MEAN COUNT STDDEV.

~~~

</div>

## Step Three: Get a Useful Picture of the Means{#betweenStepThree}

Box plots are very useful for getting a sense of what our grouped data *looks* like.

From [Wikipedia](https://en.wikipedia.org/wiki/Box_plot):

> In descriptive statistics, a box plot or boxplot is a convenient way of graphically depicting groups of numerical data through their quartiles. Box plots may also have lines extending vertically from the boxes (whiskers) indicating variability outside the upper and lower quartiles, hence the terms box-and-whisker plot and box-and-whisker diagram.

Boxplots can be constructed by going to *Graphs* > *Legacy Dialogues* > *Boxplot*. For this kind of plot, make sure *Simple* and *Summaries for groups of cases* are selected, like [@fig:boxplot].

![SPSS boxplot dialogue](.3owa/06-10-2016-48.png "SPSS boxplot dialogue"){#fig:boxplot}

When you've clicked *OK*, you can specify the dependent variable as *Variable* and the grouping variable as *Category Axis*, like [@fig:boxplotDef]

![SPSS boxplot definition dialogue](.3owa/06-10-2016-978.png "SPSS boxplot definition dialogue"){#fig:boxplotDef}

<div latex="true" class="task" id="Task"> 

3. Using the instructions above, create boxplots for the activity ratings within each group by going to *Graphs* > *Legacy* > *Boxplot*. Make sure that your output looks like [@fig:boxplotSocAct].

</div>

![Social activity level by therapy group](.3owa/06-10-2016-915.png "Social activity level by therapy group"){#fig:boxplotSocAct}

<div latex="true" class="answer" id="Answer"> 

SPSS syntax:

~~~

EXAMINE VARIABLES=activity BY group
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL.

~~~

</div>

## Step Four: Set up the ANOVA

We can see that there are differences in activity between the groups. We're more interested in whether these differences are true. In other words, do the data better fit a null distribution (of no difference) or an alternative distribution (where the effect is true)? The Analysis of Variance can tell us this.

<div latex="true" class="highlight" id="Remember">

- Like any statistical test, the ANOVA requires certain conditions to be in place. We'll talk more about these later. Right now, I want you to experience producing the ANOVA; we'll return again to the important skill of knowing whether or not an ANOVA is appropriate. So, for the time being, we'll focus on checking just one assumption: *the homogeneity of variance*.

- Similarly, to keep things simple, we won't talk about *effect size* for now. 

</div>

Before you run the ANOVA, read through the following to get an overall sense of how you do it.

- First, you'll go to *Analyze > Compare means > One-way ANOVA*, then put the dependent variable into the ‘dependent’ box and the independent variable into the ‘factor’ box ([@fig:anovaMainDialogue])

![One-way ANOVA main dialogue](.3owa/06-10-2016-608.png "One-way ANOVA main dialogue"){#fig:anovaMainDialogue}

- To see exactly where the differences lie, if there are any, between the groups are you need to tell SPSS to carry out some *post hoc* tests. So you'll click on *post hoc* and select *Tukey* ([@fig:anovaPostHoc]), then click *continue*.

![One-way ANOVA post hoc test dialogue](.3owa/06-10-2016-703.png "One-way ANOVA post hoc test dialogue"){#fig:anovaPostHoc}

- To ensure that we have satisfied the homogeneity of variance assumption, you'll click on *Options* and select *homogeneity of variance test* ([@fig:anovaOptions]).

![One-way ANOVA options dialogue](.3owa/06-10-2016-412.png "One-way ANOVA options dialogue"){#fig:anovaOptions}

- Then you'll click on *continue* and *OK*.

<div latex="true" class="task" id="Task"> 

4. Run the ANOVA according to the instructions above.

</div>

<div latex="true" class="highlight" id="Remember">

That's a lot of clicking. Remember that you can click *paste* and have SPSS produce the 'syntax' for running the ANOVA as you've just configured it. If you want to run it again with different options or variables, this is often the more efficient way of making changes.

</div>

<div latex="true" class="answer" id="Answer"> 

For completeness, the SPSS syntax is:

~~~

ONEWAY activity BY group
  /STATISTICS HOMOGENEITY 
  /MISSING ANALYSIS
  /POSTHOC=TUKEY ALPHA(0.05).

~~~

</div>

## Step Five: Interpret the Output

You should get the same output as I have below. Let’s see first of all whether we have satisfied the assumption of homogeneity of variance. The first table in the output, [@fig:anovaHom], compares the variance within each group against the others. If Levene’s test is significant then, just like with T-tests, the assumption is violated and the result of the ANOVA may not be reliable. If it is non-significant, then the assumption is met and the result of the ANOVA should be reliable.

![Output---Homogeneity of Variance](.3owa/06-10-2016-438.png "Homogeneity of variance"){#fig:anovaHom}

<div latex="true" class="journal" id="Journal">

2. Have we met the homogeneity of variance assumption? Explain why or why not.

</div>

<div latex="true" class="answer" id="Answer"> 

We have indeed met it because Levene's test returns a *p* value of .873. This indicates that the variances do not differ significantly between groups.

</div>

The next table on the output, the ‘ANOVA’ table shows us whether the difference between the groups is statistically significant or not. Have a look at your own table (which should resemble [@fig:anovaMain]) and answer the next question in your Journal.

![Output---ANOVA](.3owa/06-10-2016-768.png "ANOVA"){#fig:anovaMain}

<div latex="true" class="journal" id="Journal">

3. Is there a significant effect of the type of therapy a person receives on their subsequent activity levels? Write out your interpretation in plain English and report the ANOVA results in APA style.

- Be sure to include the F ratio itself, degrees of freedom for between and within groups, mean squared error, and the significance.

</div>

<div latex="true" class="answer" id="Answer"> 

Yes, there is a significant effect of group, *F*(2, 27) = 10.419, *MSE* = 0.89, *p* < .001.

</div>

## Follow-up Comparisons

The final table in the output, the ‘Multiple Comparisons' table ([@fig:postHocAnova]), tells us the result of the *post hoc* comparisons.

<div latex="true" class="highlight" id="Remember">

Post hoc comparisons can help us determine which of the groups differ from one another. This is important because the ANOVA tells us only that there is a difference *somewhere* between the groups (i.e. between at least two). Post hoc paired comparisons look more deeply into the groups.

</div>

![Output---Post Hoc Comparisons](.3owa/06-10-2016-775.png "Post Hoc Comparisons"){#fig:postHocAnova}

<div latex="true" class="journal" id="Journal">

4. What conclusions can you draw from the *post hoc* tests?

</div>

<div latex="true" class="answer" id="Answer"> 

- No therapy vs. CBT groups are significantly different at *p* < .05. Judging by the means, CBT leads to higher activity than no therapy.

- No therapy vs. Sunshine therapy groups are significantly different at *p* < .05. The means suggest, likewise, that Sunshine therapy leads to higher activity.

- CBT vs. Sunshine therapy are not, however, significantly different from one another. So our sample suggests these are equally effective in terms of their impact on social activity.

</div>

<div latex="true" class="journal" id="Journal">

- Family-wise error is the problem of an increasing false positive rate as you perform multiple comparisons.

5. Why don't we need to make a family-wise error correction for the post-hoc tests?

</div>

<div latex="true" class="answer" id="Answer"> 

Such tests are already conservative, i.e. have weaker statistical power, than planned comparisons, which means that they are corrected for the family-wise error rate.

</div>


# Within-Groups ANOVA


We'll continue now with a one-way within-groups ANOVA using SPSS, and once again we will interpret the results.

<div latex="true" class="highlight" id="Remember">

- Remember, *one-way* means that the ANOVA has one 'factor', which translates as 'basis on which we have created groups'. Typically, it is the thing we have manipulated.

- This is a *within* or *repeated* ANOVA because the people in the groups are the same. In other words, the group data are not correlated. Because of this correlation, the ANOVA needs to account for the correlation by making an ajustment.

</div>

<div latex="true" class="answer" id="Answer"> 

[Download the complete SPSS syntax](https://www.dropbox.com/s/l2jm4m9m8ydnec9/3sigDriving.sps?dl=0)

[Download the complete SPSS output](https://www.dropbox.com/s/s9ct53lrl8tjafj/3sigDriving.spv?dl=0)

</div>

## Our Scenario

> Does alcohol affect driving ability? A researcher interested in answering this question tested 10 people on a driving test under 3 conditions (no alcohol, one pint, and two pints) and counted up the number of errors they made.

## Step One: Obtain the Data

Open [Driving errors after alcohol](https://www.dropbox.com/s/vd5x9k2057jzcpo/3sigDriving.sav?dl=0). Note that you have three columns: 'control', 'onePint', and 'twoPints'.

<div latex="true" class="highlight" id="Remember">

- Why are the data now split across three columns? The answer lies with SPSS. It prefers to have people in rows. Earlier, in the between-groups example, each person was uniquely assigned to a group, so their score had a particular group code (no therapy, CBT, and sunshine). Now, in our within-groups example, each person has contributed to each group. In other words, they have been tested while sober, after one pint, and after two pints.

</div>

## Step Two: Run the Descriptive Statistics

<div latex="true" class="task" id="Task"> 

5. As before, we need to look at the means to get a sense of our data. Go to *Analyze > Descriptive Statistics > Descriptives...* and make sure all of the variables are transferred to the box marked *Variable(s)*. Click *OK*.

</div>

<div latex="true" class="journal" id="Journal">

6. What are the mean number of driving errors made by participants in each of the three conditions?

</div>

<div latex="true" class="answer" id="Answer"> 

- *No alcohol*: 1.40

- *One pint*: 6.50

- *Two pints*: 6.80

---

SPSS Syntax:

~~~

DESCRIPTIVES VARIABLES=control onePint twoPints
  /STATISTICS=MEAN STDDEV MIN MAX.

~~~


</div>

## Step Three: Get a Useful Picture of the Means

For the data on therapy, we created boxplots that used a grouping variable (see [@fig:boxplot]). Now we'll simply create boxplots for each variable (i.e. each condition).

You'll start by going to *Graphs* > *Legacy Dialogues* > *Boxplots*. Make sure that *Summaries of separate variables* are selected, like [@fig:RepBoxplot].


![SPSS boxplot dialogue](.3owa/07-10-2016-692.png "SPSS boxplot dialogue"){#fig:RepBoxplot}

When you've clicked *OK*, you can specify the variables of interest (all of them, in this case) in the *Boxes Represent* box. See [@fig:RepBoxplotDefine].


![SPSS boxplot definition dialogue](.3owa/07-10-2016-219.png "SPSS boxplot definition dialogue"){#fig:RepBoxplotDefine}

<div latex="true" class="task" id="Task"> 

6. Create boxplots for the groups (no alcohol, one pint and two pints) by going to *Graphs* > *Legacy* > *Boxplot*. Make sure that it looks like [@fig:boxplotAlcGroup].

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax:

~~~

EXAMINE VARIABLES=control onePint twoPints 
  /COMPARE VARIABLE
  /PLOT=BOXPLOT
  /STATISTICS=NONE
  /NOTOTAL
  /MISSING=LISTWISE.

~~~

</div>

![Number of errors by alcohol group](.3owa/07-10-2016-458.png "Number of errors by alcohol group"){#fig:boxplotAlcGroup}

## Step Four: Set up the ANOVA

As before, we can see that there are differences in activity between the groups, but these might superficial sample differences. We're more interested in whether these differences are true. In other words, do the data better fit a null distribution (of no difference) or an alternative distribution (where the effect is true)? The Analysis of Variance can tell us this.

<div latex="true" class="highlight" id="Remember">

- Again, we'll not concern ourselves with some of the prerequisites that need to be true before it is appropriate to run a repeated measures ANOVA, with the exception of one thing: the sphericity assumption.

</div>

Before you run the ANOVA, read through the following to get an overall sense of how you do it.

- First, you'll go to *Analyze > General Linear Model > Repeated Measures*.

- A box like [@fig:RptDefineFactors] will appear where you have to tell SPSS what the repeated measures factor is and how many levels (conditions) it contains. In this study there is only one factor, ‘drink’, and there are three levels (no alcohol, one pint, and two pints). So enter the factor name (such as 'group' in the *Within-Groups Factor Name* box, and enter its levels (3), in the *Number of Levels* box. Then click *add*.

![One-way within-groups ANOVA factor definitions](.3owa/07-10-2016-650.png "One-way within-groups ANOVA factor definitions"){#fig:RptDefineFactors}

Click the arrow to pass each of the conditions over into the middle box so that it looks like [@fig:RptVariablesEntered]

![One-way within-groups ANOVA variables entered](.3owa/07-10-2016-949.png "One-way within-groups ANOVA variables entered"){#fig:RptVariablesEntered}

Then you'll click *continue* and *OK*.

<div latex="true" class="task" id="Task"> 

7. Run the ANOVA according to the instructions above.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax:

~~~

GLM control onePint twoPints
  /WSFACTOR=group 3 Polynomial 
  /METHOD=SSTYPE(3)
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=group.

~~~

</div>

## Step Five: Interpret the Output

You should get the same output as I have here. Let’s see what it tells us. We can ignore the *Multivariate Tests* table ([@fig:RptMultiv]) 

![Output---Multivariate Tests](.3owa/07-10-2016-932.png "Output---Multivariate Tests"){#fig:RptMultiv}

The table in [@fig:RptMauch], however, is much more important. *Mauchly’s test of sphericity* is the repeated measures equivalent of Levene’s test for homogeneity of variance. That means we will check to see if we have violated the assumption of equal variances of the differences between levels. See @field2009discovering. 

<div latex="true" class="task" id="Task"> 

8. Check the significance. If it *is* significant, then we have violated the assumption and may not to rely on the result of the ANOVA without adjustment.

</div>

![Output---Mauchley's Test](.3owa/07-10-2016-913.png "Output---Mauchley's Test"){#fig:RptMauch}

<div latex="true" class="journal" id="Journal">

7. Have we met the sphericity assumption? Explain with regards to the statistic in the *Mauchly's Test of Sphericity* table.

</div>

<div latex="true" class="answer" id="Answer"> 

Yes, we have met the assumption between Mauchly's test was not significant.

</div>

Depending on the result of Mauchly's test, we will decide which sub-row of data to look at on the next table, the *Tests of within-subjects effects* ([@fig:RptWSEffects]). 

- If Mauchly's test was non-significant, we can assume sphericity, and we look at sub-row labelled 'Sphericity assumed'. 

- If the test was significant, we cannot assume sphericity, and must look at one of the other rows. Each row is a corrected result based on a slightly different formula. There are lots of complicated discussions about which one to use, but if you do not want to go into all the complications, Girden (1992) recommends that when the estimate of sphericity is greater than .75 the Huynh-Feldt correction should be used; otherwise, the Greenhouse-Geisser correction should be used. For more information, see @field2009discovering.

![Output---Tests of Within-Groups Effects](.3owa/07-10-2016-140.png "Output---Tests of Within-Groups Effects"){#fig:RptWSEffects}

<div latex="true" class="journal" id="Journal">

8. Is there a significant main effect of alcohol on driving ability? Write a sentence in this box to describe the finding and write out the result of the ANOVA in APA style.

</div>

<div latex="true" class="answer" id="Answer"> 

The main effect of alcohol was significant, *F*(2,18) =  109.55, *MSE* = .84, *p* < .001. This means that the amount of errors participants made depended on how much alcohol they had drunk.

</div>

## Follow-up Comparisons

Since the effect of alcohol on driving ability was significant, we need to do some follow-up analyses. 

<div latex="true" class="task" id="Task"> 

9. Do post-hoc tests on the data by carrying out three paired-samples T-tests comparing the three conditions (*Analyze > Compare Means > Paired Samples T-test*)

- T-test 1: no alcohol v one pint

- T-test 2: no alcohol v two pints

- T-test 3: one pint v two pints

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax:

~~~

T-TEST PAIRS=control control onePint 
  WITH onePint twoPints twoPints (PAIRED)
  /CRITERIA=CI(.9500)
  /MISSING=ANALYSIS.

~~~

</div>

<div latex="true" class="journal" id="Journal">

9. What are the results of these T-tests? Report each in APA format and provide a verbal description of what the results mean.

</div>

<div latex="true" class="answer" id="Answer"> 

- T-test 1: no alcohol v one pint: *t*(9) = 9.70, *p* < .001, 95% CI [-6.29, -3.91]

- T-test 2: no alcohol v two pints: *t*(9) = 20.25, *p* < .001, 95% CI [-6.00, -4.80]

- T-test 3: one pint v two pints: *t*(9) = .76, *p* = .47, 95% CI [-1.20, 0.60]

These results show that drinking one or two pints affected driving ability compared to the no alcohol condition. However, there was no difference in performance between the one versus two pint conditions.

</div>

As you know, when carrying out a number of t-tests, we need to control our family-wise error rate. 

<div latex="true" class="journal" id="Journal">

10. Applying Bonferroni’s correction, what would the new significance cut-off be? Does it change the results of the T-test?

</div>

<div latex="true" class="answer" id="Answer"> 

.05 / 3 = .02

- The new cut-off doesn’t change the interpretation of our results. Drinking one or two pints affected driving ability compared to no alcohol but the amount of alcohol consumed did not impact performance.

</div>

# Versions {#versions}

& deployments &

&& referencesHeader
