log using sip96t4, text replace
set mem 500m
*This program reads the 1996 SIPP Wave 4 Topical Module Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*by Jean Roth Tue Nov  4 11:38:13 EST 2003
*Please report errors to jroth@nber.org
*run with do sip96t4
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp/1996\sip96t4.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96t4

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
label values epwsunv  epwsunv;
label define epwsunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values ewsempct ewsempct;
label define ewsempct
	-1          "  1)Not in Universe"           
	0           "  2)Not in Universe"           
	1           "  3)1 employer"                
	2           "  4)2 employers"               
	3           "  5)3 or more employers"       
;
label values awsempct awsempct;
label define awsempct
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values aallimp  aallimp;
label define aallimp 
	0           "Full Set of variables were not"
	1           "Full set of variables were"    
;
label values ewseno1  ewseno1l;
label define ewseno1l
	-1          "Not in Universe"               
;
label values ewsbno1  ewsbno1l;
label define ewsbno1l
	-1          "Not in Universe"               
;
label values ewseno2  ewseno2l;
label define ewseno2l
	-1          "Not in Universe"               
;
label values ewsbno2  ewsbno2l;
label define ewsbno2l
	-1          "Not in Universe"               
;
label values ewshrs1  ewshrs1l;
label define ewshrs1l
	-1          "Not in universe"               
;
label values awshrs1  awshrs1l;
label define awshrs1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdys1  ewsdys1l;
label define ewsdys1l
	-1          "Not in Universe"               
;
label values awsdys1  awsdys1l;
label define awsdys1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday11 ewsday1p;
label define ewsday1p
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday11 awsday1p;
label define awsday1p
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday12 ewsday1k;
label define ewsday1k
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday12 awsday1k;
label define awsday1k
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday13 ewsday1l;
label define ewsday1l
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday13 awsday1l;
label define awsday1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday14 ewsday1m;
label define ewsday1m
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday14 awsday1m;
label define awsday1m
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday15 ewsday1n;
label define ewsday1n
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday15 awsday1n;
label define awsday1n
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday16 ewsday1o;
label define ewsday1o
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday16 awsday1o;
label define awsday1o
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday17 ewsday1q;
label define ewsday1q
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday17 awsday1q;
label define awsday1q
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsbeg1  ewsbeg1l;
label define ewsbeg1l
	-1          "Not in Universe"               
;
label values awsbeg1  awsbeg1l;
label define awsbeg1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsbegm1 ewsbegmp;
label define ewsbegmp
	-1          "Not in Universe"               
	1           "A.M."                          
	2           "P.M."                          
	3           "Noon"                          
	4           "Midnight"                      
;
label values awsbegm1 awsbegmp;
label define awsbegmp
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsend1  ewsend1l;
label define ewsend1l
	-1          "Not in Universe"               
;
label values awsend1  awsend1l;
label define awsend1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsendm1 ewsendmp;
label define ewsendmp
	-1          "Not in Universe"               
	1           "A.M."                          
	2           "P.M."                          
	3           "Noon"                          
	4           "Midnight"                      
;
label values awsendm1 awsendmp;
label define awsendmp
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewshmwk1 ewshmwkp;
label define ewshmwkp
	-1          "Not in Universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awshmwk1 awshmwkp;
label define awshmwkp
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy11  ewsdy11l;
label define ewsdy11l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Sunday" 
;
label values awsdy11  awsdy11l;
label define awsdy11l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy12  ewsdy12l;
label define ewsdy12l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Monday" 
;
label values awsdy12  awsdy12l;
label define awsdy12l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy13  ewsdy13l;
label define ewsdy13l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Tuesday"
;
label values awsdy13  awsdy13l;
label define awsdy13l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy14  ewsdy14l;
label define ewsdy14l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Wednesday"
;
label values awsdy14  awsdy14l;
label define awsdy14l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy15  ewsdy15l;
label define ewsdy15l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Thursday"
;
label values awsdy15  awsdy15l;
label define awsdy15l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy16  ewsdy16l;
label define ewsdy16l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Friday" 
;
label values awsdy16  awsdy16l;
label define awsdy16l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy17  ewsdy17l;
label define ewsdy17l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Saturday"
;
label values awsdy17  awsdy17l;
label define awsdy17l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsjob1  ewsjob1l;
label define ewsjob1l
	-1          "Not in Universe"               
	1           "Regular daytime schedule YES"  
	2           "Regular evening shift"         
	3           "Regular night shift"           
	4           "Rotating shift"                
	5           "Split shift"                   
	6           "Irregular shift"               
	7           "Other"                         
;
label values awsjob1  awsjob1l;
label define awsjob1l
	0           "Not in Universe"               
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsmnr1  ewsmnr1l;
label define ewsmnr1l
	-1          "Not in Universe"               
	1           "Better child care arrangements"
	2           "Better pay Regular evening shift"
	3           "Better arrangements for care of"
	4           "Allows time for school"        
	5           "Other Voluntary reasons"       
	6           "Requirement of the job"        
	7           "Could not get any other job"   
	8           "Other voluntary reason"        
;
label values awsmnr1  awsmnr1l;
label define awsmnr1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewshrs2  ewshrs2l;
label define ewshrs2l
	-1          "Not in universe"               
;
label values awshrs2  awshrs2l;
label define awshrs2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdys2  ewsdys2l;
label define ewsdys2l
	-1          "Not in Universe"               
;
label values awsdys2  awsdys2l;
label define awsdys2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday21 ewsday2p;
label define ewsday2p
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday21 awsday2p;
label define awsday2p
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday22 ewsday2k;
label define ewsday2k
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday22 awsday2k;
label define awsday2k
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday23 ewsday2l;
label define ewsday2l
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday23 awsday2l;
label define awsday2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday24 ewsday2m;
label define ewsday2m
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday24 awsday2m;
label define awsday2m
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday25 ewsday2n;
label define ewsday2n
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday25 awsday2n;
label define awsday2n
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday26 ewsday2o;
label define ewsday2o
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday26 awsday2o;
label define awsday2o
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsday27 ewsday2q;
label define ewsday2q
	-1          "Not in Universe"               
	0           "Did not work"                  
	1           "Worked"                        
;
label values awsday27 awsday2q;
label define awsday2q
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsbeg2  ewsbeg2l;
label define ewsbeg2l
	-1          "Not in Universe"               
;
label values awsbeg2  awsbeg2l;
label define awsbeg2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsbegm2 ewsbegmk;
label define ewsbegmk
	-1          "Not in Universe"               
	1           "A.M."                          
	2           "P.M."                          
	3           "Noon"                          
	4           "Midnight"                      
;
label values awsbegm2 awsbegmk;
label define awsbegmk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsend2  ewsend2l;
label define ewsend2l
	-1          "Not in Universe"               
;
label values awsend2  awsend2l;
label define awsend2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsendm2 ewsendmk;
label define ewsendmk
	-1          "Not in Universe"               
	1           "A.M."                          
	2           "P.M."                          
	3           "Noon"                          
	4           "Midnight"                      
;
label values awsendm2 awsendmk;
label define awsendmk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewshmwk2 ewshmwkk;
label define ewshmwkk
	-1          "Not in Universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awshmwk2 awshmwkk;
label define awshmwkk
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy21  ewsdy21l;
label define ewsdy21l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Sunday" 
;
label values awsdy21  awsdy21l;
label define awsdy21l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy22  ewsdy22l;
label define ewsdy22l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Monday" 
;
label values awsdy22  awsdy22l;
label define awsdy22l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy23  ewsdy23l;
label define ewsdy23l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Tuesday"
;
label values awsdy23  awsdy23l;
label define awsdy23l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy24  ewsdy24l;
label define ewsdy24l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Wednesday"
;
label values awsdy24  awsdy24l;
label define awsdy24l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy25  ewsdy25l;
label define ewsdy25l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Thursday"
;
label values awsdy25  awsdy25l;
label define awsdy25l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy26  ewsdy26l;
label define ewsdy26l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Friday" 
;
label values awsdy26  awsdy26l;
label define awsdy26l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsdy27  ewsdy27l;
label define ewsdy27l
	-1          "Not in Universe"               
	0           "Did not work only at home on"  
	1           "Worked only at home on Saturday"
;
label values awsdy27  awsdy27l;
label define awsdy27l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsjob2  ewsjob2l;
label define ewsjob2l
	-1          "Not in Universe"               
	1           "Regular daytime schedule YES"  
	2           "Regular evening shift"         
	3           "Regular night shift"           
	4           "Rotating shift"                
	5           "Split shift"                   
	6           "Irregular shift"               
	7           "Other"                         
;
label values awsjob2  awsjob2l;
label define awsjob2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewsmnr2  ewsmnr2l;
label define ewsmnr2l
	-1          "Not in Universe"               
	1           "Better child care arrangements"
	2           "Better pay Regular evening shift"
	3           "Better arrangements for care of"
	4           "Allows time for school"        
	5           "Other Voluntary reasons"       
	6           "Requirement of the job"        
	7           "Could not get any other job"   
	8           "Other voluntary reason"        
;
label values awsmnr2  awsmnr2l;
label define awsmnr2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eccunv   eccunv; 
label define eccunv  
	-1          "Not in Universe"               
	1           "In universe"                   
;
label values ehrwksch ehrwksch;
label define ehrwksch
	-6          "Not enrolled"                  
	-5          "Hours varied"                  
	-1          "Not in universe"               
	0           "No unusual hours last month"   
;
label values ahrwksch ahrwksch;
label define ahrwksch
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rrhrswk  rrhrswk;
label define rrhrswk 
	-1          "Not in universe"               
	0           "Not working or not in school"  
;
label values ehrwkjob ehrwkjob;
label define ehrwkjob
	-7          "Did not look for job last month"
	-5          "Hours varied"                  
	-1          "Not in universe"               
;
label values ahrwkjob ahrwkjob;
label define ahrwkjob
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eccpnuma eccpnuma;
label define eccpnuma
	-1          "Not in universe"               
;
label values eccpnumb eccpnumb;
label define eccpnumb
	-1          "Not in universe"               
;
label values eccpnumc eccpnumc;
label define eccpnumc
	-1          "Not in universe"               
;
label values eccpnumd eccpnumd;
label define eccpnumd
	-1          "Not in universe"               
;
label values eccpnume eccpnume;
label define eccpnume
	-1          "Not in universe"               
;
label values eccagea  eccagea;
label define eccagea 
	-1          "Not in universe"               
;
label values eccageb  eccageb;
label define eccageb 
	-1          "Not in universe"               
;
label values eccagec  eccagec;
label define eccagec 
	-1          "Not in universe"               
;
label values eccaged  eccaged;
label define eccaged 
	-1          "Not in universe"               
;
label values eccagee  eccagee;
label define eccagee 
	-1          "Not in universe"               
