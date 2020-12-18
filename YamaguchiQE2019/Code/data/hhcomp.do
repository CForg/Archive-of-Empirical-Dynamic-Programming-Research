use ../dta/jpsc-raw.dta, clear
tsset id panel

/*** household composition ***/

/* rename variables to comprehensible ones */
forval i = 2/10 {
  local j1 = `i' * 5 + 1
  local j2 = `i' * 5 + 2
  local j3 = `i' * 5 + 3
  local j4 = `i' * 5 + 4
  local j5 = `i' * 5 + 5

  rename q`j1' rltn`i'
  rename q`j2' sex`i'
  rename q`j3' age`i'
  rename q`j4' schl`i'
  rename q`j5' cohb`i'

  /** note: coding rule changed in panel 10 and 11 **/
  replace schl`i' = q`j4'r if panel == 10
  replace schl`i' = q`j4's if panel >= 11
}

/* marital status (cohabitation = marriage) */
rename q1 married
replace married = 0 if married == 2

/* own age */
rename q8 age

/* fix known problems with age */
replace age = 27 if id == 2189 & panel == 5  
replace age = 28 if id == 2189 & panel == 6  
replace age = 29 if id == 2189 & panel == 7  
replace age = 30 if id == 2189 & panel == 8  
replace age = 31 if id == 2189 & panel == 9  
replace age = 32 if id == 2189 & panel == 10
replace age = 33 if id == 2189 & panel == 11 
replace age = 41 if id == 631 & panel == 16
replace age = 42 if id == 631 & panel == 17
replace age = 41 if id == 748 & panel == 16
replace age = 42 if id == 1023 & panel == 15
replace age = 46 if id == 1080 & panel == 13
replace age = 28 if id == 3280 & panel == 12
replace age = 29 if id == 3280 & panel == 13
replace age = 30 if id == 3280 & panel == 14
replace age = 31 if id == 3280 & panel == 15
replace age = 32 if id == 3280 & panel == 16
replace age = 33 if id == 3280 & panel == 16
replace age = 30 if id == 3662 & panel == 16
replace age = .  if id == 3679 | id == 4143

/* husband's age */
gen age_s = .
replace age_s = age2 if married == 1

/* children age 0 */
gen nchild1 = 0

forval i = 2/10{
  replace nchild1 = 1 + nchild1 if (rltn`i' >= (1+married) & rltn`i' <= (5+married)) & age`i' == 0
}

/* children age 1-2 */
gen nchild2 = 0

forval i = 2/10{
  replace nchild2 = 1 + nchild2 if (rltn`i' >= (1+married) & rltn`i' <= (5+married)) & /*
                                */ age`i' >= 1 & age`i' <= 2
}

/* children age 3-5 */
gen nchild3 = 0

forval i = 2/10{
  replace nchild3 = 1 + nchild3 if (rltn`i' >= (1+married) & rltn`i' <= (5+married)) & /*
                                */ age`i' >= 3 & age`i' <= 5
}

/* children age 6+ */
gen nchild4 = 0

forval i = 2/10{
  replace nchild4 = 1 + nchild4 if (rltn`i' >= (1+married) & rltn`i' <= (5+married)) & age`i' >= 6
}

/* number of children total */
gen nchild = nchild1 + nchild2 + nchild3 + nchild4

/* age of youngest child */
  /* vast majority of children age under 10 cohabitate with mom. so I do not check if they cohabitate */
gen yca = .

forval i = 2/10{
  replace yca = age`i' if yca > age`i' & (rltn`i' >= (1+married) & rltn`i' <= (5+married))
}

replace yca = -1 if yca == .

/*** # of parents and in-laws ***/
gen father = 0
gen mother = 0
gen fatheril = 0
gen motheril = 0
  
forval i = 2/10{
  replace father = 1 + father if rltn`i' == (6 + married) & sex`i' == 1
  replace mother = 1 + mother if rltn`i' == (6 + married) & sex`i' == 2
  replace fatheril = 1 + fatheril if married == 1 & rltn`i' == 8 & sex`i' == 1
  replace motheril = 1 + motheril if married == 1 & rltn`i' == 8 & sex`i' == 2
}

gen nparent = father + mother
gen ninlaw = fatheril + motheril

/*** save outcomes ***/
keep  id panel married age age_s nchild* father* mother* nparent ninlaw yca
sort  id panel
save /tmp/hhcomp.dta, replace
