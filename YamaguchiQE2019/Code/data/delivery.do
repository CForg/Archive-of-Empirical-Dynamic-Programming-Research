/*** info around fertility ***/
use ../dta/jpsc-raw.dta, clear
tsset id panel

/* delivery in the past year */
gen deliv = q67a
replace deliv = 0 if deliv == 2
replace deliv = . if deliv == 3

/* rltn to the new child */
gen deliv_order = q68
replace deliv_order = . if deliv_order == 4

/* work around deliv */
gen deliv_work = q78
replace deliv_work = . if q78 == 4

label define deliv_work_lab 1 "no-work" 2 "quit" 3 "work"
label values deliv_work deliv_work_lab

/* maternity leave */
gen ml_use = q79a
replace ml_use = . if q79a == 4
label define ml_use_lab 1 "yes" 2 "no" 3 "unavailable"
label values ml_use ml_use_lab

gen ml = q79a
replace ml = 0 if ml == 2 | ml == 3
replace ml = . if q79a == 4

gen ml_pre = q79b
replace ml_pre = 0 if ml == 0
replace ml_pre = . if q79b == 99

gen ml_post = q79b
replace ml_post = 0 if ml == 0
replace ml_post = . if q79b == 99

/* parental leave */
gen pl_use = q80a
replace pl_use = . if q80a == 4
label define pl_use_lab 1 "yes" 2 "no" 3 "unavailable"
label values pl_use pl_use_lab
  
gen pl = q80a
replace pl =0 if pl == 2 | pl == 3
replace pl = . if q80a == 4

gen pl_months = q80c
replace pl_months = 0 if pl == 0

/*** save outcomes ***/
keep id panel deliv* ml* pl*
sort id panel
save /tmp/delivery.dta, replace
