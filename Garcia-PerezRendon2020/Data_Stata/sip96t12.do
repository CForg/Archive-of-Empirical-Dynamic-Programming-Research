log using sip96t12, text replace
set mem 500m
*This program reads the 1996 SIPP Wave 12 Topical Module Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*by Jean Roth Tue Nov  4 11:37:49 EST 2003
*Please report errors to jroth@nber.org
*run with do sip96t12
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp/1996\sip96t12.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96t12

*Everything below this point are value labels

#delimit ;

;
label values spanel   spanel; 
label define spanel  
	1996        "Panel Year"                    
;
label values tfipsst  tfipsst;
label define tfipsst 
	1           "Alabama"                       
	2           "Alaska"                        
	4           "Arizona"                       
	5           "Arkansas"                      
	6           "California"                    
	8           "Colorado"                      
	9           "Connecticut"                   
	10          "Delaware"                      
	11          "DC"                            
	12          "Florida"                       
	13          "Georgia"                       
	15          "Hawaii"                        
	16          "Idaho"                         
	17          "Illinois"                      
	18          "Indiana"                       
	19          "Iowa"                          
	20          "Kansas"                        
	21          "Kentucky"                      
	22          "Louisiana"                     
	24          "Maryland"                      
	25          "Massachusetts"                 
	26          "Michigan"                      
	27          "Minnesota"                     
	28          "Mississippi"                   
	29          "Missouri"                      
	30          "Montana"                       
	31          "Nebraska"                      
	32          "Nevada"                        
	33          "New Hampshire"                 
	34          "New Jersey"                    
	35          "New Mexico"                    
	36          "New York"                      
	37          "North Carolina"                
	39          "Ohio"                          
	40          "Oklahoma"                      
	41          "Oregon"                        
	42          "Pennsylvania"                  
	44          "Rhode Island"                  
	45          "South Carolina"                
	47          "Tennessee"                     
	48          "Texas"                         
	49          "Utah"                          
	51          "Virginia"                      
	53          "Washington"                    
	54          "West Virginia"                 
	55          "Wisconsin"                     
	61          "Maine, Vermont"                
	62          "North Dakota, South Dakota,"   
;
label values sinthhid sinthhid;
label define sinthhid
	0           "Not in universe"               
;
label values eoutcome eoutcome;
label define eoutcome
	201         "Completed interview"           
	203         "Compl. partial- missing data; no"
	207         "Complete partial - TYPE-Z; no" 
	213         "TYPE-A, language problem"      
	215         "TYPE-A, insufficient partial"  
	216         "TYPE-A, no one home (noh)"     
	217         "TYPE-A, temporarily absent (ta)"
	218         "TYPE-A, hh refused"            
	219         "TYPE-A, other occupied (specify)"
	234         "TYPE-B, entire hh institut. or"
	248         "TYPE-C, other (specify)"       
	249         "TYPE-C, sample adjustment"     
	250         "TYPE-C, hh deceased"           
	251         "TYPE-C, moved out of country"  
	252         "TYPE-C, living in armed forces"
	253         "TYPE-C, on active duty in Armed"
	254         "TYPE-C, no one over age 15 years"
	255         "TYPE-C, no Wave 1 persons"     
	260         "TYPE-D, moved address unknown" 
	261         "TYPE-D, moved w/in U.S. but"   
	262         "Merged with another SIPP"      
	270         "Mover, no longer located in same"
	271         "Mover, new address located in" 
	280         "Newly spawned case outside fr's"
;
label values rfid2    rfid2l; 
label define rfid2l  
	0           "Member of related subfamily"   
;
label values epopstat epopstat;
label define epopstat
	1           "Adult (15 years of age or older)"
	2           "Child (Under 15 years of age)" 
;
label values eppintvw eppintvw;
label define eppintvw
	1           "Interview (self)"              
	2           "Interview (proxy)"             
	3           "Noninterview - Type Z"         
	4           "Nonintrvw - pseudo Type Z.  Left"
	5           "Children under 15 during"      
;
label values eppmis4  eppmis4l;
label define eppmis4l
	1           "Interview"                     
	2           "Non-interview"                 
;
label values esex     esex;   
label define esex    
	1           "Male"                          
	2           "Female"                        
;
label values erace    erace;  
label define erace   
	1           "White"                         
	2           "Black"                         
	3           "American Indian, Aleut, or"    
	4           "Asian or Pacific Islander"     
;
label values eorigin  eorigin;
label define eorigin 
	1           "Canadian"                      
	2           "Dutch"                         
	3           "English"                       
	4           "French"                        
	5           "French-Canadian"               
	6           "German"                        
	7           "Hungarian"                     
	8           "Irish"                         
	9           "Italian"                       
	10          "Polish"                        
	11          "Russian"                       
	12          "Scandinavian"                  
	13          "Scotch-Irish"                  
	14          "Scottish"                      
	15          "Slovak"                        
	16          "Welsh"                         
	17          "Other European"                
	20          "Mexican"                       
	21          "Mexican-American"              
	22          "Chicano"                       
	23          "Puerto Rican"                  
	24          "Cuban"                         
	25          "Central American"              
	26          "South American"                
	27          "Dominican Republic"            
	28          "Other Hispanic"                
	30          "African-American or"           
	31          "American Indian, Eskimo, or"   
	32          "Arab"                          
	33          "Asian"                         
	34          "Pacific Islander"              
	35          "West Indian"                   
	39          "Another group not listed"      
	40          "American"                      
;
label values errp     errp;   
label define errp    
	1           "Reference person w/ rel. persons"
	2           "Reference Person w/out rel."   
	3           "Spouse of reference person"    
	4           "Child of reference person"     
	5           "Grandchild of reference person"
	6           "Parent of reference person"    
	7           "Brother/sister of reference"   
	8           "Other relative of reference"   
	9           "Foster child of reference person"
	10          "Unmarried partner of reference"
	11          "Housemate/roommate"            
	12          "Roomer/boarder"                
	13          "Other non-relative of reference"
;
label values tage     tage;   
label define tage    
	0           "Less than 1 full year old"     
;
label values ems      ems;    
label define ems     
	1           "Married, spouse present"       
	2           "Married, Spouse absent"        
	3           "Widowed"                       
	4           "Divorced"                      
	5           "Separated"                     
	6           "Never Married"                 
;
label values epnspous epnspous;
label define epnspous
	9999        "Spouse not in hhld or person not"
;
label values epnmom   epnmom; 
label define epnmom  
	9999        "No mother in household"        
;
label values epndad   epndad; 
label define epndad  
	9999        "No father in household"        
;
label values epnguard epnguard;
label define epnguard
	-1          "Not in universe"               
	9999        "Guardian not in household"     