;
label values eckd01a  eckd01a;
label define eckd01a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01b  eckd01b;
label define eckd01b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01c  eckd01c;
label define eckd01c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01d  eckd01d;
label define eckd01d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01e  eckd01e;
label define eckd01e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02a  eckd02a;
label define eckd02a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02b  eckd02b;
label define eckd02b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02c  eckd02c;
label define eckd02c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02d  eckd02d;
label define eckd02d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02e  eckd02e;
label define eckd02e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03a  eckd03a;
label define eckd03a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03b  eckd03b;
label define eckd03b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03c  eckd03c;
label define eckd03c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03d  eckd03d;
label define eckd03d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03e  eckd03e;
label define eckd03e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04a  eckd04a;
label define eckd04a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04b  eckd04b;
label define eckd04b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04c  eckd04c;
label define eckd04c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04d  eckd04d;
label define eckd04d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04e  eckd04e;
label define eckd04e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05a  eckd05a;
label define eckd05a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05b  eckd05b;
label define eckd05b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05c  eckd05c;
label define eckd05c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05d  eckd05d;
label define eckd05d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05e  eckd05e;
label define eckd05e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06a  eckd06a;
label define eckd06a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06b  eckd06b;
label define eckd06b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06c  eckd06c;
label define eckd06c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06d  eckd06d;
label define eckd06d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06e  eckd06e;
label define eckd06e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07a  eckd07a;
label define eckd07a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07b  eckd07b;
label define eckd07b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07c  eckd07c;
label define eckd07c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07d  eckd07d;
label define eckd07d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07e  eckd07e;
label define eckd07e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08a  eckd08a;
label define eckd08a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08b  eckd08b;
label define eckd08b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08c  eckd08c;
label define eckd08c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08d  eckd08d;
label define eckd08d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08e  eckd08e;
label define eckd08e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09a  eckd09a;
label define eckd09a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09b  eckd09b;
label define eckd09b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09c  eckd09c;
label define eckd09c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09d  eckd09d;
label define eckd09d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09e  eckd09e;
label define eckd09e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10a  eckd10a;
label define eckd10a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10b  eckd10b;
label define eckd10b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10c  eckd10c;
label define eckd10c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10d  eckd10d;
label define eckd10d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10e  eckd10e;
label define eckd10e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11a  eckd11a;
label define eckd11a 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11b  eckd11b;
label define eckd11b 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11c  eckd11c;
label define eckd11c 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11d  eckd11d;
label define eckd11d 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11e  eckd11e;
label define eckd11e 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values accarea  accarea;
label define accarea 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accareb  accareb;
label define accareb 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accarec  accarec;
label define accarec 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accared  accared;
label define accared 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accaree  accaree;
label define accaree 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eckd03aa eckd03aa;
label define eckd03aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ab eckd03ab;
label define eckd03ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ac eckd03ac;
label define eckd03ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ad eckd03ad;
label define eckd03ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ae eckd03ae;
label define eckd03ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04aa eckd04aa;
label define eckd04aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ab eckd04ab;
label define eckd04ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ac eckd04ac;
label define eckd04ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ad eckd04ad;
label define eckd04ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ae eckd04ae;
label define eckd04ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05aa eckd05aa;
label define eckd05aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ab eckd05ab;
label define eckd05ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ac eckd05ac;
label define eckd05ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ad eckd05ad;
label define eckd05ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ae eckd05ae;
label define eckd05ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06aa eckd06aa;
label define eckd06aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ab eckd06ab;
label define eckd06ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ac eckd06ac;
label define eckd06ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ad eckd06ad;
label define eckd06ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ae eckd06ae;
label define eckd06ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07aa eckd07aa;
label define eckd07aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ab eckd07ab;
label define eckd07ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ac eckd07ac;
label define eckd07ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ad eckd07ad;
label define eckd07ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ae eckd07ae;
label define eckd07ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08aa eckd08aa;
label define eckd08aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ab eckd08ab;
label define eckd08ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ac eckd08ac;
label define eckd08ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ad eckd08ad;
label define eckd08ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ae eckd08ae;
label define eckd08ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09aa eckd09aa;
label define eckd09aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ab eckd09ab;
label define eckd09ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ac eckd09ac;
label define eckd09ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ad eckd09ad;
label define eckd09ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ae eckd09ae;
label define eckd09ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10aa eckd10aa;
label define eckd10aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ab eckd10ab;
label define eckd10ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ac eckd10ac;
label define eckd10ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ad eckd10ad;
label define eckd10ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ae eckd10ae;
label define eckd10ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11aa eckd11aa;
label define eckd11aa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ab eckd11ab;
label define eckd11ab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ac eckd11ac;
label define eckd11ac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ad eckd11ad;
label define eckd11ad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ae eckd11ae;
label define eckd11ae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values accare1a accare1a;
label define accare1a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1b accare1b;
label define accare1b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1c accare1c;
label define accare1c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1d accare1d;
label define accare1d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1e accare1e;
label define accare1e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhepara ewhepara;
label define ewhepara
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awhepara awhepara;
label define awhepara
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewheparb ewheparb;
label define ewheparb
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awheparb awheparb;
label define awheparb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewheparc ewheparc;
label define ewheparc
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awheparc awheparc;
label define awheparc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhepard ewhepard;
label define ewhepard
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awhepard awhepard;
label define awhepard
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhepare ewhepare;
label define ewhepare
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awhepare awhepare;
label define awhepare
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1a eparhr1a;
label define eparhr1a
	-1          "Not in universe"               
;
label values aparhr1a aparhr1a;
label define aparhr1a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1b eparhr1b;
label define eparhr1b
	-1          "Not in universe"               
;
label values aparhr1b aparhr1b;
label define aparhr1b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1c eparhr1c;
label define eparhr1c
	-1          "Not in universe"               
;
label values aparhr1c aparhr1c;
label define aparhr1c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1d eparhr1d;
label define eparhr1d
	-1          "Not in universe"               
;
label values aparhr1d aparhr1d;
label define aparhr1d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1e eparhr1e;
label define eparhr1e
	-1          "Not in universe"               
;
label values aparhr1e aparhr1e;
label define aparhr1e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfa ewhselfa;
label define ewhselfa
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfa awhselfa;
label define awhselfa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfb ewhselfb;
label define ewhselfb
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfb awhselfb;
label define awhselfb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfc ewhselfc;
label define ewhselfc
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfc awhselfc;
label define awhselfc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfd ewhselfd;
label define ewhselfd
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfd awhselfd;
label define awhselfd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfe ewhselfe;
label define ewhselfe
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfe awhselfe;
label define awhselfe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhra eselfhra;
label define eselfhra
	-1          "Not in universe"               
;
label values aselfhra aselfhra;
label define aselfhra
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrb eselfhrb;
label define eselfhrb
	-1          "Not in universe"               
;
label values aselfhrb aselfhrb;
label define aselfhrb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrc eselfhrc;
label define eselfhrc
	-1          "Not in universe"               
;
label values aselfhrc aselfhrc;
label define aselfhrc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrd eselfhrd;
label define eselfhrd
	-1          "Not in universe"               
;
label values aselfhrd aselfhrd;
label define aselfhrd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhre eselfhre;
label define eselfhre
	-1          "Not in universe"               
;
label values aselfhre aselfhre;
label define aselfhre
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb15a ewhsb15a;
label define ewhsb15a
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other  home"                   
	3           "Someplace else"                
;
label values awhsb15a awhsb15a;
label define awhsb15a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15b ewhsb15b;
label define ewhsb15b
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other  home"                   
	3           "Someplace else"                
;
label values awhsb15b awhsb15b;
label define awhsb15b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15c ewhsb15c;
label define ewhsb15c
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other  home"                   
	3           "Someplace else"                
;
label values awhsb15c awhsb15c;
label define awhsb15c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15d ewhsb15d;
label define ewhsb15d
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other  home"                   
	3           "Someplace else"                
;
label values awhsb15d awhsb15d;
label define awhsb15d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15e ewhsb15e;
label define ewhsb15e
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other  home"                   
	3           "Someplace else"                
;
label values awhsb15e awhsb15e;
label define awhsb15e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsbhra ewhsbhra;
label define ewhsbhra
	-1          "Not in universe"               
;
label values awhsbhra awhsbhra;
label define awhsbhra
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhrb ewhsbhrb;
label define ewhsbhrb
	-1          "Not in universe"               
;
label values awhsbhrb awhsbhrb;
label define awhsbhrb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhrc ewhsbhrc;
label define ewhsbhrc
	-1          "Not in universe"               
;
label values awhsbhrc awhsbhrc;
label define awhsbhrc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhrd ewhsbhrd;
label define ewhsbhrd
	-1          "Not in universe"               
;
label values awhsbhrd awhsbhrd;
label define awhsbhrd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhre ewhsbhre;
label define ewhsbhre
	-1          "Not in universe"               
;
label values awhsbhre awhsbhre;
label define awhsbhre
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14a ewhsb14a;
label define ewhsb14a
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14a awhsb14a;
label define awhsb14a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14b ewhsb14b;
label define ewhsb14b
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14b awhsb14b;
label define awhsb14b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14c ewhsb14c;
label define ewhsb14c
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14c awhsb14c;
label define awhsb14c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14d ewhsb14d;
label define ewhsb14d
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14d awhsb14d;
label define awhsb14d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14e ewhsb14e;
label define ewhsb14e
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14e awhsb14e;
label define awhsb14e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hra esb14hra;
label define esb14hra
	-1          "Not in universe"               
;
label values asb14hra asb14hra;
label define asb14hra
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrb esb14hrb;
label define esb14hrb
	-1          "Not in universe"               
;
label values asb14hrb asb14hrb;
label define asb14hrb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrc esb14hrc;
label define esb14hrc
	-1          "Not in universe"               
;
label values asb14hrc asb14hrc;
label define asb14hrc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrd esb14hrd;
label define esb14hrd
	-1          "Not in universe"               
;
label values asb14hrd asb14hrd;
label define asb14hrd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hre esb14hre;
label define esb14hre
	-1          "Not in universe"               
;
label values asb14hre asb14hre;
label define asb14hre
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgrana ewhgrana;
label define ewhgrana
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgrana awhgrana;
label define awhgrana
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgranb ewhgranb;
label define ewhgranb
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgranb awhgranb;
label define awhgranb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgranc ewhgranc;
label define ewhgranc
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgranc awhgranc;
label define awhgranc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgrand ewhgrand;
label define ewhgrand
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgrand awhgrand;
label define awhgrand
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgrane ewhgrane;
label define ewhgrane
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgrane awhgrane;
label define awhgrane
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhra egranhra;
label define egranhra
	-1          "Not in universe"               
;
label values agranhra agranhra;
label define agranhra
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrb egranhrb;
label define egranhrb
	-1          "Not in universe"               
;
label values agranhrb agranhrb;
label define agranhrb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrc egranhrc;
label define egranhrc
	-1          "Not in universe"               
;
label values agranhrc agranhrc;
label define agranhrc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrd egranhrd;
label define egranhrd
	-1          "Not in universe"               
;
label values agranhrd agranhrd;
label define agranhrd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhre egranhre;
label define egranhre
	-1          "Not in universe"               
;
label values agranhre agranhre;
label define agranhre
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygraa epaygraa;
label define epaygraa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygraa apaygraa;
label define apaygraa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrab epaygrab;
label define epaygrab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrab apaygrab;
label define apaygrab
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrac epaygrac;
label define epaygrac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrac apaygrac;
label define apaygrac
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrad epaygrad;
label define epaygrad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrad apaygrad;
label define apaygrad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrae epaygrae;
label define epaygrae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrae apaygrae;
label define apaygrae
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgraa tamtgraa;
label define tamtgraa
	0           "Not in universe"               
;
label values aamtgraa aamtgraa;
label define aamtgraa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrab tamtgrab;
label define tamtgrab
	0           "Not in universe"               
;
label values aamtgrab aamtgrab;
label define aamtgrab
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrac tamtgrac;
label define tamtgrac
	0           "Not in universe"               
;
label values aamtgrac aamtgrac;
label define aamtgrac
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrad tamtgrad;
label define tamtgrad
	0           "Not in universe"               
;
label values aamtgrad aamtgrad;
label define aamtgrad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrae tamtgrae;
label define tamtgrae
	0           "Not in universe"               
;
label values aamtgrae aamtgrae;
label define aamtgrae
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelaa ewhrelaa;
label define ewhrelaa
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelaa awhrelaa;
label define awhrelaa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelab ewhrelab;
label define ewhrelab
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelab awhrelab;
label define awhrelab
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelac ewhrelac;
label define ewhrelac
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelac awhrelac;
label define awhrelac
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelad ewhrelad;
label define ewhrelad
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelad awhrelad;
label define awhrelad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelae ewhrelae;
label define ewhrelae
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelae awhrelae;
label define awhrelae
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1a erelhr1a;
label define erelhr1a
	-1          "Not in universe"               
;
label values arelhr1a arelhr1a;
label define arelhr1a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1b erelhr1b;
label define erelhr1b
	-1          "Not in universe"               
;
label values arelhr1b arelhr1b;
label define arelhr1b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1c erelhr1c;
label define erelhr1c
	-1          "Not in universe"               
;
label values arelhr1c arelhr1c;
label define arelhr1c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1d erelhr1d;
label define erelhr1d
	-1          "Not in universe"               
;
label values arelhr1d arelhr1d;
label define arelhr1d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1e erelhr1e;
label define erelhr1e
	-1          "Not in universe"               
;
label values arelhr1e arelhr1e;
label define arelhr1e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrela epayrela;
label define epayrela
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrela apayrela;
label define apayrela
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrelb epayrelb;
label define epayrelb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrelb apayrelb;
label define apayrelb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrelc epayrelc;
label define epayrelc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrelc apayrelc;
label define apayrelc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayreld epayreld;
label define epayreld
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayreld apayreld;
label define apayreld
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrele epayrele;
label define epayrele
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrele apayrele;
label define apayrele
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrela tamtrela;
label define tamtrela
	0           "Not in universe"               
;
label values aamtrela aamtrela;
label define aamtrela
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrelb tamtrelb;
label define tamtrelb
	0           "Not in universe"               
;
label values aamtrelb aamtrelb;
label define aamtrelb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrelc tamtrelc;
label define tamtrelc
	0           "Not in universe"               
