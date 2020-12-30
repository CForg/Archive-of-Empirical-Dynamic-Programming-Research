use /tmp/jpsc.dta, clear

/*
 education: use edu, not years of actual schooling. one reason is that this method cannot be
            applied to HS dropouts. another justification is taht credit is more relevant than
            just time of schooling.

 sampling: after schooling is completed.

 home: period of no work or school after 18. unfortunately, leave is not in retrospective file.

*/

/* time */
    gen year = panel + 1992

/* indicator for child bearing */
    gen db = deliv == 1 | yca == 0
    gen fdb = f.db

/* indicator for fertility (conception) decision */
    gen df = fdb

/*************/
/* decisions */
/*************/

/* 
   The empirical definition of PL includes post-delivery ML (PL or ML after deliver).

   PL taking can be identified by "pl" and "leave". I am pretty sure those who responded pl=1 took PL,
   but those who reported PL by leave=1 do not seem correct. I investigate this problem by age of the
   youngest child.

     tab yca if leave == 1 & db == 0

   Case 1 (yca = -1, meaing no child): all of them deliver a baby in the next period.
   Aassume they take pre-deliv ML, instead of PL.

     list id year yca nchild fdb if leave == 1 & db == 0 & nchild == 0

   Case 2 (yca = 4): Assume they took pre-deliv ML, because (1) they deliver a second baby in the next year
   and (2) did not take a PL for the first child (except for ID2495, because this is her first obs).

     list id year yca nchild fdb if leave == 1 & db == 0 & yca == 4
     list id year yca nchild b leave lfs if id == 163 | id == 1317 | id == 2495

   Case 3 (yca = 3): 2 out of 3 women are similar to case 2. ID766 is different. she takes PL for an extended period.
   in the 1993 survey. no leave can be reported. take a cloase look at ID766. she worked almost full-time full-year.
   so, she should be considered to have worked.

     list id year yca nchild fdb if leave == 1 & db == 0 & yca == 3
     list id year yca nchild b leave lfs if id == 149 | id == 695 | id == 766
     list id panel yca lfs empcont leave dayyr hrswk payfreq pay_month if id == 766

   Case 4 (yca = 2): Both seems legitimate, because they took PL (pl=1) in the last year.
   Note that one is ID766.

     list id year yca nchild fdb if leave == 1 & db == 0 & yca == 2
     list id year yca nchild b leave lfs if id == 766 | id == 1171

   Case 5 (yca = 1): Too many to inspect individually. So, I first check whether they took PL in the last year
   or not. Only 4 did not take PL last year. ID880 & ID2252 report (leave = 1) and (leave = 4), respectively,
   in the last year. Although they did not report pl=1. So they seem legitimate. I do not find a reason to
   deny their PL take up. This PL taking pattern may seem unreasonable, but they are self-employed. So they
   can take this unusual pattern. In any case, they are dropped from the sample, and hence, no need to be
   mentioned in the paper. ID4032 and 4491 report PL in their first survey year (2008), which seem reasonable.
   In sum, they are all legitimate.

     list id year yca nchild fdb if leave == 1 & db == 0 & yca == 1 & l.pl != 1
     list id year yca nchild b leave lfs if id == 324 | id == 880 | id == 1274 | id == 2252
     list id year yca nchild b leave lfs if id == 4032 | id == 4491

   I define PL taking if (1) pl == 1 and db == 1 or (2) leave == (1, 4, or 5) and be == 1.
*/

/* employment choices */
gen dl = 0
replace dl = 1 if pl == 1 | leave == 1
replace dl = 0 if dl == 1 & (yca == -1 | yca == 3 | yca == 4)
replace dl = 0 if dl == 1 & (yca == 2 & id == 4350)

gen dh = lfs >= 3 & lfs <= 5

gen dr = empcont == 1 & dl == 0 
gen dn = empcont == 2 & dl == 0

/* employment status */
gen er = empcont == 1
gen en = empcont == 2

/*********************/
/* sector experience */
/*********************/

/* retrospective LFS history */
gen x_self = .    
gen x_reg  = .
gen x_nreg = .
gen x_sch  = .
gen x_home = .

replace x_self = 0 if lfp18 != .
replace x_reg  = 0 if lfp18 != .
replace x_nreg = 0 if lfp18 != .
replace x_sch  = 0 if lfp18 != .
replace x_home = 0 if lfp18 != .

/* 1. family biz, 2. reg, 3. part-time, 4. dispatched, 5. naishoku, 6. student, 7. no work */
forval i = 18/37{
    replace x_self = x_self + 1 if lfp`i' == 1
    replace x_reg  = x_reg  + 1 if lfp`i' == 2
    replace x_nreg = x_nreg + 1 if lfp`i' == 3 | lfp`i' == 4 | lfp`i' == 5
    replace x_sch  = x_sch  + 1 if lfp`i' == 6
    replace x_home = x_home + 1 if lfp`i' == 7
}