;
label values rdesgpnt rdesgpnt;
label define rdesgpnt
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eeducate eeducate;
label define eeducate
	-1          "Not in universe"               
	31          "Less than 1st grade"           
	32          "1st, 2nd, 3rd or 4th grade"    
	33          "5th or 6th grade"              
	34          "7th or 8th grade"              
	35          "9th grade"                     
	36          "10th grade"                    
	37          "11th grade"                    
	38          "12th grade"                    
	39          "High school graduate - high"   
	40          "Some college but no degree"    
	41          "Diploma or certificate from a" 
	42          "Associate degree in college -" 
	43          "Associate Degree in college -" 
	44          "Bachelors degree (For example:"
	45          "Master's degree (For example:" 
	46          "Professional School Degree (For"
	47          "Doctorate degree (For example:"
;
label values ehreunv  ehreunv;
label define ehreunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values eremobho eremobho;
label define eremobho
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aremobho aremobho;
label define aremobho
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehowner1 ehownero;
label define ehownero
	-1          "Not in universe"               
;
label values ahowner1 ahownero;
label define ahownero
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehowner2 ehownerk;
label define ehownerk
	-1          "Not in universe"               
;
label values ahowner2 ahownerk;
label define ahownerk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)}"
;
label values ehowner3 ehownerl;
label define ehownerl
	-1          "Not in universe"               
;
label values ehbuymo  ehbuymo;
label define ehbuymo 
	-1          "Not in universe"               
;
label values ahbuymo  ahbuymo;
label define ahbuymo 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehbuyyr  ehbuyyr;
label define ehbuyyr 
	-1          "Not in universe"               
;
label values ahbuyyr  ahbuyyr;
label define ahbuyyr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehmort   ehmort; 
label define ehmort  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahmort   ahmort; 
label define ahmort  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enummort enummort;
label define enummort
	-1          "Not in universe"               
;
label values anummort anummort;
label define anummort
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmor1pr  tmor1pr;
label define tmor1pr 
	0           "Not in universe"               
;
label values amor1pr  amor1pr;
label define amor1pr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor1yr  emor1yr;
label define emor1yr 
	-1          "Not in universe"               
;
label values amor1yr  amor1yr;
label define amor1yr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor1mo  emor1mo;
label define emor1mo 
	-1          "Not in universe"               
;
label values amor1mo  amor1mo;
label define amor1mo 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmor1amt tmor1amt;
label define tmor1amt
	0           "None or not in universe"       
;
label values amor1amt amor1amt;
label define amor1amt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor1yrs emor1yrs;
label define emor1yrs
	-1          "Not in universe"               
;
label values amor1yrs amor1yrs;
label define amor1yrs
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor1int emor1int;
label define emor1int
	-1          "Not in universe"               
;
label values amor1int amor1int;
label define amor1int
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor1var emor1var;
label define emor1var
	-1          "Not in universe"               
	1           "Variable interest rate"        
	2           "Fixed interest rate"           
;
label values amor1var amor1var;
label define amor1var
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor1pgm emor1pgm;
label define emor1pgm
	-1          "Not in universe"               
	1           "Yes - FHA LOAN"                
	2           "Yes - VA LOAN"                 
	3           "No"                            
;
label values amor1pgm amor1pgm;
label define amor1pgm
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmor2pr  tmor2pr;
label define tmor2pr 
	0           "Not in universe"               
	1           "Flag indicating principal on"  
;
label values amor2pr  amor2pr;
label define amor2pr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor2yr  emor2yr;
label define emor2yr 
	-1          "Not in universe"               
;
label values amor2yr  amor2yr;
label define amor2yr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor2mo  emor2mo;
label define emor2mo 
	-1          "Not in universe"               
;
label values amor2mo  amor2mo;
label define amor2mo 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmor2amt tmor2amt;
label define tmor2amt
	0           "None or not in universe"       
	1           "Flag indicating second mortgage"
;
label values amor2amt amor2amt;
label define amor2amt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor2yrs emor2yrs;
label define emor2yrs
	-1          "Not in universe"               
;
label values amor2yrs amor2yrs;
label define amor2yrs
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor2int emor2int;
label define emor2int
	-1          "Not in universe"               
;
label values amor2int amor2int;
label define amor2int
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor2var emor2var;
label define emor2var
	-1          "Not in universe"               
	1           "Variable interest rate"        
	2           "Fixed interest rate"           
;
label values amor2var amor2var;
label define amor2var
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emor2pgm emor2pgm;
label define emor2pgm
	-1          "Not in universe"               
	1           "Yes-FHA loan"                  
	2           "Yes-VA loan"                   
	3           "No"                            
;
label values amor2pgm amor2pgm;
label define amor2pgm
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmor3pr  tmor3pr;
label define tmor3pr 
	0           "None or not in universe"       
	1           "Flag indicating principal"     
;
label values amor3pr  amor3pr;
label define amor3pr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tpropval tpropval;
label define tpropval
	0           "None or not in universe"       
;
label values apropval apropval;
label define apropval
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emhloan  emhloan;
label define emhloan 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amhloan  amhloan;
label define amhloan 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emhtype  emhtype;
label define emhtype 
	-1          "Not in universe"               
	1           "Mobile home only"              
	2           "Site only"                     
	3           "Site and home"                 
;
label values amhtype  amhtype;
label define amhtype 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmhpr    tmhpr;  
label define tmhpr   
	0           "None or not in universe"       
;
label values amhpr    amhpr;  
label define amhpr   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmhval   tmhval; 
label define tmhval  
	0           "None or not in universe"       
;
label values amhval   amhval; 
label define amhval  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values thomeamt thomeamt;
label define thomeamt
	0           "None or not in universe"       
;
label values ahomeamt ahomeamt;
label define ahomeamt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tutils   tutils; 
label define tutils  
	0           "None or not in universe"       
;
label values autils   autils; 
label define autils  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eperspay eperspay;
label define eperspay
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aperspay aperspay;
label define aperspay
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eperspya eperspya;
label define eperspya
	-1          "Not in universe"               
;
label values aperspya aperspya;
label define aperspya
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eperspy1 eperspyk;
label define eperspyk
	-1          "Not in universe"               
;
label values aperspy1 aperspyk;
label define aperspyk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eperspy2 eperspyl;
label define eperspyl
	-1          "Not in universe"               
;
label values eperspy3 eperspym;
label define eperspym
	-1          "Not in universe"               
;
label values tpersam1 tpersama;
label define tpersama
	0           "None or not in universe"       
;
label values apersam1 apersama;
label define apersama
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tpersam2 tpersamk;
label define tpersamk
	0           "None or not in universe"       
;
label values apersam2 apersamk;
label define apersamk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tpersam3 tpersaml;
label define tpersaml
	0           "None or not in universe"       
;
label values apersam3 apersaml;
label define apersaml
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaycare epaycare;
label define epaycare
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaycare apaycare;
label define apaycare
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tcarecst tcarecst;
label define tcarecst
	0           "None or not in universe"       
