********************************************************************************
****************************** TREATMENT TESTING *******************************
********************************************************************************

********************** SET WORKING DIRECTORY **********************

pwd
cd "C:\Users\cxl87\Desktop\Teaching\Experimental and Behavioral Economics\Econometrics for Experiment"

********************** IMPORT AND SUMMARIZE DICTATOR GAME DATA **********************

use dictator_game.dta, clear

describe
summarize

histogram y1, bin(10) normal
histogram y2, bin(10) normal
histogram y, bin(10) normal

twoway (lfit y2 y1) (scatter y2 y1)
corr y1 y2

********************** NORMALITY TESTS **********************

help sktest // Skewness and kurtosis test for normality
sktest y1 y2 y

help swilk // Shapiro-Wilk normality test
swilk y1 y2 y

********************** INDEPENDENT-SAMPLE (BETWEEN-SUBJECT) TESTS **********************

*parametric treatment test
help ttest // t tests (mean-comparison tests)
ttest y1 == y2, unpaired // with equal variances
ttest y1 == y2, unpaired unequal // with unequal variances
ttest y, by(treat) unpaired

*bootstrap (Efron and Tibshirani, 1994):
*"Their idea is to recenter the two samples to the combined sample mean so that the data now 
*conform to the null hypothesis but that the variances within the samples remain unchanged."
help bootstrap // Bootstrap sampling and estimation
ttest y, by(treat) unpaired level(95)
return list
scalar tobs = r(t)

summarize y
scalar omean = r(mean)
summarize y if treat == 0
replace y = y - r(mean) + scalar(omean) if treat == 0
summarize y if treat == 1
replace y = y - r(mean) + scalar(omean) if treat == 1
sort treat
by treat : summarize y

bootstrap t = r(t), rep(999) strata(treat) seed(2021) saving(bs_dictator, replace) : ttest y, by(treat) unpaired level(95)
use bs_dictator, clear
generate indicator = ( abs(t) >= abs(scalar(tobs)) )
summarize indicator

*non-parametric treatment test
use dictator_game.dta, clear
help ranksum // Mann–Whitney test (Wilcoxon rank-sum test)
ranksum y, by(treat)

help sdtest // Variance-comparison tests
sdtest y1 == y2

*tests comparing entire distribution
help ksmirnov // Kolmogorov –Smirnov equality-of-distributions test
ksmirnov y, by(treat)

help escftest // Epps-Singleton two-sample empirical characteristic function test (user-written!)
escftest y, group(treat)

*binary outcomes
help tabulate // Two-way table of frequencies
tabulate y_bin treat, chi2 // Pearson's Chi-squared test
tabulate y_bin treat, exact // Fisher's exact test

*regression models
regress y treat, robust

********************** WITHIN-SUBJECT TESTS **********************

*parametric treatment test
help ttest // t tests (mean-comparison tests)
ttest y1 == y2 // paired t test

*non-parametric treatment tests
help signrank // Wilcoxon matched-pairs signed-ranks test
signrank y1 = y2

help signtest // Sign test of matched pairs
signtest y1 = y2

*binary outcomes
help mcci // McNemar's change test
mcci 20 1 1 8

*regression models
regress y treat, vce(cluster subject_id) // s.e. clustered at the subject level