/* for panels 1 to 4 */
forval i = 4(-1)1{
    replace x_reg  = f.x_reg  - dr      if panel == `i' & f.x_reg  != . & dr != .
    replace x_nreg = f.x_nreg - dn      if panel == `i' & f.x_nreg != . & dn != .
    replace x_home = f.x_home - dh - dl if panel == `i' & f.x_home != . & dh != . 
}

/* correct if negative */
replace x_reg  = 0 if x_reg  < 0    
replace x_nreg = 0 if x_nreg < 0    
replace x_home = 0 if x_home < 0    

/* for panels 2 to 20 */
forval i = 2/20{
    replace x_reg  = l.x_reg  + dr      if panel == `i' & l.x_reg  != . & dr != .
    replace x_nreg = l.x_nreg + dn      if panel == `i' & l.x_nreg != . & dn != . 
    replace x_home = l.x_home + dh + dl if panel == `i' & l.x_home != . & dh != . 
}

/* no of children and child age are not deterministic for various reasons
   including death, adoption, divorce, re-marriage in addition to mere
   reporting error */

/* make yca, nchild, and b consistent (12 out of 1530 cases) */
replace yca = 0 if db == 1
replace nchild = 1 if db == 1 & nchild == 0

/* places */
gen rural = place == 3
gen abroad = place == 4  

/* in 1993, cur_labinc_s is missing. replace by labinc_s */
replace cur_labinc_s = labinc_s if year == 1993

/* earnings of current year */
rename cur_labinc y    
rename cur_labinc_s ys

/* divorce */
gen divorce = married == 0 & l.married == 1

/* indicator for schooling completed */
gen sch_comp = 1

replace sch_comp = 0 if lfs == 3 & panel == 20

forval i = 17(-1)1{
    replace sch_comp = 0 if (lfs == 3 | f.sch_comp == 0) & panel == `i'
}

/* rename variables */
rename x_reg  hr  
rename x_nreg hn
rename x_home hh

/* lagged choices */
gen ldl = l.dl
gen ldn = l.dn
gen ldr = l.dr
gen ldh = l.dh
gen ldf = l.df

/* lagged employment status */
gen ler = l.er
gen len = l.en

/* lead of stochastic state variables */
gen fys = f.ys

/* education must be time-invariant */
sort id year
by id: egen maxedu = max(edu)
replace edu = maxedu

/* no earnings if not worked */
replace y = 0 if dr == 0 & dn == 0
    
/* save intermediate data */
save /tmp/jpsc-tmp.dta, replace

/***********************/
/* sample restrictions */
/***********************/
keep if abroad == 0
keep if married == 1
keep if selfemp == 0
drop if (dh+dl+dn+dr) != 1 | df == . | hh == . | hr == . | hn == . | ys == . | nchild == . | age == . | yca == . | edu == . 

/***************************/    
/* select the logest spells*/
/***************************/    

/* indicator for the beginning of consecutive spell */
bysort id (year): gen begin = (year - year[_n-1]) > 1

/* spell ID */
bysort id: gen spell = sum(begin)

/* spell length */
bysort id spell: gen length = _N

/* select the logest spells */
bysort id (length year): keep if spell == spell[_N]

/* inidicator for the initial and last observations */
bysort id: gen ini = _n == 1
bysort id: gen last = _n == _N

/* minimum panel length is 2 */
drop if length == 1

/*****************************************
  DO NOT DROP ANY OBSERVATION AFTER THIS 
 *****************************************/

/* lagged employment status for initial observations */
replace ler = 0 if ini == 1
replace len = 0 if ini == 1
replace ler = 1 if ini == 1 & dl == 1 & er == 1
replace len = 1 if ini == 1 & dl == 1 & en == 1

/* initial conditions */
by id: gen ini_age = age[1]

/* save the file */
keep  id year hh hn hr ys nchild age yca len ler ld? d? y fys ini_age edu ini asset hrswk_s hrswk2_s
order id year hh hn hr ys nchild age yca len ler ld? d? y fys ini_age edu ini asset hrswk_s hrswk2_s

sort id year

/* treat ID 1139 as an outlier */
drop if id == 1139

outsheet using "jpsc180328a.csv", comma nolabel replace

/* summary stats */
sum

/* do this everytime when new wave is added */
tabstat hh hn hr ys nchild age yca, by(year)
tabstat len ler ldl ldn ldr ldh, by(year)
tabstat dh dr dn dl df y, by(year)
tabstat fys ini_age edu ini, by(year)

/* distribution of yca for all PL takers */
tab yca if dl == 1

/* distribution of yca and dl for non-initial obs */
    /* no one takes PL for yca > 0 if did not take it for yca == 0 */
tab yca ldl if dl == 1 & ini == 0

/* employment before leave */
    /* only REG workers took PL for more than a year */
tab ler ldl if dl == 1 & ini == 0    
tab len ldl if dl == 1 & ini == 0    

/* one person took PL immediately. this seems legitimate */
list id if dl == 1 & ldh == 1
list id year dh dl dn dr if id == 1139

/* take-up rate */
gen post2005 = year >= 2005
reg dl year post2005 if yca == 0