;
label values aamtrelc aamtrelc;
label define aamtrelc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtreld tamtreld;
label define tamtreld
	0           "Not in universe"               
;
label values aamtreld aamtreld;
label define aamtreld
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrele tamtrele;
label define tamtrele
	0           "Not in universe"               
;
label values aamtrele aamtrele;
label define aamtrele
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1a ehrfam1a;
label define ehrfam1a
	-1          "Not in universe"               
;
label values ahrfam1a ahrfam1a;
label define ahrfam1a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1b ehrfam1b;
label define ehrfam1b
	-1          "Not in universe"               
;
label values ahrfam1b ahrfam1b;
label define ahrfam1b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1c ehrfam1c;
label define ehrfam1c
	-1          "Not in universe"               
;
label values ahrfam1c ahrfam1c;
label define ahrfam1c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1d ehrfam1d;
label define ehrfam1d
	-1          "Not in universe"               
;
label values ahrfam1d ahrfam1d;
label define ahrfam1d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1e ehrfam1e;
label define ehrfam1e
	-1          "Not in universe"               
;
label values ahrfam1e ahrfam1e;
label define ahrfam1e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfama epayfama;
label define epayfama
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfama apayfama;
label define apayfama
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamb epayfamb;
label define epayfamb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamb apayfamb;
label define apayfamb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamc epayfamc;
label define epayfamc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamc apayfamc;
label define apayfamc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamd epayfamd;
label define epayfamd
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamd apayfamd;
label define apayfamd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfame epayfame;
label define epayfame
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfame apayfame;
label define apayfame
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfama tamtfama;
label define tamtfama
	0           "Not in universe"               
;
label values aamtfama aamtfama;
label define aamtfama
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical  imputation (derivation)"
;
label values tamtfamb tamtfamb;
label define tamtfamb
	0           "Not in universe"               
;
label values aamtfamb aamtfamb;
label define aamtfamb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfamc tamtfamc;
label define tamtfamc
	0           "Not in universe"               
;
label values aamtfamc aamtfamc;
label define aamtfamc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfamd tamtfamd;
label define tamtfamd
	0           "Not in universe"               
;
label values aamtfamd aamtfamd;
label define aamtfamd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfame tamtfame;
label define tamtfame
	0           "Not in universe"               
;
label values aamtfame aamtfame;
label define aamtfame
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdayca ewhdayca;
label define ewhdayca
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdayca awhdayca;
label define awhdayca
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaycb ewhdaycb;
label define ewhdaycb
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaycb awhdaycb;
label define awhdaycb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaycc ewhdaycc;
label define ewhdaycc
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaycc awhdaycc;
label define awhdaycc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaycd ewhdaycd;
label define ewhdaycd
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaycd awhdaycd;
label define awhdaycd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdayce ewhdayce;
label define ewhdayce
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdayce awhdayce;
label define awhdayce
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsa edayhrsa;
label define edayhrsa
	-1          "Not in universe"               
;
label values adayhrsa adayhrsa;
label define adayhrsa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsb edayhrsb;
label define edayhrsb
	-1          "Not in universe"               
;
label values adayhrsb adayhrsb;
label define adayhrsb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsc edayhrsc;
label define edayhrsc
	-1          "Not in universe"               
;
label values adayhrsc adayhrsc;
label define adayhrsc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsd edayhrsd;
label define edayhrsd
	-1          "Not in universe"               
;
label values adayhrsd adayhrsd;
label define adayhrsd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrse edayhrse;
label define edayhrse
	-1          "Not in universe"               
;
label values adayhrse adayhrse;
label define adayhrse
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydaya epaydaya;
label define epaydaya
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydaya apaydaya;
label define apaydaya
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayb epaydayb;
label define epaydayb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayb apaydayb;
label define apaydayb
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayc epaydayc;
label define epaydayc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayc apaydayc;
label define apaydayc
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayd epaydayd;
label define epaydayd
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayd apaydayd;
label define apaydayd
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydaye epaydaye;
label define epaydaye
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydaye apaydaye;
label define apaydaye
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdaya tamtdaya;
label define tamtdaya
	0           "Not in universe"               
;
label values aamtdaya aamtdaya;
label define aamtdaya
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayb tamtdayb;
label define tamtdayb
	0           "Not in universe"               
;
label values aamtdayb aamtdayb;
label define aamtdayb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayc tamtdayc;
label define tamtdayc
	0           "Not in universe"               
;
label values aamtdayc aamtdayc;
label define aamtdayc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayd tamtdayd;
label define tamtdayd
	0           "Not in universe"               
;
label values aamtdayd aamtdayd;
label define aamtdayd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdaye tamtdaye;
label define tamtdaye
	0           "Not in universe"               
;
label values aamtdaye aamtdaye;
label define aamtdaye
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhnursa ewhnursa;
label define ewhnursa
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhnursa awhnursa;
label define awhnursa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhnursb ewhnursb;
label define ewhnursb
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhnursb awhnursb;
label define awhnursb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhnursc ewhnursc;
label define ewhnursc
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhnursc awhnursc;
label define awhnursc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhnursd ewhnursd;
label define ewhnursd
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhnursd awhnursd;
label define awhnursd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhnurse ewhnurse;
label define ewhnurse
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhnurse awhnurse;
label define awhnurse
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enurhrsa enurhrsa;
label define enurhrsa
	-1          "Not in universe"               
;
label values anurhrsa anurhrsa;
label define anurhrsa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enurhrsb enurhrsb;
label define enurhrsb
	-1          "Not in universe"               
;
label values anurhrsb anurhrsb;
label define anurhrsb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enurhrsc enurhrsc;
label define enurhrsc
	-1          "Not in universe"               
;
label values anurhrsc anurhrsc;
label define anurhrsc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enurhrsd enurhrsd;
label define enurhrsd
	-1          "Not in universe"               
;
label values anurhrsd anurhrsd;
label define anurhrsd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enurhrse enurhrse;
label define enurhrse
	-1          "Not in universe"               
;
label values anurhrse anurhrse;
label define anurhrse
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaynura epaynura;
label define epaynura
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaynura apaynura;
label define apaynura
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaynurb epaynurb;
label define epaynurb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaynurb apaynurb;
label define apaynurb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaynurc epaynurc;
label define epaynurc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaynurc apaynurc;
label define apaynurc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaynurd epaynurd;
label define epaynurd
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaynurd apaynurd;
label define apaynurd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaynure epaynure;
label define epaynure
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaynure apaynure;
label define apaynure
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtnura tamtnura;
label define tamtnura
	0           "Not in universe"               
;
label values aamtnura aamtnura;
label define aamtnura
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtnurb tamtnurb;
label define tamtnurb
	0           "Not in universe"               
;
label values aamtnurb aamtnurb;
label define aamtnurb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtnurc tamtnurc;
label define tamtnurc
	0           "Not in universe"               
;
label values aamtnurc aamtnurc;
label define aamtnurc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtnurd tamtnurd;
label define tamtnurd
	0           "Not in universe"               
;
label values aamtnurd aamtnurd;
label define aamtnurd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtnure tamtnure;
label define tamtnure
	0           "Not in universe"               
;
label values aamtnure aamtnure;
label define aamtnure
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eheadhra eheadhra;
label define eheadhra
	-1          "Not in universe"               
;
label values aheadhra aheadhra;
label define aheadhra
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eheadhrb eheadhrb;
label define eheadhrb
	-1          "Not in universe"               
;
label values aheadhrb aheadhrb;
label define aheadhrb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eheadhrc eheadhrc;
label define eheadhrc
	-1          "Not in universe"               
;
label values aheadhrc aheadhrc;
label define aheadhrc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eheadhrd eheadhrd;
label define eheadhrd
	-1          "Not in universe"               
;
label values aheadhrd aheadhrd;
label define aheadhrd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eheadhre eheadhre;
label define eheadhre
	-1          "Not in universe"               
;
label values aheadhre aheadhre;
label define aheadhre
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaystaa epaystaa;
label define epaystaa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaystaa apaystaa;
label define apaystaa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaystab epaystab;
label define epaystab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaystab apaystab;
label define apaystab
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaystac epaystac;
label define epaystac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaystac apaystac;
label define apaystac
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaystad epaystad;
label define epaystad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaystad apaystad;
label define apaystad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaystae epaystae;
label define epaystae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaystae apaystae;
label define apaystae
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtstaa tamtstaa;
label define tamtstaa
	0           "Not in universe"               
;
label values aamtstaa aamtstaa;
label define aamtstaa
	0           "Not imputed"                   
	1           "Statistical imputation  (hot"  
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtstab tamtstab;
label define tamtstab
	0           "Not in universe"               
;
label values aamtstab aamtstab;
label define aamtstab
	0           "Not imputed"                   
	1           "Statistical imputation  (hot"  
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtstac tamtstac;
label define tamtstac
	0           "Not in universe"               
;
label values aamtstac aamtstac;
label define aamtstac
	0           "Not imputed"                   
	1           "Statistical imputation  (hot"  
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtstad tamtstad;
label define tamtstad
	0           "Not in universe"               
;
label values aamtstad aamtstad;
label define aamtstad
	0           "Not imputed"                   
	1           "Statistical imputation  (hot"  
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtstae tamtstae;
label define tamtstae
	0           "Not in universe"               
;
label values aamtstae aamtstae;
label define aamtstae
	0           "Not imputed"                   
	1           "Statistical imputation  (hot"  
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothea ewhothea;
label define ewhothea
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothea awhothea;
label define awhothea
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhotheb ewhotheb;
label define ewhotheb
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhotheb awhotheb;
label define awhotheb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothec ewhothec;
label define ewhothec
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothec awhothec;
label define awhothec
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothed ewhothed;
label define ewhothed
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothed awhothed;
label define awhothed
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothee ewhothee;
label define ewhothee
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothee awhothee;
label define awhothee
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehra eothehra;
label define eothehra
	-1          "Not in universe"               
;
label values aothehra aothehra;
label define aothehra
	0           "Not imputed"                   
	1           "Statical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrb eothehrb;
label define eothehrb
	-1          "Not in universe"               
;
label values aothehrb aothehrb;
label define aothehrb
	0           "Not imputed"                   
	1           "Statical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrc eothehrc;
label define eothehrc
	-1          "Not in universe"               
;
label values aothehrc aothehrc;
label define aothehrc
	0           "Not imputed"                   
	1           "Statical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrd eothehrd;
label define eothehrd
	-1          "Not in universe"               
;
label values aothehrd aothehrd;
label define aothehrd
	0           "Not imputed"                   
	1           "Statical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehre eothehre;
label define eothehre
	-1          "Not in universe"               
;
label values aothehre aothehre;
label define aothehre
	0           "Not imputed"                   
	1           "Statical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayotha epayotha;
label define epayotha
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayotha apayotha;
label define apayotha
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothb epayothb;
label define epayothb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothb apayothb;
label define apayothb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothc epayothc;
label define epayothc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothc apayothc;
label define apayothc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothd epayothd;
label define epayothd
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothd apayothd;
label define apayothd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothe epayothe;
label define epayothe
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothe apayothe;
label define apayothe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtotha tamtotha;
label define tamtotha
	0           "Not in universe"               
;
label values aamtotha aamtotha;
label define aamtotha
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothb tamtothb;
label define tamtothb
	0           "Not in universe"               
;
label values aamtothb aamtothb;
label define aamtothb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothc tamtothc;
label define tamtothc
	0           "Not in universe"               
;
label values aamtothc aamtothc;
label define aamtothc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothd tamtothd;
label define tamtothd
	0           "Not in universe"               
;
label values aamtothd aamtothd;
label define aamtothd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothe tamtothe;
label define tamtothe
	0           "Not in universe"               
;
label values aamtothe aamtothe;
label define aamtothe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowa eschoowa;
label define eschoowa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowa aschoowa;
label define aschoowa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowb eschoowb;
label define eschoowb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowb aschoowb;
label define aschoowb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowc eschoowc;
label define eschoowc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowc aschoowc;
label define aschoowc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowd eschoowd;
label define eschoowd
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowd aschoowd;
label define aschoowd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowe eschoowe;
label define eschoowe
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowe aschoowe;
label define aschoowe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwa ehrschwa;
label define ehrschwa
	-1          "Not in universe"               
;
label values ahrschwa ahrschwa;
label define ahrschwa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwb ehrschwb;
label define ehrschwb
	-1          "Not in universe"               
;
label values ahrschwb ahrschwb;
label define ahrschwb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwc ehrschwc;
label define ehrschwc
	-1          "Not in universe"               
