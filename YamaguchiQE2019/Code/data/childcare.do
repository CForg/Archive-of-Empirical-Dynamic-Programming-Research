use ../dta/jpsc-raw.dta, clear

insheet using ../childcare_capacity/capacity-population.csv, clear

/* pref ID */
gen ken = _n
keep if ken >= 1 & ken <= 47

/* linear interpolation of pop */
forval i = 1996/1999{
  gen pop`i' = (pop2000 - pop1995) * (`i'-1995)/5 + pop1995
}

forval i = 2001/2004{
  gen pop`i' = (pop2005 - pop2000) * (`i'-2000)/5 + pop2000
}

forval i = 2006/2009{
  gen pop`i' = (pop2010 - pop2005) * (`i'-2005)/5 + pop2005
}

/* assume 93-94 are same as 96 */
gen pop1993 = pop1995  
gen pop1994 = pop1995  
gen cap1993 = cap1996
gen cap1994 = cap1996
gen cap1995 = cap1996

/* reshape */
reshape long cap pop, i(ken) j(year)

/* cca (child care availability) */
gen cca = cap / pop

/* panel, instead of year */
gen panel = year - 1992  

/* merge with the main data (JPSC) */
merge 1:m ken panel using ../dta/jpsc-raw.dta
drop if _merge == 1
drop _merge

/* save outcomes */
order id panel cca  
keep  id panel cca
sort  id panel
save /tmp/childcare.dta, replace
