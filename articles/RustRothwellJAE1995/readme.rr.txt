John Rust and Geoff Rothwell, "Optimal Response to a Shift in Regulatory
Regime: The Case of the U.S. Nuclear Power Industry", Journal of Applied 
Econometrics, Vol. 10, Supplement, 1995, pp. S75-S118.

README file for monthly nuclear operating data. There are 118 files, all 
zipped in the file rr-data.zip. These files came from a Unix system.

Data set consists of 117 separate ASCII files on U.S. nuclear reactor
monthly operating histories over the period 4/75 to 12/94 (start date is
later than 4/75 if plant came online after 4/75 and ending date is earlier
than 12/94 if plant was shut down prior to 12/94). In addition there is a
summary file, NUKESUM.ASC, which provides summary information on
non-time-varying characteristics of 121 U.S. nuclear power plants,
including the 117 plants for which we have data on monthly operating
histories. 

The reactor monthly operating history files (*.mon) have the following 
format:

col 1   2 3  4  5 6   7      8      9     10     111213 14 
ZION2 304 4 75  1 0   4    0.0    0.0  252.6  744.0 0 0  3
ZION2 304 4 75  2 0   5    0.0    0.0  338.9  672.0 0 0  2
ZION2 304 4 75  3 0   6    0.0    0.0  226.4  744.0 0 0 13
ZION2 304 4 75  4 0   7    0.0    0.0  247.5  720.0 0 0  3

Col
1:  NAME Name of plant
2:  ID   NRC ID number of plant
3:  NSS  Nuclear steam supply system:
      1 = Babcock and Wilcox
      2 = Combustion Engineering
      3 = General Electric
      4 = Westinghouse
4:  YEAR Year of observation
5:  MONTH  Month of observation
6:  VINTAGE Vintage of reactor construction 
      0 = pre Three Mile Island design
      1 = post Three Mile Island design
7:  AGE  Age of reactor in months
8:  HREFUEL Hours in month spent in refueling
9:  HPLANNED Hours in month spent in scheduled outages
10: HFORCED  Hours in month spent in forced outages
11: HMONTH   Total hours in month
12: SCRAMIN  Scram in indicator
13: SCRAMOUT Scram out indicator
14: FOUTNUM  Number of forced outages in the month

Documentation for NUKESUM.ASC, a file containing non-time varying
characteristics of 121 U.S. nuclear reactors. 

CODE   FIRM CM CD CY THERM  NP  NET AE      NSSS BUILDER TURB ST
ARKA1  ARPL 12 19 74 2568  903  850 BECHTEL B&W  BECHTEL WEST AR
ARKA2  ARPL  3 26 80 2815  943  912 BECHTEL COMB BECHTEL GE   AR
ARNO1  IOEL  2  1 75 1658  565  538 BECHTEL GE   BECHTEL GE   IA

CODE = NAME OF REACTOR
FIRM = UTILITY
CM   = Commercial Operation Month
CD   = Commercial Operation Day
CY   = Commercial Operation Year
THERM = Thermal Capacity
NP   = Nameplate rating of generator
NET  = NP - self consumed power
AE   = Architect Engineer
NSSS = Nuclear Steam Supply System
BUILD= General Contractor
TURB = Turbine-Generator Set manufacturer
ST   = State