;
label values ahrschwc ahrschwc;
label define ahrschwc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwd ehrschwd;
label define ehrschwd
	-1          "Not in universe"               
;
label values ahrschwd ahrschwd;
label define ahrschwd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwe ehrschwe;
label define ehrschwe
	-1          "Not in universe"               
;
label values ahrschwe ahrschwe;
label define ahrschwe
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcaa eselfcaa;
label define eselfcaa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcaa aselfcaa;
label define aselfcaa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcab eselfcab;
label define eselfcab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcab aselfcab;
label define aselfcab
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcac eselfcac;
label define eselfcac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcac aselfcac;
label define aselfcac
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcad eselfcad;
label define eselfcad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcad aselfcad;
label define aselfcad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcae eselfcae;
label define eselfcae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcae aselfcae;
label define aselfcae
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1a ekidhr1a;
label define ekidhr1a
	-1          "Not in universe"               
;
label values akidhr1a akidhr1a;
label define akidhr1a
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1b ekidhr1b;
label define ekidhr1b
	-1          "Not in universe"               
;
label values akidhr1b akidhr1b;
label define akidhr1b
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1c ekidhr1c;
label define ekidhr1c
	-1          "Not in universe"               
;
label values akidhr1c akidhr1c;
label define akidhr1c
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1d ekidhr1d;
label define ekidhr1d
	-1          "Not in universe"               
;
label values akidhr1d akidhr1d;
label define akidhr1d
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1e ekidhr1e;
label define ekidhr1e
	-1          "Not in universe"               
;
label values akidhr1e akidhr1e;
label define akidhr1e
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychaa edaychaa;
label define edaychaa
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychaa adaychaa;
label define adaychaa
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychab edaychab;
label define edaychab
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychab adaychab;
label define adaychab
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychac edaychac;
label define edaychac
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychac adaychac;
label define adaychac
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychad edaychad;
label define edaychad
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychad adaychad;
label define adaychad
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychae edaychae;
label define edaychae
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychae adaychae;
label define adaychae
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhela epayhela;
label define epayhela
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhela apayhela;
label define apayhela
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhelb epayhelb;
label define epayhelb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhelb apayhelb;
label define apayhelb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhelc epayhelc;
label define epayhelc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhelc apayhelc;
label define apayhelc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayheld epayheld;
label define epayheld
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayheld apayheld;
label define apayheld
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhele epayhele;
label define epayhele
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhele apayhele;
label define apayhele
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhopa1a ewhopa1a;
label define ewhopa1a
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1b ewhopa1b;
label define ewhopa1b
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1c ewhopa1c;
label define ewhopa1c
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1d ewhopa1d;
label define ewhopa1d
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1e ewhopa1e;
label define ewhopa1e
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2a ewhopa2a;
label define ewhopa2a
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2b ewhopa2b;
label define ewhopa2b
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2c ewhopa2c;
label define ewhopa2c
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2d ewhopa2d;
label define ewhopa2d
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2e ewhopa2e;
label define ewhopa2e
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3a ewhopa3a;
label define ewhopa3a
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3b ewhopa3b;
label define ewhopa3b
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3c ewhopa3c;
label define ewhopa3c
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3d ewhopa3d;
label define ewhopa3d
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3e ewhopa3e;
label define ewhopa3e
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4a ewhopa4a;
label define ewhopa4a
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4b ewhopa4b;
label define ewhopa4b
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4c ewhopa4c;
label define ewhopa4c
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4d ewhopa4d;
label define ewhopa4d
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4e ewhopa4e;
label define ewhopa4e
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awhopaa  awhopaa;
label define awhopaa 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopab  awhopab;
label define awhopab 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopac  awhopac;
label define awhopac 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopad  awhopad;
label define awhopad 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopae  awhopae;
label define awhopae 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earranga earranga;
label define earranga
	-1          "Not in universe"               
;
label values aarranga aarranga;
label define aarranga
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangb earrangb;
label define earrangb
	-1          "Not in universe"               
;
label values aarrangb aarrangb;
label define aarrangb
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangc earrangc;
label define earrangc
	-1          "Not in universe"               
;
label values aarrangc aarrangc;
label define aarrangc
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangd earrangd;
label define earrangd
	-1          "Not in universe"               
;
label values aarrangd aarrangd;
label define aarrangd
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrange earrange;
label define earrange
	-1          "Not in universe"               
;
label values aarrange aarrange;
label define aarrange
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eccunv2  eccunv2l;
label define eccunv2l
	-1          "Not in Universe"               
	1           "In universe"                   
;
label values eccpnumf eccpnumf;
label define eccpnumf
	-1          "Not in universe"               
;
label values eccpnumg eccpnumg;
label define eccpnumg
	-1          "Not in universe"               
;
label values eccpnumh eccpnumh;
label define eccpnumh
	-1          "Not in universe"               
;
label values eccpnumi eccpnumi;
label define eccpnumi
	-1          "Not in universe"               
;
label values eccpnumj eccpnumj;
label define eccpnumj
	-1          "Not in universe"               
;
label values eccagef  eccagef;
label define eccagef 
	-1          "Not in universe"               
;
label values eccageg  eccageg;
label define eccageg 
	-1          "Not in universe"               
;
label values eccageh  eccageh;
label define eccageh 
	-1          "Not in universe"               
;
label values eccagei  eccagei;
label define eccagei 
	-1          "Not in universe"               
;
label values eccagej  eccagej;
label define eccagej 
	-1          "Not in universe"               
;
label values eckd01f  eckd01f;
label define eckd01f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01g  eckd01g;
label define eckd01g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01h  eckd01h;
label define eckd01h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01i  eckd01i;
label define eckd01i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd01j  eckd01j;
label define eckd01j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02f  eckd02f;
label define eckd02f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02g  eckd02g;
label define eckd02g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02h  eckd02h;
label define eckd02h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02i  eckd02i;
label define eckd02i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd02j  eckd02j;
label define eckd02j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03f  eckd03f;
label define eckd03f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03g  eckd03g;
label define eckd03g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03h  eckd03h;
label define eckd03h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03i  eckd03i;
label define eckd03i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03j  eckd03j;
label define eckd03j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04f  eckd04f;
label define eckd04f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04g  eckd04g;
label define eckd04g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04h  eckd04h;
label define eckd04h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04i  eckd04i;
label define eckd04i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04j  eckd04j;
label define eckd04j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05f  eckd05f;
label define eckd05f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05g  eckd05g;
label define eckd05g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05h  eckd05h;
label define eckd05h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05i  eckd05i;
label define eckd05i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05j  eckd05j;
label define eckd05j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06f  eckd06f;
label define eckd06f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06g  eckd06g;
label define eckd06g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06h  eckd06h;
label define eckd06h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06i  eckd06i;
label define eckd06i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06j  eckd06j;
label define eckd06j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07f  eckd07f;
label define eckd07f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07g  eckd07g;
label define eckd07g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07h  eckd07h;
label define eckd07h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07i  eckd07i;
label define eckd07i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07j  eckd07j;
label define eckd07j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08f  eckd08f;
label define eckd08f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08g  eckd08g;
label define eckd08g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08h  eckd08h;
label define eckd08h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08i  eckd08i;
label define eckd08i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08j  eckd08j;
label define eckd08j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09f  eckd09f;
label define eckd09f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09g  eckd09g;
label define eckd09g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09h  eckd09h;
label define eckd09h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09i  eckd09i;
label define eckd09i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09j  eckd09j;
label define eckd09j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10f  eckd10f;
label define eckd10f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10g  eckd10g;
label define eckd10g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10h  eckd10h;
label define eckd10h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10i  eckd10i;
label define eckd10i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10j  eckd10j;
label define eckd10j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11f  eckd11f;
label define eckd11f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11g  eckd11g;
label define eckd11g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11h  eckd11h;
label define eckd11h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11i  eckd11i;
label define eckd11i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11j  eckd11j;
label define eckd11j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12f  eckd12f;
label define eckd12f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12g  eckd12g;
label define eckd12g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12h  eckd12h;
label define eckd12h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12i  eckd12i;
label define eckd12i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12j  eckd12j;
label define eckd12j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13f  eckd13f;
label define eckd13f 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13g  eckd13g;
label define eckd13g 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13h  eckd13h;
label define eckd13h 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13i  eckd13i;
label define eckd13i 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13j  eckd13j;
label define eckd13j 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values accaref  accaref;
label define accaref 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accareg  accareg;
label define accareg 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accareh  accareh;
label define accareh 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accarei  accarei;
label define accarei 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accarej  accarej;
label define accarej 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eckd03af eckd03af;
label define eckd03af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ag eckd03ag;
label define eckd03ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ah eckd03ah;
label define eckd03ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03ai eckd03ai;
label define eckd03ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd03aj eckd03aj;
label define eckd03aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04af eckd04af;
label define eckd04af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ag eckd04ag;
label define eckd04ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ah eckd04ah;
label define eckd04ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04ai eckd04ai;
label define eckd04ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd04aj eckd04aj;
label define eckd04aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05af eckd05af;
label define eckd05af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ag eckd05ag;
label define eckd05ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ah eckd05ah;
label define eckd05ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05ai eckd05ai;
label define eckd05ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd05aj eckd05aj;
label define eckd05aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06af eckd06af;
label define eckd06af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ag eckd06ag;
label define eckd06ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ah eckd06ah;
label define eckd06ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06ai eckd06ai;
label define eckd06ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd06aj eckd06aj;
label define eckd06aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07af eckd07af;
label define eckd07af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ag eckd07ag;
label define eckd07ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ah eckd07ah;
label define eckd07ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07ai eckd07ai;
label define eckd07ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd07aj eckd07aj;
label define eckd07aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08af eckd08af;
label define eckd08af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ag eckd08ag;
label define eckd08ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ah eckd08ah;
label define eckd08ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08ai eckd08ai;
label define eckd08ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd08aj eckd08aj;
label define eckd08aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09af eckd09af;
label define eckd09af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ag eckd09ag;
label define eckd09ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ah eckd09ah;
label define eckd09ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09ai eckd09ai;
label define eckd09ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd09aj eckd09aj;
label define eckd09aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10af eckd10af;
label define eckd10af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ag eckd10ag;
label define eckd10ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ah eckd10ah;
label define eckd10ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10ai eckd10ai;
label define eckd10ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd10aj eckd10aj;
label define eckd10aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11af eckd11af;
label define eckd11af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ag eckd11ag;
label define eckd11ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ah eckd11ah;
label define eckd11ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11ai eckd11ai;
label define eckd11ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd11aj eckd11aj;
label define eckd11aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12af eckd12af;
label define eckd12af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12ag eckd12ag;
label define eckd12ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12ah eckd12ah;
label define eckd12ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12ai eckd12ai;
label define eckd12ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd12aj eckd12aj;
label define eckd12aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13af eckd13af;
label define eckd13af
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13ag eckd13ag;
label define eckd13ag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13ah eckd13ah;
label define eckd13ah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13ai eckd13ai;
label define eckd13ai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eckd13aj eckd13aj;
label define eckd13aj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values accare1f accare1f;
label define accare1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1g accare1g;
label define accare1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1h accare1h;
label define accare1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1i accare1i;
label define accare1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values accare1j accare1j;
label define accare1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewheparf ewheparf;
label define ewheparf
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awheparf awheparf;
label define awheparf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewheparg ewheparg;
label define ewheparg
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awheparg awheparg;
label define awheparg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewheparh ewheparh;
label define ewheparh
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awheparh awheparh;
label define awheparh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhepari ewhepari;
label define ewhepari
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awhepari awhepari;
label define awhepari
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewheparj ewheparj;
label define ewheparj
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other parent's home (parent"   
	3           "Another person's home"         
	4           "Someplace else"                
;
label values awheparj awheparj;
label define awheparj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1f eparhr1f;
label define eparhr1f
	-1          "Not in universe"               
;
label values aparhr1f aparhr1f;
label define aparhr1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1g eparhr1g;
label define eparhr1g
	-1          "Not in universe"               
;
label values aparhr1g aparhr1g;
label define aparhr1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1h eparhr1h;
label define eparhr1h
	-1          "Not in universe"               
;
label values aparhr1h aparhr1h;
label define aparhr1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1i eparhr1i;
label define eparhr1i
	-1          "Not in universe"               
;
label values aparhr1i aparhr1i;
label define aparhr1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eparhr1j eparhr1j;
label define eparhr1j
	-1          "Not in universe"               
