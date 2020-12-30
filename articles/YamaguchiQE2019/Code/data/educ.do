use ../dta/jpsc-raw.dta, clear

/*** educational background ***/
rename q60sr educat
rename q61sr educat_s

replace educat   = . if educat == 8
replace educat_s = . if educat_s == 8

label define educat_lab 1 "jrh" 2 "oth1" 3 "hsg" 4 "oth2" 5 "scl" 6 "clg" 7 "adv"
label values educat   educat_lab
label values educat_s educat_lab

/*** years of education ***/
gen edu = .
replace edu =  9 if educat == 1
replace edu = 12 if educat == 2
replace edu = 12 if educat == 3
replace edu = 14 if educat == 4
replace edu = 14 if educat == 5
replace edu = 16 if educat == 6
replace edu = 18 if educat == 7

gen edu_s = .
replace edu_s =  9 if educat_s == 1
replace edu_s = 12 if educat_s == 2
replace edu_s = 12 if educat_s == 3
replace edu_s = 14 if educat_s == 4
replace edu_s = 14 if educat_s == 5
replace edu_s = 16 if educat_s == 6
replace edu_s = 18 if educat_s == 7

/*** save outcomes ***/
keep  id panel edu*
order id panel edu*
sort  id panel
save /tmp/educ.dta, replace
