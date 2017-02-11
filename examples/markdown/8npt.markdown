---
title: "MPSMD2RES Workshop 8: Advanced Nonparametric Statistics"
title-meta: "MPSMD2RES Workshop 8, Advanced Nonparametric Statistics"
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
autoEqnLabels: true
...

# Overview

-----------------------  -------------------------------------
*Data files required*    [Mann-Whitney data](https://www.dropbox.com/s/yq0o4ew8pl6gbpf/8nprMannWhitney.sav?dl=0)
                         [Wilcoxon data](https://www.dropbox.com/s/zj2pjxteusq65qw/8nprWilcoxon.sav?dl=0)
                         [Kruskal-Wallis data](https://www.dropbox.com/s/aip55rrvumwn3um/8nprKruskalWallis.sav?dl=0)
                         [Friedman data](https://www.dropbox.com/s/r4clnwxvwbfx433/8nprFriedman.sav?dl=0)

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop will introduce you to nonparametric tests of difference for two independent samples, two paired samples, multiple independent samples, and multiple related samples.

&& 2resWorkshopBookletHeader

# Workshop

In this workshop, we'll look at the [Mann-Whitney](#mannWhitney), [Wilcoxon](#wilcoxon), [Kruskal-Wallis](#kruskalWallis) and [Friedman](#friedman) tests, which are all nonparametric tests of group differences.

The *parametric* statistical tests you've looked at so far on MPSMD2RES, like the t-test, make assumptions about your population. For instance, if you measure reaction times in two conditions and compare them using a t-test, the t-test assumes that the reaction time population[^population] has characteristics such as a normal distribution.

*Nonparametric* statistical tests---sometimes called *distribution-free*---rely less on assumptions about the population. Because a test is distribution-free, that makes it very useful under certain circumstances, such as when your sample[^sample] is taken from a population that may not have the restrictive characteristics required by parametric tests. Now, nonparametric tests do make *some* assumptions; but these are far more liberal than those of parametric tests. Partly as a result of this, they have lower *power*---i.e., they are less likely to detect an effect if it exists. Nonparametric tests do, however, have an advantage. They are less sensitive to outliers because their calculations are based on ranks (where last is last, no matter how far from the mean), and thus work as tests of *median* differences.

[^population]: The population represents all the possible reaction times that you might have sampled.

[^sample]: Remember that your sample should look like your population, as long as the sample is a fair one.

<div latex="true" class="answer" id="Answer"> 

SPSS data files and syntax:

[Mann-Whitney data](https://www.dropbox.com/s/yq0o4ew8pl6gbpf/8nprMannWhitney.sav?dl=0)

[Mann-Whitney syntax](https://www.dropbox.com/s/dziljuuvpgogwui/8nprMannWhitney.sps?dl=0)

[Wilcoxon data](https://www.dropbox.com/s/zj2pjxteusq65qw/8nprWilcoxon.sav?dl=0)

[Wilcoxon syntax](https://www.dropbox.com/s/5pt4zvquj6o1j5q/8nprWilcoxon.sps?dl=0)

[Kruskal-Wallis data](https://www.dropbox.com/s/aip55rrvumwn3um/8nprKruskalWallis.sav?dl=0)

[Kruskal-Wallis syntax](https://www.dropbox.com/s/ah5echx3omwyprw/8nprKruskalWallis.sps?dl=0)

[Friedman data](https://www.dropbox.com/s/r4clnwxvwbfx433/8nprFriedman.sav?dl=0)

[Friedman syntax](https://www.dropbox.com/s/z579po07t6hjr08/8nprFriedman.sps?dl=0)

</div>

# Mann-Whitney Test {#mannWhitney}


Use this test when you wish to test for the differences of *two conditions* of *independent* data. This is the nonparametric equivalent of the independent samples t-test.

<div latex="true" class="highlight" id="Remember">

Assumptions of this test are:

- Observations from the two groups are independent

- The observations are *ordinal* (i.e. they can be put in a meaningful order; or, in other words, they can be ranked)

The null hypothesis ($H_0$) for this test is:

> The overall difference between the two groups is zero

As usual, our *p* will tell us the probability of seeing our observed data under the assumption that $H_0$ is true.

- Our alternative hypothesis ($H_1$) is that ranked observations in each group are different. Whereas a t-test, being parametric, tells us about the likelihood of finding *mean* differences, the Mann-Whitney test tells us more about the *median* difference; in other words, these are both tests of central tendency but use different measures of central tendency.   

</div>

> In the following example, a researcher was interested in the effect of distraction on a measure of verbal working memory called reading span [@daneman_individual_1980]. She had participants attempt this test---providing a *reading span score*---under either noisy or silent conditions. A higher reading span score indicate higher reading span.

<div latex="true" class="task" id="Task"> 

1. Download and familiarise yourself with the [data](https://www.dropbox.com/s/yq0o4ew8pl6gbpf/8nprMannWhitney.sav?dl=0)

</div>

<div latex="true" class="task" id="Task"> 

2. Using *Analyse* > *Descriptive Statistics* > *Explore*, get descriptive statistics for the dependent variable broken down by the independent variable. I'd suggest requesting Q-Q plots, histograms, and tests of normality.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS Syntax for the above:

~~~

* Descriptive statistics.

DATASET ACTIVATE DataSet1.
EXAMINE VARIABLES=readingSpan BY group
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

~~~

</div>

It's worth taking a moment to look at these descriptive statistics. The median span for noise and silence are 6 and 7 respectively, which suggests that reading span was higher under the silence condition---an expected finding. However, we need to be careful about concluding anything from the means because we need an inferential statistic to tell us whether we can trust the difference. Which test do we choose? Because we have small, unequal cell sizes, a parametric test might not be appropriate. A look at the Q-Q plots is also worrying. For noise, the Q-Q plot shows a poor fit between observed values and values that we would predict on the basis of the normal distribution. Similarly, while the reading span scores in the silence condition show a non-significant Shapiro-Wilk W statistic, this is not the case for noise: *W*(5) = .68, *p* < .001.

Taken together, this suggests that a more appropriate test is the Mann-Whitney.

Let's get ready to run the test. Look over the instructions below before you do so.

1. Navigate to *Analyse* > *Nonparametric* > *Legacy Dialogues* > *2 Independent samples*

2. Set 'readingSpan' as your test variable, as you see in [@fig:mwOptions].

3. Set 'group' as your grouping variable. Define its groups as '1' and '2'.

4. Make sure that 'Mann-Whitney U' is selected. 

5. Because we want the *exact* significance level, we will request it by clicking *Exact...* on this dialogue box and then selecting *Exact* (with a *Time limit per test* of five minutes, if you like). See [@fig:mwOptionsExact].

![SPSS Two-Independent-Samples Tests](.8npt/11-11-2016-57.png "SPSS Two-Independent-Samples Tests"){#fig:mwOptions}

![SPSS Two-Independent-Samples Tests, Exact Tests](.8npt/11-11-2016-251.png "SPSS Two-Independent-Samples Tests, Exact Tests"){#fig:mwOptionsExact}

<div latex="true" class="highlight" id="Remember">

When reporting the significance (*p*) value for nonparametric tests, SPSS often provides different methods. These are:

1. The Asymptotic Method

2. The Exact Method

- The first case---the *asymptotic* method---is most accurate with large samples and doesn't use up too much computer processing time. The second---*exact*---is more accurate when we have fewer data points or when the data are poorly distributed.

- @field2009discovering recommends going for the *exact* significance where possible, since we clearly would like precision(pp. 546-547). Because the *exact* method is labour-intensive for the computer, Field suggests a *Monte Carlo* option when the sample is large and a straightforward *exact* test when the sample is small. Most of our samples in psychology are small.

- Lastly, if don't see the *Exact Tests* table in your version of SPSS, it could be that you don't have the *Exact tests* module installed.

</div>

<div latex="true" class="task" id="Task"> 

3. Run the Mann-Whitney U test.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS Syntax:

~~~

NPAR TESTS
  /M-W= readingSpan BY group(1 2)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).

~~~

</div>

Your output should look like [@fig:mwOutput]. In the *Ranks* you will find the mean ranks of both groups (remember that the Mann-Whitney is comparing ranks, not not means), and the sum of ranks. It's good practice to verify that the number of participants is correct.

The test statistic---$U$---is shown in the lower table of [@fig:mwOutput]. In this case, it's 6. Note that SPSS is also showing the Wilcoxon $W$ (which can be converted to a $z$ score).

![SPSS Output---Mann-Whitney](.8npt/11-11-2016-14.png "SPSS Two-Independent-Samples Tests"){#fig:mwOutput}

As an aside, remember that a *z* score, or standard score, is a value on the standard normal distribution. It tells us how far a value is above the mean. (The mean of the standard normal distribution is 0.) The higher the absolute value of a *z* score, the further from the mean, and the lower the chances are of finding it at random. For a one-tailed test, scores +/- 1.64 will occur less than 5% of the time (and the one-tailed significance for our *z* in @fig:mwOutput is indeed *p* = .032 < 0.05). You can read more about *z* scores in @field2009discovering.

If we assume that the researcher had a preconceived idea about noise being detrimental to reading span performance, we should attend to the one-tailed exact significance. We might report the Mann-Whitney in the following manner (note the use of the median instead of the mean, as the Mann-Whitney is telling us about median differences):

> Descriptive statistics showed that participants in the noise condition had lower reading span scores (median 6) than those in the silence condition (median 7). The Mann-Whitney U was found to be 6 (*z* = -1.94), *p* < 0.05.

# Wilcoxon's Matched Pairs Signed-Ranks Test {#wilcoxon}

Use this test when you wish to test for the differences of *two conditions* of *related* data. This is the nonparametric equivalent of the related samples t-test.

<div latex="true" class="highlight" id="Remember">

The assumptions of this test are:

- Data are paired

- The observations are *ordinal* (i.e. they can be put in a meaningful order; or, in other words, they can be ranked)

The null hypothesis ($H_0$) for this test is:

> The overall difference between the two groups is zero

As usual, our *p* will tell us the probability of seeing our observed data under the assumption that $H_0$ is true.

- Our alternative hypothesis ($H_1$) is that there is a difference between the groups. Whereas a related t-test, being parametric, tells us about the likelihood of finding *mean* differences between two related groups, the Wilcoxon test tells us more about the *median* difference; in other words, these are both tests of central tendency but use different measures of central tendency. The Wilcoxon looks at the ranks of the differences rather than the absolute difference.

</div>

> In our next example, we'll consider a design where the researcher wished to measure the susceptibility of reading span to training, so she measured reading span twice: once before training and once after.

<div latex="true" class="task" id="Task"> 

4. Download and familiarise yourself with the [data](https://www.dropbox.com/s/zj2pjxteusq65qw/8nprWilcoxon.sav?dl=0)

</div>


<div latex="true" class="task" id="Task"> 

5. Obtain descriptive statistics for the dependent variable broken down by the independent variable.

</div>

<div latex="true" class="journal" id="Journal">

1. What do you make of the normality in the data and the median differences?

</div>

<div latex="true" class="answer" id="Answer"> 

- Before training median = 3, after training median = 6 (so perhaps in the direction we might expect)

- The histogram (suggesting a bimodal distribution) and Shapiro-Wilks (*W* [12] = .84, *p* < 0.05) for the after training group both suggest a lack of normality.

---

SPSS Syntax for the above:

~~~

DATASET ACTIVATE DataSet2.
EXAMINE VARIABLES=time1 time2
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

~~~

</div>

We'll examine these group differences using the Wilcoxon test. Look over the instructions below before you carry them out.


1. Navigate to *Analyse* > *Nonparametric* > *Legacy Dialogues* > *2 Related Samples*

2. Set 'time1' and 'time2' as your only test pair. Note that in [@fig:wOptions] the variables are shown by their longer labels.

3. Make sure that 'Wilcoxon' is selected.

![SPSS Two-Related-Samples Tests](.8npt/11-11-2016-16.png "SPSS Two-Related-Samples Tests"){#fig:wOptions}

4. As before, because we want the *exact* significance level, we will request it by clicking *Exact...* on this dialogue box and then selecting *Exact*. This is identical to the Mann-Whitney *Eaxct...* box shown in [@fig:mwOptionsExact].

<div latex="true" class="task" id="Task"> 

6. Go ahead and run the Wilcoxon.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above:

~~~

NPAR TESTS
  /WILCOXON=time1 WITH time2 (PAIRED)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).
  
~~~

</div>

Your output should look like [@fig:wOutput].

![SPSS Output---Wilcoxon](.8npt/11-11-2016-102.png "SPSS Output---Wilcoxon"){#fig:wOutput}

<div latex="true" class="journal" id="Journal">

2. Assume the that the researcher was testing a one-tailed hypothesis. Using the medians as your descriptive statistics, how might you report the findings? The key statistic for the Wilcoxon is *z*.

</div>

<div latex="true" class="answer" id="Answer"> 

Descriptive statistics showed that participants improved their reading span scores after training, with a before training median of 3 and an after training median of 6. A Wilcoxon signed rank test indicated that this difference was reliable, *z* = -2.59, *p* < 0.05

</div>

# The Kruskal-Wallis One-way Analysis of Variance {#kruskalWallis}

Use this test when you wish to test for the differences between *multiple conditions* of *independent* data. This is an extension of the nonparametric Mann-Whitney test from two groups to multiple groups. You can also think of it as a nonparametric version of the parametric one-way between-groups ANOVA.

<div latex="true" class="highlight" id="Remember">

The assumptions of this test are:

- Data are independent

- The observations are *ordinal* (i.e. they can be put in a meaningful order; or, in other words, they can be ranked)

The null hypothesis ($H_0$) for this test is:

> The overall difference between the groups is zero

As usual, our *p* will tell us the probability of seeing our observed data under the assumption that $H_0$ is true.

- Our alternative hypothesis ($H_1$) is that there is a difference between the groups. Whereas a one-way between-groups ANOVA, being parametric, tells us about the likelihood of finding *mean* differences between two independent groups, the Kruskal-Wallis test tells us more about the *median* difference; in other words, these are both tests of central tendency but use different measures of central tendency. The Kruskal-Wallis looks at the ranks of the differences rather than the absolute difference.
             
</div>

> In this example, a researcher was interested in the effect of training on a measure called *reading fluency*, but rather than look at the effect within participants, she created three conditions---low, medium and high training---and placed different participants in each.

<div latex="true" class="task" id="Task"> 

7. Download and familiarise yourself with the [data](https://www.dropbox.com/s/aip55rrvumwn3um/8nprKruskalWallis.sav?dl=0)

</div>

<div latex="true" class="journal" id="Journal"> 

3. Report and comment on the normality of the data and the median group differences.

</div>


<div latex="true" class="answer" id="Answer"> 

- Medians for training group (low, medium and high) are: 12.5, 4, and 9.5

- The Shapiro-Wilk statistics are nonsignificant for low and medium groups, and marginally nonsignificant for the high group: *W*(4) = .76, *p* = .051

- The histograms for low and high training look decidedly non-normal; the Q-Q plots tell a similar story.

---

SPSS syntax for the above:

~~~

EXAMINE VARIABLES=readingFluency BY training
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

~~~

</div>


We'll examine these group differences using the Kruskal-Wallis test. Look over the instructions below before you carry them out.

1. Navigate to *Analyse* > *Nonparametric* > *Legacy Dialogues* > *K Independent Samples*

2. Set the *Test variable list* as 'readingFluency' and *Grouping variable* as 'training', as you see in [@fig:kwOptions]. Because our training groups are numbered 3, 4, and 5 (these are arbitrary), use 3-5 after clicking *Define Range*.

![SPSS Tests for Several Independent Samples](.8npt/11-11-2016-116.png "SPSS Tests for Several Independent Samples"){#fig:kwOptions}

3. Make sure 'Kruskal-Wallis H' is selected.

4. As before, request an *Exact* *p* value.

<div latex="true" class="task" id="Task"> 

8. Run the Kruskal-Wallis.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above:

~~~

NPAR TESTS
  /K-W=readingFluency BY training(3 5)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).

~~~

</div>

Your output should look like [@fig:kwOutput].

![SPSS Output---Kruskal-Wallis](.8npt/11-11-2016-605.png "SPSS Output---Kruskal-Wallis"){#fig:kwOutput}

<div latex="true" class="journal" id="Journal">

4. Using the medians as your descriptive statistics, how might you report the findings? The key statistic for the Kruskal-Wallis is the Chi-Square, written $\chi^2$. 

</div>

<div latex="true" class="answer" id="Answer"> 

Descriptive statistics showed that participants differed in their reading fluency according to level of training (with medians of 12.5, 4 and 9.5 for low, medium and high training conditions respectively). A Kruskal-Wallis one-way analysis of variance indicated that this difference was reliable, $\chi^2$ (2) = 11.44, *p* < 0.001.

</div>

<div latex="true" class="journal" id="Journal">

5. Investigate the source of the differences between conditions using two Mann-Whitney U tests. Examine low v. high and medium v. high. Don't forget that these are post hoc tests and require a correction for familywise error. I'd suggest the Bonferroni correction.

</div>

We won't exhaust all the possible comparisons because we want to keep our Bonferroni correction to a minimum---remember that, as the number of post hoc comparisons increase, the corrected alpha level gets harder and harder to beat.

<div latex="true" class="answer" id="Answer"> 

Our Bonferroni correction gives us a new alpha level of (5% / 2) = 2.5%. Note that we won't exhaust all the possible comparisons because we want to keep our Bonferroni correction to a minimum. Remember that, as comparison increase, the corrected alpha level gets harder and harder to beat.

- Curiously enough, those in the low training group (median 12.5) scored more than the medium and high training groups (medians of 4 and 9.5). Low-medium Mann-Whitney U was 0, *z* = -2.67, *p* < 0.025. Low-high Mann-Whitney was 0, *z* = 2.32, *p* < 0.025.

- (Note that a Mann-Whitney statistic of 0 occurs when all the values in one sample are higher than another.) 

---

SPSS syntax for the above:

~~~

* Mann-Whitney 'low' versus 'medium' (Group 3 v 4).
* Asking for asymptotic and exact significance.
NPAR TESTS
  /M-W= readingFluency BY training(3 4)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).

* Mann-Whitney 'low' versus 'high' (Group 3 v 5).
* Asking for asymptotic and exact significance.
NPAR TESTS
  /M-W= readingFluency BY training(3 5)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).

~~~

</div>

# The Friedman's Rank Test for *k* Correlated Samples {#friedman}

Use this test when you wish to test for the differences of *multiple conditions* of *related* data. This is an extension of the Wilcoxon test and represents the nonparametric equivalent of the one-way repeated-measures ANOVA.

<div latex="true" class="highlight" id="Remember">

The assumptions of this test are:

- Data are related

- The observations are *ordinal* (i.e. they can be put in a meaningful order; or, in other words, they can be ranked)

The null hypothesis ($H_0$) for this test is:

> The overall difference between the groups is zero

As usual, our *p* will tell us the probability of seeing our observed data under the assumption that $H_0$ is true.

- Our alternative hypothesis ($H_1$) is that there is a difference between the groups. Whereas a one-way repeated-measures ANOVA, being parametric, tells us about the likelihood of finding *mean* differences between two related groups, the Friedman test tells us more about the *median* difference; in other words, these are both tests of central tendency but use different measures of central tendency. The Friedman looks at the ranks of the differences rather than the absolute difference.

</div>

> In our final example, a researcher was interested in whether a visual stimulus could lead to changes in appetite. She showed participants a movie---'The Hunger Games'---and asked them to rate their hunger on three occasions: at the beginning, middle and end of the film.

<div latex="true" class="task" id="Task"> 

9. Download and familiarise yourself with the [data](https://www.dropbox.com/s/r4clnwxvwbfx433/8nprFriedman.sav?dl=0)

</div>

<div latex="true" class="journal" id="Journal"> 

6. Report and comment on the normality of the data and the median group differences.

</div>


<div latex="true" class="answer" id="Answer"> 

- Medians for hunger score at the beginning, middle and end of the film are 1.5, 2 and 3 respectively.

- The Shapiro-Wilk statistics are significant for the beginning and end hunger scores, though not the middle. Beginning: *W*(10) = .66, *p* < 0.001; end: *W*(10) = .76, *p* < 0.01.

- The histograms and Q-Q plots for the beginning seem non-normal; they look reasonably normal for the middle; for the end, they're also looking problematic. 

---

SPSS syntax:

~~~

* Descriptive statistics (via Explore option).
EXAMINE VARIABLES=beginning middle end
  /PLOT BOXPLOT HISTOGRAM NPPLOT
  /COMPARE GROUPS
  /STATISTICS DESCRIPTIVES
  /CINTERVAL 95
  /MISSING LISTWISE
  /NOTOTAL.

~~~

</div>

We'll examine these group differences using the Friedman test. Look over the instructions below before you carry them out.

1. Navigate to *Analyse* > *Nonparametric* > *Legacy Dialogues* > *K Related Samples*

2. Set the *Test variables* as our beginning, middle and end hunger measures, as you see in [@fig:fOptions]. 

![SPSS Tests for Several Related Samples](.8npt/12-11-2016-164.png "SPSS Tests for Several Related Samples"){#fig:fOptions}

3. Again, request an *Exact* *p* value.

<div latex="true" class="task" id="Task"> 

10. Run the Friedman.

</div>

<div latex="true" class="answer" id="Answer"> 

SPSS syntax for the above:

~~~

NPAR TESTS
  /FRIEDMAN=beginning middle end
  /MISSING LISTWISE
  /METHOD=EXACT TIMER(5).

~~~

</div>

Your output should look like [@fig:fOutput].


![SPSS Output---Friedman](.8npt/12-11-2016-245.png "SPSS Output---Friedman"){#fig:fOutput}

<div latex="true" class="journal" id="Journal">

7. Using the medians as your descriptive statistics, how might you report the findings? The key statistic for the Friedman is Chi-Square ($\chi^2$). 

</div>

<div latex="true" class="answer" id="Answer"> 

Descriptive statistics showed that participants differed in their hunger scores throughout the film (with medians of 1.5, 2 and 3 for beginning, middle and end respectively). A Friedman one-way analysis of variance indicated a main effect of time, $\chi^2$ (2) = 12.25, *p* < 0.05.

</div>

<div latex="true" class="journal" id="Journal">

8. Investigate the source of the differences between conditions using two Wilcoxon matched pair tests examining (i) the beginning and the end hunger scores, and (ii) beginning and middle hunger scores. Don't forget to correct for familywise error.

</div>

<div latex="true" class="answer" id="Answer"> 

- Our Bonferroni correction gives us a new alpha level of (5%/2) = 2.5%.

Wilcoxon tests indicate a difference between the beginning and the end, but not between the beginning and the middle:

- For beginning vs. end: *z* = -2.70, *p* < .025

- For beginning vs. middle: *z* = -2.00, *p* > .025

---

SPSS syntax for the above:

~~~

* Follow-up analyses (testing difference at 
* beginning versus end)
* Wilcoxon.
NPAR TESTS
  /WILCOXON=beginning WITH end (PAIRED)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).

* Follow-up analyses (testing difference at 
* beginning versus middle)
* Wilcoxon.
NPAR TESTS
  /WILCOXON=beginning WITH middle (PAIRED)
  /MISSING ANALYSIS
  /METHOD=EXACT TIMER(5).

~~~

</div>

# Versions {#versions}

& deployments &

&& licence

&& referencesHeader