;
label values acarecst acarecst;
label define acarecst
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothre   eothre; 
label define eothre  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aothre   aothre; 
label define aothre  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothreo1 eothreoe;
label define eothreoe
	-1          "Not in universe"               
;
label values aothreo1 aothreoe;
label define aothreoe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothreo2 eothreok;
label define eothreok
	-1          "Not in universe"               
;
label values eothreo3 eothreol;
label define eothreol
	-1          "Not in universe"               
;
label values tothreva tothreva;
label define tothreva
	0           "None or not in universe"       
;
label values aothreva aothreva;
label define aothreva
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eautoown eautoown;
label define eautoown
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aautoown aautoown;
label define aautoown
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eautonum eautonum;
label define eautonum
	-1          "Not in universe"               
;
label values aautonum aautonum;
label define aautonum
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea1own1  ea1own1l;
label define ea1own1l
	-1          "Not in universe"               
;
label values aa1own1  aa1own1l;
label define aa1own1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea1own2  ea1own2l;
label define ea1own2l
	-1          "Not in universe"               
;
label values tcarval1 tcarvalm;
label define tcarvalm
	0           "None or not in universe"       
;
label values acarval1 acarvalm;
label define acarvalm
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ta1year  ta1year;
label define ta1year 
	-1          "Not in universe"               
	9999        "Dont Know, Refusal, Blanks from"
;
label values ea1owed  ea1owed;
label define ea1owed 
	-1          "Not in universe"               
	1           "Money owed"                    
	2           "Free and clear"                
;
label values aa1owed  aa1owed;
label define aa1owed 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ta1amt   ta1amt; 
label define ta1amt  
	0           "None or not in universe"       
;
label values aa1amt   aa1amt; 
label define aa1amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea1use   ea1use; 
label define ea1use  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aa1use   aa1use; 
label define aa1use  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea2own1  ea2own1l;
label define ea2own1l
	-1          "Not in universe"               
;
label values aa2own1  aa2own1l;
label define aa2own1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea2own2  ea2own2l;
label define ea2own2l
	-1          "Not in universe"               
;
label values tcarval2 tcarvale;
label define tcarvale
	0           "None or not in universe"       
;
label values acarval2 acarvale;
label define acarvale
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ta2year  ta2year;
label define ta2year 
	-1          "Not in universe"               
	9999        "Dont Know, Refusal, Blanks from"
;
label values ea2owed  ea2owed;
label define ea2owed 
	-1          "Not in universe"               
	1           "Money owed"                    
	2           "Free and clear"                
;
label values aa2owed  aa2owed;
label define aa2owed 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ta2amt   ta2amt; 
label define ta2amt  
	0           "None or not in universe"       
;
label values aa2amt   aa2amt; 
label define aa2amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea2use   ea2use; 
label define ea2use  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aa2use   aa2use; 
label define aa2use  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea3own1  ea3own1l;
label define ea3own1l
	-1          "Not in universe"               
;
label values aa3own1  aa3own1l;
label define aa3own1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea3own2  ea3own2l;
label define ea3own2l
	-1          "Not in universe"               
;
label values tcarval3 tcarvalk;
label define tcarvalk
	0           "None or not in universe"       
;
label values acarval3 acarvalk;
label define acarvalk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ta3year  ta3year;
label define ta3year 
	-1          "Not in universe"               
	9999        "Dont Know, Refusal, Blanks from"
;
label values ea3owed  ea3owed;
label define ea3owed 
	-1          "Not in universe"               
	1           "Money owed"                    
	2           "Free and clear"                
;
label values aa3owed  aa3owed;
label define aa3owed 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ta3amt   ta3amt; 
label define ta3amt  
	0           "None or not in universe"       
;
label values aa3amt   aa3amt; 
label define aa3amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ea3use   ea3use; 
label define ea3use  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aa3use   aa3use; 
label define aa3use  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothveh  eothveh;
label define eothveh 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aothveh  aothveh;
label define aothveh 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eovmtrcy eovmtrcy;
label define eovmtrcy
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aovmtrcy aovmtrcy;
label define aovmtrcy
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eovboat  eovboat;
label define eovboat 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aovboat  aovboat;
label define aovboat 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eovrv    eovrv;  
label define eovrv   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "Not"                           
;
label values aovrv    aovrv;  
label define aovrv   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eovothrv eovothrv;
label define eovothrv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "Not"                           
;
label values aovothrv aovothrv;
label define aovothrv
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eov1own1 eov1ownv;
label define eov1ownv
	-1          "Not in universe"               
;
label values aov1own1 aov1ownv;
label define aov1ownv
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eov1own2 eov1ownk;
label define eov1ownk
	-1          "Not in universe"               
;
label values tov1val  tov1val;
label define tov1val 
	0           "None or not in universe"       
;
label values aov1val  aov1val;
label define aov1val 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eov1owe  eov1owe;
label define eov1owe 
	-1          "Not in universe"               
	1           "Money owed"                    
	2           "Free and clear"                
;
label values aov1owe  aov1owe;
label define aov1owe 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tov1amt  tov1amt;
label define tov1amt 
	0           "None or not in universe"       
;
label values aov1amt  aov1amt;
label define aov1amt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eov2own1 eov2ownt;
label define eov2ownt
	-1          "Not in universe"               
;
label values aov2own1 aov2ownt;
label define aov2ownt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eov2own2 eov2ownk;
label define eov2ownk
	-1          "Not in universe"               
;
label values tov2val  tov2val;
label define tov2val 
	0           "None or not in universe"       
;
label values aov2val  aov2val;
label define aov2val 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eov2owe  eov2owe;
label define eov2owe 
	-1          "Not in universe"               
	1           "Money owed"                    
	2           "Free and clear"                
;
label values aov2owe  aov2owe;
label define aov2owe 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tov2amt  tov2amt;
label define tov2amt 
	0           "None or not in universe"       
;
label values aov2amt  aov2amt;
label define aov2amt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values thhtnw   thhtnw; 
label define thhtnw  
	0           "None or Not in universe"       
;
label values thhtwlth thhtwlth;
label define thhtwlth
	0           "None or Not in universe"       
;
label values thhtheq  thhtheq;
label define thhtheq 
	0           "None or Not in universe"       
;
label values thhmortg thhmortg;
label define thhmortg
	0           "None or Not in universe"       
;
label values thhvehcl thhvehcl;
label define thhvehcl
	0           "None or Not in universe"       
;
label values thhbeq   thhbeq; 
label define thhbeq  
	0           "None or Not in universe"       
;
label values thhintbk thhintbk;
label define thhintbk
	0           "None or Not in universe"       
;
label values thhintot thhintot;
label define thhintot
	0           "None or Not in universe"       
;
label values rhhstk   rhhstk; 
label define rhhstk  
	0           "None or Not in universe"       
;
label values thhore   thhore; 
label define thhore  
	0           "None or Not in universe"       
