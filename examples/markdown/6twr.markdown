---
title: "MPSMD2RES Workshop 6: Two-Way Repeated and Mixed ANOVA"
title-meta: "MPSMD2RES Workshop 6, Two-Way Repeated and Mixed ANOVA"
author: "Dr Ian Hocking, Psychology Programme"
date: "September 2016 to April 2017"
version: 1.0
headimage: "$HOME/Dropbox/CCCU/text/deploy/media/2res/tufteHeadImageCompass"
headquote: "Research is creating new knowledge."
headquoteauthor: "Neil Armstrong"
httpdestination: "http://cccupsychology.com/deployIh/2res/workshops/"
remotedirectory: "2res/workshops/"
deployto: "$HOME/Dropbox/CCCU/text/2res/deploy/workshops"
formats: "octavoTuftePdf, octavoHtml, octavoNormalPdf, octavoOpenDyslexic, octavoLargePdf, octavoSpoken"
preview: ""
ftpdeploy: "yes"
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
bibliography: "$HOME/Dropbox/CCCU/text/biblio/handbooks/2RES.bib"
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
*Data files required*    [Therapy](https://www.dropbox.com/s/y356wdy7jxpcbip/6twrSunshine.sav?dl=0)

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop extends your knowledge of Analysis of Variance (ANOVA) to repeated and mixed factorial designs. In a *repeated* design, all factors are repeated. In a *mixed* design, there is at least one *repeated* factor and one *independent* factor.

&& 2resWorkshopBookletHeader

# Workshop

Analysis of variance or ‘ANOVA’ is a statistical technique that allows us to examine the differences between mean scores when there are more than two conditions. In this booklet, we will carry out the analysis required for a design with two independent variables (i.e. two factors). In the [first case](#repeated), we will look at an analysis where both factors are *repeated*. In the [second](#mixed), we will look at a *mixed* analysis where one factor is *repeated* and one is *independent*.

<div latex="true" class="highlight" id="Remember">

In both cases, the ANOVA will tell us three things:

1. Is there a main effect of factor one on the dependent variable (DV)? 

2. Is there a main effect of factor two on the DV? 

3. Is there an interaction effect of the two factors on the DV?

There's a lot to get through in this week's booklet, but it's important material. Be prepared to continue with the exercises outside of the seminar.

</div>

<div latex="true" class="answer" id="Answer"> 

All data and syntax for this booklet:

- [Repeated ANOVA SPSS data](https://www.dropbox.com/s/wesf1eoqfb9djoc/6twrCourse.sav?dl=0)

- [Repeated ANOVA SPSS syntax](https://www.dropbox.com/s/mk7nrhboodqjbe5/6twrCourse.sps?dl=0)

- [Mixed ANOVA SPSS data](https://www.dropbox.com/s/y356wdy7jxpcbip/6twrSunshine.sav?dl=0)

- [Mixed ANOVA SPSS syntax](https://www.dropbox.com/s/d8nrsu9ak6fav2t/6twrSunshine.sps?dl=0)

</div>

# Repeated ANOVA

We'll start by revisiting the example I showed you in the lecture. 

> Students from the University of Statisticsburg were asked to rate the lectures that they received in relation to how much they enjoyed them. Each student surveyed was taking a course in statistics and a course in criminal psychology and were given the survey at the beginning of the course and again ten weeks later at the end. The researcher wanted to know three things:

> 1. Did people rate one course more positively than the other?

> 2. Did people rate the course differently from the start to the end of the course?

> 3. Was the difference in ratings from the start to the end of the course the same for both courses?

> Ratings are provided per student in the table below. Responses could range from 0 (hate it) to 10 (love it).

![Before and after ratings for the statistics and criminal psychology courses. ycccc](support/6twrCourse.csv)

## Step One: Load the data into SPSS{#repeated}

<div latex="true" class="task" id="Task"> 

1. Set up a new SPSS data file and enter the data in the table above.

- Call the variables *stats_start*, *criminal_start*, *stats_end* and *criminal_end*

- Give them appropriate labels

- Make sure SPSS knows the data type associated with each (which should be *scale*)

</div>

## Step Two: Run descriptive statistics

Before we carry out the ANOVA it is a good idea to get an idea of what is going on with the data. 

<div latex="true" class="task" id="Task"> 

2. Calculate the mean scores for the four conditions by going to *Analyze > Descriptive statistics > Descriptives*. Put all four conditions into the right hand box and click *OK*.

</div>

<div latex="true" class="journal" id="Journal">

1. Describe what the means tell you.

</div>

<div latex="true" class="answer" id="Answer"> 

These means represent the average ratings for Statistics and for Criminal Psychology at the beginning and end of the courses. They show that Statistics had much lower ratings than Criminal Psychology at the beginning of the term but the difference was much smaller by the end of the term. Whereas Statistics increased, Criminal Psychology decreased slightly.

---

SPSS Syntax:

~~~

DESCRIPTIVES VARIABLES=stats_start criminal_start 
stats_end criminal_end
  /STATISTICS=MEAN STDDEV MIN MAX.

~~~

</div>

## Step Three: Set up the ANOVA

By looking at the descriptive statistics you have some idea of what students thought about the courses and whether their opinions became more or less positive by the end of the course. Now let’s see whether those differences are significant or not.

<div latex="true" class="highlight" id="Remember">

Read through the instructions below before doing them yourself.

</div>

1. Remember that all the SPSS statistical analyses are under the *Analyze* menu, so go there, select *General Linear Model*, then *Repeated Measures*. A window will appear where you can define the repeated measures factors (independent variables). As we have two repeated measures factors, we will define two.

2. First type ‘time’ into the box next to Within-Subject Factor Name. This variable has two levels (the start and the end of term) so type 2 into the box next to *Number of Levels*. Then click on *Add* and it will show up in the main box. Next, define the second repeated measures variable: 'course'. This also has two levels (statistics and criminal psychology). Once this has been defined and added you should have something that looks like [@fig:courseDefine].

![SPSS Repeated Measures Define Factors Dialogue](.6twr/26-10-2016-439.png "SPSS Repeated Measures Define Factors Dialogue"){#fig:courseDefine}

3. Now click on *Define* and a new box will appear, which should look like [@fig:courseANOVA]. This is where we tell the SPSS which columns of data to look at.

![SPSS Repeated Measures Main ANOVA Dialogue](.6twr/26-10-2016-584.png "SPSS Repeated Measures Main ANOVA Dialogue"){#fig:courseANOVA}

<div latex="true" class="highlight" id="Remember">

- Pay close attention to the numbers in [@fig:courseANOVA]'s *Within-Subjects Variables (time, course)* box. Each line in this box refers to the *column* in the *Data View* where SPSS can find the data for a particular factor combination. (You can think of these combinations as the cells in the overall table when you put ANOVA into tabular form, with marginal means.) For instance, *\_?\_(1,1)* is SPSS's way of requesting the data that matches level 1 of the first factor and level 1 of the second factor. Likewise, *\_?\_(1,2)* requests level 1 of the first factor and level 2 of the second. Bearing in mind that factor one is Time (start vs. end) and factor two is Course (statistics vs. criminal psychology):

    - stats_start is (1,1)

    - criminal_start is (1,2)

    - stats_end (2,1)

    - criminal_end (2,2)

</div>

4. Drag the variables across to the *Within-Subjects Variables (time, course)* box. It should look like [@fig:courseANOVAtwo].

![SPSS Repeated Measures Main ANOVA Dialogue, completed](.6twr/26-10-2016-57.png "SPSS Repeated Measures Main ANOVA Dialogue, completed"){#fig:courseANOVAtwo}

5. Make sure you also ask SPSS to create a graph of the results by clicking on *Plots*. Put 'Time’ along the x-axis (category axis) and enter ‘Course’ as separate lines. See [@fig:coursePlots]. Now click *Add* then *Continue*.


![SPSS Repeated Measures Plots](.6twr/26-10-2016-334.png "SPSS Repeated Measures Plots"){#fig:coursePlots}

6. Lastly, click on *Options* and move everything in the left-hand box into the right-hand box; also tick *Descriptives* and *Homogeneity Tests* (see [@fig:courseOptions]). Click on *Continue* and *OK*. 


![SPSS Repeated Measures Options](.6twr/26-10-2016-478.png "SPSS Repeated Measures Options"){#fig:courseOptions}

Now we're ready to run the ANOVA.


<div latex="true" class="task" id="Task"> 

2. Go ahead and run the ANOVA as described above.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the ANOVA:

~~~

* Repeated measures ANOVA (Time by Course).
GLM stats_start criminal_start stats_end criminal_end
  /WSFACTOR=time 2 Polynomial course 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(time*course)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(time) 
  /EMMEANS=TABLES(course) 
  /EMMEANS=TABLES(time*course) 
  /PRINT=DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time course time*course.

~~~

</div>


## Step Four: Interpret the Output

We are now ready to answer the important question. Are those differences significant or not?

The table that we should look at first is *Mauchly’s Test of Sphericity*. You should have one that looks like [@fig:courseMauchly].

![Output---Mauchly's Test](.6twr/26-10-2016-238.png "Output---Mauchly's Test"){#fig:courseMauchly}

<div latex="true" class="journal" id="Journal">

2. What do you make of the Mauchly's Test results?

</div>

<div latex="true" class="answer" id="Answer"> 

- Mauchly's test cannot be completed without at least one factor with more than two levels. Because both our factors have two levels each, this table will remain blank.

- When a factor has two levels, we don't actually need to worry about sphericity (the property being assessed by Mauchly's test) because the data happen to have perfect sphericity in this case. To find out more, take a look at @field2009discovering.

</div>

Next, let’s look at the *Tests of Within-Subjects Effects*, [@fig:courseTestsWS].

![Output---Tests of Within-Subjects Effects](.6twr/26-10-2016-562.png "Output---Tests of Within-Subjects Effects"){#fig:courseTestsWS}


<div latex="true" class="journal" id="Journal">

- Answer the following questions in plain English and back them up with the appropriate statistics written in APA format. Remember, you will also need to look at the descriptive statistics to interpret the findings fully.

4. Did people rate one course more positively than the other? Is there a need for further analysis?

5. Did people rate the courses differently from the start to the end of the course? And is there a need for further analysis?

6. Was the difference in ratings from the start to the end of the courses the same for both courses? Is there a need for further analysis?

</div>

<div latex="true" class="answer" id="Answer"> 

4. Yes, the main effect of Course was significant: *F*(1,9) = 36.41, *MSE* = 2.73, *p* < .001. The means tell us that Criminal Psychology was rated more positively than Statistics. Because this factor has only two groups, there is no scope for further analysis.

5. Yes, there was a significant main effect of Time: *F*(1,9) = 14.23, *MSE* = 1.28, *p* = .004. The descriptive statistics tell us that ratings, averaged across both courses, were higher at the end of the courses than at the beginning. Since there are only two time points, there is no need for further analysis.

6. The difference in ratings was not the same for both courses, since the interaction between Course and Time was significant: *F*(1,9) = 23.28, *MSE* = 1.17, *p* = .001. We need to explore this with further analysis.

</div>

<div latex="true" class="task" id="Task"> 

3. As you did last time, make the interaction graph look like the one in [@fig:courseInteraction] by using the SPSS graph editor.

</div>

![Output---Profile Plots](.6twr/26-10-2016-563.png "Output---Profile Plots"){#fig:courseInteraction}

<div latex="true" class="journal" id="Journal">

7. Generally, and with regards to a potential interaction, what does the graph show?

</div>

<div latex="true" class="answer" id="Answer"> 

The lines are not parallel, which might indicate the interaction is significant. The pattern of cell means would indicate that the ratings for Statistics changed more than the ratings for Criminal between the start and end.

</div>

Since the interaction was significant, we’ll need to carry out Simple Main Effects analyses. To do this, you’ll need to carry out one-way repeated measures ANOVAs for each factor within the levels of the other factor. Carry out these analyses using the instructions in the lecture slides and answer the questions below. Remember that this analysis is very similar to one you've just done with two factors, but now you'll have one factor (for instance, Course) constrained to one level of the other factor (for instance, Time 1).

<div latex="true" class="journal" id="Journal">

8. Were the Simple Main Effects of Course within each level of Time significant? Report the statistics to back up your response and explain what these results mean in plain English.

</div>

<div latex="true" class="answer" id="Answer"> 

- The SME of Course was significant at the Start: *F*(1,9) = 70.05, *MSE* = 1.64, *p* < .001. The means show that Criminal Psychology was rated more positively than Statistics.

- The SME of Course was not significant at the End: *F*(1,9) = 5.00, *MSE* = 2.25, *p* = .052, which means that by the end of term, students rated Statistics and Criminal Psychology equally. (Alternatively, this can be treated as a marginally significant difference, showing that Criminal was still liked better than Statistics, although the gap is much narrower than at the start of term.)

---

SPSS syntax for the above ANOVAs:

~~~

* SME of Course for Time1 (beginning).
GLM stats_start criminal_start
  /WSFACTOR=Course_time1 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(Course_time1)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Course_time1) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Course_time1.

* SME of Course for Time2 (end).
GLM stats_end criminal_end
  /WSFACTOR=Course_time2 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(Course_time2)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Course_time2) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Course_time2.

~~~

</div>


<div latex="true" class="journal" id="Journal">

9. Were the Simple Main Effects of Time within each level of Course significant? Report the statistics to back up your response and explain what these results mean in plain English.

</div>

<div latex="true" class="answer" id="Answer"> 

- The SME of Time was significant for Statistics: *F*(1,9) = 21.32, *MSE* = 2.11, *p* = .001. The means show that ratings increased for Statistics from the start to the end of the course.

- However, the SME of Time was not significant within Criminal Psychology: *F*(1,9) = 1.33, *MSE* = 0.34, *p* = .279. This means there was no change in ratings between the start and the end of the course for Criminal Psychology.

---

SPSS syntax for the above ANOVAs:

~~~

* SME of Time for Course1 (statistics).
GLM stats_start stats_end
  /WSFACTOR=Time_Course1 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(Time_Course1)
  /EMMEANS=TABLES(Time_Course1) 
  /EMMEANS=TABLES(OVERALL) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Time_Course1.

* SME of Time for Course2 (criminal psychology).
GLM criminal_start criminal_end
  /WSFACTOR=Time_Course2 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(Time_Course2)
  /EMMEANS=TABLES(Time_Course2) 
  /EMMEANS=TABLES(OVERALL) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Time_Course2.

~~~

</div>

# Mixed ANOVA

So far you have looked at ANOVAs where all independent variables have been of one design or another (either repeated measures/within-groups or independent/between-groups). Now we will work through the analysis required when you have two factors (two-way), one of which has participants contributing to all conditions (repeated measures) while the other has different participants in each group (independent measures). We call this design *mixed*.

As always, the ANOVA will tell us three things: 

1. Is there a main effect of IV1 on the DV? 

2. Is there a main effect of IV2 on the DV? 

3. Is there an interaction effect of the two IVs on the DV?

In the following analysis, we'll build upon an example you've looked at before.

> A researcher put 30 depressed patients into one of three therapy groups (CBT, Sunshine therapy, no therapy). She found that having some therapy had a positive effect on sociability levels but it didn’t matter whether that therapy was CBT or sunshine. Three months later the researcher was interested in finding out whether the effects of therapy had lasted so she got the group of patients together again and recorded, just like the first time, the amount of time each patient engaged in social activities.

## Step One: Load the data into SPSS {#mixed}

<div latex="true" class="task" id="Task"> 

4. Download the [data file](https://www.dropbox.com/s/y356wdy7jxpcbip/6twrSunshine.sav?dl=0).

</div>

## Step Two: Run descriptive statistics

As usual, let's get an overview of what's going on with the data.

<div latex="true" class="task" id="Task"> 

5. Calculate mean scores for the three groups. Do this by going to *Analyze > Compare Means > Means*. Put ‘activity 1’ and ‘activity 2’ in the *Dependent* box and ‘group’ into the *Independent box*. Now click *OK*.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax:

~~~

MEANS TABLES=activity1 activity2 BY group
  /CELLS=MEAN COUNT STDDEV.

~~~

</div>

You should get [@fig:sunshineDescriptives].

![Therapy and Sociability Descriptives](.6twr/30-10-2016-491.png "Therapy and Anxiety Descriptives"){#fig:sunshineDescriptives}

<div latex="true" class="journal" id="Journal">

10. On the basis of the descriptives, do you think the effect of therapy varies over time?

</div>

<div latex="true" class="answer" id="Answer"> 

Although the overall amount of sociability between time 1 and time 2 hasn’t changed, there are differences depending on the group. Activity in the group receiving sunshine therapy has decreased from 2.50 to 1.10 hours, in the CBT group sociability increased from 2.80 to 4 hours, and in the no therapy group it remained more or less stable.

</div>

## Step Three: Set up the ANOVA

We'll now see whether the differences in the sample can be said to be differences in the population. To do this, we'll use the same *Repeated Measures* SPSS menu option as before, because this dialogue box allows us to specify not only within-groups factors but between-groups factors as well. (In other words, don't look for an SPSS procedure specifically labelled 'mixed'.)  

<div latex="true" class="highlight" id="Remember">

Read through the instructions below before doing them yourself.

</div>

1. Go to *Analyze* > *General Linear Model* > *Repeated Measures*. A window will appear where you can define the repeated measures factor (independent variable) you have. As we have only one repeated measures factor (Time: immediately after therapy and three months later), we will just define this one. If you can’t remember how to define your repeated measures factor, have a look at [the repeated measures example](#repeated).

2. Your next window, where you define factors, should look like [@fig:sunshineUndefine].

![SPSS Repeated Measures Define Factors Dialogue](.6twr/27-10-2016-446.png "SPSS Repeated Measures Define Factors Dialogue"){#fig:sunshineUndefine}

3. Put the two repeated measures conditions into the *Within-Subjects Variable* box and the independent measures factor into the *Between-Subjects Factor* box. This should look like [@fig:sunshineSelected].

![SPSS Repeated Measures Factor Selection](.6twr/27-10-2016-36.png "SPSS Repeated Measures Factor Selection"){#fig:sunshineSelected}

4. As you've done several times by now, click on *Options* ask for means for every effect. This will give us more detailed descriptive statistics. Click on *Continue*. 

5. Ask SPSS for two graphs: one with ‘Therapy Group’ on the horizontal axis and ‘Time’ as separate lines; and one with 'Time' on the horizontal axis and 'Therapy Group' as separate lines. Click *Continue* and *OK*. You've now set up a basic two-way mixed ANOVA.

<div latex="true" class="task" id="Task"> 

5. Carry out the ANOVA according to the method above.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the ANOVA:

~~~

* Mixed (Therapy Group by Time) ANOVA.
GLM activity1 activity2 BY group
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(group*time time*group)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(group) 
  /EMMEANS=TABLES(time) 
  /EMMEANS=TABLES(group*time) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=group.

~~~

</div>

## Step Four: Interpret the Output

Before we look at the basic statistics, let's look at the graphs produced by SPSS, [@fig:sunshinePlotsXtherapy] and [@fig:sunshinePlotsXtime]. I've suggested you produce two of them because each represents a way of looking at the data. It could well be that you find one arrangement more intuitive than another; be aware, however, that they depict the same information.

![Output---Plot (Therapy by Time)](.6twr/27-10-2016-715.png "Output---Plot (Therapy by Time"){#fig:sunshinePlotsXtherapy}

![Output---Plot (Time by Therapy)](.6twr/27-10-2016-770.png "Output---Plot (Time by Therapy"){#fig:sunshinePlotsXtime}

<div latex="true" class="journal" id="Journal">

10. What can we infer from the graph in terms of main and interaction effects? Explain how you arrived at your answer.

</div>

<div latex="true" class="answer" id="Answer"> 

- Since the lines are not parallel, we might expect an interaction.

- The effect of Time would not appear to be significant (averaging data points across each line, there wouldn’t be much of a difference between the two marginal means).

- There seems to be an effect of Therapy, as the marginal means for each group (average of Time 1 & Time 2 means for each Therapy group), are different. 

</div>

Let’s see if your inferences are backed up by the ANOVA. Again, there are a number of tables we don’t need to look at to understand our findings. The first table that we should look at is *Mauchly’s Test of Sphericity*. You should have one that looks like [@fig:sunshineMauchly].

![Output---Mauchly's Test of Sphericity](.6twr/27-10-2016-776.png "Output---Mauchly's Test of Sphericity"){#fig:sunshineMauchly}

<div latex="true" class="journal" id="Journal">

11. What assumption does the above table relate to? Why are there no significance values?

</div>

<div latex="true" class="answer" id="Answer"> 

The table relates to the Sphericity assumption. There are no significance values because it only applies when the within-subjects factors have more than two levels, which is not the case here.

</div>

Next, let’s look at the *Tests of Within-Subjects Effects*, [@fig:sunshineWSE]. This will tell us about the main effect of our repeated measures factor (Time) and the interaction between Time and Therapy Group.

![Output---Tests of Within-Subjects Effects](.6twr/27-10-2016-548.png "Output---Tests of Within-Subjects Effects"){#fig:sunshineWSE}

<div latex="true" class="journal" id="Journal">

- Answer the following questions in plain English and back them up with the appropriate statistics written in APA format. Remember, you will also need to look at the descriptive statistics to interpret the findings fully.

12. Was there an effect of time on sociability? Is there a need for further analysis?

13. Was there an interaction between time and therapy on sociability? Is there a need for further analysis?

</div>

<div latex="true" class="answer" id="Answer"> 

- No, there was no effect of time on sociability – this means that participants did not engage in more social activity in time 1 than in time 2 or vice versa: *F*(1,27) <0.001, *MSE* = 0.40, *p* >.99. Since the effect is not significant, there is no need for further analysis. And, even if it were significant, there is no need to track down where the difference might lie because the factor has only two levels.

- Yes, the interaction between time and therapy was significant, *F*(2,27) = 21.50, *MSE* = 0.40, *p* < .001. This means that there was a different amount of change in levels of activity between time 1 and time 2, depending on the therapy group. Because the interaction is significant, we need Simple Effects analysis to help us determine where the differences across time in [@fig:sunshinePlotsXtime] actually differ.

</div>

The last thing to find out is whether there was an effect of therapy on sociability generally, regardless of how long after therapy the measure was taken. To find this out come down to the table titled *Tests of Between-Subjects Effects*, shown in [@fig:sunshineBSE].

![Output---Tests of Between-Subjects Effects](.6twr/27-10-2016-765.png "Output---Tests of Between-Subjects Effects"){#fig:sunshineBSE}

<div latex="true" class="journal" id="Journal">

14. Was there a main effect of therapy on sociability? Is there a need for further analysis?

</div>

<div latex="true" class="answer" id="Answer"> 

Yes, there was a difference in sociability levels depending on the group: *F*(,2) = 17.96, *MSE* = 1.55, *p* < .001. We need to follow this up with post-hoc comparisons because we have three groups, so we don’t know which mean differs from which.

</div>

<div latex="true" class="highlight" id="Remember">

In this example, we have a main effect of Therapy Group and an interaction between Therapy and Time. We need, therefore, to carry out *post hoc analyses*.

</div>

## Investigating the Main Effect of Therapy Group

Therapy is a three-level factor (CBT, sunshine and no therapy). Our main effect tells us that there is a significant difference between at least one pair of levels, or groups (i.e. CBT v. sunshine, CBT v. no therapy, or sunshine v. therapy). Because we're looking for paired differences, we need to do *pairwise comparisons*.

<div latex="true" class="task" id="Task"> 

6. Run the pairwise comparisons on Therapy Group to investigate the main effect.

- Go back into *General Linear Model > Repeated Measures* and click *Define*. (The ANOVA should still be set up if you haven’t exited SPSS.)

- Go to *Options* and ask for the marginal means of ‘Group’ only. (You can remove the other effects and the ‘overall’ mean by highlighting them and clicking on the arrow between the two boxes). 

- Click on *compare main effects* and selected *Bonferroni* from the drop-down list immediately below. (This will offer pair-wise comparisons for the means of the levels of ‘Group’, controlling for family-wise error rate.) Click on *Continue*. Your dialogue box should look like [@fig:sunshineGroupOptions]. Click *OK*.

</div>

![Repeated Measures ANOVA Dialogue, Pairwise Comparisons for Therapy Group](.6twr/27-10-2016-712.png "Repeated Measures ANOVA Dialogue, Pairwise Comparisons for Therapy Group"){#fig:sunshineGroupOptions}

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above analysis:

~~~

GLM activity1 activity2 BY group
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(group*time time*group)
  /EMMEANS=TABLES(group) COMPARE ADJ(BONFERRONI)
  /PRINT=DESCRIPTIVE HOMOGENEITY 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time 
  /DESIGN=group.

~~~

</div>

Your *Pairwise Comparisons* table should look like [@fig:sunshineTherapyPairwise].

![Output---Pairwise Comparisons for Levels within Therapy Group](.6twr/27-10-2016-957.png "Output---Pairwise Comparisons for Levels within Therapy Group"){#fig:sunshineTherapyPairwise}

<div latex="true" class="journal" id="Journal">

15. What were the results of the post hoc tests on the main effect of Therapy? Report the statistics to back up your answer.

</div>

<div latex="true" class="answer" id="Answer"> 

CBT differed from both no therapy (*p* < .01) and sunshine therapy conditions (*p* < .01). Looking at the means, we can see that CBT resulted in higher sociability than the other two. CBT is, therefore, driving the main effect that we see.

</div>

## Investigating the Interaction of Therapy Group and Time

In our mixed analysis, we have an independent factor (Therapy Group) and a repeated factor (Time). For various reasons that we don't need to go into---[unless you're interested](http://psychologicalstatistics.blogspot.co.uk/2006/07/how-to-calculate-simple-main-effects.html); cf. @howell_statistical_1997), it is quite straightforward to examine the interaction in terms of the repeated factor, but more difficult to examine it in terms of the independent factor (and we do not expect you to do this in your assignment). For this reason, we'll focus on looking at the interaction from the perspective of the repeated factor.

This means we'll be be asking 'What is the effect of Time within each Therapy Group?' In other words, we're looking at how the repeated factor explains variability within each level of the independent factor. In other words, again, we're going to run three separate one-way repeated measures ANOVAs, presented below as the analyses followed by the question each analysis answers:

1. Time (for No Therapy): Did the No Therapy Group change over time?

2. Time (for CBT): Did the CBT group change over time?

3. Time (for Sunshine): Did the Sunshine group change over time?

<div latex="true" class="highlight" id="Remember">

At this point, it might be useful to touch upon the analysis we *won't* be doing, i.e. 'What is the effect of Therapy Group within Time?' This analysis, from the perspective of the independent/between-groups factor, would have allowed us examine:

1. Therapy Group (for Time 1): Did Therapy Groups differ at Time 1?

2. Therapy Group (for Time 2): Did Therapy Groups differ at Time 2?

In this case, such an analysis would be theoretically less interesting for us, since we're really interested in the effects of therapy *across* time, which best answered by the three one-way repeated ANOVAs above (Time (for No Therapy) etc.).

- Again, if you find yourself needing to do Simple Main Effects from the perspective of the between-groups factor, [see this webpage](http://psychologicalstatistics.blogspot.co.uk/2006/07/how-to-calculate-simple-main-effects.html), or @howell_statistical_1997.

</div>

Let's now do the Simple Main Effects analysis of Therapy Group from the perspective of Time. At the moment, our SPSS data file has all cases (participants) selected. We want to focus on each level of Therapy Group and perform an analysis on each. So, because Therapy Group is a between-groups factor, marking group membership on a case-by-case basis, we can simply use *Select Cases* to identify, or filter, the participants we're interested in.

<div latex="true" class="highlight" id="Remember">

- Read through the instructions for selecting cases and running each ANOVA before performing them.

</div>

1. Start by going to *Data* > *Select Cases*.

2. We're now going to describe our filter to SPSS. Select *If condition is satisfied*.

3. Define the Therapy Group to be selected. Start with *If Group = 1*. Your dialogue box should look like [@fig:sunshineDefineTG].

![Define Cases where Therapy Group = 1, No Therapy](.6twr/27-10-2016-218.png "Define Cases where Therapy Group = 1, No Therapy"){#fig:sunshineDefineTG}

4. Verify that the selection is working as you expect. Check that the *Data View* shows the appropriate cases to be *selected* (row number is untouched) and *unselected* (row number is struck out). When the filter is 'Therapy Group = 1', you should see something like [@fig:sunshineSelectedTG].

![Data View with only Therapy Group = 1, No Therapy](.6twr/27-10-2016-895.png "Data View with only Therapy Group = 1, No Therapy"){#fig:sunshineSelectedTG}

5. Now that the scope of the data has been restricted to those participants in the No Therapy group, we can run a one-way repeated measures ANOVA (the factor being Time) and our F ratio will tell us whether is there an effect of time within the No Therapy group.

<div latex="true" class="task" id="Task"> 

7. Using the *Select Cases* procedure above, and referring to an earlier workshop booklet on one-way repeated measure ANOVA, go ahead and run one-way repeated ANOVAs of Time for each of the three levels of Therapy Group. 

- Tip: If you paste the syntax from the *Select Cases* command, as well as the ANOVA, you may find changing the group variable and running the syntax much faster than doing everything manually via the menu system.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above analysis:

~~~

* Examining Simple Main Effects of Time
* within levels of Therapy Group.

* Start by defining our filter to select
* case where Group = 1 (no therapy).
USE ALL.
COMPUTE filter_$=(group=1).
VARIABLE LABELS filter_$ 'group=1 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Repeated measures ANOVA, one way,
* examing effect of Time within
* Therapy Group = 1.
GLM activity1 activity2
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time.




* Select cases for Therapy Group = 2.
USE ALL.
COMPUTE filter_$=(group=2).
VARIABLE LABELS filter_$ 'group=2 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Repeated measures ANOVA, one way,
* examing effect of Time within
* Therapy Group = 2.
GLM activity1 activity2
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time.


* Select cases for Therapy Group = 3.
USE ALL.
COMPUTE filter_$=(group=3).
VARIABLE LABELS filter_$ 'group=3 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

* Repeated measures ANOVA, one way,
* examing effect of Time within
* Therapy Group = 3.
GLM activity1 activity2
  /WSFACTOR=time 2 Polynomial 
  /METHOD=SSTYPE(3)
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=time.

~~~

</div>

<div latex="true" class="journal" id="Journal">

16. Report what the above analysis tells you.

</div>

<div latex="true" class="answer" id="Answer"> 

- Sociability levels did not change for those in the No Therapy group: *F*(1,9) = .47, *MSE* = 0.42, *p* = .51.

- There was a significant change in sociability for those in the CBT group, *F*(1,9) = 17.05, *MSE* = 0.42, *p* = .003, and in the sunshine group, *F*(1,9) = 27.56, *MSE* = 0.36, *p* = .001. Looking at the means in the *Descriptive Statistics* table, we can see that sociability went up for the CBT group and decreased in the sunshine group.

</div>

# Versions {#versions}

& deployments &

&& licence

&& referencesHeader
