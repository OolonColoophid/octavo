---
title: "MPSMD2RES Workshop 7: ANOVA Overview"
title-meta: "MPSMD2RES Workshop 7, ANOVA Overview"
author: "Dr Ian Hocking, Psychology Programme"
date: "September 2016 to April 2017"
version: 1.1
headimage: "$HOME/Dropbox/CCCU/text/deploy/media/2res/tufteHeadImageCompass"
headquote: "Research is creating new knowledge."
headquoteauthor: "Neil Armstrong"
httpdestination: "http://cccupsychology.com/deployIh/2res/workshops/"
remotedirectory: "2res/workshops/"
deployto: "$HOME/Dropbox/CCCU/text/2res/deploy/workshops"
formats: "octavoOpenDyslexicPdf"
preview: "octavoOpenDyslexicPdf"
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
autoEqnLabels: true
...

# Overview

-----------------------  -------------------------------------
*Data files required*    [Wellbeing data](https://www.dropbox.com/s/ylrpxert0mp3af2/7anvWellbeing.sav?dl=0)
                         [Wellbeing data, trimmed](https://www.dropbox.com/s/28hewif2qbxji4q/7anvWellbeingTrimmed.sav?dl=0)

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop will reinforce some of the assumptions of ANOVA and what to do when they are broken. It will also introduce measures of effect size for the ANOVA. We'll begin with the ANOVAs (between groups and within) and then consider the effect size statistics $R^2$, $r$ and $\omega^2$. 

&& 2resWorkshopBookletHeader

# Workshop

This workshop represents just about as far as we'll go with ANOVA.

<div latex="true" class="answer" id="Answer"> 

SPSS data files and syntax:

[Wellbeing data](https://www.dropbox.com/s/ylrpxert0mp3af2/7anvWellbeing.sav?dl=0)

[Wellbeing syntax](https://www.dropbox.com/s/kpxtxe8d9oq8fwv/7anvWellbeing.sps?dl=0)

[Wellbeing data, trimmed](https://www.dropbox.com/s/28hewif2qbxji4q/7anvWellbeingTrimmed.sav?dl=0)

[Wellbeing syntax, trimmed](https://www.dropbox.com/s/dt1ujpxcgw43h65/7anvWellbeingTrimmed.sps?dl=0)

</div>

# Between-Groups ANOVA{#between}

For this example, we'll use the [Wellbeing data set](https://www.dropbox.com/s/ylrpxert0mp3af2/7anvWellbeing.sav?dl=0). This study captured questionnaire data on life satisfaction and some other demographic variables. It is not an experiment---in which groups are created and manipulated---but uses existing groups in the manner of a correlational design.

<div latex="true" class="journal" id="Journal">

1. Spend a few moments looking at the data. Switch between the *Variable View* and the *Data View* to get a sense of it. Pay particular attention to the labels given each to variable and what its values are. 

</div>

We're going to run an analysis looking at differences in 'lifenow' ("Overall, how satisfied are you with your life nowadays?") by 'higheducation' ("What is the highest level of qualification?"; this can be broken into four levels, as you can see from the *Variable View*).

<div latex="true" class="journal" id="Journal">

2. How would you describe this analysis?

</div>

<div latex="true" class="answer" id="Answer"> 

- This is a one-way between groups ANOVA looking at the effect of Education Level (degree, below degree, other, none) on life satisfaction.

</div>

<div latex="true" class="journal" id="Journal"> 

3. As usual, we should start by looking at the means. Using *Analyze > Compare Means > Means* investigate the overall pattern of means for life satisfaction broken down by Education.

</div>

<div latex="true" class="answer" id="Answer"> 

- The picture in the means (6.78, 7.34, 7.00, and 5.76) is unclear, though it could well be that those in the 'degree' group and those in the 'none' group have a slightly lower life satisfaction.

---

SPSS syntax for the above:

~~~

MEANS TABLES=lifenow BY higheducation
  /CELLS=MEAN COUNT STDDEV.

~~~

</div>

<div latex="true" class="highlight" id="Remember">

Recall that between groups ANOVA has three main assumptions:

1. Independence of cases

2. Normality

3. Equality (or "homogeneity") of variances

- We can test for (2) by trying to ensure that the dependent variable is normally distributed within the different levels of the factor. There are many ways of assessing normality but I'd like to focus on Q-Q plots and the Shapiro-Wilk Test.

- We can test for (3) by looking at variance differences. For this, we'll examine the statistic produced by Levene's Test.

</div>

## Assessing Normality

Read through the instructions below, which describe how you can obtain some measures of normality, before you actually follow the instructions.

1. Begin by heading to *Analyse > Descriptive Statistics > Explore*.

2. Enter the appropriate variables in the *Dependent List* and the *Factor List* ([@fig:spssExp]).

![SPSS Explore](.7anv/04-11-2016-150.png "SPSS Explore"){#fig:spssExp}

3. Go to *Plots* and set the options described in [@fig:spssExpPlots].

![SPSS Explore---Plots](.7anv/04-11-2016-542.png "SPSS Explore---Plots"){#fig:spssExpPlots}

4. Click *OK* and brace yourself for a raft of output.

<div latex="true" class="task" id="Task"> 

1. Go ahead and run the *Explore* command as described above. 

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above:

~~~

EXAMINE VARIABLES=lifenow BY higheducation
  /PLOT BOXPLOT STEMLEAF HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

~~~

</div>

There are two things to look at:

1. Q-Q Plots

2. The Shapiro-Wilk statistic

Let's talk about the Q-Q plots first. When data are normally distributed, data points should fall along the diagonal. [@fig:qqOther] shows the Q-Q plot for life satisfaction when the educational level is 'other'. There's certainly deviation from the diagonal line, and in this case I'd say we need to be a bit careful about whether we can assume normality.

![SPSS Output---Q-Q Plot for life satisfaction (now) when the educational level is 'other'](.7anv/04-11-2016-496.png "SPSS Output---Q-Q Plot for life satisfaction (now) when the educational level is 'other'"){#fig:qqOther}

<div latex="true" class="journal" id="Journal">

4. Look at the other Q-Q plots. What do you make of them?

</div>

<div latex="true" class="answer" id="Answer"> 

Certainly, none is quite so out-of-true as [@fig:qqOther]. But there are grounds for being cautious about their normality.

</div>

Now we'll turn to the Shapiro-Wilk statistic. The null-hypothesis of this test states that the population is normally distributed. Thus, when we see a *p* value that is lower than our criterion value of 5%, we can call this a deviation from normality. To view the statistic for each factor level, look at [@fig:swEduc].

![SPSS Output---Tests of Normality](.7anv/04-11-2016-195.png "SPSS Output---Tests of Normality"){#fig:swEduc}

<div latex="true" class="journal" id="Journal">

5. Interpret this table in plain English. What do you see here?

</div>

<div latex="true" class="answer" id="Answer"> 

The Shapiro-Wilk statistics are all significant, so we may well have problems with our ANOVA achieving the normality.

</div>

The last assumption, equality of variances, will be tested by the Levene statistic, which we can compute when we run the ANOVA itself.

Let's prepare to run a one-way ANOVA to test the effect we've been talking about. Before you run it, make sure you select the options shown in [@fig:bgOptions].

![SPSS ANOVA Options](.7anv/04-11-2016-863.png "SPSS ANOVA Options"){#fig:bgOptions}

Under *Post hoc* select the comparisons Bonferroni, Tukey, Scheffe and Games-Howell, as you see in [@fig:bgPostHoc].

![SPSS ANOVA Options, Post Hoc](.7anv/04-11-2016-137.png "SPSS ANOVA Options, Post Hoc"){#fig:bgPostHoc}

<div latex="true" class="task" id="Task"> 

2. Run a one-way ANOVA of Education Level on Life Satisfaction (now). Refer to the earlier seminar booklet if you need to.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above ANOVA:

~~~

ONEWAY lifenow BY higheducation
  /STATISTICS DESCRIPTIVES HOMOGENEITY BROWNFORSYTHE 
WELCH 
  /PLOT MEANS
  /MISSING ANALYSIS.
  /POSTHOC=TUKEY SCHEFFE BONFERRONI GH ALPHA(0.05).
 
~~~

</div>

<div latex="true" class="journal" id="Journal">

6. What do you make of Levene's test for the equality of variances?

</div>

<div latex="true" class="answer" id="Answer"> 

- In the table *Test of Homogeneity of Variances*, Levene's statistic(3,239) = 7.94, *p* < .001.

- Because the null hypothesis for this test is for the equality of variances, we can say that the ANOVA has failed this assumption.

</div>

Given that (spoiler alert) the ANOVA has failed the test of equality of variances (probably because of the uneven cell sizes), we will need to look for an adjusted statistic; the original *F* is no longer reliable. The one we'll look for in this case is the Welch corrected *F*, which can be found in [@fig:robust] (under some circumstances, which you can read more about in Field, 2009, you might wish to report the Brown-Forsythe).

![SPSS Output---Robust Tests of Equality of Means](.7anv/04-11-2016-546.png "SPSS Output---Robust Tests of Equality of Means"){#fig:robust}

We report Welch's *F* like this (fictitious example):

> Welch's *F*(3,30.17) = 10.95, *p* < .001

<div latex="true" class="journal" id="Journal">

7. Report Welch's *F* for the ANOVA you've just performed.

</div>

<div latex="true" class="answer" id="Answer"> 

Welch's *F*(3,63.99) = 4.30, *p* < .01. We're seeing a main effect (adjusted for the violation of homogeneity of variance) of Education.

</div>

When Levene's test is significant, we'll need to look at a corrected pairwise comparison, which in this case is the Games-Howell post hoc test.

<div latex="true" class="journal" id="Journal">

8. Where do the differences lie within education level?

</div>

<div latex="true" class="answer" id="Answer"> 

The Games-Howell statistic tells us the difference lies between 'none' (mean of 5.76; the lowest) and 'below degree level' (mean of 7.34; the highest).

</div>

# Within Groups ANOVA

Download the SPSS data [Wellbeing data, trimmed](https://www.dropbox.com/s/28hewif2qbxji4q/7anvWellbeingTrimmed.sav?dl=0).

<div latex="true" class="highlight" id="Remember">

The repeated measures ANOVA has two assumptions:

1. Normality

2. Sphericity

</div>

<div latex="true" class="task" id="Task"> 

3. Familiarise yourself with the new data set. Notice that we now have fewer cases and that some variables are measured at three different times (T1, T2 and T3).

</div>

<div latex="true" class="journal" id="Journal">

9. Use *Explore*, as you did [above](#between), to produce a descriptives report on the answer to the question 'Overall, how satisfied are you with your work situation?' at time 1, time 2 and time 3 (work_T1, work_T2 and work_T3), as well as the answer to the question 'Overall, how satisfied are you with your financial situation?' (financial_T1, financial_T2 and financial_T3). What do you think of the normality? Use the Q-Q plots and Shapiro-Wilk Test statistics.

- Don't put anything in the factor list of the *Explore* box; that's more useful when you have a between-groups factor. Simply drop all four variables into the *Dependent List* box.

</div>

<div latex="true" class="answer" id="Answer"> 

- In terms of means, the highest mean is the Time 2 measure of Work satisfaction (M=5.89) while the lowest is the one reported by participants for financial satisfaction at Time 3 (M=5.04). (Remember too that standard deviation provides a measure of dispersion, and this can be informative.)

- In terms of the Q-Q plots and Shapiro-Wilk Test statistics, the data are not normally distributed. There's a good chance that our ANOVA will be unreliable under these circumstances.

---

SPSS syntax for the above:

~~~

EXAMINE VARIABLES=work_T1 financial_T1 work_T2 
financial_T2 work_T3 financial_T3
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING PAIRWISE
  /NOTOTAL.

~~~

</div>

<div latex="true" class="task" id="Task"> 

4. Use what you've learned in an earlier booklet to run a two-way repeated measures ANOVA to test for differences in Work and Financial satisfaction at Time 1, Time 2 and Time 3. Thus, you will have two factors: Wellbeing (Work or Financial) and Time (1, 2 and 3).

- Use the *Plots* menu to create a Time by Wellbeing plot and another one for the reversed order, Wellbeing by Time. This will give you two plots so you can see the effects from different perspectives.

- In the *Options* menu put the following into *Display means for:* overall, Time, Wellbeing and Time*Wellbeing. This will give you a comprehensive set of means.

- If you want to do follow-up analyses, use the *compare main effects* with a Bonferroni adjustment. Check the *Descriptive Statistics* box.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above:

~~~

GLM work_T1 work_T2 work_T3 financial_T1 
financial_T2 financial_T3
  /WSFACTOR=Wellbeing 2 Polynomial Time 3 Polynomial 
  /METHOD=SSTYPE(3)
  /PLOT=PROFILE(Wellbeing*Time Time*Wellbeing)
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Wellbeing) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Time) COMPARE ADJ(BONFERRONI)
  /EMMEANS=TABLES(Wellbeing*Time) 
  /PRINT=DESCRIPTIVE 
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=Wellbeing Time Wellbeing*Time.
  
~~~

</div>

When Mauchly's Test shows non-sphericity, we need to report an adjusted *F* ratio such as the Greenhouse-Geisser.

<div latex="true" class="journal" id="Journal">

10. What do you make of Mauchly's Test?

</div>

<div latex="true" class="answer" id="Answer"> 

Given that this highly significant for Time (*p* < 0.001), we need to apply the Greenhouse-Geisser correction to both the *F* ratio and its associated Mean Square Error.

</div>

<div latex="true" class="journal" id="Journal">

11. Making use of adjusted statistics where necessary, report all main and interaction effects for the ANOVA.

</div>

<div latex="true" class="answer" id="Answer"> 

- Wellbeing: *F*(1,111) = 9.97, *MSE* = 6.39, *p* < 0.01. Work satisfaction was higher than financial satisfaction.

- Time: *F*(2,222) = 0.46, *MSE* = 15.756, *p* = .955. There was no change attributable to time overall.

- Wellbeing * Time: *F*(2,222) = 4.91, *MSE* = 5.06, *p* < 0.05. There was interaction between Wellbeing and Time, which could be further investigated using Simple Main Effects.

</div>

# Effect Sizes

In the second seminar booklet, you learned about effect size. This is a simple way of quantifying differences. It's particularly handy---once you've noted which effect size is being used---for getting a quick sense of how large an experimental effect actually is.

The two measures of effect size I'd like to concentrate on are $r$, which is the correlation statistic that you're used to, and $\omega^2$, or *omega squared*.

It would be nice if SPSS produced these for us. Unfortunately, it doesn't.

## r

In the first seminar booklet, you looked at the statistic $r$. This is a measure of association that runs from -1 to +1. If you take a correlation of .5, for instance, you can claim a strong correlation. We might see such an association when we collect data on temperature and road rage incidents: a correlation of .5 would tell us that, as temperate increases, so too does road rage.

The $r$ statistic can also tell something else about variance. When we take its square, we derive a measure of the variability overlap---or *shared variance*---between the two variables in the correlation. For instance, keeping to the example of $r=.5$, look what happens when we square it:

$$ r=.5 $$

$$ R^2=.25 $$

This value, $R^2$[^rsq], gives us a measure of how much variability in the first variable is shared with---or accounted by---the second variable. So we can now say that there is a $25$% shared variability between temperature and road rage. In other words, 25% of the variability in road rage can be accounted for by temperature, and vice versa. Because $R^2$ is the square of $r$, which can run between -1 and +1, $R^2$ will always be a positive number between 0 and 1. You can always multiply $R^2$ by 100 to get a percentage score of overlap.

[^rsq]: $R^2$ can be written in uppercase or as $r^2$. However, I'll stick to $R^2$ because you'll most commonly see it in this form.

Now let's apply this to the ANOVA, starting with a one-way between subjects ANOVA.

Think about effect size for ANOVA as the amount of variability explained by our factor versus the total amount of variability that we have. In other words, we can consider it as the amount of variability explained by our factor versus the amount of variability left over. Thus, it is the sum of squares for the model, $SS_M$, versus the total sum of squares, $SS_T$.

A better way of expressing this is as a fraction representing the proportion of all the variability in the data that the factor can explain, and this is shown in [@eq:simpleRsquare].

$$ R^2=\frac{SS_M}{SS_T} $$ {#eq:simpleRsquare}

This value is also known as $\eta^2$, or *eta squared*, as shown in [@eq:RsquareIsEtaSquared].

$$ R^2=\eta^2 $$ {#eq:RsquareIsEtaSquared}

We can either stick with $R^2$ and interpret our findings in terms of shared variance, or we can simply take the square of $R^2$ to find *r*.

Let's do an example--which happens to be the one you'll find in Field (2009, p.389). Here, we're looking at a one-way ANOVA with a factor whose model sum of squares is 20.13 and whose total sum of squares is 43.73.

$$ R^2=\frac{SS_M}{SS_T} $$

$$ =\frac{20.13}{43.73} $$

$$ =.46 $$

This gives us a shared variance of .46. In other words, the factor accounts for 46% of the total variability in the study.

Now let's convert this into *r*, which will give us a more familiar statistic.

$$ r=\sqrt{.46} $$
$$ =.68 $$

We now have an *r* statistic of .68, and from here we can apply the benchmark of Cohen (1992, as cited by Field, 2009) in [@tbl:interpR].

--------------------------------------------------
*r*  Effect size Variance accounted for
---- ----------- ---------------------------------
.1   Small       1%

.3   Medium      9%

.5   Large       25%
--------------------------------------------------

Table: Interpreting Effect Size for *R* {#tbl:interpR}

Thus, our value of $r=.68$ would be a large effect size.

<div latex="true" class="highlight" id="Remember">

Remember that effect size interpretations need to be made in the context of the literature, not just the rule of thumb above. For instance, in a clinical context, one might need to reach a particular effect size in a study comparing the effectiveness of a new drug against a control group in order for that drug to be viewed as clinically effective.

</div>


<div latex="true" class="journal" id="Journal">

12. Assume that you have produced an ANOVA whose main effect $SS_M$ is 4.6 and $SS_T$ is 30.1.

- Report the $R^2$.

- Report the $r$.

- Interpret the $r$ according to [@tbl:interpR]

</div>

<div latex="true" class="answer" id="Answer"> 

- $R^2=.46$

- $r = \sqrt{R^2} = .68$

- According to [@tbl:interpR], this is a very large effect.

</div>

---

You might have noticed above that our measure of variance was the *total* squares, not the *mean* squares. The mean squares are, as we've seen earlier in the module, the sum of squares divided by *degrees of freedom*. This allows the *F* ratio to be a better fit for the population by adjusting it slightly (according to how many groups and participants we have). Without this adjustment, the *F* ratio tells us more about our sample and less about the population. As psychologists, we're more interested in the population than the sample.

The same is true, then, for *r*. When it is based on unadjusted sums of squares, it's a poorer fit for the population. The adjusted statistic that you often see for this task is $\omega^2$, or *omega squared*. Calculating $\omega^2$ is similar to calculating *r*.

The equation for $\omega^2$ is below..

$$ \omega^2 = \frac{SS_M-(df_M)MS_E}{SS_T+MS_E}$$ {#eq:omegaSquared}

Let's talk about what's happening in [@eq:omegaSquared]. The top part of the fraction is still the variability explained by the model. The bottom part is still the total variability. But, now, the top part is adjusted so that as the error for the model, $MS_E$, gets larger, the top part of the fraction gets smaller; this means that, the larger the error, the more likely the overall effect is to get smaller. Secondly, the bottom part will become greater as the model error, $MS_E$, increases, which in turn reduces the overall effect size.

The other thing to plug into [@eq:omegaSquared] is the degrees of freedom for the effect, which you can get from SPSS output[^df].

[^df]: For a main effect, this will be the number of levels in the factor minus one.

Let's go through an example. Again, we'll use the same one as @field2009discovering, p. 389.

$$ \omega^2 = \frac{20.13-(2)1.97}{43.73+1.97} $$

$$ = \frac{16.19}{45.70} $$

$$ = .35 $$

So our $\omega^2$ statistic, an adjusted effect size, is (at .35) a little smaller than our $R^2$ (which was .46), but we can be sure it represents the population more accurately.

Remember that $\omega^2$, in its squared form, is a measure of shared variance telling you how much of a factor's variance overlaps with the total variability. In the form $\omega$---having taken the square root---interpretation is just like *r*.

<div latex="true" class="journal" id="Journal">

13. Assume that you have run a one-way between groups ANOVA and see the output in [@fig:oneWay]. This shows a significant main effect of Therapy Group on social activity level.

- Report $\omega^2$

- Remembering that $\omega$ is equivalent to $r$, interpret $\omega$ according to [@tbl:interpR].

</div>

![SPSS Output---One Way ANOVA](.7anv/04-11-2016-35.png "SPSS Output---One Way ANOVA"){#fig:oneWay}

<div latex="true" class="answer" id="Answer"> 

- $\omega^2 = \frac{18.6-(2)0.893}{42.7+0.893} = 0.39$

- $\omega = \sqrt{\omega^2}$

- $\omega = .62$

- According to [@fig:oneWay], this is a very large effect size, so we can call the effect of Therapy Group a very large one.

</div>

----

As @field2009discovering points out, most of the time a statistic like $\omega^2$ isn't very informative because it's telling us about the overall effect for a factor, which can often have several levels. It's somewhat more useful to examine the effect size of two-group comparisons. Knowing that the effect size refers to two groups makes it easier to interpret. The statistic we'll use for this is, once again, *r*.

Let's say that we've just run a t-test on two levels in a factor (as a follow-up to a main effect) and found *t* statistic of 2.474. Our degrees of freedom can be found in the SPSS output. In this case, $df=12$.

Have a look at [@eq:rEffect].

$$ r=\sqrt{\frac{t^2}{t^2+df}}$${#eq:rEffect}

Using this, we can run through the figures to determine *r*.

$$ r=\sqrt{\frac{2.474^2}{2.474^2+12}} $$

$$ =\sqrt{\frac{6.12}{18.12}} $$

$$ =.58 $$

Now that we have the value for *r*, we can look it up using Cohen's (1992, as cited by Field, 2009) criteria in [@tbl:interpR] and see that it is a large effect size.

<div latex="true" class="journal" id="Journal">

14. Assume that you have found a significant difference between two conditions, where $t=1.82$ and $df=20$.

- Report the $r$.

- Interpret the $r$ according to [@tbl:interpR]

</div>

<div latex="true" class="answer" id="Answer"> 

- $r=\sqrt{\frac{1.82^2}{1.82^2+20}}=0.38$

- This is a medium effect size.

</div>

Use effect sizes where you can and report them alongside the statistic whose effect size you are estimating.

# Versions {#versions}

& deployments &

&& licence

&& referencesHeader
