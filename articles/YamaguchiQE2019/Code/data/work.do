use ../dta/jpsc-raw.dta, clear
tsset id panel

/********************* employer characteristics *************************/
/*** occupation ***/
gen occ = q144
replace occ = q859 if occ == .

label define occ_lab 1 "primary" 2 "primary (family)" 3 "small" 4 "small (family)" 5 "small (pro)" 6 "manager" 7 "professional" 8 "technician" 9 "teacher" 10 "clerical" 11 "blue collar" 12 "service" 13 "homeworking" 14 "others"
label values occ occ_lab

/*** self-employment ***/
gen selfemp = 0
replace selfemp = 1 if occ >= 1 & occ <= 5

/*** firm size ***/
gen firmsize = q145
replace firmsize = . if firmsize == 9

label define firmsize_lab 1 "1-4" 2 "5-9" 3 "10-29" 4 "30-99" 5 "100-499" 6 "500-999" 7 "1000+" 8 "gov"
label values firmsize firmsize_lab

gen govemp = firmsize == 8

/*** industry ***/
rename q146 ind
replace ind = . if ind == 13

label define ind_lab 1 "agri & forestry" 2 "fishing" 3 "mining" 4 "construction" 5 "manufacturing" 6 "sales" 7 "finince" 8 "transportation" 9 "infrastructure" 10 "service" 11 "public" 12 "others"
label values ind ind_lab

/********************* husband's employer characteristics *************************/
/*** occupation ***/
gen occ_s = q215
replace occ_s = q860 if occ_s == .
replace occ_s = . if occ_s == 15

label values occ_s occ_lab

gen selfemp_s = 1 if occ_s >= 1 & occ_s <= 5
replace selfemp_s = 0 if occ_s >= 6 & occ_s <= 14

/*** firm size ***/
gen firmsize_s = q216
replace firmsize_s = . if firmsize_s == 9

label values firmsize_s firmsize_lab

/*** industry ***/
rename q217 ind_s
replace ind_s = . if ind_s == 13

label values ind_s ind_lab

/*** does the firm have PL? ***/
gen pl_firm = .
replace pl_firm = 1 if q880 >= 1 & q880 <= 3 | (panel == 2 & q157 == 1)
replace pl_firm = 2 if q880 == 4 | (panel == 2 & q157 == 2)
replace pl_firm = 3 if q880 == 5 | (panel == 2 & q157 == 3)
label define pl_firm_lab 1 "yes" 2 "no" 3 "unknown"
label values pl_firm pl_firm_lab

/*** freq of pay of labor earnings (1994 and after) ***/
rename q219 payfreq_s
replace payfreq_s = . if payfreq_s == 6

label define payfreq_lab 1 "monthly" 2 "weekly" 3 "dayly" 4 "hourly" 5 "others"
label values payfreq_s payfreq_lab

/*** monthly earnings without bonuses (if paid monthly/weekly) ***/
rename q220 pay_month_s
replace pay_month_s = . if pay_month_s == 9999

/*** daily earnings (if paid daily) ***/
rename q221 pay_day_s
replace pay_day_s = . if pay_day_s == 99999

/*** hourly earnings (if paid hourly) ***/
rename q222 pay_hour_s
replace pay_hour_s = . if pay_hour_s == 99999

/*** actual weekly hours of work (1994 and after) ***/
rename q223 hrswk_s
replace hrswk_s = . if hrswk_s == 11

label define hrswk_lab 1 "< 15" 2 "15-21" 3 "22-34" 4 "35-42" 5 "43-45" 6 "46-48" 7 "49-54" 8 "55-59" 9 "60-64" 10 "65+"
label values hrswk_s hrswk_lab

/*** actual yearly days of work (1994 and after) ***/
rename q226 dayyr_s
replace dayyr_s = . if dayyr_s == 11

label define dayyr_lab 1 "< 50" 2 "50-99" 3 "100-149" 4 "150-174" 5 "175-199" 6 "200-224" 7 "225-249" 8 "250-274" 9 "275-299" 10 "300+"
label values dayyr_s dayyr_lab