;
label values thhotast thhotast;
label define thhotast
	0           "None or Not in universe"       
;
label values thhira   thhira; 
label define thhira  
	0           "None or Not in universe"       
;
label values thhdebt  thhdebt;
label define thhdebt 
	0           "None or Not in universe"       
;
label values thhscdbt thhscdbt;
label define thhscdbt
	0           "None or Not in universe"       
;
label values rhhuscbt rhhuscbt;
label define rhhuscbt
	0           "None or Not in universe"       
;
label values epalunv  epalunv;
label define epalunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values ealow    ealow;  
label define ealow   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalow    aalow;  
label define aalow   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealowa   ealowa; 
label define ealowa  
	0           "None or not in universe"       
;
label values aalowa   aalowa; 
label define aalowa  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealsb    ealsb;  
label define ealsb   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalsb    aalsb;  
label define aalsb   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values talsbv   talsbv; 
label define talsbv  
	0           "None or not in universe"       
;
label values aalsbv   aalsbv; 
label define aalsbv  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjch   ealjch; 
label define ealjch  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaljch   aaljch; 
label define aaljch  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values taljcha  taljcha;
label define taljcha 
	0           "None or not in universe"       
;
label values aaljcha  aaljcha;
label define aaljcha 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjdb   ealjdb; 
label define ealjdb  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaljdb   aaljdb; 
label define aaljdb  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjdl   ealjdl; 
label define ealjdl  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaljdl   aaljdl; 
label define aaljdl  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjdo   ealjdo; 
label define ealjdo  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaljdo   aaljdo; 
label define aaljdo  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjdab  ealjdab;
label define ealjdab 
	0           "None or not in universe"       
;
label values aaljdab  aaljdab;
label define aaljdab 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjdal  ealjdal;
label define ealjdal 
	0           "None or not in universe"       
;
label values aaljdal  aaljdal;
label define aaljdal 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealjdao  ealjdao;
label define ealjdao 
	0           "None or not in universe"       
;
label values aaljdao  aaljdao;
label define aaljdao 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealich   ealich; 
label define ealich  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalich   aalich; 
label define aalich  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values talicha  talicha;
label define talicha 
	0           "None or not in universe"       
;
label values aalicha  aalicha;
label define aalicha 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealil    ealil;  
label define ealil   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalil    aalil;  
label define aalil   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealidb   ealidb; 
label define ealidb  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalidb   aalidb; 
label define aalidb  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealidl   ealidl; 
label define ealidl  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalidl   aalidl; 
label define aalidl  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealido   ealido; 
label define ealido  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalido   aalido; 
label define aalido  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealidab  ealidab;
label define ealidab 
	0           "None or not in universe"       
;
label values aalidab  aalidab;
label define aalidab 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealidal  ealidal;
label define ealidal 
	0           "None or not in universe"       
;
label values aalidal  aalidal;
label define aalidal 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealidao  ealidao;
label define ealidao 
	0           "None or not in universe"       
;
label values aalidao  aalidao;
label define aalidao 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealr     ealr;   
label define ealr    
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalr     aalr;   
label define aalr    
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealry    ealry;  
label define ealry   
	-1          "Not in universe"               
	0           "None"                          
;
label values aalry    aalry;  
label define aalry   
	0           "Not Imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values talrb    talrb;  
label define talrb   
	0           "None or not in universe"       
;
label values aalrb    aalrb;  
label define aalrb   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealra1   ealra1l;
label define ealra1l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalra1   aalra1l;
label define aalra1l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealra2   ealra2l;
label define ealra2l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalra2   aalra2l;
label define aalra2l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealra3   ealra3l;
label define ealra3l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalra3   aalra3l;
label define aalra3l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealra4   ealra4l;
label define ealra4l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalra4   aalra4l;
label define aalra4l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealk     ealk;   
label define ealk    
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalk     aalk;   
label define aalk    
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealky    ealky;  
label define ealky   
	-1          "Not in universe"               
	0           "None"                          
;
label values aalky    aalky;  
label define aalky   
	0           "Not Imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values talkb    talkb;  
label define talkb   
	0           "None or not in universe"       
;
label values aalkb    aalkb;  
label define aalkb   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealka1   ealka1l;
label define ealka1l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalka1   aalka1l;
label define aalka1l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealka2   ealka2l;
label define ealka2l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalka2   aalka2l;
label define aalka2l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealka3   ealka3l;
label define ealka3l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalka3   aalka3l;
label define aalka3l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealka4   ealka4l;
label define ealka4l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalka4   aalka4l;
label define aalka4l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealt     ealt;   
label define ealt    
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalt     aalt;   
label define aalt    
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealty    ealty;  
label define ealty   
	-1          "Not in universe"               
	0           "None"                          
;
label values aalty    aalty;  
label define aalty   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values taltb    taltb;  
label define taltb   
	0           "None or not in universe"       
;
label values aaltb    aaltb;  
label define aaltb   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealta1   ealta1l;
label define ealta1l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalta1   aalta1l;
label define aalta1l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealta2   ealta2l;
label define ealta2l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalta2   aalta2l;
label define aalta2l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealta3   ealta3l;
label define ealta3l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalta3   aalta3l;
label define aalta3l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealta4   ealta4l;
label define ealta4l 
	-1          "Not in universe"               
	1           "Certificates of deposit or other"
	2           "Money market funds"            
	3           "U.S. Government securities"    
	4           "Municipal or corporate bonds"  
	5           "U.S. Savings Bonds"            
	6           "Stocks or mutual fund shares"  
	7           "Other assets"                  
;
label values aalta4   aalta4l;
label define aalta4l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ealli    ealli;  
label define ealli   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aalli    aalli;  
label define aalli   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values talliv   talliv; 
label define talliv  
	0           "None or not in universe"       
;
label values aalliv   aalliv; 
label define aalliv  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eallit   eallit; 
label define eallit  
	-1          "Not in universe"               
	1           "Term only"                     
	2           "Whole life only"               
	3           "Both types"                    
;
label values aallit   aallit; 
label define aallit  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eallie   eallie; 
label define eallie  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aallie   aallie; 
label define aallie  
	0           "Not Imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values talliev  talliev;
label define talliev 
	0           "None or not in universe"       
;
label values aalliev  aalliev;
label define aalliev 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epcwunv  epcwunv;
label define epcwunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values ehtotal  ehtotal;
label define ehtotal 
	-1          "Not in universe"               
;
label values ahtotal  ahtotal;
label define ahtotal 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eweighns eweighns;
label define eweighns
	-1          "Not in universe"               
;
label values aweighns aweighns;
label define aweighns
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaycare edaycare;
label define edaycare
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaycare adaycare;
label define adaycare
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecaremth ecaremth;
label define ecaremth
	-1          "Not in universe"               
	1           "0-3 Months"                    
	2           "4-6 Months"                    
	3           "7-11 Months"                   
	4           "12-17 Months"                  
	5           "18-23 Months"                  
	6           "24 or more Months"             
