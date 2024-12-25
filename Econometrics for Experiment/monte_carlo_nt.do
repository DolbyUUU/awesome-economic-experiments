********************************************************************************
******************************** POWER ANALYSIS ********************************
********************************************************************************

********************** SET WORKING DIRECTORY **********************

pwd
cd "C:\Users\cxl87\Desktop\Teaching\Experimental and Behavioral Economics\Econometrics for Experiment"

********************** MONTE CARLO SIMULATIONS OF N-T TRADEOFF **********************

*u_i, v_j, e_ijt follows normal 

*four choices of n
*1) 40
*2) 80
*3) 120

*four choices of T
*1) 50
*2) 100
*3) 150

********************** MONTE CARLO SIMULATIONS OF BETWEEN-SUBJECT TESTS **********************

*n=40 X T=50 (J=10 groups, 4 in one group)
*treatment to random half of subjects
*true treatment effect size = 0.5

clear all
program size_normal_ttest
	clear
	use task_subject_group_id.dta
	
	gen obs_id = _n
	gen v = rnormal(0,3)
	bysort group_id: replace v = v[1]
	gen u = rnormal(0,3)
	bysort subject_id: replace u = u[1]
	gen e = rnormal(0,3)
	bysort obs_id: replace e = e[1]
	
	gen d = 0
	replace d = 1 if subject_id > 20 // treatment on half of the subjects
	gen y = 0.5 * d + u + v + e
	
	ttest y, unpaired by(d)
	gen type2 = 0
	replace type2 = 1 if r(p) >= 0.01
	gen power = 1- type2
end
*set seed 2021
simulate power, reps(1000): size_normal_ttest
summarize

********************** MONTE CARLO SIMULATIONS OF WITHIN-SUBJECT TESTS **********************

*n=40 X T=50 (J=10 groups, 4 in one group)
*treatment to random half of tasks
*true treatment effect size = 0.05

clear all
program size_normal_ttest
	clear
	use task_subject_group_id.dta
	
	gen obs_id = _n
	gen v = rnormal(0,0.3)
	bysort group_id: replace v = v[1]
	gen u = rnormal(0,0.3)
	bysort subject_id: replace u = u[1]
	gen e = rnormal(0,0.3)
	bysort obs_id: replace e = e[1]
	
	gen d = 0
	replace d = 1 if task_id > 25 // treatment on half of the tasks
	gen y = 0.05 * d + u + v + e
	
	ttest y, by(d)
	gen type2 = 0
	replace type2 = 1 if r(p) >= 0.01
	gen power = 1- type2
end
*set seed 2021
simulate power, reps(1000): size_normal_ttest
summarize