/*** PL eligibility (self-reported) ***/
gen pl_elg = .
replace pl_elg = 1 if q880 == 1
replace pl_elg = 2 if q880 == 2 | q880 == 4
replace pl_elg = 3 if q880 == 3 | q880 == 5
label values pl_elg pl_firm_lab

/*** PL taking by others ***/
rename q160 pl_others
replace pl_others = . if pl_others == 3

/************************** salary and contract information *****************/

/* starting year of the current job */
rename p53a syear
replace syear = . if syear == 99 | syear == 9999
replace syear = syear + 1900 if panel == 1 | panel == 5

/* starting month of the current job */
rename p53b smonth  
replace smonth = . if smonth == 99 | smonth == 0

/*** same employer as the last year ***/
gen sameemp = 0
replace sameemp = 1 if q179 == 1
replace sameemp = . if q179 == 3

/*** for those who newly joined the sample, `sameemp' is missing ***/
replace sameemp = 0 if panel == 1 & syear == 1993 | (syear == 1992 & smonth >= 11 & smonth != .)
replace sameemp = 1 if panel == 1 & syear <= 1991 | (syear == 1992 & smonth <= 10)

replace sameemp = 0 if panel == 5 & syear == 1997 | (syear == 1996 & smonth >= 11 & smonth != .)
replace sameemp = 1 if panel == 5 & syear <= 1995 | (syear == 1996 & smonth <= 10)

replace sameemp = 0 if panel == 11 & syear == 2003 | (syear == 2002 & smonth >= 11 & smonth != .)
replace sameemp = 1 if panel == 11 & syear <= 2001 | (syear == 2002 & smonth <= 10)

replace sameemp = 0 if panel == 16 & syear == 2008 | (syear == 2007 & smonth >= 11 & smonth != .)
replace sameemp = 1 if panel == 16 & syear <= 2006 | (syear == 2007 & smonth <= 10)

/*** employment contract ***/
rename q147 empcont
replace empcont = . if empcont == 4

 /* change from panel 18 (2010) on */
     /* q1112 == 5 is self or family business */
replace empcont = 1 if panel >= 18 & q1112 == 1      
replace empcont = 2 if panel >= 18 & q1112 == 4
replace empcont = 3 if panel >= 18 & (q1112 == 2 | q1112 == 3)
 
label define empcont_lab 1 "permanent" 2 "temporary" 3 "contract"
label values empcont empcont_lab

/*** freq of pay of labor earnings ***/
rename q148 payfreq
replace payfreq = . if payfreq == 6
label values payfreq payfreq_lab

/*** monthly earnings without bonuses (if paid monthly/weekly) ***/
rename q149 pay_month
replace pay_month = . if pay_month == 9999

/*** daily earnings (if paid daily) ***/
rename q150 pay_day
replace pay_day = . if pay_day == 99999

/*** hourly earnings (if paid hourly) ***/
rename q151 pay_hour
replace pay_hour = . if pay_hour == 99999

/*** hours per week (continuous measure) ***/
gen hrswk2_s = .
replace hrswk2_s = (0+15)/2 if hrswk_s == 1
replace hrswk2_s = (15+21)/2 if hrswk_s == 2
replace hrswk2_s = (22+34)/2 if hrswk_s == 3
replace hrswk2_s = (35+42)/2 if hrswk_s == 4
replace hrswk2_s = (43+45)/2 if hrswk_s == 5
replace hrswk2_s = (46+48)/2 if hrswk_s == 6
replace hrswk2_s = (49+54)/2 if hrswk_s == 7
replace hrswk2_s = (55+59)/2 if hrswk_s == 8
replace hrswk2_s = (60+64)/2 if hrswk_s == 9
replace hrswk2_s = 70 if hrswk_s == 10

/*** days per year (continuous measure) ***/
gen dayyr2_s = .
replace dayyr2_s = (0+50)/2 if dayyr_s == 1
replace dayyr2_s = (50+99)/2 if dayyr_s == 2
replace dayyr2_s = (100+149)/2 if dayyr_s == 3
replace dayyr2_s = (150+174)/2 if dayyr_s == 4
replace dayyr2_s = (175+199)/2 if dayyr_s == 5
replace dayyr2_s = (200+224)/2 if dayyr_s == 6
replace dayyr2_s = (225+249)/2 if dayyr_s == 7
replace dayyr2_s = (250+274)/2 if dayyr_s == 8
replace dayyr2_s = (275+299)/2 if dayyr_s == 9
replace dayyr2_s = 330 if dayyr_s == 10