;
label values acaremth acaremth;
label define acaremth
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold Deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrscare ehrscare;
label define ehrscare
	-1          "Not in universe"               
;
label values ahrscare ahrscare;
label define ahrscare
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elivapat elivapat;
label define elivapat
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values alivapat alivapat;
label define alivapat
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enotable enotable;
label define enotable
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Sometimes yes, sometimes no"   
;
label values anotable anotable;
label define anotable
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation"            
;
label values epastmon epastmon;
label define epastmon
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apastmon apastmon;
label define apastmon
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
;
label values eouting  eouting;
label define eouting 
	-3          "None"                          
	-1          "Not in universe"               
;
label values aouting  aouting;
label define aouting 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etotread etotread;
label define etotread
	-3          "None"                          
	-1          "Not in universe"               
;
label values atotread atotread;
label define atotread
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparread eparread;
label define eparread
	-3          "None"                          
	-1          "Not in universe"               
;
label values aparread aparread;
label define aparread
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edadread edadread;
label define edadread
	-3          "None"                          
	-1          "Not in universe"               
;
label values adadread adadread;
label define adadread
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etvrules etvrules;
label define etvrules
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values atvrules atvrules;
label define atvrules
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etimestv etimestv;
label define etimestv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values atimestv atimestv;
label define atimestv
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehoustv  ehoustv;
label define ehoustv 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahoustv  ahoustv;
label define ahoustv 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eeatbkf  eeatbkf;
label define eeatbkf 
	-3          "None"                          
	-1          "Not in universe"               
;
label values aeatbkf  aeatbkf;
label define aeatbkf 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eeatdinn eeatdinn;
label define eeatdinn
	-3          "None"                          
	-1          "Not in universe"               
;
label values aeatdinn aeatdinn;
label define aeatdinn
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edadbrkf edadbrkf;
label define edadbrkf
	-3          "None"                          
	-1          "Not in universe"               
;
label values adadbrkf adadbrkf;
label define adadbrkf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaddinn edaddinn;
label define edaddinn
	-3          "None"                          
	-1          "Not in universe"               
;
label values adaddinn adaddinn;
label define adaddinn
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values efuntime efuntime;
label define efuntime
	-1          "Not in universe"               
	1           "Never"                         
	2           "About once a week (or less)"   
	3           "A few times a week"            
	4           "One or two times a day"        
	5           "Many times each day"           
;
label values afuntime afuntime;
label define afuntime
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edadfun  edadfun;
label define edadfun 
	-1          "Not in universe"               
	1           "Never"                         
	2           "About once a week (or less)"   
	3           "A few times a week"            
	4           "One or two times a day"        
	5           "Many times each day"           
;
label values adadfun  adadfun;
label define adadfun 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epraise  epraise;
label define epraise 
	-1          "Not in universe"               
	1           "Never"                         
	2           "About once a week (or less)"   
	3           "A few times a week"            
	4           "One or two times a day"        
	5           "Many times each day"           
;
label values apraise  apraise;
label define apraise 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edadprai edadprai;
label define edadprai
	-1          "Not in universe"               
	1           "Never"                         
	2           "About once a week (or less)"   
	3           "A few times a week"            
	4           "One or two times a day"        
	5           "Many times each day"           
;
label values adadprai adadprai;
label define adadprai
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values efarscho efarscho;
label define efarscho
	-1          "Not in universe"               
	1           "Leave school before graduation"
	2           "Graduate from high school"     
	3           "Get some college or other"     
	4           "Graduate from college"         
	5           "Take further education or"     
;
label values afarscho afarscho;
label define afarscho
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edadfar  edadfar;
label define edadfar 
	-1          "Not in universe"               
	1           "Leave school before graduation"
	2           "Graduate from high school"     
	3           "Get some college or other"     
	4           "Graduate from college"         
	5           "Take further education or"     
;
label values adadfar  adadfar;
label define adadfar 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ethinksc ethinksc;
label define ethinksc
	-1          "Not in universe"               
	1           "Leave school before graduation"
	2           "Graduate from high school"     
	3           "Get some college or other"     
	4           "Graduate from college"         
	5           "Take further education or"     
;
label values athinksc athinksc;
label define athinksc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eatkindg eatkindg;
label define eatkindg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aatkindg aatkindg;
label define aatkindg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekindage ekindage;
label define ekindage
	-1          "Not in universe"               
;
label values akindage akindage;
label define akindage
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values efirgrad efirgrad;
label define efirgrad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values afirgrad afirgrad;
label define afirgrad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values estrtage estrtage;
label define estrtage
	-1          "Not in universe"               
;
label values astrtage astrtage;
label define astrtage
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekindele ekindele;
label define ekindele
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values akindele akindele;
label define akindele
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehighgra ehighgra;
label define ehighgra
	-3          "None (No grade completed)"     
	-1          "Not in universe"               
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
	14          "College, one year or more"     
;
label values ahighgra ahighgra;
label define ahighgra
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecurrerl ecurrerl;
label define ecurrerl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acurrerl acurrerl;
label define acurrerl
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egrdeatt egrdeatt;
label define egrdeatt
	-3          "None"                          
	-1          "Not in universe"               
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
	14          "College, one year or more"     
;
label values agrdeatt agrdeatt;
label define agrdeatt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epubpriv epubpriv;
label define epubpriv
	-1          "Not in universe"               
	1           "Public"                        
	2           "Private"                       
;
label values apubpriv apubpriv;
label define apubpriv
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eassschl eassschl;
label define eassschl
	-1          "Not in universe"               
	1           "Assigned"                      
	2           "Chosen"                        
	3           "Both -- assigned school is"    
;
label values aassschl aassschl;
label define aassschl
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelisch erelisch;
label define erelisch
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arelisch arelisch;
label define arelisch
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values especsch especsch;
label define especsch
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aspecsch aspecsch;
label define aspecsch
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esportea esportea;
label define esportea
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asportea asportea;
label define asportea
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elessons elessons;
label define elessons
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values alessons alessons;
label define alessons
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eclubsch eclubsch;
label define eclubsch
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aclubsch aclubsch;
label define aclubsch
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elikesch elikesch;
label define elikesch
	-1          "Not in universe"               
	1           "Not true"                      
	2           "Sometimes true"                
	3           "Often true"                    
;
label values alikesch alikesch;
label define alikesch
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eintschl eintschl;
label define eintschl
	-1          "Not in universe"               
	1           "Not true"                      
	2           "Sometimes true"                
	3           "Often true"                    
;
label values aintschl aintschl;
label define aintschl
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewkshard ewkshard;
label define ewkshard
	-1          "Not in universe"               
	1           "Not true"                      
	2           "Sometimes true"                
	3           "Often true"                    
