********************************************************************************
******************************** POWER ANALYSIS ********************************
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

********************** INDEPENDENT-SAMPLE (BETWEEN-SUBJECT) POWER ANALYSIS **********************

help power // Power and sample-size analysis for hypothesis tests

*power of the test, given sample size
power twomeans 13.83 19.43, alpha(0.05) sd(15.95) n(60) oneside

*graph of power function, power against sample size
power twomeans 13.83 19.43, alpha(0.05) sd(15.95) n(40 60 80 100 120 140 160 180 200 220 240 260 280 300) oneside graph
power twomeans 13.83 19.43, alpha(0.05) sd(15.95) n1(30 50) n2(40 60) oneside graph

*sample size required, given power
power twomeans 13.83 19.43, alpha(0.05) sd(15.95) power(0.8) oneside

*graph of power function, sample size against power
power twomeans 13.83 19.43, alpha(0.05) sd(15.95) power(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95) oneside graph

********************** WITHIN-SUBJECT POWER ANALYSIS **********************

*power of the test, given sample size
power pairedmeans 13.83 19.43, alpha(0.05) sd(15.95) n(30) oneside corr(0) // y1 & y2 correlation matters!
power pairedmeans 13.83 19.43, alpha(0.05) sd(15.95) n(30) oneside corr(0.78)

*graph of power function, power against sample size
power pairedmeans 13.83 19.43, alpha(0.05) sd(15.95) n(20 30 40 50 60 70 80 90 100) oneside corr(0.78) graph

*sample size required, given power
power pairedmeans 13.83 19.43, alpha(0.05) sd(15.95) power(0.8) oneside corr(0) // y1 & y2 correlation matters!
power pairedmeans 13.83 19.43, alpha(0.05) sd(15.95) power(0.8) oneside corr(0.78)

*graph of power function, sample size against power
power pairedmeans 13.83 19.43, alpha(0.05) sd(15.95) power(0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 0.95) oneside corr(0.78) graph