/********************* labor supply variables *************************/

/*** labor force status ***/
gen lfs = q142
replace lfs = 1 if q1025 == 1 & panel == 1
replace lfs = 3 if q1025 == 2 & panel == 1
replace lfs = 4 if q1025 == 3 & panel == 1
replace lfs = 5 if q1025 == 4 & panel == 1

label define lfs_lab 1 "work" 2 "leave" 3 "student" 4 "homemaker" 5 "no-work"
label values lfs lfs_lab

/*** type of leave ***/
gen leave = q143

label define leave_lab 1 "parental" 2 "care" 3 "sick" 4 "other"
label value leave leave_lfs  

/*** retrospective info ***/
rename q855a lfp18
rename q855b lfp19
rename q855c lfp20
rename q855d lfp21
rename q855e lfp22
rename q855f lfp23
rename q855g lfp24
rename q855h lfp25
rename q855i lfp26
rename q855j lfp27
rename q855k lfp28
rename q855l lfp29
rename q855m lfp30
rename q855n lfp31
rename q855o lfp32
rename q855p lfp33
rename q855q lfp34
rename q855r lfp35
rename q855s lfp36
rename q855t lfp37

/*** actual weekly hours of work (1994 and after) ***/
rename q152 hrswk
replace hrswk = . if hrswk == 11
label values hrswk hrswk_lab

/*** actual yearly days of work (1994 and after) ***/
rename q155 dayyr
replace dayyr = . if dayyr == 11
label values dayyr dayyr_lab

/*** usual monthly days of work (1993, all) ***/
gen daymonth = p48 if panel == 1
replace daymonth = p50 if panel == 1 & daymonth == .
replace daymonth = p52 if panel == 1 & daymonth == .
replace daymonth = . if daymonth == 99

/*** usual daily hours of work (1993, if paid daily or hourly) ***/
gen hrsdy = p49 if panel == 1
replace hrsdy = p51 if panel == 1 & hrsdy == .
replace hrsdy = . if hrsdy == 99

/*** hours per week (continuous measure) ***/
gen hrswk2 = .
replace hrswk2 = (0+15)/2 if hrswk == 1
replace hrswk2 = (15+21)/2 if hrswk == 2
replace hrswk2 = (22+34)/2 if hrswk == 3
replace hrswk2 = (35+42)/2 if hrswk == 4
replace hrswk2 = (43+45)/2 if hrswk == 5
replace hrswk2 = (46+48)/2 if hrswk == 6
replace hrswk2 = (49+54)/2 if hrswk == 7
replace hrswk2 = (55+59)/2 if hrswk == 8
replace hrswk2 = (60+64)/2 if hrswk == 9
replace hrswk2 = 70 if hrswk == 10

/*** days per year (continuous measure) ***/
gen dayyr2 = .
replace dayyr2 = (0+50)/2 if dayyr == 1
replace dayyr2 = (50+99)/2 if dayyr == 2
replace dayyr2 = (100+149)/2 if dayyr == 3
replace dayyr2 = (150+174)/2 if dayyr == 4
replace dayyr2 = (175+199)/2 if dayyr == 5
replace dayyr2 = (200+224)/2 if dayyr == 6
replace dayyr2 = (225+249)/2 if dayyr == 7
replace dayyr2 = (250+274)/2 if dayyr == 8
replace dayyr2 = (275+299)/2 if dayyr == 9
replace dayyr2 = 330 if dayyr == 10

/*** (imputed) hours per year ***/
gen hrsyr = (hrswk2/5) * dayyr2  

/*** work experience ***/
  /* year */
gen exp = p40a if p40a != 99
replace exp = p46a if p46a != 99 & p46a != .
  /* month if available */
replace exp = exp + p40b / 12 if p40b >= 0 & p40b <= 12
replace exp = exp + p46b / 12 if p46b >= 0 & p46b <= 12