;
label values awkshard awkshard;
label define awkshard
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values echgschl echgschl;
label define echgschl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values achgschl achgschl;
label define achgschl
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etimchan etimchan;
label define etimchan
	-1          "Not in universe"               
;
label values atimchan atimchan;
label define atimchan
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erepgrad erepgrad;
label define erepgrad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arepgrad arepgrad;
label define arepgrad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egrdrpt1 egrdrptd;
label define egrdrptd
	-3          "None"                          
	-1          "Not in universe"               
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
;
label values egrdrpt2 egrdrptk;
label define egrdrptk
	-3          "None"                          
	-1          "Not in universe"               
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
;
label values egrdrpt3 egrdrptl;
label define egrdrptl
	-3          "None"                          
	-1          "Not in universe"               
	0           "Fewer than five grades reported"
	1           "First grade"                   
	2           "Second grade"                  
	3           "Third grade"                   
	4           "Fourth grade"                  
	5           "Fifth grade"                   
	6           "Sixth grade"                   
	7           "Seventh grade"                 
	8           "Eighth grade"                  
	9           "Ninth grade"                   
	10          "Tenth grade"                   
	11          "Eleventh grade"                
	12          "Twelfth grade"                 
	13          "Kindergarten"                  
;
label values egrdrpt4 egrdrptm;
label define egrdrptm
	-3          "None"                          
	-1          "Not in universe"               
	0           "Fewer than five grades reported"
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
;
label values egrdrpt5 egrdrptn;
label define egrdrptn
	-3          "None"                          
	-1          "Not in universe"               
	0           "Fewer than five grades reported"
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
;
label values agrdrpt  agrdrpt;
label define agrdrpt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eexpschl eexpschl;
label define eexpschl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aexpschl aexpschl;
label define aexpschl
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etimexp  etimexp;
label define etimexp 
	-1          "Not in universe"               
;
label values atimexp  atimexp;
label define atimexp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egradexp egradexp;
label define egradexp
	-3          "None (No grade completed)"     
	-1          "Not in universe"               
	1           "Kindergarten"                  
	2           "First grade"                   
	3           "Second grade"                  
	4           "Third grade"                   
	5           "Fourth grade"                  
	6           "Fifth grade"                   
	7           "Sixth grade"                   
	8           "Seventh grade"                 
	9           "Eighth grade"                  
	10          "Ninth grade"                   
	11          "Tenth grade"                   
	12          "Eleventh grade"                
	13          "Twelfth grade"                 
;
label values agradexp agradexp;
label define agradexp
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehardcar ehardcar;
label define ehardcar
	-1          "Not in universe"               
	1           "Never"                         
	2           "Sometimes"                     
	3           "Often"                         
	4           "Very often"                    
;
label values ahardcar ahardcar;
label define ahardcar
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebother  ebother;
label define ebother 
	-1          "Not in universe"               
	1           "Never"                         
	2           "Sometimes"                     
	3           "Often"                         
	4           "Very often"                    
;
label values abother  abother;
label define abother 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egivuplf egivuplf;
label define egivuplf
	-1          "Not in universe"               
	1           "Never"                         
	2           "Sometimes"                     
	3           "Often"                         
	4           "Very often"                    
;
label values agivuplf agivuplf;
label define agivuplf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eangrycl eangrycl;
label define eangrycl
	-1          "Not in universe"               
	1           "Never"                         
	2           "Sometimes"                     
	3           "Often"                         
	4           "Very often"                    
;
label values aangrycl aangrycl;
label define aangrycl
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehelpech ehelpech;
label define ehelpech
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values ahelpech ahelpech;
label define ahelpech
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewatchot ewatchot;
label define ewatchot
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values awatchot awatchot;
label define awatchot
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecounton ecounton;
label define ecounton
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values acounton acounton;
label define acounton
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebadpeop ebadpeop;
label define ebadpeop
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values abadpeop abadpeop;
label define abadpeop
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etrustpe etrustpe;
label define etrustpe
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values atrustpe atrustpe;
label define atrustpe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekeepins ekeepins;
label define ekeepins
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values akeepins akeepins;
label define akeepins
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esafepla esafepla;
label define esafepla
	-1          "Not in universe"               
	1           "Strongly agree"                
	2           "Agree"                         
	3           "Disagree"                      
	4           "Strongly Disagree"             
	5           "Have no opinion"               
;
label values asafepla asafepla;
label define asafepla
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emdunv   emdunv; 
label define emdunv  
	-1          "Not in universe"               
	1           "In universe"                   
;
label values tdonorid tdonorid;
label define tdonorid
	0           "Not in universe or did not"    
	1           "Received data from a Donor"    
;
label values ehltstat ehltstat;
label define ehltstat
	-1          "Not in universe"               
	1           "Excellent"                     
	2           "Very Good"                     
	3           "Good"                          
	4           "Fair"                          
	5           "Poor"                          
;
label values ahltstat ahltstat;
label define ahltstat
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehospsta ehospsta;
label define ehospsta
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahospsta ahospsta;
label define ahospsta
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehospnit ehospnit;
label define ehospnit
	0           "None or not in universe"       
;
label values ahospnit ahospnit;
label define ahospnit
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehreas1  ehreas1l;
label define ehreas1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahreas1  ahreas1l;
label define ahreas1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehreas2  ehreas2l;
label define ehreas2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahreas2  ahreas2l;
label define ahreas2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehreas3  ehreas3l;
label define ehreas3l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahreas3  ahreas3l;
label define ahreas3l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehreas4  ehreas4l;
label define ehreas4l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahreas4  ahreas4l;
label define ahreas4l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehreas5  ehreas5l;
label define ehreas5l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahreas5  ahreas5l;
label define ahreas5l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehreas6  ehreas6l;
label define ehreas6l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahreas6  ahreas6l;
label define ahreas6l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edocnum  edocnum;
label define edocnum 
	0           "None or not in universe"       
;
label values adocnum  adocnum;
label define adocnum 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values thipay   thipay; 
label define thipay  
	0           "Not in universe or none"       
;
label values ahipay   ahipay; 
label define ahipay  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epresdrg epresdrg;
label define epresdrg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apresdrg apresdrg;
label define apresdrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edalydrg edalydrg;
label define edalydrg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adalydrg adalydrg;
label define adalydrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eflshyn  eflshyn;
label define eflshyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values evisdent evisdent;
label define evisdent
	0           "None or not in universe"       
;
label values avisdent avisdent;
label define avisdent
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edenseal edenseal;
label define edenseal
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adenseal adenseal;
label define adenseal
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elostth  elostth;
label define elostth 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values alostth  alostth;
label define alostth 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eallth   eallth; 
label define eallth  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aallth   aallth; 
label define aallth  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values evisdoc  evisdoc;
label define evisdoc 
	0           "None or not in universe"       