;
label values aparhr1j aparhr1j;
label define aparhr1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselff ewhselff;
label define ewhselff
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselff awhselff;
label define awhselff
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfg ewhselfg;
label define ewhselfg
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfg awhselfg;
label define awhselfg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfh ewhselfh;
label define ewhselfh
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfh awhselfh;
label define awhselfh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfi ewhselfi;
label define ewhselfi
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfi awhselfi;
label define awhselfi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhselfj ewhselfj;
label define ewhselfj
	-1          "Not in universe"               
	1           "In the person's home"          
	2           "At work or at school"          
	3           "Someplace else"                
;
label values awhselfj awhselfj;
label define awhselfj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrf eselfhrf;
label define eselfhrf
	-1          "Not in universe"               
;
label values aselfhrf aselfhrf;
label define aselfhrf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrg eselfhrg;
label define eselfhrg
	-1          "Not in universe"               
;
label values aselfhrg aselfhrg;
label define aselfhrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrh eselfhrh;
label define eselfhrh
	-1          "Not in universe"               
;
label values aselfhrh aselfhrh;
label define aselfhrh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhri eselfhri;
label define eselfhri
	-1          "Not in universe"               
;
label values aselfhri aselfhri;
label define aselfhri
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfhrj eselfhrj;
label define eselfhrj
	-1          "Not in universe"               
;
label values aselfhrj aselfhrj;
label define aselfhrj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb15f ewhsb15f;
label define ewhsb15f
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb15f awhsb15f;
label define awhsb15f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15g ewhsb15g;
label define ewhsb15g
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb15g awhsb15g;
label define awhsb15g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15h ewhsb15h;
label define ewhsb15h
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb15h awhsb15h;
label define awhsb15h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15i ewhsb15i;
label define ewhsb15i
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb15i awhsb15i;
label define awhsb15i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsb15j ewhsb15j;
label define ewhsb15j
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb15j awhsb15j;
label define awhsb15j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation derivation" 
;
label values ewhsbhrf ewhsbhrf;
label define ewhsbhrf
	-1          "Not in universe"               
;
label values awhsbhrf awhsbhrf;
label define awhsbhrf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhrg ewhsbhrg;
label define ewhsbhrg
	-1          "Not in universe"               
;
label values awhsbhrg awhsbhrg;
label define awhsbhrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhrh ewhsbhrh;
label define ewhsbhrh
	-1          "Not in universe"               
;
label values awhsbhrh awhsbhrh;
label define awhsbhrh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhri ewhsbhri;
label define ewhsbhri
	-1          "Not in universe"               
;
label values awhsbhri awhsbhri;
label define awhsbhri
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsbhrj ewhsbhrj;
label define ewhsbhrj
	-1          "Not in universe"               
;
label values awhsbhrj awhsbhrj;
label define awhsbhrj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14f ewhsb14f;
label define ewhsb14f
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14f awhsb14f;
label define awhsb14f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14g ewhsb14g;
label define ewhsb14g
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14g awhsb14g;
label define awhsb14g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14h ewhsb14h;
label define ewhsb14h
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14h awhsb14h;
label define awhsb14h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14i ewhsb14i;
label define ewhsb14i
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14i awhsb14i;
label define awhsb14i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsb14j ewhsb14j;
label define ewhsb14j
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Other home"                    
	3           "Someplace else"                
;
label values awhsb14j awhsb14j;
label define awhsb14j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrf esb14hrf;
label define esb14hrf
	-1          "Not in universe"               
;
label values asb14hrf asb14hrf;
label define asb14hrf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrg esb14hrg;
label define esb14hrg
	-1          "Not in universe"               
;
label values asb14hrg asb14hrg;
label define asb14hrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrh esb14hrh;
label define esb14hrh
	-1          "Not in universe"               
;
label values asb14hrh asb14hrh;
label define asb14hrh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hri esb14hri;
label define esb14hri
	-1          "Not in universe"               
;
label values asb14hri asb14hri;
label define asb14hri
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esb14hrj esb14hrj;
label define esb14hrj
	-1          "Not in universe"               
;
label values asb14hrj asb14hrj;
label define asb14hrj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgranf ewhgranf;
label define ewhgranf
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgranf awhgranf;
label define awhgranf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgrang ewhgrang;
label define ewhgrang
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgrang awhgrang;
label define awhgrang
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgranh ewhgranh;
label define ewhgranh
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgranh awhgranh;
label define awhgranh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgrani ewhgrani;
label define ewhgrani
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgrani awhgrani;
label define awhgrani
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhgranj ewhgranj;
label define ewhgranj
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "Grandparent's home"            
	3           "Someplace else"                
;
label values awhgranj awhgranj;
label define awhgranj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrf egranhrf;
label define egranhrf
	-1          "Not in universe"               
;
label values agranhrf agranhrf;
label define agranhrf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrg egranhrg;
label define egranhrg
	-1          "Not in universe"               
;
label values agranhrg agranhrg;
label define agranhrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrh egranhrh;
label define egranhrh
	-1          "Not in universe"               
;
label values agranhrh agranhrh;
label define agranhrh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhri egranhri;
label define egranhri
	-1          "Not in universe"               
;
label values agranhri agranhri;
label define agranhri
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values egranhrj egranhrj;
label define egranhrj
	-1          "Not in universe"               
;
label values agranhrj agranhrj;
label define agranhrj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygraf epaygraf;
label define epaygraf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygraf apaygraf;
label define apaygraf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrag epaygrag;
label define epaygrag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrag apaygrag;
label define apaygrag
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrah epaygrah;
label define epaygrah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrah apaygrah;
label define apaygrah
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygrai epaygrai;
label define epaygrai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygrai apaygrai;
label define apaygrai
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaygraj epaygraj;
label define epaygraj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaygraj apaygraj;
label define apaygraj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgraf tamtgraf;
label define tamtgraf
	0           "Not in universe"               
;
label values aamtgraf aamtgraf;
label define aamtgraf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrag tamtgrag;
label define tamtgrag
	0           "Not in universe"               
;
label values aamtgrag aamtgrag;
label define aamtgrag
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrah tamtgrah;
label define tamtgrah
	0           "Not in universe"               
;
label values aamtgrah aamtgrah;
label define aamtgrah
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgrai tamtgrai;
label define tamtgrai
	0           "Not in universe"               
;
label values aamtgrai aamtgrai;
label define aamtgrai
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtgraj tamtgraj;
label define tamtgraj
	0           "Not in universe"               
;
label values aamtgraj aamtgraj;
label define aamtgraj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelaf ewhrelaf;
label define ewhrelaf
	-1          "Not in Universe"               
	0           "None or not in universe"       
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelaf awhrelaf;
label define awhrelaf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelag ewhrelag;
label define ewhrelag
	-1          "Not in Universe"               
	0           "None or not in universe"       
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelag awhrelag;
label define awhrelag
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelah ewhrelah;
label define ewhrelah
	-1          "Not in Universe"               
	0           "None or not in universe"       
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelah awhrelah;
label define awhrelah
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelai ewhrelai;
label define ewhrelai
	-1          "Not in Universe"               
	0           "None or not in universe"       
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelai awhrelai;
label define awhrelai
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhrelaj ewhrelaj;
label define ewhrelaj
	-1          "Not in Universe"               
	0           "None or not in universe"       
	1           "Child's home"                  
	2           "Other relative's home"         
	3           "Someplace else"                
;
label values awhrelaj awhrelaj;
label define awhrelaj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1f erelhr1f;
label define erelhr1f
	-1          "Not in universe"               
;
label values arelhr1f arelhr1f;
label define arelhr1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1g erelhr1g;
label define erelhr1g
	-1          "Not in universe"               
;
label values arelhr1g arelhr1g;
label define arelhr1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1h erelhr1h;
label define erelhr1h
	-1          "Not in universe"               
;
label values arelhr1h arelhr1h;
label define arelhr1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1i erelhr1i;
label define erelhr1i
	-1          "Not in universe"               
;
label values arelhr1i arelhr1i;
label define arelhr1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelhr1j erelhr1j;
label define erelhr1j
	-1          "Not in universe"               
;
label values arelhr1j arelhr1j;
label define arelhr1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrelf epayrelf;
label define epayrelf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrelf apayrelf;
label define apayrelf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrelg epayrelg;
label define epayrelg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrelg apayrelg;
label define apayrelg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrelh epayrelh;
label define epayrelh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrelh apayrelh;
label define apayrelh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayreli epayreli;
label define epayreli
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayreli apayreli;
label define apayreli
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayrelj epayrelj;
label define epayrelj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayrelj apayrelj;
label define apayrelj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrelf tamtrelf;
label define tamtrelf
	0           "Not in universe"               
;
label values aamtrelf aamtrelf;
label define aamtrelf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrelg tamtrelg;
label define tamtrelg
	0           "Not in universe"               
;
label values aamtrelg aamtrelg;
label define aamtrelg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrelh tamtrelh;
label define tamtrelh
	0           "Not in universe"               
;
label values aamtrelh aamtrelh;
label define aamtrelh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtreli tamtreli;
label define tamtreli
	0           "Not in universe"               
;
label values aamtreli aamtreli;
label define aamtreli
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtrelj tamtrelj;
label define tamtrelj
	0           "Not in universe"               
;
label values aamtrelj aamtrelj;
label define aamtrelj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1f ehrfam1f;
label define ehrfam1f
	-1          "Not in universe"               
;
label values ahrfam1f ahrfam1f;
label define ahrfam1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1g ehrfam1g;
label define ehrfam1g
	-1          "Not in universe"               
;
label values ahrfam1g ahrfam1g;
label define ahrfam1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1h ehrfam1h;
label define ehrfam1h
	-1          "Not in universe"               
;
label values ahrfam1h ahrfam1h;
label define ahrfam1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1i ehrfam1i;
label define ehrfam1i
	-1          "Not in universe"               
;
label values ahrfam1i ahrfam1i;
label define ahrfam1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrfam1j ehrfam1j;
label define ehrfam1j
	-1          "Not in universe"               
;
label values ahrfam1j ahrfam1j;
label define ahrfam1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamf epayfamf;
label define epayfamf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamf apayfamf;
label define apayfamf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamg epayfamg;
label define epayfamg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamg apayfamg;
label define apayfamg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamh epayfamh;
label define epayfamh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamh apayfamh;
label define apayfamh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfami epayfami;
label define epayfami
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfami apayfami;
label define apayfami
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayfamj epayfamj;
label define epayfamj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayfamj apayfamj;
label define apayfamj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfamf tamtfamf;
label define tamtfamf
	0           "Not in universe"               
;
label values aamtfamf aamtfamf;
label define aamtfamf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical  imputation (derivation)"
;
label values tamtfamg tamtfamg;
label define tamtfamg
	0           "Not in universe"               
;
label values aamtfamg aamtfamg;
label define aamtfamg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfamh tamtfamh;
label define tamtfamh
	0           "Not in universe"               
;
label values aamtfamh aamtfamh;
label define aamtfamh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfami tamtfami;
label define tamtfami
	0           "Not in universe"               
;
label values aamtfami aamtfami;
label define aamtfami
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtfamj tamtfamj;
label define tamtfamj
	0           "Not in universe"               
;
label values aamtfamj aamtfamj;
label define aamtfamj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaycf ewhdaycf;
label define ewhdaycf
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaycf awhdaycf;
label define awhdaycf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaycg ewhdaycg;
label define ewhdaycg
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaycg awhdaycg;
label define awhdaycg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaych ewhdaych;
label define ewhdaych
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaych awhdaych;
label define awhdaych
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdayci ewhdayci;
label define ewhdayci
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdayci awhdayci;
label define awhdayci
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhdaycj ewhdaycj;
label define ewhdaycj
	-1          "Not in universe"               
	1           "At work or at school"          
	2           "Someplace else, including"     
;
label values awhdaycj awhdaycj;
label define awhdaycj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsf edayhrsf;
label define edayhrsf
	-1          "Not in universe"               
;
label values adayhrsf adayhrsf;
label define adayhrsf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsg edayhrsg;
label define edayhrsg
	-1          "Not in universe"               
;
label values adayhrsg adayhrsg;
label define adayhrsg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsh edayhrsh;
label define edayhrsh
	-1          "Not in universe"               
;
label values adayhrsh adayhrsh;
label define adayhrsh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsi edayhrsi;
label define edayhrsi
	-1          "Not in universe"               
;
label values adayhrsi adayhrsi;
label define adayhrsi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edayhrsj edayhrsj;
label define edayhrsj
	-1          "Not in universe"               
