********************************************************************************
******************************** META-REGRESSION ********************************
********************************************************************************

********************** SET WORKING DIRECTORY **********************

pwd
cd "C:\Users\cxl87\Desktop\Teaching\Experimental and Behavioral Economics\Econometrics for Experiment"

********************** IMPORT AND SUMMARIZE BCG VACCINE DATA **********************

use bcg_vaccine.dta, clear

describe
summarize

********************** META-REGRESSION **********************

*ssc install metareg
help metareg // Meta-analysis regression

*y_i = a + B*x_i + u_i + e_i
*where a is a constant, u_i is a normal error term with known standard deviations
*wsse_i that may vary across units, and e_i is a normal error with variance tau2 to
*be estimated, assumed equal across units.

metareg logrr year latitude alloc, wsse(selogrr) // wsse -> within-study s.e. of the statistic

metareg logrr latitude, wsse(selogrr) graph