;
label values avisdoc  avisdoc;
label define avisdoc 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emdspnd  emdspnd;
label define emdspnd 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amdspnd  amdspnd;
label define amdspnd 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emdspnds emdspnds;
label define emdspnds
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amdspnds amdspnds;
label define amdspnds
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaysick edaysick;
label define edaysick
	0           "None or not in universe"       
;
label values adaysick adaysick;
label define adaysick
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmdpay   tmdpay; 
label define tmdpay  
	0           "Not in universe or none"       
;
label values amdpay   amdpay; 
label define amdpay  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ereimb   ereimb; 
label define ereimb  
	-1          "Not in universe"               
	1           "Total Cost"                    
	2           "Got Reimbursed"                
	3           "Expects to get reimbursed but" 
;
label values areimb   areimb; 
label define areimb  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values treimbur treimbur;
label define treimbur
	0           "None or not in universe"       
;
label values areimbur areimbur;
label define areimbur
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehspstas ehspstas;
label define ehspstas
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahspstas ahspstas;
label define ahspstas
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eprsdrgs eprsdrgs;
label define eprsdrgs
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aprsdrgs aprsdrgs;
label define aprsdrgs
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values evsdents evsdents;
label define evsdents
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values avsdents avsdents;
label define avsdents
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values evsdocs  evsdocs;
label define evsdocs 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values avsdocs  avsdocs;
label define avsdocs 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enowkyr  enowkyr;
label define enowkyr 
	-1          "Not in universe"               
	1           "A year or longer"              
	2           "less than a year"              
;
label values anowkyr  anowkyr;
label define anowkyr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewkfutr  ewkfutr;
label define ewkfutr 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awkfutr  awkfutr;
label define awkfutr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trmoops  trmoops;
label define trmoops 
	0           "None or not in universe"       
;
label values enoindnt enoindnt;
label define enoindnt
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoindnt anoindnt;
label define anoindnt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoindoc enoindoc;
label define enoindoc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoindoc anoindoc;
label define anoindoc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enointrt enointrt;
label define enointrt
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anointrt anointrt;
label define anointrt
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoinchk enoinchk;
label define enoinchk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoinchk anoinchk;
label define anoinchk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoindrg enoindrg;
label define enoindrg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoindrg anoindrg;
label define anoindrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoinpay enoinpay;
label define enoinpay
	-1          "Not in universe"               
	1           "Free"                          
	2           "Paid something"                
	3           "Both (if respondent volunteers)"
;
label values anoinpay anoinpay;
label define anoinpay
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoindis enoindis;
label define enoindis
	-1          "Not in universe"               
	1           "Full price"                    
	2           "Reduced price"                 
	3           "Don't know"                    
;
label values anoindis anoindis;
label define anoindis
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoininc enoininc;
label define enoininc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoininc anoininc;
label define anoininc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoincln enoincln;
label define enoincln
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoiner  enoiner;
label define enoiner 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinhsp enoinhsp;
label define enoinhsp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinva  enoinva;
label define enoinva 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoindr  enoindr;
label define enoindr 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoindds enoindds;
label define enoindds
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinoth enoinoth;
label define enoinoth
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoinloc anoinloc;
label define anoinloc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epoaunv  epoaunv;
label define epoaunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values eoaeq    eoaeq;  
label define eoaeq   
	0           "None or not in universe"       
;
label values aoaeq    aoaeq;  
label define aoaeq   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tiajta   tiajta; 
label define tiajta  
	0           "None or not in universe"       
;
label values aiajta   aiajta; 
label define aiajta  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tiaita   tiaita; 
label define tiaita  
	0           "None or not in universe"       
;
label values aiaita   aiaita; 
label define aiaita  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values timja    timja;  
label define timja   
	0           "None or not in universe"       
;
label values aimja    aimja;  
label define aimja   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values timia    timia;  
label define timia   
	0           "None or not in universe"       
;
label values aimia    aimia;  
label define aimia   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmjm    esmjm;  
label define esmjm   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asmjm    asmjm;  
label define asmjm   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmjs    esmjs;  
label define esmjs   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asmjs    asmjs;  
label define asmjs   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmjv    esmjv;  
label define esmjv   
	0           "None or not in universe"       
;
label values asmjv    asmjv;  
label define asmjv   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmjma   esmjma; 
label define esmjma  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asmjma   asmjma; 
label define asmjma  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmjmav  esmjmav;
label define esmjmav 
	0           "None or not in universe"       
;
label values asmjmav  asmjmav;
label define asmjmav 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmi     esmi;   
label define esmi    
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asmi     asmi;   
label define asmi    
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmiv    esmiv;  
label define esmiv   
	0           "None or not in universe"       
;
label values asmiv    asmiv;  
label define asmiv   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmima   esmima; 
label define esmima  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asmima   asmima; 
label define asmima  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esmimav  esmimav;
label define esmimav 
	0           "None or not in universe"       
;
label values asmimav  asmimav;
label define asmimav 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjown   erjown; 
label define erjown  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arjown   arjown; 
label define arjown  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjnum   erjnum; 
label define erjnum  
	0           "None or not in universe"       
;
label values arjnum   arjnum; 
label define arjnum  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjtyp1  erjtyp1l;
label define erjtyp1l
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arjtyp1  arjtyp1l;
label define arjtyp1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjtyp2  erjtyp2l;
label define erjtyp2l
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arjtyp2  arjtyp2l;
label define arjtyp2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjtyp3  erjtyp3l;
label define erjtyp3l
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arjtyp3  arjtyp3l;
label define arjtyp3l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjtyp4  erjtyp4l;
label define erjtyp4l
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arjtyp4  arjtyp4l;
label define arjtyp4l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjtyp5  erjtyp5l;
label define erjtyp5l
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arjtyp5  arjtyp5l;
label define arjtyp5l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjtyp6  erjtyp6l;
label define erjtyp6l
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arjtyp6  arjtyp6l;
label define arjtyp6l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjat    erjat;  
label define erjat   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arjat    arjat;  
label define arjat   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjata   erjata; 
label define erjata  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arjata   arjata; 
label define arjata  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trjmv    trjmv;  
label define trjmv   
	0           "None or not in universe"       
;
label values arjmv    arjmv;  
label define arjmv   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erjdeb   erjdeb; 
label define erjdeb  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arjdeb   arjdeb; 
label define arjdeb  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trjpri   trjpri; 
label define trjpri  
	0           "None or not in universe"       
;
label values arjpri   arjpri; 
label define arjpri  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eriown   eriown; 
label define eriown  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ariown   ariown; 
label define ariown  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erinum   erinum; 
label define erinum  
	0           "None or not in universe"       