;
label values adayhrsj adayhrsj;
label define adayhrsj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayf epaydayf;
label define epaydayf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayf apaydayf;
label define apaydayf
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayg epaydayg;
label define epaydayg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayg apaydayg;
label define apaydayg
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayh epaydayh;
label define epaydayh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayh apaydayh;
label define apaydayh
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayi epaydayi;
label define epaydayi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayi apaydayi;
label define apaydayi
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaydayj epaydayj;
label define epaydayj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaydayj apaydayj;
label define apaydayj
	0           "None or not imputed"           
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayf tamtdayf;
label define tamtdayf
	0           "Not in universe"               
;
label values aamtdayf aamtdayf;
label define aamtdayf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayg tamtdayg;
label define tamtdayg
	0           "Not in universe"               
;
label values aamtdayg aamtdayg;
label define aamtdayg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayh tamtdayh;
label define tamtdayh
	0           "Not in universe"               
;
label values aamtdayh aamtdayh;
label define aamtdayh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayi tamtdayi;
label define tamtdayi
	0           "Not in universe"               
;
label values aamtdayi aamtdayi;
label define aamtdayi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtdayj tamtdayj;
label define tamtdayj
	0           "Not in universe"               
;
label values aamtdayj aamtdayj;
label define aamtdayj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsporf ewhsporf;
label define ewhsporf
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhsporf awhsporf;
label define awhsporf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsporg ewhsporg;
label define ewhsporg
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhsporg awhsporg;
label define awhsporg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsporh ewhsporh;
label define ewhsporh
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhsporh awhsporh;
label define awhsporh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhspori ewhspori;
label define ewhspori
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhspori awhspori;
label define awhspori
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhsporj ewhsporj;
label define ewhsporj
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhsporj awhsporj;
label define awhsporj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehsportf ehsportf;
label define ehsportf
	-1          "Not in universe"               
;
label values ahsportf ahsportf;
label define ahsportf
	0           "Not imputated"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehsportg ehsportg;
label define ehsportg
	-1          "Not in universe"               
;
label values ahsportg ahsportg;
label define ahsportg
	0           "Not imputated"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehsporth ehsporth;
label define ehsporth
	-1          "Not in universe"               
;
label values ahsporth ahsporth;
label define ahsporth
	0           "Not imputated"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehsporti ehsporti;
label define ehsporti
	-1          "Not in universe"               
;
label values ahsporti ahsporti;
label define ahsporti
	0           "Not imputated"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehsportj ehsportj;
label define ehsportj
	-1          "Not in universe"               
;
label values ahsportj ahsportj;
label define ahsportj
	0           "Not imputated"                 
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayspof epayspof;
label define epayspof
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayspof apayspof;
label define apayspof
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayspog epayspog;
label define epayspog
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayspog apayspog;
label define apayspog
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayspoh epayspoh;
label define epayspoh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayspoh apayspoh;
label define apayspoh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayspoi epayspoi;
label define epayspoi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayspoi apayspoi;
label define apayspoi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayspoj epayspoj;
label define epayspoj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayspoj apayspoj;
label define apayspoj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtspof tamtspof;
label define tamtspof
	0           "Not in universe"               
;
label values aamtspof aamtspof;
label define aamtspof
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtspog tamtspog;
label define tamtspog
	0           "Not in universe"               
;
label values aamtspog aamtspog;
label define aamtspog
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtspoh tamtspoh;
label define tamtspoh
	0           "Not in universe"               
;
label values aamtspoh aamtspoh;
label define aamtspoh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtspoi tamtspoi;
label define tamtspoi
	0           "Not in universe"               
;
label values aamtspoi aamtspoi;
label define aamtspoi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtspoj tamtspoj;
label define tamtspoj
	0           "Not in universe"               
;
label values aamtspoj aamtspoj;
label define aamtspoj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhlessf ewhlessf;
label define ewhlessf
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhlessf awhlessf;
label define awhlessf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhlessg ewhlessg;
label define ewhlessg
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhlessg awhlessg;
label define awhlessg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhlessh ewhlessh;
label define ewhlessh
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhlessh awhlessh;
label define awhlessh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhlessi ewhlessi;
label define ewhlessi
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhlessi awhlessi;
label define awhlessi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhlessj ewhlessj;
label define ewhlessj
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhlessj awhlessj;
label define awhlessj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrles1f ehrles1f;
label define ehrles1f
	-1          "Not in universe"               
;
label values ahrles1f ahrles1f;
label define ahrles1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrles1g ehrles1g;
label define ehrles1g
	-1          "Not in universe"               
;
label values ahrles1g ahrles1g;
label define ahrles1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrles1h ehrles1h;
label define ehrles1h
	-1          "Not in universe"               
;
label values ahrles1h ahrles1h;
label define ahrles1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrles1i ehrles1i;
label define ehrles1i
	-1          "Not in universe"               
;
label values ahrles1i ahrles1i;
label define ahrles1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrles1j ehrles1j;
label define ehrles1j
	-1          "Not in universe"               
;
label values ahrles1j ahrles1j;
label define ahrles1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaylesf epaylesf;
label define epaylesf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaylesf apaylesf;
label define apaylesf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaylesg epaylesg;
label define epaylesg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaylesg apaylesg;
label define apaylesg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaylesh epaylesh;
label define epaylesh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaylesh apaylesh;
label define apaylesh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaylesi epaylesi;
label define epaylesi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaylesi apaylesi;
label define apaylesi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaylesj epaylesj;
label define epaylesj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaylesj apaylesj;
label define apaylesj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtlesf tamtlesf;
label define tamtlesf
	0           "Not in universe"               
;
label values aamtlesf aamtlesf;
label define aamtlesf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtlesg tamtlesg;
label define tamtlesg
	0           "Not in universe"               
;
label values aamtlesg aamtlesg;
label define aamtlesg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtlesh tamtlesh;
label define tamtlesh
	0           "Not in universe"               
;
label values aamtlesh aamtlesh;
label define aamtlesh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtlesi tamtlesi;
label define tamtlesi
	0           "Not in universe"               
;
label values aamtlesi aamtlesi;
label define aamtlesi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtlesj tamtlesj;
label define tamtlesj
	0           "Not in universe"               
;
label values aamtlesj aamtlesj;
label define aamtlesj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhclubf ewhclubf;
label define ewhclubf
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhclubf awhclubf;
label define awhclubf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhclubg ewhclubg;
label define ewhclubg
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhclubg awhclubg;
label define awhclubg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhclubh ewhclubh;
label define ewhclubh
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhclubh awhclubh;
label define awhclubh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhclubi ewhclubi;
label define ewhclubi
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhclubi awhclubi;
label define awhclubi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhclubj ewhclubj;
label define ewhclubj
	-1          "Not in universe"               
	1           "At school"                     
	2           "Someplace else"                
;
label values awhclubj awhclubj;
label define awhclubj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eclubhrf eclubhrf;
label define eclubhrf
	-1          "Not in universe"               
;
label values aclubhrf aclubhrf;
label define aclubhrf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eclubhrg eclubhrg;
label define eclubhrg
	-1          "Not in universe"               
;
label values aclubhrg aclubhrg;
label define aclubhrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eclubhrh eclubhrh;
label define eclubhrh
	-1          "Not in universe"               
;
label values aclubhrh aclubhrh;
label define aclubhrh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eclubhri eclubhri;
label define eclubhri
	-1          "Not in universe"               
;
label values aclubhri aclubhri;
label define aclubhri
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eclubhrj eclubhrj;
label define eclubhrj
	-1          "Not in universe"               
;
label values aclubhrj aclubhrj;
label define aclubhrj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaycluf epaycluf;
label define epaycluf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaycluf apaycluf;
label define apaycluf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayclug epayclug;
label define epayclug
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayclug apayclug;
label define apayclug
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaycluh epaycluh;
label define epaycluh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaycluh apaycluh;
label define apaycluh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayclui epayclui;
label define epayclui
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayclui apayclui;
label define apayclui
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epaycluj epaycluj;
label define epaycluj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apaycluj apaycluj;
label define apaycluj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtcluf tamtcluf;
label define tamtcluf
	0           "Not in universe"               
;
label values aamtcluf aamtcluf;
label define aamtcluf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtclug tamtclug;
label define tamtclug
	0           "Not in universe"               
;
label values aamtclug aamtclug;
label define aamtclug
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtcluh tamtcluh;
label define tamtcluh
	0           "Not in universe"               
;
label values aamtcluh aamtcluh;
label define aamtcluh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtclui tamtclui;
label define tamtclui
	0           "Not in universe"               
;
label values aamtclui aamtclui;
label define aamtclui
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtcluj tamtcluj;
label define tamtcluj
	0           "Not in universe"               
;
label values aamtcluj aamtcluj;
label define aamtcluj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhschof ewhschof;
label define ewhschof
	-1          "Not in universe"               
	1           "At work or school"             
	2           "At child's school"             
	3           "Someplace else"                
;
label values awhschof awhschof;
label define awhschof
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhschog ewhschog;
label define ewhschog
	-1          "Not in universe"               
	1           "At work or school"             
	2           "At child's school"             
	3           "Someplace else"                
;
label values awhschog awhschog;
label define awhschog
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhschoh ewhschoh;
label define ewhschoh
	-1          "Not in universe"               
	1           "At work or school"             
	2           "At child's school"             
	3           "Someplace else"                
;
label values awhschoh awhschoh;
label define awhschoh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhschoi ewhschoi;
label define ewhschoi
	-1          "Not in universe"               
	1           "At work or school"             
	2           "At child's school"             
	3           "Someplace else"                
;
label values awhschoi awhschoi;
label define awhschoi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhschoj ewhschoj;
label define ewhschoj
	-1          "Not in universe"               
	1           "At work or school"             
	2           "At child's school"             
	3           "Someplace else"                
;
label values awhschoj awhschoj;
label define awhschoj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehscho1f ehscho1f;
label define ehscho1f
	-1          "Not in universe"               
;
label values ahscho1f ahscho1f;
label define ahscho1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehscho1g ehscho1g;
label define ehscho1g
	-1          "Not in universe"               
;
label values ahscho1g ahscho1g;
label define ahscho1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehscho1h ehscho1h;
label define ehscho1h
	-1          "Not in universe"               
;
label values ahscho1h ahscho1h;
label define ahscho1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehscho1i ehscho1i;
label define ehscho1i
	-1          "Not in universe"               
;
label values ahscho1i ahscho1i;
label define ahscho1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehscho1j ehscho1j;
label define ehscho1j
	-1          "Not in universe"               
;
label values ahscho1j ahscho1j;
label define ahscho1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayschf epayschf;
label define epayschf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayschf apayschf;
label define apayschf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayschg epayschg;
label define epayschg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayschg apayschg;
label define apayschg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayschh epayschh;
label define epayschh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayschh apayschh;
label define apayschh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayschi epayschi;
label define epayschi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayschi apayschi;
label define apayschi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayschj epayschj;
label define epayschj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayschj apayschj;
label define apayschj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtschf tamtschf;
label define tamtschf
	0           "Not in universe"               
;
label values aamtschf aamtschf;
label define aamtschf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtschg tamtschg;
label define tamtschg
	0           "Not in universe"               
;
label values aamtschg aamtschg;
label define aamtschg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtschh tamtschh;
label define tamtschh
	0           "Not in universe"               
;
label values aamtschh aamtschh;
label define aamtschh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtschi tamtschi;
label define tamtschi
	0           "Not in universe"               
;
label values aamtschi aamtschi;
label define aamtschi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtschj tamtschj;
label define tamtschj
	0           "Not in universe"               
;
label values aamtschj aamtschj;
label define aamtschj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothef ewhothef;
label define ewhothef
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothef awhothef;
label define awhothef
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhotheg ewhotheg;
label define ewhotheg
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhotheg awhotheg;
label define awhotheg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhotheh ewhotheh;
label define ewhotheh
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhotheh awhotheh;
label define awhotheh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothei ewhothei;
label define ewhothei
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothei awhothei;
label define awhothei
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhothej ewhothej;
label define ewhothej
	-1          "Not in universe"               
	1           "Child's home"                  
	2           "The non-relative's home"       
	3           "Someplace else"                
;
label values awhothej awhothej;
label define awhothej
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrf eothehrf;
label define eothehrf
	-1          "Not in universe"               
;
label values aothehrf aothehrf;
label define aothehrf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrg eothehrg;
label define eothehrg
	-1          "Not in universe"               
