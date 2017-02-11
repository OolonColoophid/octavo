---
title: "MPSMD2RES Workshop 4: Two-Way Between Groups ANOVA"
title-meta: "MPSMD2RES Workshop 4, Two-Way Between Groups ANOVA"
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
preview: "octavoHtml"
ftpdeploy: "no"
spokendeploy: "yes"
refreshcalendar: "no"
customfilterone: "pandoc-csv2table"
customfiltertwo: "pandoc-crossref"
customfilterthree: "pandoc-citeproc"
papersize: A4
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
redact: "yes"
tblPrefix: "Table"
eqnPrefix: "Equation"
figPrefix: "Figure"
...

# Overview

-----------------------  -------------------------------------
*Data files required*    [Example 1 SPSS data](https://www.dropbox.com/s/od35eu72mr5pui8/4twaTraffic.sav?dl=0)

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop extends your knowledge of Analysis of Variance (ANOVA) to factorial designs. Remember that ANOVA uses the ratio between explained and unexplained variance to tell you whether the means are difference between levels (groups) of a factor (the thing you are manipulating, or your independent variable). Having looked at the simple case of one-way (i.e. one factor) ANOVA last week, in both independent and repeated forms, this week you'll look at the two-way ANOVA in its independent form.

- In the first example, you'll examine the effects of traffic noise and age on learning;

- In the second example, you'll examine the effects of music and alcohol on driving behaviour;

    - You'll also learn how to set up your SPSS data file.

Remember, this booklet will focus on <span class="inlineKeyword">between-groups</span> analysis. That is, for a given factor, there will be different people in each level. This means that the observations will be independent.

&& 2resWorkshopBookletHeader

# Workshop

Analysis of variance or ‘ANOVA’ is a statistical technique that allows us to examine the differences between mean scores when there are more than two conditions. Basically, it compares the variance *between* the conditions with the variance *within* the conditions. The bigger the differences between the conditions and the smaller the individual differences within a condition, the more likely we are to get a significant result. In this booklet we will carry out the analysis required for a design with two independent variables (i.e. two factors). Both of them are between-subjects (i.e. there are different people in each group or condition). 

<div latex="true" class="highlight" id="Remember">

The ANOVA will tell us three things:

1. Is there a main effect of factor one on the dependent variable (DV)? 

2. Is there a main effect of factor two on the DV? 

3. Is there an interaction effect of the two factors on the DV?

</div>

<div latex="true" class="answer" id="Answer"> 

All data and syntax for this booklet:

- [Example 1 SPSS data](https://www.dropbox.com/s/od35eu72mr5pui8/4twaTraffic.sav?dl=0)

- [Example 1 SPSS syntax](https://www.dropbox.com/s/xfnlhg44jettx2e/4twaTraffic.sps?dl=0)

- [Eaxmple 2 SPSS data](https://www.dropbox.com/s/cll374711woc1st/4twaAlcoholMusic.sav?dl=0)

- [Example 2 SPSS syntax](https://www.dropbox.com/s/3gduer0rwbv8966/4twaAlcoholMusic.sps?dl=0)

</div>

# Example 1: Traffic noise and Learning

> The conditions under which words are remembered are thought to affect the amount of subsequent recall. In particular, road traffic noise at the time of learning has been shown to affect subsequent recall and it seems to be most damaging for children. To look at this phenomenon, participants in the current experiment were randomly assigned to one of two noise conditions: loud (with road traffic) or quiet (no audible road traffic) and asked to read a 1000 word story. There were 20 children (aged 11 - 14) and 20 adults (aged 30 - 35). One week later they came back into the lab and were asked a series of 20 questions about the story. Recall (the dependent variable) was measured as the number of correct answers.

## Step One: Load the data into SPSS

The full data set is available for download here: [Example 1 SPSS data](https://www.dropbox.com/s/od35eu72mr5pui8/4twaTraffic.sav?dl=0)

<div latex="true" class="task" id="Task"> 

1. Open the data file and familiarise yourself with its contents. Use the paragraph above you help you.

</div>

<div latex="true" class="journal" id="Journal"> 

1. What is the design of this study?

</div>

<div latex="true" class="answer" id="Answer"> 

This is a 2 x 2 between-groups factorial design. Factor 1 is Age (child; adult) and factor 2 is Noise Condition (loud; quiet).

</div>

## Step Two: Run descriptive statistics{#exDesc}

Before we carry out the ANOVA, we should get an idea of what is going on with the data. 

<div latex="true" class="task" id="Task"> 

2. Calculate the mean scores for the four conditions by going to *Analyze > Compare means > Means*. As shown in [@fig:trafficDescriptives], put the DV (recall) into the *Dependent List* and ‘ageGroup’ into the *Independent List*. Now click on *Next* and 'ageGroup' should disappear. You are now specifying the second layer of your comparison (note where it says *Layer 2 of 2*). Click on ‘noise’ and put this into the *Independent List* and click *OK*.

- Your means per condition should be the same as mine in [@fig:trafficMeans].

</div>

![SPSS compare means dialogue](.4twa/12-10-2016-421.png "SPSS compare means dialogue"){#fig:trafficDescriptives}


![Output---compare means output](.4twa/12-10-2016-627.png "Output---compare means"){#fig:trafficMeans}

<div latex="true" class="journal" id="Journal">

2. What do the descriptives tell you?

</div>

<div latex="true" class="answer" id="Answer"> 

In our sample:

- Children had lower recall than adults. 

- Quiet noise conditions resulted in better recall than louder conditions. 

- The difference between quiet and load conditions in children was be greater than for adults, so noise impaired children’s recall more than adults’.

---

SPSS Syntax:

~~~

MEANS TABLES=recall BY ageGroup BY noise
  /CELLS=MEAN COUNT STDDEV.

~~~

</div>

## Step Three: Set up the ANOVA {#exSetup}

By looking at the descriptive statistics, we have some inkling of group differences. Now let’s see whether those differences are significant or not.

<div latex="true" class="highlight" id="Remember">

Read through the instructions below before doing them yourself.

</div>

1. Remember that all the SPSS statistical analyses are under the *Analyze* menu, so go there, select *General Linear Model*, then *Univariate*.

2. As I've done in [@fig:trafficUniDialogue], put the dependent variable into the *Dependent Variable* box and the independent variables into the *Fixed Factors* box.

![SPSS Univariate ANOVA dialogue](.4twa/12-10-2016-242.png "SPSS Univariate ANOVA dialogue"){#fig:trafficUniDialogue}

3. Click on *Options* and make sure you have selected the factors and interactions that are included in [@fig:trafficUniOptions].

![SPSS Univariate ANOVA dialogue, Options](.4twa/12-10-2016-658.png "SPSS Univariate ANOVA dialogue, Options"){#fig:trafficUniOptions}

4. Now click *Continue*. We know that graphs aid the understanding of patterns in our data, so click *Plots* and ask SPSS to produce a graph with 'ageGroup' on the horizontal axis and 'noise' as separate lines, just as you see in [@fig:trafficPlots].

![SPSS Univariate ANOVA dialogue, Profile Plots](.4twa/12-10-2016-180.png "SPSS Univariate ANOVA dialogue, Profile Plots"){#fig:trafficPlots}

5. Click on *Add* and *Continue*. Then click *OK*. 

By the end of the above process, you will have set up and run your first two-way between-subjects ANOVA.

<div latex="true" class="task" id="Task"> 

3. Go ahead and run the ANOVA described above.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the ANOVA:

~~~

* Run the first ANOVA on recall with age and noise 
* as between participants factors.
UNIANOVA recall BY ageGroup noise
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(ageGroup*noise)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(ageGroup) 
  /EMMEANS=TABLES(noise) 
  /EMMEANS=TABLES(ageGroup*noise) 
  /PRINT=HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=ageGroup noise ageGroup*noise.

~~~

</div>

## Step Four: Interpret the output

We are now ready to answer the important question. Are those differences significant or not?

The first box tells us how many people we have under each condition---nothing new here. The second box gives us the descriptive statistics that we should already have looked at in [Step Two](#exDesc). The first new bit of information comes with Levene’s Test of the assumption of homogeneity of variance. Remember that we want the variances to be equal (not different), so this needs to be non-significant.

<div latex="true" class="task" id="Task"> 

3. Look at the homogeneity of variance statistic in [@fig:trafficHomo]. Has the homogeneity of variance assumption been met? Include the statistics to back that up.

</div>

<div latex="true" class="answer" id="Answer"> 

Yes, Levene’s test is nonsignificant, *F*(3,26) = 1.93, *p* = .142.

</div>

![Output---Homogeneity of Variance](.4twa/12-10-2016-324.png "Output---Homogeneity of Variance"){#fig:trafficHomo}

Take a look at the ANOVA table (*Tests of Between-Subjects Effects*), which should resemble [@fig:trafficAnovaTable].

![Output---ANOVA](.4twa/12-10-2016-941.png "Output---ANOVA"){#fig:trafficAnovaTable}

<div latex="true" class="journal" id="Journal"> 

3. Use [@fig:trafficAnovaTable] to answer the following questions, providing the statistics to back up your answers.

3.1 Is there a main effect of factor one on the DV?

3.2 Is there a main effect of factor two on the DV?

3.3 Is there an interaction effect of the two factors on the DV?

</div>

<div latex="true" class="answer" id="Answer"> 

3.1. Yes, there is a main effect of noise on recall: *F*(1,36) = 9.85, *MSE* = 6.09, *p* = .003.

3.2. Yes, there is a main effect of age on recall: *F*(1,36) = 41.87, *MSE* = 6.09, *p* < 0.01.

3.3. There was no interaction: *F*(1,36) = .10, *MSE* = 6.09, *p* < .75.

</div>

<div latex="true" class="task" id="Task"> 

Providing charts in APA style is an important skill. SPSS charts need some work to make them conform. [@fig:trafficPlot] is a spruced up version of the plot that SPSS original produced. Editing charts is achieved by double-clicking on them in the output window. This exposes a toolbox with which can change visual properties.

4. See if you can get your plot to look like [@fig:trafficPlot]. 

</div>

![Output---Profile Plots](.4twa/12-10-2016-883.png "Output---Profile Plots"){#fig:trafficPlot}


<div latex="true" class="journal" id="Journal"> 

4. What do the significant effects reported in [@fig:trafficAnovaTable], together with the plot in [@fig:trafficPlot], tell us?

</div>

<div latex="true" class="answer" id="Answer"> 

The effect of age was significant, and adult participants had better recall than younger ones. The effect of noise was significant, and quiet conditions led to better recall than loud conditions. The interaction was not significant, so the effect of noise was the same for both adults and children (the differences observed in the descriptive statistics failed to reach significance).

</div>



# Example 2: Alcohol and Music on Driving Ability

> In the lecture, I described an experiment investigating the effects of alcohol and music on driving behaviour. Below you will find the raw data. Participants were allocated to one of four groups, depending on whether or not they had some alcohol before getting in the car and whether or not they had music whilst driving. Alcohol and Music are the two factors, both between-subjects. The DV is driving ability, measured as the number of errors committed whilst driving.

![The effects of alchohol and music on driving ability. ycccc](support/4twaAlcoholDriving.csv)

<div latex="true" class="task" id="Task"> 

5. Type these data into SPSS, which will give you more practice with setting up data files correctly. Make sure:

- You enter the above data correctly in the *Data* view;

- In the *Variable* view, give each variable an appropriate label and name (I've called my variables *participant*, *music*, *alcohol*, *errors*---use the same for now, so that you don't have any problems running the syntax below);

- Also in the *Variable* view, use the *Values* column to assign values to your grouping numbers (without these, your output will be more difficult to interpret);

- Finally, in the *Variable* view, set the *Measure* view correctly for each variable (without this, SPSS may not perform the correct analyses).

</div>

<div latex="true" class="answer" id="Answer"> 

- My values for *music* are *1 = Music*, *2 = No music*; values for *alcohol* are *1 = Alcohol*, *2 = No alcohol*

- *participant* is *nominal*, *music* is *ordinal*, *alcohol* is *ordinal*, *errors* is *scale*

</div>

<div latex="true" class="journal" id="Journal">

5. Report the design of the study

</div>

<div latex="true" class="answer" id="Answer"> 

This is a 2 x 2 between-groups factorial design. Factor one is music (no music; music) and factor two is alcohol (no alcohol; alcohol).

</div>

<div latex="true" class="task" id="Task"> 

6. As usual, get an overview of your data by looking at the means. Go to *Analyse* > *Compare Means* and compute them for each group. You should get something like [@fig:drivingDescs].

</div>

![Output---Descriptives for error by alcohol group and music group](.4twa/12-10-2016-354.png "Output---Descriptives for error by alcohol group and music group"){#fig:drivingDescs}

<div latex="true" class="journal" id="Journal">

6. Describe what you see in the means.

</div>

<div latex="true" class="answer" id="Answer"> 

Participants produced more errors when they heard music (mean 4.67) versus not hearing music (2.50). With alcohol, their errors increased markedly (from 1.00 to 6.2). 

</div>

<div latex="true" class="task" id="Task"> 

7. Now set up the ANOVA as you did in Example 1's [Step Three](#exSetup). Remember:

- to ask that SPSS produce a table of descriptives as well marginal means for all our effects;

- to test the homogeneity of variance;

- to produce a plot depicting the results (ask for alcohol as separate lines and music on the horizontal axis, so that you get the same plot as mine).

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS Syntax:

~~~

UNIANOVA errors BY music alcohol
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /PLOT=PROFILE(music*alcohol)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(music) 
  /EMMEANS=TABLES(alcohol) 
  /EMMEANS=TABLES(music*alcohol) 
  /PRINT=HOMOGENEITY DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=music alcohol music*alcohol.

~~~

</div>


![Output---Estimated Marginal Means](.4twa/12-10-2016-548.png "Output---Estimated Marginal Means"){#fig:drivingPlot}

<div latex="true" class="task" id="Task"> 

8. Before you check anything else, have a look at your plot to see the familiar data pattern. Edit it to make it look like [@fig:drivingPlot].

</div>

<div latex="true" class="journal" id="Journal">

7. What does the graph tell us about our results? On the basis of the graph, would you expect a main effect of music? A main effect of alcohol? An interaction? Explain your answer to each of those questions.

</div>

<div latex="true" class="answer" id="Answer"> 

- Yes, you might expect a main effect of music. When collapsed across alcohol condition, the means will be different.

- You might expect a main effect of alcohol because, again, when collapsing across the other factor (music), the means will be different.

- Since the lines are not parallel, we might expect an interaction.

</div>

Now let’s have a look at the results and find out what the statistics are telling us.

<div latex="true" class="journal" id="Journal"> 

7. Have we met the homogeneity of variance assumption? Report the statistics from [@fig:drivingLevene] to back up your answer.

</div>

![Output---Levene's Test of Equality of Variances](.4twa/12-10-2016-549.png "Output---Levene's Test of Equality of Variances"){#fig:drivingLevene}

<div latex="true" class="answer" id="Answer"> 

Yes, Levene’s test is nonsignificant: *F*(3,8) = 0.40, *p* = .76. A non significant result means that the variances are likely to be equal.

</div>

<div latex="true" class="journal" id="Journal"> 

8. Report all main and interaction effects. In plain English, what does each effect mean in terms of group differences? Which of these effects need post hoc tests and why?

</div>

<div latex="true" class="answer" id="Answer"> 

We have:

- A significant main effect of music on driving ability, *F*(1, 8) = 10.56, *MSE* = 1.33, *p* = .012. Driving ability differed depending on music group (with music, performance was worse).

- A significant main effect of alcohol on driving ability, *F*(1, 8) = 60.06, *MSE* = 1.33, *p* < .001. Driving ability differed depending on alcohol group (with alcohol, performance was worse).

- A significant interaction of music and alcohol on driving ability, *F*(1, 8) = 10.56, *MSE* = 1.33,  *p* = .012

We should carry out simple main effects analyses for the interaction. No post hoc testing is required to follow up the significant main effects because both factors have only two conditions; because of this, there's nothing more we can learn from post hoc pairwise comparisons.

</div>

The (spoiler alert) significant interaction effect needs to be followed up with simple main effects analyses. Remember that in order to carry out SME analyses, we need to access the SPSS Syntax Editor. 

<div latex="true" class="task" id="Task"> 

9. Go to *Analyse > General Linear Model > Univariate*.

- If you haven't exited SPSS, you'll find that the settings for your last ANOVA will still be present in the dialogue box. In this case, simply click *paste* and the syntax for the ANOVA will appear in a new syntax window. (The window might be somewhere in the background.)

- If you have exited SPSS, you'll have to re-enter the settings for your last ANOVA before clicking *paste*.

10. Ensure your syntax looks like [@fig:drivingSyntax].

</div>


![Syntax---Univariate ANOVA, without SME analyses](.4twa/12-10-2016-485.png "Syntax---Univariate ANOVA, without SME analyses"){#fig:drivingSyntax}

<div latex="true" class="highlight" id="Remember">

- Syntax is a programming language, and these need attention to detail. Even a misplaced comma will stop a program running correctly.

- In SPSS Syntax, variables are black and all other text colour-coded. If you find that you've typed a command but SPSS has not coloured-coded it, then this suggests that SPSS has not recognised the command; have you spelled it correctly?

</div>

In [@fig:drivingSyntax], look at the line reading:

~~~

/EMMEANS=TABLES(music*alcohol) 

~~~

We're going to extend this line so that it asks SPSS to calculate the simple main effects *within music* of *alcohol*[^mA], while making a Bonferroni adjustment to control for familywise error:

~~~

/EMMEANS=TABLES(music*alcohol) compare (music) ADJ(BONFERRONI)

~~~

Additionally, beneath it, we will include the following, which produces the simple main effects *within alcohol* of *music*[^Am] (while making the same familywise error adjustment):

[^mA]: These SMEs will tell us (i) whether listening to music affected driving ability in the group that had alcohol and (ii) whether listening to music affected driving in the group that had no alcohol.

[^Am]: These SMEs will tell us (i) whether drinking alcohol affected driving ability in the group that had music in the car and (ii) whether alchohol affected driving in the group that did have music.


~~~

/EMMEANS=TABLES(music*alcohol) compare (alcohol) ADJ(BONFERRONI)

~~~

Your syntax should now look like [@fig:drivingSyntaxSME].

![Syntax---Univariate ANOVA, including SME analyses](.4twa/12-10-2016-870.png "Syntax---Univariate ANOVA, including SME analyses]"){#fig:drivingSyntaxSME}

<div latex="true" class="task" id="Task"> 

10. Run the syntax.

- Make sure the syntax window has focus and the syntax you wish to run is currently under cursor selection.

- Then click on the menu bar *Run* followed by *Selection*.

- Check that your two new *Univariate Tests* tables look like [@fig:drivingmA] and [@fig:drivingAm]. If they don't, something might be wrong with your syntax, so go back and see if you can spot your error.

</div>

![Output---Univariate Tests, Simple Main Effects of Music within Alcohol](.4twa/12-10-2016-892.png "Output---Univariate Tests, Simple Main Effects of Music within Alcohol"){#fig:drivingmA}

![Output---Univariate Tests, Simple Main Effects of Alcohol within Music](.4twa/12-10-2016-936.png "Output---Univariate Tests, Sample Main Effects of Alcohol within Music"){#fig:drivingAm}

<div latex="true" class="journal" id="Journal"> 

9. Were the simple main effects of music within alcohol significant ([@fig:drivingmA])? Report the statistics to back up your answer.

</div>

<div latex="true" class="answer" id="Answer"> 

The SME of music was significant within the alcohol condition, *F*(1,8) = 21.13, *MSE* = 1.33, *p* =.002, but it wasn’t significant within the no alcohol condition, *F*(1,8) = .001, *MSE* = 1.33, *p* > .99.

</div>

<div latex="true" class="journal" id="Journal"> 

10. Were the simple main effects of alcohol within music significant ([@fig:drivingAm])? Report the statistics to back up your answer.

</div>

<div latex="true" class="answer" id="Answer"> 

The SME of Alcohol was significant within the no music condition, *F*(1,8) = 60.50, *MSE* = 1.33, *p* < .001, and it was also significant within the music condition, *F*(1,8) = 10.13, *MSE* = 1.33, *p* = .013.

</div>

<div latex="true" class="journal" id="Journal"> 

11. Based on the results of the ANOVA and post hoc analyses, what can we conclude?

</div>

<div latex="true" class="answer" id="Answer"> 

- Both music and alcohol had an effect on driving ability independently (which we have determined by observing the main effect of each factor). The presence of music made their performance worse, as did the presence of alcohol.

There was a significant interaction. Follow up analyses indicated:

- When participants had alcohol, music made their performance worse. When participants had no alcohol, music didn't have an effect on their performance. (This is concluded from the SME of music within alcohol.)

- Participants were made worse by alcohol no matter whether they heard music or not. (This is concluded from the SME of alcohol within music.)

</div>

# Versions {#versions}

& deployments &