;
label values arinum   arinum; 
label define arinum  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eritype1 eritypem;
label define eritypem
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values aritype1 aritypem;
label define aritypem
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eritype2 eritypek;
label define eritypek
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values aritype2 aritypek;
label define aritypek
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eritype3 eritypel;
label define eritypel
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values aritype3 aritypel;
label define aritypel
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eritype4 eritypen;
label define eritypen
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values aritype4 aritypen;
label define aritypen
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eritype5 eritypeo;
label define eritypeo
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values aritype5 aritypeo;
label define aritypeo
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eritype6 eritypep;
label define eritypep
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values aritype6 aritypep;
label define aritypep
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eriat    eriat;  
label define eriat   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ariat    ariat;  
label define ariat   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eriata   eriata; 
label define eriata  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ariata   ariata; 
label define ariata  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trimv    trimv;  
label define trimv   
	0           "None or not in universe"       
;
label values arimv    arimv;  
label define arimv   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erideb   erideb; 
label define erideb  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arideb   arideb; 
label define arideb  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tripri   tripri; 
label define tripri  
	0           "None or not in universe"       
;
label values aripri   aripri; 
label define aripri  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ertown   ertown; 
label define ertown  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values artown   artown; 
label define artown  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ertnum   ertnum; 
label define ertnum  
	0           "None or not in universe"       
;
label values artnum   artnum; 
label define artnum  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erttype1 erttypem;
label define erttypem
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arttype1 arttypem;
label define arttypem
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erttype2 erttypek;
label define erttypek
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arttype2 arttypek;
label define arttypek
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erttype3 erttypel;
label define erttypel
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arttype3 arttypel;
label define arttypel
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erttype4 erttypen;
label define erttypen
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arttype4 arttypen;
label define arttypen
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erttype5 erttypeo;
label define erttypeo
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arttype5 arttypeo;
label define arttypeo
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erttype6 erttypep;
label define erttypep
	-1          "Not in universe"               
	1           "Vacation home"                 
	2           "Other residential property"    
	3           "Farm property"                 
	4           "Commercial property"           
	5           "Equipment"                     
	6           "Other"                         
;
label values arttype6 arttypep;
label define arttypep
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trtmv    trtmv;  
label define trtmv   
	0           "None or not in universe"       
;
label values artmv    artmv;  
label define artmv   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ertdeb   ertdeb; 
label define ertdeb  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values artdeb   artdeb; 
label define artdeb  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trtpri   trtpri; 
label define trtpri  
	0           "None or not in universe"       
;
label values artpri   artpri; 
label define artpri  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values trtsha   trtsha; 
label define trtsha  
	0           "None or not in universe"       
;
label values artsha   artsha; 
label define artsha  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emjp     emjp;   
label define emjp    
	0           "None or not in universe"       
;
label values amjp     amjp;   
label define amjp    
	0           "Not Imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emip     emip;   
label define emip    
	0           "None or not in universe"       
;
label values amip     amip;   
label define amip    
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epvunv   epvunv; 
label define epvunv  
	-1          "Not in universe"               
	1           "In universe"                   
;
label values epvwk1   epvwk1l;
label define epvwk1l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values epvwk2   epvwk2l;
label define epvwk2l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values epvwk3   epvwk3l;
label define epvwk3l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values epvwk4   epvwk4l;
label define epvwk4l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values epvwk5   epvwk5l;
label define epvwk5l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apvwk    apvwk;  
label define apvwk   
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvmilwk epvmilwk;
label define epvmilwk
	-1          "Not in universe"               
;
label values apvmilwk apvmilwk;
label define apvmilwk
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvpaprk epvpaprk;
label define epvpaprk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apvpaprk apvpaprk;
label define apvpaprk
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvpaywk epvpaywk;
label define epvpaywk
	0           "Not in universe"               
;
label values apvpaywk apvpaywk;
label define apvpaywk
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvcomut epvcomut;
label define epvcomut
	0           "Not in universe"               
;
label values apvcomut apvcomut;
label define apvcomut
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvwkexp epvwkexp;
label define epvwkexp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apvwkexp apvwkexp;
label define apvwkexp
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvanexp epvanexp;
label define epvanexp
	0           "Not in universe"               
;
label values apvanexp apvanexp;
label define apvanexp
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvchild epvchild;
label define epvchild
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apvchild apvchild;
label define apvchild
	0           "no imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvmancd epvmancd;
label define epvmancd
	-1          "Not in universe"               
;
label values apvmancd apvmancd;
label define apvmancd
	0           "no imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values epvmosup epvmosup;
label define epvmosup
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apvmosup apvmosup;
label define apvmosup
	0           "no imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values tpvchpa1 tpvchpap;
label define tpvchpap
	0           "None or not in universe"       
;
label values tpvchpa2 tpvchpak;
label define tpvchpak
	0           "None or not in universe"       
;
label values tpvchpa3 tpvchpal;
label define tpvchpal
	0           "None or not in universe"       
;
label values tpvchpa4 tpvchpam;
label define tpvchpam
	0           "None or not in universe"       
;
label values apvchpa  apvchpa;
label define apvchpa 
	0           "No imputation"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed from the previous wave"
;
label values evbunv1  evbunv1l;
label define evbunv1l
	-1          "Not in universe"               
	1           "In universe"                   
;
label values evbno1   evbno1l;
label define evbno1l 
	-1          "Not in universe"               
;
label values evbow1   evbow1l;
label define evbow1l 
	0           "Not in universe"               
;
label values avbow1   avbow1l;
label define avbow1l 
	0           "Not imputed"                   
	1           "Statistical imputed (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tvbva1   tvbva1l;
label define tvbva1l 
	0           "None or not in universe"       
;
label values avbva1   avbva1l;
label define avbva1l 
	0           "Not imputed"                   
	1           "Statistical imputed (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tvbde1   tvbde1l;
label define tvbde1l 
	0           "None or not in universe"       
;
label values avbde1   avbde1l;
label define avbde1l 
	0           "Not imputed"                   
	1           "Statistical imputed (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values evbunv2  evbunv2l;
label define evbunv2l
	-1          "Not in universe"               
	1           "In universe"                   
;
label values evbno2   evbno2l;
label define evbno2l 
	-1          "Not in universe"               
;
label values evbow2   evbow2l;
label define evbow2l 
	0           "Not in universe"               
;
label values avbow2   avbow2l;
label define avbow2l 
	0           "Not imputed"                   
	1           "Statistical imputed (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tvbva2   tvbva2l;
label define tvbva2l 
	0           "None or not in universe"       
;
label values avbva2   avbva2l;
label define avbva2l 
	0           "Not imputed"                   
	1           "Statistical imputed (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tvbde2   tvbde2l;
label define tvbde2l 
	0           "None or not in universe"       
;
label values avbde2   avbde2l;
label define avbde2l 
	0           "Not imputed"                   
	1           "Statistical imputed (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;

/*
Copyright 2003 shared by the National Bureau of Economic Research and Jean Roth

National Bureau of Economic Research.
1050 Massachusetts Avenue
Cambridge, MA 02138
jroth@nber.org

This program and all programs referenced in it are free software. You
can redistribute the program or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
USA.
*/
