set more off

/*** convert into .dta files (w/o additional files) ***/
foreach x in p1  p11ab p12 p14 p16abc p17 p3 p5a p6 p8 /*
*/           p10 p11c  p13 p15 p16d   p2  p4 p5b p7 p9 p18 /*
*/           p19 p20{
  forval i = 1/5 {
    /* basic data */
    insheet using "~/Dropbox/JPSC/2015/userdata/csv/`x'/`x'_`i'.csv", clear
    save "/tmp/`x'_`i'.dta", replace
    /* pref data */
      insheet using "~/Dropbox/JPSC/2015/csv/`x'pref.csv", clear
    save "/tmp/`x'pref.dta", replace
  }
}

/*** merge subfiles for each survey year ***/
foreach x in p1   p11ab  p12  p14  p16abc  p17  p3  p5a  p6  p8 /*
*/           p10  p11c   p13  p15  p16d    p2   p4  p5b  p7  p9 p18 /*
*/           p19  p20 {

  /* merge basic data */
  use /tmp/`x'_1.dta, clear

  forval i = 2/5 {
    merge m:m id using /tmp/`x'_`i'.dta
    drop _merge
  }

  /* merge with pref data */
  merge 1:1 id using /tmp/`x'pref.dta
  drop _merge

  save "/tmp/`x'.dta", replace
}

/*** consolidate all survey years ***/
use /tmp/p1.dta, clear

foreach x in      p11ab  p12  p14  p16abc  p17  p3  p5a  p6  p8 /*
*/           p10  p11c   p13  p15  p16d    p2   p4  p5b  p7  p9 p18 /*
*/           p19  p20{

  append using /tmp/`x'.dta
}

save ../dta/jpsc-raw.dta, replace
