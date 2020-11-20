I. Data:

A. 
mobility4.dta: cps data in stata format
mobility4.txt: cps data raw file

 Variable descriptions
survey year
age
sex
years of schooling (created)
weeks worked last year
hours worked last year
full or part-time work
income from wage and salary
cd: career decision 1 to 8 (created from occupation, industry, weeks worked, hours worked):
  1 = goods sector - white collar; 2 = goods sector - pink collar
  3 = goods sector - blue collar; 4 = service sector - white collar;
  5 = service sector - pink collar 6 = service sector - blue collar;
  7 = in school; 8 = at home
number of children under age 6 (created)
sample weight

These data files are available on Donghoon Lee's website at http://homepages.nyu.edu/~dl64

B.
merged4ec.dta: NLSY79 data in stata format
merged4ec.txt: NLSY79 data raw file
 Variable descriptions 
respondent identification number
year
age 
sex
highest grade completed
hourly wage
sample weight
career decision

These data files are available on http://homepages.nyu.edu/~dl64

C. Files read by the estimation program
Data moments used in estimation obtained from A and B above: 
wt_475.txt: career decision
wt4_473.txt: education distribution
adlw2_472.txt: wage change by age
wdlw2_472.txt: weight for adlw2_472.txt
acd6_472.txt: career decision by work experience
wcd6_472.txt: weight for acd6_472.txt
w3_475.txt: wage
pcd.txt: career switching by period
pwgt.txt: weight for pcd.txt
ocd.txt: career swithcing between occupations
owgt.txt: weight for ocd.txt
icd.txt: career switching between sectors
iwgt.txt: weight for icd.txt
lws2_487: log wage variance by sector/occupation
lwe2_487: log wage variance by education
arelxcum.txt: distribution of work experiences by age
alogw6_472.txt: log wage by work experience
adlw2_472.txt: log wage change by past and current sector occupation
acd16_2.txt: career decision by initial education level 

Aggregate data used in estimation:
MPK19012000.txt (before 1960); mpncaesy6195sm.txt (since 1960): fertility process
nis_473.txt: ratio of national income to GDP by year
loutput_470.txt: log output by sector by year
lcapital_470.txt: log total capital stock by year
ka3_475.txt  log capital stock by sector by year
lc_473.txt: non wage salary wage compensation rate
cpsbea_475.txt: aggregate wage difference between CPS and BEA
cohortwgt.txt: cohort size by year
akrental_477.txt: capital rental price by year


II. Estimation Program Files:
pr487.txt : user supplied initial parameter values for the estimation program
p487_main.f90: main fortran source program




