---
title: "MPSMD2RES Workshop 9: Correlation and Regression"
title-meta: "MPSMD2RES Workshop 9: Correlation and Regression"
author: "Dr Ian Hocking, Psychology Programme"
date: "September 2016 to April 2017"
version: 1.3
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
*Data files required*    [Conscientiousness data](https://www.dropbox.com/s/zzazjpp2hiahyew/9corConscientiousness.sav?dl=0)

*Booklet Version*        & version &

*Format*                 & documentFormat &

-----------------------  -------------------------------------

# Objectives

This workshop will cover:

- transforming variables (reverse scoring variables that were reverse-phrased in their original forms);

- reliability (to ensure that multiple variables do indeed test the same construct);

- correlation;

- and regression.

&& 2resWorkshopBookletHeader

# Workshop

<div latex="true" class="answer" id="Answer"> 

All SPSS data files and syntax:

[Conscientiousness data](https://www.dropbox.com/s/zzazjpp2hiahyew/9corConscientiousnessUnprocessed.sav?dl=0)

[Conscientiousness syntax](https://www.dropbox.com/s/tac4vu6pd6eagzt/9corConscientiousness.sps?dl=0)

</div>

In psychology, we often use a set of items (or statements) to measure some attitude or personality type. Participants are asked to respond to each item on a fixed scale, like a Likert scale, in a way that best reflects the way that they are. If you have used a scale to measure some attitude or personality type then it is essential that you know what those scores mean and that you find out how reliable they are.

We'll illustrate this by looking at conscientiousness [@costa1985neo].

<div latex="true" class="task" id="Task">

(@) Download the [Conscientiousness data](https://www.dropbox.com/s/zzazjpp2hiahyew/9corConscientiousnessUnprocessed.sav?dl=0) and inspect it.

</div>


Each item has its own column and each respondent’s answers are on one row. What we need is one score that represents how conscientious each respondent is. To do this we will need to re-score any reverse scored items, calculate reliability, and then add up all the individual item scores.

# Rescoring Reverse-Phrased Items

Some items are reverse phrased. That is, a high score on these items would indicate less conscientiousness, while a high score on the other items would suggest more conscientiousness. The first thing that we must do then is to reverse the scoring for these reverse-phrased items. The reversed phrased items were items 1, 4, 5, 8, 9, 12, 13, 14 and 15.

<div latex="true" class="task" id="Task"> 

(@) Go to *Transform* > *Recode – Into different variables*, which should look like [@fig:recodeStart] (note that I've asked SPSS to display variable names instead of labels). 

- Select 'cons' items 1, 4, 5, 8, 9, 12, 13, 14, 15 from the left hand box and arrow them into the right hand box. 

</div>

![SPSS Recode into Different Variables, Incomplete](.9cor/18-11-2016-353.png "SPSS Recode into Different Variables, Incomplete"){#fig:recodeStart}

The recoding dialogue box will allow us to create a new variable for each of these items where the score for each individual is reversed. Now you need to tell SPSS what you will call these new variables.

<div latex="true" class="task" id="Task"> 

(@) With ‘cons1’ highlighted in the middle box type ‘recons1’ into the right hand box called *Output Variable*. In the *Label* box, type:

> reversed cons1 

- Now click on *Change* and this new name should replace the question mark in the middle box next to ‘cons1’. 

- Do the same for the rest of the variables that need recoding so that it looks like [@fig:recodeOverall].

</div>

![SPSS Recode into Different Variables, Complete](.9cor/18-11-2016-790.png "SPSS Recode into Different Variables, Complete"){#fig:recodeOverall}

<div latex="true" class="task" id="Task"> 

(@) Next, click on *Old and New Values*. This will open a new dialogue box for you to tell SPSS what the old scores will be converted to. Tell SPSS that a score of 5 will become a score of 1, 4 will become 2, 3 will stay the same, 2 will become 4, and 1 will become 5. 

- Remember, *all five* values must be reversed. This is shown in [@fig:recodeValues]. Remember to click on *Add* after you tell SPSS what each old value must be converted to. Now SPSS knows to reverse score each of these items for each participant.

</div>

<div latex="true" class="task" id="Task"> 

(@) Click on *Continue* and *OK*.

</div>


<div latex="true" class="answer" id="Answer">

SPSS syntax for the above:

~~~

RECODE cons1 cons4 cons5 cons8 cons9 cons12 cons13 
cons14 cons15 (1=5) (2=4) (3=3) (4=2) (5=1) INTO 
    recons1 recons4 recons5 recons8 recons9 
    recons12 recons13 recons14 recons15.
VARIABLE LABELS  recons1 'reversed cons1' /recons4 
'reversed cons4' /recons5 'reversed cons5' 
    /recons8 'reversed cons8' /recons9 'reversed cons9' 
    /recons12 'reversed cons12' /recons13 
    'reversed cons13' /recons14 'reversed cons14' 
    /recons15 'reversed cons15'.
EXECUTE.

~~~

</div>

Look at the *data view* and verify that you have nine new columns at the end of the spreadsheet. All the values on these variables should be the reverse of the original score.

When we create a total score we will use these transformed variables (reversed negative items) and the original positive items so that high scores will mean higher conscientiousness. 

![SPSS Recode into Different Variables: Old and New Values](.9cor/18-11-2016-98295.png "SPSS Recode into Different Variables: Old and New Values"){#fig:recodeValues}

# Calculating Reliability

To look at how consistently all of the items measure conscientiousness, we need to calculate Cronbach’s Alpha (written $\alpha$), which is a measure of the degree of relationship between variables. Our rationale is this: If variables measure the same theoretical construct, we expect positive correlations among them, and this is basis for Cronbach's Alpha. The more that items in a scale measure a construct, the greater reliability the scale has.

----------------            --------------------
Cronbach's Alpha            Internal Consistency
----------------            --------------------
$\alpha$ $\geq$ 0.9         Excellent

0.9 > $\alpha$ $\geq$ 0.8   Good

0.8 > $\alpha$ $\geq$ 0.7   Acceptable

0.7 > $\alpha$ $\geq$ 0.6   Questionable

0.6 > $\alpha$ $\geq$ 0.5   Poor

0.5 > $\alpha$	            Unacceptable
------------------------------------------------

Table: Cronbach's Alpha with associated Internal Consistency {#tbl:cronbach}

Let's start.

<div latex="true" class="task" id="Task"> 

(@) Go to *Analyze* > *Scale* > *Reliability analysis*. Put all the items that make up the conscientiousness scale (i.e. the recoded items recons1, recons4, recons5, recons8, recons9, recons12, recons13, recons14, recons15, plus the original items for the ones that were not reversed) into the right hand box, as you see in [@fig:reliabilityFirst]. Make sure that where it says *Model*, *Alpha* is selected (this should be the default). 

- Click on *Statistics* and make sure the options are selected as you see in [@fig:reliability].

</div>

![SPSS Reliability Analysis](.9cor/18-11-2016-316.png "SPSS Reliability Analysis"){#fig:reliabilityFirst}

![SPSS Reliability Analysis Statistics](.9cor/18-11-2016-58518.png "SPSS Reliability Analysis Statistics"){#fig:reliability}

<div latex="true" class="task" id="Task"> 

(@) Click *continue* and *OK*.

</div>

<div latex="true" class="answer" id="Answer">

SPSS syntax for the above:

~~~

* Reliability.
RELIABILITY
  /VARIABLES=recons1 cons2 cons3 recons4 
  recons5 cons6 cons7 recons8 recons9 cons10 cons11 
    recons12 recons13 recons14 recons15 cons16
  /SCALE('ALL VARIABLES') ALL
  /MODEL=ALPHA
  /SUMMARY=TOTAL.

~~~



</div>


<div latex="true" class="journal" id="Journal">

(@) What is the Cronbach’s Alpha estimate for this scale? Is the scale reliable according to [@tbl:cronbach]?

</div>

<div latex="true" class="answer" id="Answer">

Cronbach’s Alpha is .846 (to be reported in APA style as .85). Yes, it is reliable because it’s above .70.

</div>

<div latex="true" class="journal" id="Journal">

(@) Are there any items whose elimination from the scale would make it more reliable?

</div>

<div latex="true" class="answer" id="Answer">

Eliminating item 1 (reversed) would bring it up slightly to .851 but the minimal increase in alpha doesn’t make it worthwhile. ('Reversed cons13' would improve it fractionally also to .847.)

</div>

# Creating a Total Score.

Now let’s create a total score on the scale for each individual. 

<div latex="true" class="task" id="Task">

(@) Go to *Transform* > *Compute*. In *target variable* type the name of the new variable that you are going to create. 

- As we are creating a variable that represents people’s total score, call it ‘total’. 

- In the *Numeric Expression* box we need to tell SPSS how to calculate the total. So arrow across ‘recons1’ (as opposed to the original ‘cons1’, as it was reversed scored) first of all, then click ‘+’; then arrow over ‘cons2’, then click ‘+’. Keep doing this until all the items forming the final scale are in, but remember to use the reversed items, not the original, for all the items we recoded earlier. See [@fig:compute].

</div>

![SPSS Compute Variable](.9cor/18-11-2016-51156.png "SPSS Compute Variable"){#fig:compute}

<div latex="true" class="answer" id="Answer">

SPSS syntax for the above:

~~~

COMPUTE total=recons1 + cons2 + +cons3 + recons4 + 
recons5 + cons6 + cons7 + recons8 + recons9 + 
    cons10 + cons11 + recons12 + recons13 + recons14 
    + recons15 + cons16.
EXECUTE.



~~~

</div>

Check that the 'total' mean is 53.87.

<div latex="true" class="journal" id="Journal">

(@) Who is the most conscientious participant?

</div>

<div latex="true" class="answer" id="Answer">

204 (total = 77)

</div>


# Calculating Pearson’s Correlation.

Now let’s see if conscientiousness is related to a person’s age. 

<div latex="true" class="task" id="Task">

(@) Go into *Analyze* > *Correlate* and select *Bivariate* from the menu. 

- Move the two variables you want to correlate across to the right-hand window. In this case we select ‘Age’ and our total conscientiousness score ‘Total’. As you see in [@fig:bivariate], make sure that *Pearson* is ticked (this should be the default) and, because we aren't sure about the direction of our prediction, stick to a two-tailed test. Click *OK*.

</div>

![SPSS Bivariate Correlations](.9cor/18-11-2016-513.png "SPSS Bivariate Correlations"){#fig:bivariate}

<div latex="true" class="journal" id="Journal">

(@) Was age related to conscientiousness? Report Pearson’s correlation between the two variables. 

(@) What proportion of the variance in conscientiousness was accounted for by its relationship with age? (Look back at last week's booklet if you need a reminder of how to calculate shared variance.)

</div>

<div latex="true" class="answer" id="Answer">

- Age was not related to conscientiousness, *r*(239) = -.04, *p* > .05. 

- The proportion of variance in conscientiousness accounted for by its relationship with age was .0016, or 0.16%. You obtain this value by taking the square of *r* (-.04).

</div>

# Regression

Let's say that we're interested in predicting the relationship between two variables, so that if we collect further data from more participants, we can predict the value of one variable given the value of another for each new participant. In the following example, we'll look at *one* of the conscientiousness measures, 'cons13', which captures a rating of the statement 'I'm not conscientious about cleaning'. Because this is a reverse-phrased item, we'll need to use its reverse-scored version ('recons13') so that positive values of the variable represents a positive value of the construct---which we can call 'cleaning conscientiousness'.

Imagine that the researcher believes 'cleaning conscientiousness' to be related to age. They wish to test this relationship with a regression so that they can use the age of participants, in another sample, to predict their 'cleaning conscientiousness'. 

<div latex="true" class="task" id="Task">

(@) Go to *Analyze* > *Regression* > *Linear...* and, in the dialogue box that appears (@fig:regressionDialogue), enter the variables 'age' and 'recons13'.

- Remember that thing you are trying to predict should be the *dependent* variable and the thing you are trying to predict *from* should be an *independent* variable. (This is not quite how the terms dependent and independent are used in experimental designs.)

</div>

![SPSS Linear Regression](.9cor/18-11-2016-809.png "SPSS Linear Regression"){#fig:regressionDialogue}

<div latex="true" class="task" id="Task">

(@) Click *Statistics* and ensure that *Estimates*, *Confidence Intervals*, *Model Fit* and *Descriptives* are selected (@fig:regressionStats).

</div>

![SPSS Linear Regression, Statistics](.9cor/18-11-2016-347.png "SPSS Linear Regression, Statistics"){#fig:regressionStats}

<div latex="true" class="task" id="Task">

(@) It's usually a good idea to visually inspect any relationship we find. To do this, click *Plots* and have it resemble [@fig:regressionPlots].

- Note that what we predict goes, by convention, on the Y-axis. Our predictor will go on the X-axis (here, this is the *Z* or standardised score of the predictor).

</div>

![SPSS Linear Regression, Plots](.9cor/18-11-2016-191.png "SPSS Linear Regression, Plots"){#fig:regressionPlots}

<div latex="true" class="task" id="Task">

(@) Return to the main regression dialogue box and click *OK* to run the regression.

</div>

<div latex="true" class="answer" id="Answer">

SPSS syntax for the above:

~~~

REGRESSION
  /DESCRIPTIVES MEAN STDDEV CORR SIG N
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS CI(95) R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT recons13
  /METHOD=ENTER age
  /SCATTERPLOT=(recons13 ,*ZPRED).  

~~~

</div>

Let's see what SPSS has produced. The Model Summary (@tbl:modelSummary) provides us with the *Model* (we can run lots of these; here there is only one), *R*, $R^2$, $R^2_{adj}$, as well the standard error of the estimate.

<div latex="true" class="highlight" id="Remember">

The *standard error of the estimate* tells us how well the model fits the data in terms of the mean value of how far observations fall from the regression line, expressed as units of the dependent measure. In [@tbl:modelSummary], this is 1.37, which means that, on average, cleaning conscientiousness scores are 1.37 conscientiousness-scale units away from the best-fitting regression line.

</div>

![SPSS Output---Model Summary](.9cor/18-11-2016-996.png "SPSS Output---Model Summary"){#tbl:modelSummary}

<div latex="true" class="journal" id="Journal">

(@) Looking at the Model Summary [@tbl:modelSummary], and using what you know from the lecture, what is the strength and direction of the regression? 

- What is the shared variance between 'age' and 'cleaning conscientiousness'?

</div>

<div latex="true" class="answer" id="Answer">

- Because this is simple regression (the case being more complex in multiple regression), $R$ represents the Pearson product moment correlation---i.e. the standard parametric correlation coefficient---and is .15. This is a weak correlation.

- As ever, when we square the correlation coefficient, we see the shared variance between the two variables. $R^2_{adj}$ = .02, $R^2$ = .02. This means that 'age' is predicting only 2% of 'cleaning conscientiousness'---not a lot.

</div>

Now let's turn to the ANOVA ([@tbl:anovaTable]). Remember that the *F* ratio represents the mean squares of the model (which is the improvement of the regression line over a simpler model of the mean of Y) *divided by* the residual mean squares (which is how poorly the model fits the data). If our model---i.e. our regression line---is no great improvement over a simpler model of the mean of Y, and/or our model is a poor fit for the observations, *F* will be low. So what we're testing with this ANOVA is a sense of the regression line's explanatory power. The null hypothesis is that the regression line has no explanatory power, and the line has to have good explanatory power before we accept the model as reliable.

![SPSS Output---ANOVA Table](.9cor/18-11-2016-172.png "SPSS Output---ANOVA Table"){#tbl:anovaTable}

<div latex="true" class="journal" id="Journal">

(@) Looking at the ANOVA, is the model significant overall? Report the F ratio in APA style.

(@) In plain English, what is this table telling you?

</div>

<div latex="true" class="answer" id="Answer">

- *F* (1, 237) = 5.20, *MSE*=1.89 *p* < .05.  

- It tells us the that the model (our sloped line) fits the relationship well, and it would be more sensible to trust its predictive ability. 

</div>

![SPSS Output---Scatterplot](.9cor/18-11-2016-89.png "SPSS Output---Scatterplot"){#fig:scatterplot}

<div latex="true" class="journal" id="Journal">

(@) Does the scatterplot make you cautious about interpreting the regression line?

</div>

<div latex="true" class="answer" id="Answer">

- With the bottom left and top right cases removed, we might see the regression lose its fit. This means the regression model is somewhat fragile.

</div>

[@tbl:coefficients] shows the Table of Coefficients. From this table, we can construct our raw and standardised regression equations. 

![SPSS Output---Coefficients](.9cor/18-11-2016-111.png "SPSS Output---Coefficients"){#tbl:coefficients}

<div latex="true" class="journal" id="Journal">

(@) What is the unstandardised coefficient, its confidence intervals, and its *p* value?

(@) What comments do you have on this coefficient?

</div>

<div latex="true" class="answer" id="Answer">

- B is -.02, 95% CI [-.04, .0], and this is significant: *t* = 9.95, *p* < 0.05.

- The coefficient is very small, as we saw earlier from an inspection of the regression relationship expressed as *R* and $R^2$. The Confidence Intervals show that, if we were to sample again, the coefficient would vary by up to ten times, and is quite close to zero---not a particularly consistent effect. So while the *t* statistic is significant, 'age' is not a particularly convincing predictor in this model. 

</div>

<div latex="true" class="journal" id="Journal">

(@) Report the unstandardised and standardised regression models.

</div>

<div latex="true" class="answer" id="Answer">

- Unstandardised: 

$(CleaningConscientiousness_pred)= 3.390-.021(Age)$ 

---

- Standardised:

$(zCleaningConscientiousness_pred)= -.147(zAge)$

</div>

<div latex="true" class="journal" id="Journal">

(@) Report the full regression results as you would in an APA Results section.

</div>

<div latex="true" class="answer" id="Answer">

- A simple linear regression was calculated to predict a participant's 'cleaning conscientiousness' based on their age. A significant regression equation was found, *F*(1,237) = 5.20, *MSE* = 1.89, *p* < .05., with an $R^2$ of .02. Participants' predicted 'cleaning conscientiousness' is equal to 3.390-.021(Age) when age is measured in years (95% CI for B [-.04, .0]). Participants' mean 'cleaning conscientiousness' decreased by .021 for each year of age.

</div>

<div latex="true" class="journal" id="Journal">

(@) Use the *unstandardised* regression model to predict cleaning conscientiousness for two new participants, one of whom is aged 24 and the other 78.

</div>

<div latex="true" class="answer" id="Answer">

1. Age = 24

- CC = 3.39 - (.021*24)

- = 2.87

---

2. Age = 78

- CC = 3.39 - (.021*78)

- = 1.75

---

- Thus our model, should we believe it, is telling us a precise value for cleaning conscientiousness given age.

</div>

# Versions {#versions}

& deployments &

&& licence

&& referencesHeader