;
label values aothehrg aothehrg;
label define aothehrg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrh eothehrh;
label define eothehrh
	-1          "Not in universe"               
;
label values aothehrh aothehrh;
label define aothehrh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehri eothehri;
label define eothehri
	-1          "Not in universe"               
;
label values aothehri aothehri;
label define aothehri
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothehrj eothehrj;
label define eothehrj
	-1          "Not in universe"               
;
label values aothehrj aothehrj;
label define aothehrj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothf epayothf;
label define epayothf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothf apayothf;
label define apayothf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothg epayothg;
label define epayothg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothg apayothg;
label define apayothg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothh epayothh;
label define epayothh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothh apayothh;
label define apayothh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothi epayothi;
label define epayothi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothi apayothi;
label define apayothi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayothj epayothj;
label define epayothj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayothj apayothj;
label define apayothj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothf tamtothf;
label define tamtothf
	0           "Not in universe"               
;
label values aamtothf aamtothf;
label define aamtothf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothg tamtothg;
label define tamtothg
	0           "Not in universe"               
;
label values aamtothg aamtothg;
label define aamtothg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothh tamtothh;
label define tamtothh
	0           "Not in universe"               
;
label values aamtothh aamtothh;
label define aamtothh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothi tamtothi;
label define tamtothi
	0           "Not in universe"               
;
label values aamtothi aamtothi;
label define aamtothi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tamtothj tamtothj;
label define tamtothj
	0           "Not in universe"               
;
label values aamtothj aamtothj;
label define aamtothj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowf eschoowf;
label define eschoowf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowf aschoowf;
label define aschoowf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowg eschoowg;
label define eschoowg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowg aschoowg;
label define aschoowg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowh eschoowh;
label define eschoowh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowh aschoowh;
label define aschoowh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowi eschoowi;
label define eschoowi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowi aschoowi;
label define aschoowi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eschoowj eschoowj;
label define eschoowj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aschoowj aschoowj;
label define aschoowj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwf ehrschwf;
label define ehrschwf
	-1          "Not in universe"               
;
label values ahrschwf ahrschwf;
label define ahrschwf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwg ehrschwg;
label define ehrschwg
	-1          "Not in universe"               
;
label values ahrschwg ahrschwg;
label define ahrschwg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwh ehrschwh;
label define ehrschwh
	-1          "Not in universe"               
;
label values ahrschwh ahrschwh;
label define ahrschwh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwi ehrschwi;
label define ehrschwi
	-1          "Not in universe"               
;
label values ahrschwi ahrschwi;
label define ahrschwi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrschwj ehrschwj;
label define ehrschwj
	-1          "Not in universe"               
;
label values ahrschwj ahrschwj;
label define ahrschwj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcaf eselfcaf;
label define eselfcaf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcaf aselfcaf;
label define aselfcaf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcag eselfcag;
label define eselfcag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcag aselfcag;
label define aselfcag
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcah eselfcah;
label define eselfcah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcah aselfcah;
label define aselfcah
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcai eselfcai;
label define eselfcai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcai aselfcai;
label define aselfcai
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eselfcaj eselfcaj;
label define eselfcaj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aselfcaj aselfcaj;
label define aselfcaj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1f ekidhr1f;
label define ekidhr1f
	-1          "Not in universe"               
;
label values akidhr1f akidhr1f;
label define akidhr1f
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1g ekidhr1g;
label define ekidhr1g
	-1          "Not in universe"               
;
label values akidhr1g akidhr1g;
label define akidhr1g
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1h ekidhr1h;
label define ekidhr1h
	-1          "Not in universe"               
;
label values akidhr1h akidhr1h;
label define akidhr1h
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1i ekidhr1i;
label define ekidhr1i
	-1          "Not in universe"               
;
label values akidhr1i akidhr1i;
label define akidhr1i
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ekidhr1j ekidhr1j;
label define ekidhr1j
	-1          "Not in universe"               
;
label values akidhr1j akidhr1j;
label define akidhr1j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychaf edaychaf;
label define edaychaf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychaf adaychaf;
label define adaychaf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychag edaychag;
label define edaychag
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychag adaychag;
label define adaychag
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychah edaychah;
label define edaychah
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychah adaychah;
label define adaychah
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychai edaychai;
label define edaychai
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychai adaychai;
label define adaychai
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values edaychaj edaychaj;
label define edaychaj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adaychaj adaychaj;
label define adaychaj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhelf epayhelf;
label define epayhelf
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhelf apayhelf;
label define apayhelf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhelg epayhelg;
label define epayhelg
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhelg apayhelg;
label define apayhelg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhelh epayhelh;
label define epayhelh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhelh apayhelh;
label define apayhelh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayheli epayheli;
label define epayheli
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayheli apayheli;
label define apayheli
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epayhelj epayhelj;
label define epayhelj
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Did not use any arrangements"  
;
label values apayhelj apayhelj;
label define apayhelj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewhopa1f ewhopa1f;
label define ewhopa1f
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1g ewhopa1g;
label define ewhopa1g
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1h ewhopa1h;
label define ewhopa1h
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1i ewhopa1i;
label define ewhopa1i
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa1j ewhopa1j;
label define ewhopa1j
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2f ewhopa2f;
label define ewhopa2f
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2g ewhopa2g;
label define ewhopa2g
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2h ewhopa2h;
label define ewhopa2h
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2i ewhopa2i;
label define ewhopa2i
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa2j ewhopa2j;
label define ewhopa2j
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3f ewhopa3f;
label define ewhopa3f
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3g ewhopa3g;
label define ewhopa3g
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3h ewhopa3h;
label define ewhopa3h
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3i ewhopa3i;
label define ewhopa3i
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa3j ewhopa3j;
label define ewhopa3j
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4f ewhopa4f;
label define ewhopa4f
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4g ewhopa4g;
label define ewhopa4g
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4h ewhopa4h;
label define ewhopa4h
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4i ewhopa4i;
label define ewhopa4i
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ewhopa4j ewhopa4j;
label define ewhopa4j
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awhopaf  awhopaf;
label define awhopaf 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopag  awhopag;
label define awhopag 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopah  awhopah;
label define awhopah 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopai  awhopai;
label define awhopai 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values awhopaj  awhopaj;
label define awhopaj 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangf earrangf;
label define earrangf
	-1          "Not in universe"               
;
label values aarrangf aarrangf;
label define aarrangf
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangg earrangg;
label define earrangg
	-1          "Not in universe"               
;
label values aarrangg aarrangg;
label define aarrangg
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangh earrangh;
label define earrangh
	-1          "Not in universe"               
;
label values aarrangh aarrangh;
label define aarrangh
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangi earrangi;
label define earrangi
	-1          "Not in universe"               
;
label values aarrangi aarrangi;
label define aarrangi
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values earrangj earrangj;
label define earrangj
	-1          "Not in universe"               
;
label values aarrangj aarrangj;
label define aarrangj
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etiamt01 etiamt0j;
label define etiamt0j
	-7          "None"                          
	-1          "Not in universe"               
;
label values atiamt01 atiamt0j;
label define atiamt0j
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etiamt02 etiamt0k;
label define etiamt0k
	-1          "Not in universe"               
	0           "None"                          
	1           "Hours"                         
	2           "Days"                          
	3           "Weeks"                         
	4           "Months"                        
;
label values atiamt02 atiamt0k;
label define atiamt0k
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadsunv  eadsunv;
label define eadsunv 
	-1          "Not in Universe"               
	1           "In universe"                   
;
label values edisabt2 edisabtv;
label define edisabtv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "Yes-condition sometimes makes" 
	3           "No"                            
;
label values adisabt2 adisabtv;
label define adisabtv
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
;
label values edisabt3 edisabtk;
label define edisabtk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "Yes-condition sometimes makes" 
	3           "No"                            
;
label values adisabt3 adisabtk;
label define adisabtk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
;
label values eatxunv  eatxunv;
label define eatxunv 
	-1          "Not in Universe"               
	1           "In universe"                   
;
label values itaxflyn itaxflyn;
label define itaxflyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itaxcopy itaxcopy;
label define itaxcopy
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values rfilstat rfilstat;
label define rfilstat
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Single taxpayer"               
	2           "Married, Filing joint return"  
	3           "Married, filing separately"    
	4           "Unmarried head of hhld or"     
;
label values rtotexmp rtotexmp;
label define rtotexmp
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1 exemption"                   
	2           "2 exemptions"                  
	3           "3-5 exemptions"                
	4           "6 or more exemptions"          
;
label values iexemp01 iexemp0p;
label define iexemp0p
	-5          "All"                           
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iexemp02 iexemp0k;
label define iexemp0k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iexemp03 iexemp0l;
label define iexemp0l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iexemp04 iexemp0m;
label define iexemp0m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iexemp05 iexemp0n;
label define iexemp0n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iexemp06 iexemp0o;
label define iexemp0o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iexmpout iexmpout;
label define iexmpout
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iexnmout iexnmout;
label define iexnmout
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ioutrl01 ioutrl0t;
label define ioutrl0t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl02 ioutrl0k;
label define ioutrl0k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl03 ioutrl0l;
label define ioutrl0l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl04 ioutrl0m;
label define ioutrl0m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl05 ioutrl0n;
label define ioutrl0n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl06 ioutrl0o;
label define ioutrl0o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl07 ioutrl0p;
label define ioutrl0p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl08 ioutrl0q;
label define ioutrl0q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl09 ioutrl0r;
label define ioutrl0r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ioutrl10 ioutrl1t;
label define ioutrl1t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Parent"                        
	2           "Child"                         
	3           "Brother/sister"                
	4           "Other"                         
;
label values ifilform ifilform;
label define ifilform
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Form 1040"                     
	2           "Form 1040A"                    
	3           "Form 1040EZ"                   
;
label values ischeda  ischeda;
label define ischeda 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ischedd  ischedd;
label define ischedd 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ramtdedt ramtdedt;
label define ramtdedt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-2999 Amount of itemized"     
	2           "3000-3999 Amount of itemized"  
	3           "4000-4999 Amount of itemized"  
	4           "5000-5999 Amount of itemized"  
	5           "6000-6999 Amount of itemized"  
	6           "7000-7999 Amount of itemized"  
	7           "8000-8999 Amount of itemized"  
	8           "9000-9999 Amount of itemized"  
	9           "10000-10999 Amount of itemized"
	10          "11000-11999 Amount of itemized"
	11          "12000-12999 Amount of itemized"
	12          "13000-13999 Amount of itemized"
	13          "14000-16999 Amount of itemized"
	14          "17000-21999 Amount of itemized"
	15          "22000-24999 Amount of itemized"
	16          "25000-29999 Amount of itemized"
	17          "30000-35999 Amount of itemized"
	18          "36000+ Amount of itemized"     
;
label values iccexpen iccexpen;
label define iccexpen
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values rccamt   rccamt; 
label define rccamt  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-49 Child and dependent care" 
	2           "50-99 Child and dependent care"
	3           "100-149 Child and dependent care"
	4           "150-199 Child and dependent care"
	5           "200-249 Child and dependent care"
	6           "250-299 Child and dependent care"
	7           "300-349 Child and dependent care"
	8           "350-399 Child and dependent care"
	9           "400-449 Child and dependent care"
	10          "450-499 Child and dependent care"
	11          "500-599 Child and dependent care"
	12          "600-699 Child and dependent care"
	13          "700-799 Child and dependent care"
	14          "800+ Child and dependent care" 
;
label values idsabcrd idsabcrd;
label define idsabcrd
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values rdsabamt rdsabamt;
label define rdsabamt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-199 Elderly or disadled credit"
	2           "200-499 Elderly or disadled"   
	3           "500+ Elderly or disadled credit"
;
label values rsapgain rsapgain;
label define rsapgain
	-4          "Negative values (losses)"      
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-99 Amount of capital gains"  
	2           "100-199 Amount of capital gains"
	3           "200-299 Amount of capital gains"
	4           "300-499 Amount of capital gains"
	5           "500-699 Amount of capital gains"
	6           "700-999 Amount of capital gains"
	7           "1000-1299 Amount of capital"   
	8           "1300-1999 Amount of capital"   
	9           "2000-2999 Amount of capital"   
	10          "3000-3999 Amount of capital"   
	11          "4000-5999 Amount of capital"   
	12          "6000-9999 Amount of capital"   
	13          "10000-14999 Amount of capital" 
	14          "15000+ Amount of capital gains"
