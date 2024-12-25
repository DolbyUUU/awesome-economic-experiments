********************************************************************************
******************************** POWER ANALYSIS ********************************
********************************************************************************

********************** SET WORKING DIRECTORY **********************

pwd
cd "C:\Users\cxl87\Desktop\Teaching\Experimental and Behavioral Economics\Econometrics for Experiment"

********************** MONTE CARLO SIMULATIONS OF TESTS **********************

*e follows three different distributions (standardized to have zero mean and unit variance)
*1) e~normal(0,1)
*2) e~uniform(-sqrt(3),sqrt(3))
*3) e~chi2(0.5)-0.5

*four treatment tests
*1) t-test
*2) Mann–Whitney (MW)
*3) Kolmogorov–Smirnov (KS)
*4) Epps–Singleton (ES)

********************** MONTE CARLO SIMULATIONS OF SIZE **********************

*normal X t-test
clear all
program size_normal_ttest
	clear
	set obs 100
	gen id = _n
	gen e = rnormal(0,1)
	gen d = 0
	replace d = 1 if id > 50
	gen y = 10 + 0 * d + e
	ttest y, unpaired by(d)
	gen type1 = 0
	replace type1 = 1 if r(p) < 0.05
	rename type1 size
end
*set seed 2021
simulate size, reps(10000): size_normal_ttest
summarize

*uniform X KS
clear all
program size_uniform_ks
	clear
	set obs 100
	gen id = _n
	gen e = runiform(-sqrt(3),sqrt(3))
	gen d = 0
	replace d = 1 if id > 50
	gen y = 10 + 0 * d + e
	ksmirnov y, by(d)
	gen type1 = 0
	replace type1 = 1 if r(p) < 0.05
	rename type1 size
end
*set seed 2021
simulate size, reps(10000): size_uniform_ks
summarize

*chi-sq X ES
clear all
program size_chi2_ks
	clear
	set obs 100
	gen id = _n
	gen e = rchi2(0.5)-0.5
	gen d = 0
	replace d = 1 if id > 50
	gen y = 10 + 0 * d + e
	escftest y, group(d)
	gen type1 = 0
	replace type1 = 1 if r(p_val) < 0.05
	rename type1 size
end
*set seed 2021
simulate size, reps(10000): size_chi2_ks
summarize

********************** MONTE CARLO SIMULATIONS OF POWER **********************

*normal X t-test
clear all
program power_normal_ttest
	clear
	set obs 100
	gen id = _n
	gen e = rnormal(0,1)
	gen d = 0
	replace d = 1 if id > 50
	gen y = 10 + 0.5 * d + e
	ttest y, unpaired by(d)
	gen type2 = 0
	replace type2 = 1 if r(p) >= 0.05
	gen power = 1 - type2
end
*set seed 2021
simulate power, reps(10000): power_normal_ttest
summarize

*uniform X KS
clear all
program power_uniform_ks
	clear
	set obs 100
	gen id = _n
	gen e = runiform(-sqrt(3),sqrt(3))
	gen d = 0
	replace d = 1 if id > 50
	gen y = 10 + 0.5 * d + e
	ksmirnov y, by(d)
	gen type2 = 0
	replace type2 = 1 if r(p) >= 0.05
	gen power = 1 - type2
end
*set seed 2021
simulate power, reps(10000): power_uniform_ks
summarize

*chi-sq X ES
clear all
program power_chi2_ks
	clear
	set obs 100
	gen id = _n
	gen e = rchi2(0.5)-0.5
	gen d = 0
	replace d = 1 if id > 50
	gen y = 10 + 0.5 * d + e
	escftest y, group(d)
	gen type2 = 0
	replace type2 = 1 if r(p_val) >= 0.05
	gen power = 1 - type2
end
*set seed 2021
simulate power, reps(10000): power_chi2_ks
summarize