/*** employer tenure ***/
gen ten = .
replace ten = 0 if (lfs >= 2 & lfs <= 5) | (occ < 6 | occ > 12)
replace ten = ((panel+1992) + 10/12) - (syear + smonth/12) if syear != . & smonth != .
replace ten = (panel+1992) - syear if syear != . & smonth == .

  /* use sameemp */
  forval i = 2/17{
    replace ten = 1 + l.ten if sameemp == 1 & l.ten != . & panel == `i'
    replace ten = 0 if sameemp == 0 & panel == `i'
  }

/*** higly unlikely values ***/
replace pay_month_s = . if pay_month_s/l.pay_month_s > 10 & pay_month_s!=. & l.pay_month_s!=. & pay_month_s > 1000
replace pay_month_s = . if pay_month_s/f.pay_month_s > 10 & pay_month_s!=. & f.pay_month_s!=. & pay_month_s > 1000

replace pay_month = . if pay_month/l.pay_month > 10 & pay_month!=. & l.pay_month!=. & pay_month > 1000
replace pay_month = . if pay_month/f.pay_month > 10 & pay_month!=. & f.pay_month!=. & pay_month > 1000

/*** save outcomes ***/
keep  id panel occ* ind* selfemp* firmsize* govemp syear smonth sameemp pl_* empcont payfreq* pay_* lfs leave lfp* hrswk* dayyr* daymonth hrsdy hrswk2* dayyr2* hrsyr exp ten
order id panel occ* ind* selfemp* firmsize* govemp syear smonth sameemp pl_* empcont payfreq* pay_* lfs leave lfp* hrswk* dayyr* daymonth hrsdy hrswk2* dayyr2* hrsyr exp ten
save /tmp/work.dta, replace

/**********************/
/*** deflate salary ***/
/**********************/

/*** load CPI ***/
insheet year cpi using ../cpi/cpi2010_from1970to2013.csv, clear
gen panel = year - 1992

/*** merge with work.dta */
merge 1:m panel using /tmp/work.dta
drop if _merge != 3

/*** deflate salary ***/
foreach x in month day hour {
  replace pay_`x' = pay_`x' / cpi * 100
}

/*** save outcomes ***/
drop year cpi _merge
sort  id panel
save /tmp/work.dta, replace

/************************************/
/*** impute current year's income ***/
/************************************/

/* impute current labor income (in mil yen) */
gen cur_labinc_s = .
gen cur_labinc = .

/* This is used for those who are paid monthly.
   In 2009, there were 245 weekdays exluding stat holidays. paid leave taken is 8.5 days.
   Given this, assume 237 working days are full year work. Note that 237 is middle of 225-249,
   and hence, 225-249 can be considered to be full year work.
   If worked 200-224 or less, % relative to 236 is used for month worked. */
gen month_s = dayyr2_s / 237 * 12
replace month_s = 12 if month_s > 12

gen month = dayyr2 / 237 * 12
replace month = 12 if month > 12

/* assume 15 months salary per year if paid mothly or weekly (see the questionaire) */
    /* multiply by 15/12 to account for bonus. It is true that bonus rate is different across individuals,
       but I already use bracketed numbers to determine labor supply. This shouldn't contaminate the
       data too much */
replace cur_labinc_s = pay_month_s * month_s * 15/12 * 1000 if payfreq_s == 1 | payfreq_s == 2
replace cur_labinc = pay_month * month * 15/12 * 1000 if payfreq == 1 | payfreq == 2

/* if paid daily, use daily wage and actual days of work */
replace cur_labinc_s = pay_day_s * dayyr2_s if payfreq_s == 3
replace cur_labinc = pay_day * dayyr2 if payfreq == 3

/* if paid hourly, use hourly wage * hours per week * number of weeks (= day per year / 5) */    
replace cur_labinc_s = pay_hour_s * hrswk2_s * (dayyr2_s / 5) if payfreq_s == 4
replace cur_labinc = pay_hour * hrswk2 * (dayyr2 / 5) if payfreq == 4

/* denominate to mil yen */
replace cur_labinc_s = cur_labinc_s / 1000000
replace cur_labinc = cur_labinc / 1000000

save /tmp/work.dta, replace