;
label values radjincm radjincm;
label define radjincm
	-4          "Negative values (losses)"      
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-999 Amount of adjusted gross"
	2           "1000-1199 Amount of adjusted"  
	3           "1200-1399 Amount of adjusted"  
	4           "1400-1599 Amount of adjusted"  
	5           "1600-1799 Amount of adjusted"  
	6           "1800-1999 Amount of adjusted"  
	7           "2000-2199 Amount of adjusted"  
	8           "2200-2399 Amount of adjusted"  
	9           "2400-2599 Amount of adjusted"  
	10          "2600-2799 Amount of adjusted"  
	11          "2800-2999 Amount of adjusted"  
	12          "3000-3499 Amount of adjusted"  
	13          "3500-3999 Amount of adjusted"  
	14          "4000-4499 Amount of adjusted"  
	15          "4500-4999 Amount of adjusted"  
	16          "5000-5499 Amount of adjusted"  
	17          "5500-5999 Amount of adjusted"  
	18          "6000-6499 Amount of adjusted"  
	19          "6500-6999 Amount of adjusted"  
	20          "7000-7499 Amount of adjusted"  
	21          "7500-7999 Amount of adjusted"  
	22          "8000-9999 Amount of adjusted"  
	23          "10000-14999 Amount of adjusted"
	24          "15000-19999 Amount of adjusted"
	25          "20000-24999 Amount of adjusted"
	26          "25000-29999 Amount of adjusted"
	27          "30000-34999 Amount of adjusted"
	28          "35000-39999 Amount of adjusted"
	29          "40000-49999 Amount of adjusted"
	30          "50000-59999 Amount of adjusted"
	31          "60000-69999 Amount of adjusted"
	32          "70000-74999 Amount of adjusted"
	33          "75000+ Amount of adjusted gross"
;
label values rnettax  rnettax;
label define rnettax 
	-4          "Negative values (losses)"      
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-49 Amount of net tax liability"
	2           "50-99 Amount of net tax"       
	3           "100-149 Amount of net tax"     
	4           "150-199 Amount of net tax"     
	5           "200-299 Amount of net tax"     
	6           "300-399 Amount of net tax"     
	7           "400-499 Amount of net tax"     
	8           "500-599 Amount of net tax"     
	9           "600-699 Amount of net tax"     
	10          "700-799 Amount of net tax"     
	11          "800-899 Amount of net tax"     
	12          "900-999 Amount of net tax"     
	13          "1000-1199 Amount of net tax"   
	14          "1200-1399 Amount of net tax"   
	15          "1400-1599 Amount of net tax"   
	16          "1600-1799 Amount of net tax"   
	17          "1800-1999 Amount of net tax"   
	18          "2000-2199 Amount of net tax"   
	19          "2200-2399 Amount of net tax"   
	20          "2400-2599 Amount of net tax"   
	21          "2600-2799 Amount of net tax"   
	22          "2800-2999 Amount of net tax"   
	23          "3000-3499 Amount of net tax"   
	24          "3500-3999 Amount of net tax"   
	25          "4000-4499 Amount of net tax"   
	26          "4500-4999 Amount of net tax"   
	27          "5000-5499 Amount of net tax"   
	28          "5500-5999 Amount of net tax"   
	29          "6000-6499 Amount of net tax"   
	30          "6500-6999 Amount of net tax"   
	31          "7000-7499 Amount of net tax"   
	32          "7500-7999 Amount of net tax"   
	33          "8000-9999 Amount of net tax"   
	34          "10000-13999 Amount of net tax" 
	35          "14000+ Amount of net tax"      
;
label values ierndcrd ierndcrd;
label define ierndcrd
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values rerndamt rerndamt;
label define rerndamt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-49 Amount of earned income"  
	2           "50-99 Amount of earned income" 
	3           "100-149 Amount of earned income"
	4           "150-199 Amount of earned income"
	5           "200-299 Amount of earned income"
	6           "300-399 Amount of earned income"
	7           "400-499 Amount of earned income"
	8           "500-599 Amount of earned income"
	9           "600-699 Amount of earned income"
	10          "700-799 Amount of earned income"
	11          "800-899 Amount of earned income"
	12          "900-999 Amount of earned income"
	13          "1000-1199 Amount of earned"    
	14          "1200-1399 Amount of earned"    
	15          "1400-1599 Amount of earned"    
	16          "1600-1799 Amount of earned"    
	17          "1800-1999 Amount of earned"    
	18          "2000-2199 Amount of earned"    
	19          "2200-2399 Amount of earned"    
	20          "2400-2599 Amount of earned"    
	21          "2600-2799 Amount of earned"    
	22          "2800-2999 Amount of earned"    
	23          "3000-3499 Amount of earned"    
	24          "3500+ Amount of earned income" 
;
label values iproptax iproptax;
label define iproptax
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ipropjnt ipropjnt;
label define ipropjnt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ipropn01 ipropn0t;
label define ipropn0t
	-5          "All"                           
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn02 ipropn0k;
label define ipropn0k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn03 ipropn0l;
label define ipropn0l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn04 ipropn0m;
label define ipropn0m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn05 ipropn0n;
label define ipropn0n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn06 ipropn0o;
label define ipropn0o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn07 ipropn0p;
label define ipropn0p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn08 ipropn0q;
label define ipropn0q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn09 ipropn0r;
label define ipropn0r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn10 ipropn1t;
label define ipropn1t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn11 ipropn1k;
label define ipropn1k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn12 ipropn1l;
label define ipropn1l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn13 ipropn1m;
label define ipropn1m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn14 ipropn1n;
label define ipropn1n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn15 ipropn1o;
label define ipropn1o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn16 ipropn1p;
label define ipropn1p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn17 ipropn1q;
label define ipropn1q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn18 ipropn1r;
label define ipropn1r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn19 ipropn1s;
label define ipropn1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn20 ipropn2t;
label define ipropn2t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn21 ipropn2k;
label define ipropn2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn22 ipropn2l;
label define ipropn2l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn23 ipropn2m;
label define ipropn2m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn24 ipropn2n;
label define ipropn2n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn25 ipropn2o;
label define ipropn2o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn26 ipropn2p;
label define ipropn2p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn27 ipropn2q;
label define ipropn2q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn28 ipropn2r;
label define ipropn2r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn29 ipropn2s;
label define ipropn2s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values ipropn30 ipropn3t;
label define ipropn3t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknownn person number"        
;
label values rtaxbill rtaxbill;
label define rtaxbill
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-99 Amount of property tax"   
	2           "100-199 Amount of property tax"
	3           "200-299 Amount of property tax"
	4           "300-399 Amount of property tax"
	5           "400-499 Amount of property tax"
	6           "500-599 Amount of property tax"
	7           "600-699 Amount of property tax"
	8           "700-799 Amount of property tax"
	9           "800-899 Amount of property tax"
	10          "900-999 Amount of property tax"
	11          "1000-1099 Amount of property tax"
	12          "1100-1199 Amount of property tax"
	13          "1200-1299 Amount of property tax"
	14          "1300-1499 Amount of property tax"
	15          "1500-1799 Amount of property tax"
	16          "1800-2099 Amount of property tax"
	17          "2100-2399 Amount of property tax"
	18          "2400-2599 Amount of property tax"
	19          "2600-2999 Amount of property tax"
	20          "3000-4999 Amount of property tax"
	21          "5000+ Amount of property tax"  
;
label values eairunv  eairunv;
label define eairunv 
	-1          "Not in Universe"               
	1           "In universe"                   
;
label values iothrbus iothrbus;
label define iothrbus
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iownbs96 iownbs9s;
label define iownbs9s
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ibsform1 ibsforms;
label define ibsforms
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Sole proprietorship"           
	2           "Partnership"                   
	3           "Corporation"                   
;
label values ibsloct1 ibslocts;
label define ibslocts
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Own home"                      
	2           "Somewhere else"                
;
label values iprtown1 iprtowns;
label define iprtowns
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iownrs11 iownrs1s;
label define iownrs1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values iownrs12 iownrs1k;
label define iownrs1k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ihhown1  ihhown1l;
label define ihhown1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values rpcnthh1 rpcnthhs;
label define rpcnthhs
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-50 Percentage of business"   
	2           "51-100  Percentage of business"
;
label values rpctown1 rpctowns;
label define rpctowns
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-25 Percentage of business"   
	2           "26-49 Percentage of business"  
	3           "50-100 Percentage of business" 
;
label values tgrsrcp1 tgrsrcps;
label define tgrsrcps
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ttotexp1 ttotexps;
label define ttotexps
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetinc1 tnetincs;
label define tnetincs
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetinc2 tnetinck;
label define tnetinck
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iothinc1 iothincs;
label define iothincs
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values inetin11 inetin1s;
label define inetin1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown Person NUmber"         
;
label values tnetin12 tnetin1s;
label define tnetin1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetin13 tnetin1k;
label define tnetin1k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values inetin21 inetin2s;
label define inetin2s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values tnetin22 tnetin2s;
label define tnetin2s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetin23 tnetin2k;
label define tnetin2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ibsform2 ibsformk;
label define ibsformk
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Sole proprietorship"           
	2           "Partnership"                   
	3           "Corporation"                   
;
label values ibsloct2 ibsloctk;
label define ibsloctk
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Own home"                      
	2           "Somewhere else"                
;
label values iprtown2 iprtownk;
label define iprtownk
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iownrs21 iownrs2s;
label define iownrs2s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Person number"                 
;
label values iownrs22 iownrs2k;
label define iownrs2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Person number"                 
;
label values ihhown2  ihhown2l;
label define ihhown2l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values rpcnthh2 rpcnthhk;
label define rpcnthhk
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-25 Percentage of business"   
	2           "51-100 Percentage of business" 
;
label values rpctown2 rpctownk;
label define rpctownk
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-25 Percentage of business"   
	2           "26-49 Percentage of business"  
	3           "50-100 Percentage of business" 
;
label values tgrsrcp2 tgrsrcpk;
label define tgrsrcpk
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ttotexp2 ttotexpk;
label define ttotexpk
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetinc3 tnetincl;
label define tnetincl
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetinc4 tnetincm;
label define tnetincm
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iothinc2 iothinck;
label define iothinck
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values inetin31 inetin3s;
label define inetin3s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values tnetin32 tnetin3s;
label define tnetin3s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetin33 tnetin3k;
label define tnetin3k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values inetin41 inetin4s;
label define inetin4s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values tnetin42 tnetin4s;
label define tnetin4s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tnetin43 tnetin4k;
label define tnetin4k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tothinc3 tothincs;
label define tothincs
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tothinc4 tothinck;
label define tothinck
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iirayn   iirayn; 
label define iirayn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiracont iiracont;
label define iiracont
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ttaxcont ttaxcont;
label define ttaxcont
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iirawdl  iirawdl;
label define iirawdl 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values tamtira  tamtira;
label define tamtira 
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tiraearn tiraearn;
label define tiraearn
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iiratyp1 iiratypn;
label define iiratypn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiratyp2 iiratypk;
label define iiratypk
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiratyp3 iiratypl;
label define iiratypl
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiratyp4 iiratypm;
label define iiratypm
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiratyp5 iiratypo;
label define iiratypo
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiratyp6 iiratypp;
label define iiratypp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iiratyp7 iiratypq;
label define iiratypq
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeoghyn ikeoghyn;
label define ikeoghyn
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeoghcn ikeoghcn;
label define ikeoghcn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ttxkeogh ttxkeogh;
label define ttxkeogh
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ikeoghwd ikeoghwd;
label define ikeoghwd
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values tatkeogh tatkeogh;
label define tatkeogh
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tkeogher tkeogher;
label define tkeogher
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ikeohtp1 ikeohtpr;
label define ikeohtpr
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeohtp2 ikeohtpk;
label define ikeohtpk
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeohtp3 ikeohtpl;
label define ikeohtpl
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeohtp4 ikeohtpm;
label define ikeohtpm
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeohtp5 ikeohtpn;
label define ikeohtpn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeohtp6 ikeohtpo;
label define ikeohtpo
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ikeohtp7 ikeohtpp;
label define ikeohtpp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ithrftyn ithrftyn;
label define ithrftyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values tthftcnt tthftcnt;
label define tthftcnt
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ithftwdl ithftwdl;
label define ithftwdl
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values tthftamt tthftamt;
label define tthftamt
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values tthftern tthftern;
label define tthftern
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ithftyp1 ithftypn;
label define ithftypn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ithftyp2 ithftypk;
label define ithftypk
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ithftyp3 ithftypl;
label define ithftypl
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ithftyp4 ithftypm;
label define ithftypm
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ithftyp5 ithftypo;
label define ithftypo
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
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
