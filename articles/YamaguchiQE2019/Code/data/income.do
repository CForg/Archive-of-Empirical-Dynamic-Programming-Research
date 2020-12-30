use ../dta/jpsc-raw.dta, clear

/*** own income ***/
rename q297a labinc
rename q297b bizinc
rename q297c astinc
rename q297d socinc
rename q297e othinc
rename q297f ttlinc

replace labinc = . if labinc == 9999
replace bizinc = . if bizinc == 9999
replace astinc = . if astinc == 9999
replace socinc = . if socinc == 9999
replace othinc = . if othinc == 9999
replace ttlinc = . if ttlinc == 9999

/*** husband's income ***/
rename q296a labinc_s
rename q296b bizinc_s
rename q296c astinc_s
rename q296d socinc_s
rename q296e othinc_s
rename q296f ttlinc_s

replace labinc_s = . if labinc_s == 9999
replace bizinc_s = . if bizinc_s == 9999
replace astinc_s = . if astinc_s == 9999
replace socinc_s = . if socinc_s == 9999
replace othinc_s = . if othinc_s == 9999
replace ttlinc_s = . if ttlinc_s == 9999

/*** joint income ***/
rename q298a astinc_j
rename q298b socinc_j
rename q298c othinc_j
rename q298d ttlinc_j

replace astinc_j = . if astinc_j == 9999
replace socinc_j = . if socinc_j == 9999
replace othinc_j = . if othinc_j == 9999
replace ttlinc_j = . if ttlinc_j == 9999

/*** others' income ***/
rename q299a labinc_o
rename q299b bizinc_o
rename q299c astinc_o
rename q299d socinc_o
rename q299e othinc_o
rename q299f ttlinc_o

replace labinc_o = . if labinc_o == 9999
replace bizinc_o = . if bizinc_o == 9999
replace astinc_o = . if astinc_o == 9999
replace socinc_o = . if socinc_o == 9999
replace othinc_o = . if othinc_o == 9999
replace ttlinc_o = . if ttlinc_o == 9999

/*** save outcomes ***/
order id panel labinc* bizinc* astinc* socinc* othinc* ttlinc*
keep  id panel labinc* bizinc* astinc* socinc* othinc* ttlinc*
sort  id panel
save /tmp/income.dta, replace

/**********************/
/*** deflate by CPI ***/
/**********************/

/*** load CPI ***/
insheet year cpi using ../cpi/cpi2010_from1970to2013.csv, clear
gen panel = year - 1992

/*** merge with income data ***/
merge 1:m panel using /tmp/income.dta
drop if _merge != 3

/*** deflate all types of income ***/
/*** in addition to CPI, all income is in million yen ***/  
foreach x in lab biz ast soc oth ttl {
  replace `x'inc = `x'inc / cpi * 100
}

foreach x in lab biz {
  foreach y in _s _o {
    replace `x'inc`y' = `x'inc`y' / cpi
  }
}

foreach x in ast soc oth ttl {
  foreach y in _s _o _j {
    replace `x'inc`y' = `x'inc`y' / cpi
  }
}

/*** save outcomes ***/
drop year cpi _merge
sort  id panel
save /tmp/income.dta, replace


