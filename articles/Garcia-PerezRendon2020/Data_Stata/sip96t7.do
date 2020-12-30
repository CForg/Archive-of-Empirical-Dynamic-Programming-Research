log using sip96t7, text replace
set mem 500m
*This program reads the 1996 SIPP Wave 7 Topical Module Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*by Jean Roth Tue Nov  4 11:38:34 EST 2003
*Please report errors to jroth@nber.org
*run with do sip96t7
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp/1996\sip96t7.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96t7

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
label values ephcunv  ephcunv;
label define ephcunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values epvdcare epvdcare;
label define epvdcare
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apvdcare apvdcare;
label define apvdcare
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecarehhm ecarehhm;
label define ecarehhm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acarehhm acarehhm;
label define acarehhm
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tnumhhm  tnumhhm;
label define tnumhhm 
	-1          "Not in universe"               
;
label values anumhhm  anumhhm;
label define anumhhm 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehhm1    ehhm1l; 
label define ehhm1l  
	-1          "Not in universe"               
	9999        "Unknown person number"         
;
label values ahhm1    ahhm1l; 
label define ahhm1l  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelt01  erelt01l;
label define erelt01l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Partner"                       
	3           "Child"                         
	4           "Grandchild"                    
	5           "Parent"                        
	6           "Brother/sister"                
	7           "Other relative"                
	8           "Nonrelative"                   
	9           "Relationship not identified"   
;
label values arelt01  arelt01l;
label define arelt01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tyrst01  tyrst01l;
label define tyrst01l
	-1          "Not in universe"               
;
label values ayrst01  ayrst01l;
label define ayrst01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadlt01  eadlt01l;
label define eadlt01l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aadlt01  aadlt01l;
label define aadlt01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emedt01  emedt01l;
label define emedt01l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amedt01  amedt01l;
label define amedt01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emnyt01  emnyt01l;
label define emnyt01l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amnyt01  amnyt01l;
label define amnyt01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eoutt01  eoutt01l;
label define eoutt01l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aoutt01  aoutt01l;
label define aoutt01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrst01  ehrst01l;
label define ehrst01l
	-1          "Not in universe"               
;
label values ahrst01  ahrst01l;
label define ahrst01l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eopt01   eopt01l;
label define eopt01l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aopt01   aopt01l;
label define aopt01l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emostt01 emostt0m;
label define emostt0m
	-1          "Not in universe"               
	1           "Provided the most care"        
	2           "Others provided as much or more"
;
label values amostt01 amostt0m;
label define amostt0m
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehct01   ehct01l;
label define ehct01l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahct01   ahct01l;
label define ahct01l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehhm2    ehhm2l; 
label define ehhm2l  
	-1          "Not in universe"               
	9999        "Unknown person number"         
;
label values ahhm2    ahhm2l; 
label define ahhm2l  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelt02  erelt02l;
label define erelt02l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Partner"                       
	3           "Child"                         
	4           "Grandchild"                    
	5           "Parent"                        
	6           "Brother/sister"                
	7           "Other relative"                
	8           "Nonrelative"                   
	9           "Relationship not identified"   
;
label values arelt02  arelt02l;
label define arelt02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tyrst02  tyrst02l;
label define tyrst02l
	-1          "Not in universe"               
;
label values ayrst02  ayrst02l;
label define ayrst02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadlt02  eadlt02l;
label define eadlt02l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aadlt02  aadlt02l;
label define aadlt02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emedt02  emedt02l;
label define emedt02l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amedt02  amedt02l;
label define amedt02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emnyt02  emnyt02l;
label define emnyt02l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amnyt02  amnyt02l;
label define amnyt02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eoutt02  eoutt02l;
label define eoutt02l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aoutt02  aoutt02l;
label define aoutt02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrst02  ehrst02l;
label define ehrst02l
	-1          "Not in universe"               
;
label values ahrst02  ahrst02l;
label define ahrst02l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eopt02   eopt02l;
label define eopt02l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aopt02   aopt02l;
label define aopt02l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imutation"           
	3           "Logical imputation (derivation)"
;
label values emostt02 emostt0k;
label define emostt0k
	-1          "Not in universe"               
	1           "Provided the most care"        
	2           "Others provided as much or more"
;
label values amostt02 amostt0k;
label define amostt0k
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehct02   ehct02l;
label define ehct02l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahct02   ahct02l;
label define ahct02l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecarenhm ecarenhm;
label define ecarenhm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acarenhm acarenhm;
label define acarenhm
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tnumnhm  tnumnhm;
label define tnumnhm 
	-1          "Not in universe"               
;
label values anumnhm  anumnhm;
label define anumnhm 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelt03  erelt03l;
label define erelt03l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Partner"                       
	3           "Child"                         
	4           "Grandchild"                    
	5           "Parent"                        
	6           "Brother/sister"                
	7           "Other relative"                
	8           "Nonrelative"                   
	9           "Relationship not identified"   
;
label values arelt03  arelt03l;
label define arelt03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tyrst03  tyrst03l;
label define tyrst03l
	-1          "Not in universe"               
;
label values ayrst03  ayrst03l;
label define ayrst03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eresof3  eresof3l;
label define eresof3l
	-1          "Not in universe"               
	1           "House or apartment"            
	2           "Care facility"                 
;
label values aresof3  aresof3l;
label define aresof3l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadlt03  eadlt03l;
label define eadlt03l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aadlt03  aadlt03l;
label define aadlt03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emedt03  emedt03l;
label define emedt03l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amedt03  amedt03l;
label define amedt03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emnyt03  emnyt03l;
label define emnyt03l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amnyt03  amnyt03l;
label define amnyt03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehwrkt03 ehwrkt0m;
label define ehwrkt0m
	-1          "Not in universe"               
	1           "No"                            
	2           "Yes"                           
;
label values ahwrkt03 ahwrkt0m;
label define ahwrkt0m
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eoutt03  eoutt03l;
label define eoutt03l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aoutt03  aoutt03l;
label define aoutt03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrst03  ehrst03l;
label define ehrst03l
	-1          "Not in universe"               
;
label values ahrst03  ahrst03l;
label define ahrst03l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eopt03   eopt03l;
label define eopt03l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aopt03   aopt03l;
label define aopt03l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecompt03 ecompt0m;
label define ecompt0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acompt03 acompt0m;
label define acompt0m
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emostt03 emostt0l;
label define emostt0l
	-1          "Not in universe"               
	1           "Provided the most care"        
	2           "Others provided as much or more"
;
label values amostt03 amostt0l;
label define amostt0l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehct03   ehct03l;
label define ehct03l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahct03   ahct03l;
label define ahct03l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values erelt04  erelt04l;
label define erelt04l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Partner"                       
	3           "Child"                         
	4           "Grandchild"                    
	5           "Parent"                        
	6           "Brother/sister"                
	7           "Other relative"                
	8           "Nonrelative"                   
	9           "Relationship not identified"   
;
label values arelt04  arelt04l;
label define arelt04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tyrst04  tyrst04l;
label define tyrst04l
	-1          "Not in universe"               
;
label values ayrst04  ayrst04l;
label define ayrst04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eresof4  eresof4l;
label define eresof4l
	-1          "Not in universe"               
	1           "House or apartment"            
	2           "Care facility"                 
;
label values aresof4  aresof4l;
label define aresof4l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadlt04  eadlt04l;
label define eadlt04l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aadlt04  aadlt04l;
label define aadlt04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emedt04  emedt04l;
label define emedt04l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amedt04  amedt04l;
label define amedt04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emnyt04  emnyt04l;
label define emnyt04l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amnyt04  amnyt04l;
label define amnyt04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehwrkt04 ehwrkt0k;
label define ehwrkt0k
	-1          "Not in universe"               
	1           "No"                            
	2           "Yes"                           
;
label values ahwrkt04 ahwrkt0k;
label define ahwrkt0k
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eoutt04  eoutt04l;
label define eoutt04l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aoutt04  aoutt04l;
label define aoutt04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehrst04  ehrst04l;
label define ehrst04l
	-1          "Not in universe"               
;
label values ahrst04  ahrst04l;
label define ahrst04l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eopt04   eopt04l;
label define eopt04l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aopt04   aopt04l;
label define aopt04l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecompt04 ecompt0k;
label define ecompt0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acompt04 acompt0k;
label define acompt0k
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emostt04 emostt0n;
label define emostt0n
	-1          "Not in universe"               
	1           "Provided the most care"        
	2           "Others provided as much or more"
;
label values amostt04 amostt0n;
label define amostt0n
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehct04   ehct04l;
label define ehct04l 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahct04   ahct04l;
label define ahct04l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eatxunv  eatxunv;
label define eatxunv 
	-1          "Not in universe"               
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
label values tfilstat tfilstat;
label define tfilstat
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Single taxpayer"               
	2           "Married, Filing joint return"  
	3           "Married, filing separately"    
	4           "Unmarried head of hhld or"     
;
label values ttotexmp ttotexmp;
label define ttotexmp
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
label values tamtdedt tamtdedt;
label define tamtdedt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-2999 Amount of itemized"     
	2           "3000-4999 Amount of itemized"  
	3           "5000-5999 Amount of itemized"  
	4           "6000-6999 Amount of itemized"  
	5           "7000-7999 Amount of itemized"  
	6           "8000-8999 Amount of itemized"  
	7           "9000-9999 Amount of itemized"  
	8           "10000-10999 Amount of itemized"
	9           "11000-11999 Amount of itemized"
	10          "12000-12999 Amount of itemized"
	11          "13000-13999 Amount of itemized"
	12          "14000-16999 Amount of itemized"
	13          "17000-21999 Amount of itemized"
	14          "22000-24999 Amount of itemized"
	15          "25000-35999 Amount of itemized"
	16          "36000+ Amount of itemized"     
;
label values iccexpen iccexpen;
label define iccexpen
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values tccamt   tccamt; 
label define tccamt  
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
	12          "600-799 Child and dependent care"
	13          "800+ Child and dependent care" 
;
label values icarex01 icarex0t;
label define icarex0t
	-5          "All"                           
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex02 icarex0k;
label define icarex0k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex03 icarex0l;
label define icarex0l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex04 icarex0m;
label define icarex0m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex05 icarex0n;
label define icarex0n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex06 icarex0o;
label define icarex0o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex07 icarex0p;
label define icarex0p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex08 icarex0q;
label define icarex0q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex09 icarex0r;
label define icarex0r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex10 icarex1t;
label define icarex1t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex11 icarex1k;
label define icarex1k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex12 icarex1l;
label define icarex1l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex13 icarex1m;
label define icarex1m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex14 icarex1n;
label define icarex1n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex15 icarex1o;
label define icarex1o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex16 icarex1p;
label define icarex1p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex17 icarex1q;
label define icarex1q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex18 icarex1r;
label define icarex1r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex19 icarex1s;
label define icarex1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex20 icarex2t;
label define icarex2t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex21 icarex2k;
label define icarex2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex22 icarex2l;
label define icarex2l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex23 icarex2m;
label define icarex2m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex24 icarex2n;
label define icarex2n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex25 icarex2o;
label define icarex2o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex26 icarex2p;
label define icarex2p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex27 icarex2q;
label define icarex2q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex28 icarex2r;
label define icarex2r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex29 icarex2s;
label define icarex2s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values icarex30 icarex3t;
label define icarex3t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values idsabcrd idsabcrd;
label define idsabcrd
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values tdsabamt tdsabamt;
label define tdsabamt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-199 Elderly or disabled credit"
	2           "200-499 Elderly or disabled"   
	3           "500+ Elderly or disabled credit"
;
label values tsapgain tsapgain;
label define tsapgain
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
label values tadjincm tadjincm;
label define tadjincm
	-4          "Negative values (losses)"      
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-2199 Amount of adjusted gross"
	2           "2200-4999 Amount of adjusted"  
	3           "5000-7999 Amount of adjusted"  
	4           "8000-9999 Amount of adjusted"  
	5           "10000-14999 Amount of adjusted"
	6           "15000-19999 Amount of adjusted"
	7           "20000-24999 Amount of adjusted"
	8           "25000-29999 Amount of adjusted"
	9           "30000-34999 Amount of adjusted"
	10          "35000-39999 Amount of adjusted"
	11          "40000-49999 Amount of adjusted"
	12          "50000-59999 Amount of adjusted"
	13          "60000-74999 Amount of adjusted"
	14          "75000+ Amount of adjusted gross"
;
label values tnettax  tnettax;
label define tnettax 
	-4          "Negative values (losses)"      
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           ">0-99 Amount of net tax"       
	2           "100-299 Amount of net tax"     
	3           "300-499 Amount of net tax"     
	4           "500-699 Amount of net tax"     
	5           "700-899 Amount of net tax"     
	6           "900-1199 Amount of net tax"    
	7           "1200-1599 Amount of net tax"   
	8           "1600-1999 Amount of net tax"   
	9           "2000-2399 Amount of net tax"   
	10          "2400-2999 Amount of net tax"   
	11          "3000-3499 Amount of net tax"   
	12          "3500-3999 Amount of net tax"   
	13          "4000-4499 Amount of net tax"   
	14          "4500-4999 Amount of net tax"   
	15          "5000-5499 Amount of net tax"   
	16          "5500-6499 Amount of net tax"   
	17          "6500-7999 Amount of net tax"   
	18          "8000-9999 Amount of net tax"   
	19          "10000-13999 Amount of net tax" 
	20          "14000+ Amount of net tax"      
;
label values ierndcrd ierndcrd;
label define ierndcrd
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values terndamt terndamt;
label define terndamt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "1-99 Amount of earned income"  
	2           "100-199 Amount of earned income"
	3           "200-299 Amount of earned income"
	4           "300-499 Amount of earned income"
	5           "500-599 Amount of earned income"
	6           "600-799 Amount of earned income"
	7           "800-999 Amount of earned income"
	8           "1000-1199 Amount of earned"    
	9           "1200-1399 Amount of earned"    
	10          "1400-1599 Amount of earned"    
	11          "1600-1799 Amount of earned"    
	12          "1800-1999 Amount of earned"    
	13          "2000-2199 Amount of earned"    
	14          "2200-2399 Amount of earned"    
	15          "2400-2599 Amount of earned"    
	16          "2600-2999 Amount of earned"    
	17          "3000-3499 Amount of earned"    
	18          "3500+ Amount of earned income" 
;
label values ieicex01 ieicex0t;
label define ieicex0t
	-5          "All"                           
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex02 ieicex0k;
label define ieicex0k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex03 ieicex0l;
label define ieicex0l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex04 ieicex0m;
label define ieicex0m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex05 ieicex0n;
label define ieicex0n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex06 ieicex0o;
label define ieicex0o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex07 ieicex0p;
label define ieicex0p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex08 ieicex0q;
label define ieicex0q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex09 ieicex0r;
label define ieicex0r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex10 ieicex1t;
label define ieicex1t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex11 ieicex1k;
label define ieicex1k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex12 ieicex1l;
label define ieicex1l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex13 ieicex1m;
label define ieicex1m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex14 ieicex1n;
label define ieicex1n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex15 ieicex1o;
label define ieicex1o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex16 ieicex1p;
label define ieicex1p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex17 ieicex1q;
label define ieicex1q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex18 ieicex1r;
label define ieicex1r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex19 ieicex1s;
label define ieicex1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex20 ieicex2t;
label define ieicex2t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex21 ieicex2k;
label define ieicex2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex22 ieicex2l;
label define ieicex2l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex23 ieicex2m;
label define ieicex2m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex24 ieicex2n;
label define ieicex2n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex25 ieicex2o;
label define ieicex2o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex26 ieicex2p;
label define ieicex2p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex27 ieicex2q;
label define ieicex2q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex28 ieicex2r;
label define ieicex2r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex29 ieicex2s;
label define ieicex2s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ieicex30 ieicex3t;
label define ieicex3t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
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
	9999        "Unknown person number"         
;
label values ipropn02 ipropn0k;
label define ipropn0k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn03 ipropn0l;
label define ipropn0l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn04 ipropn0m;
label define ipropn0m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn05 ipropn0n;
label define ipropn0n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn06 ipropn0o;
label define ipropn0o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn07 ipropn0p;
label define ipropn0p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn08 ipropn0q;
label define ipropn0q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn09 ipropn0r;
label define ipropn0r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn10 ipropn1t;
label define ipropn1t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn11 ipropn1k;
label define ipropn1k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn12 ipropn1l;
label define ipropn1l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn13 ipropn1m;
label define ipropn1m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn14 ipropn1n;
label define ipropn1n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn15 ipropn1o;
label define ipropn1o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn16 ipropn1p;
label define ipropn1p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn17 ipropn1q;
label define ipropn1q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn18 ipropn1r;
label define ipropn1r
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn19 ipropn1s;
label define ipropn1s
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn20 ipropn2t;
label define ipropn2t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn21 ipropn2k;
label define ipropn2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn22 ipropn2l;
label define ipropn2l
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn23 ipropn2m;
label define ipropn2m
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn24 ipropn2n;
label define ipropn2n
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn25 ipropn2o;
label define ipropn2o
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn26 ipropn2p;
label define ipropn2p
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ipropn27 ipropn2q;
label define ipropn2q
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
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
	9999        "Unknown person number"         
;
label values ipropn30 ipropn3t;
label define ipropn3t
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
;
label values ttaxbill ttaxbill;
label define ttaxbill
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
	11          "1000-1199 Amount of property tax"
	12          "1200-1299 Amount of property tax"
	13          "1300-1499 Amount of property tax"
	14          "1500-1799 Amount of property tax"
	15          "1800-2099 Amount of property tax"
	16          "2100-2399 Amount of property tax"
	17          "2400-2599 Amount of property tax"
	18          "2600-2999 Amount of property tax"
	19          "3000-4999 Amount of property tax"
	20          "5000+ Amount of property tax"  
;
label values eairunv  eairunv;
label define eairunv 
	-1          "Not in universe"               
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
	9999        "Unknown person number"         
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
	9999        "Unknown person number"         
;
label values iownrs22 iownrs2k;
label define iownrs2k
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	9999        "Unknown person number"         
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
	1           "1-50 Percentage of business"   
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
label values earpunv  earpunv;
label define earpunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values rmjb     rmjb;   
label define rmjb    
	-1          "Not in universe"               
;
label values rmbs     rmbs;   
label define rmbs    
	-1          "Not in universe"               
;
label values rmnjbbs  rmnjbbs;
label define rmnjbbs 
	-1          "Not in universe"               
	1           "Job"                           
	2           "Business"                      
;
label values therempl therempl;
label define therempl
	-1          "Not in universe"               
	1           "Less than 10"                  
	2           "10 to 24"                      
	3           "25 to 49"                      
	4           "50 to 99"                      
	5           "100 or more"                   
;
label values aherempl aherempl;
label define aherempl
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ttotempl ttotempl;
label define ttotempl
	-1          "Not in universe"               
	1           "Less than 10"                  
	2           "10 to 24"                      
	3           "25 to 49"                      
	4           "50 to 99"                      
	5           "100 or more"                   
;
label values atotempl atotempl;
label define atotempl
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tbustotl tbustotl;
label define tbustotl
	-1          "Not in universe"               
	1           "Less than 10"                  
	2           "10 to 24"                      
	3           "25 to 49"                      
	4           "50 to 99"                      
	5           "100 or more"                   
;
label values abustotl abustotl;
label define abustotl
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewksyear ewksyear;
label define ewksyear
	-1          "Not in universe"               
;
label values awksyear awksyear;
label define awksyear
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tnumlen  tnumlen;
label define tnumlen 
	-1          "Not in universe"               
;
label values emthyear emthyear;
label define emthyear
	-1          "Not in universe"               
	1           "Months"                        
	2           "Years"                         
;
label values anumyear anumyear;
label define anumyear
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epensnyn epensnyn;
label define epensnyn
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apensnyn apensnyn;
label define apensnyn
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eincpens eincpens;
label define eincpens
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aincpens aincpens;
label define aincpens
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoina01 enoina0s;
label define enoina0s
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina02 enoina0k;
label define enoina0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina03 enoina0l;
label define enoina0l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina04 enoina0m;
label define enoina0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina05 enoina0n;
label define enoina0n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina06 enoina0o;
label define enoina0o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina07 enoina0p;
label define enoina0p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina08 enoina0q;
label define enoina0q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina09 enoina0r;
label define enoina0r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina10 enoina1s;
label define enoina1s
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina11 enoina1k;
label define enoina1k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina12 enoina1l;
label define enoina1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina13 enoina1m;
label define enoina1m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoina14 enoina1n;
label define enoina1n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoina   anoina; 
label define anoina  
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values etdeffen etdeffen;
label define etdeffen
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values atdeffen atdeffen;
label define atdeffen
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emultpen emultpen;
label define emultpen
	-1          "Not in universe"               
;
label values amultpen amultpen;
label define amultpen
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e1pentyp e1pentyp;
label define e1pentyp
	-1          "Not in universe"               
	1           "Plan based on earnings and years"
	2           "Individual account plan"       
;
label values a1pentyp a1pentyp;
label define a1pentyp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e2pentyp e2pentyp;
label define e2pentyp
	-1          "Not in universe"               
	1           "Plan based on earnings and years"
	2           "Individual account plan"       
;
label values a2pentyp a2pentyp;
label define a2pentyp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e1penctr e1penctr;
label define e1penctr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a1penctr a1penctr;
label define a1penctr
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e1taxdef e1taxdef;
label define e1taxdef
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a1taxdef a1taxdef;
label define a1taxdef
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e1recben e1recben;
label define e1recben
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a1recben a1recben;
label define a1recben
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e1lvlmps e1lvlmps;
label define e1lvlmps
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a1lvlmps a1lvlmps;
label define a1lvlmps
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t1yrsinc t1yrsinc;
label define t1yrsinc
	-1          "Not in universe"               
;
label values a1yrsinc a1yrsinc;
label define a1yrsinc
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e1ssofst e1ssofst;
label define e1ssofst
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Do not participate in Social"  
;
label values a1ssofst a1ssofst;
label define a1ssofst
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t1yrcont t1yrcont;
label define t1yrcont
	0           "Not in universe"               
;
label values a1yrcont a1yrcont;
label define a1yrcont
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t1totamt t1totamt;
label define t1totamt
	0           "Not in universe"               
;
label values a1totamt a1totamt;
label define a1totamt
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e2penctr e2penctr;
label define e2penctr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a2penctr a2penctr;
label define a2penctr
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e2taxdef e2taxdef;
label define e2taxdef
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a2taxdef a2taxdef;
label define a2taxdef
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e2recben e2recben;
label define e2recben
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a2recben a2recben;
label define a2recben
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e2lvlmps e2lvlmps;
label define e2lvlmps
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a2lvlmps a2lvlmps;
label define a2lvlmps
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t2yrsinc t2yrsinc;
label define t2yrsinc
	-1          "Not in universe"               
;
label values a2yrsinc a2yrsinc;
label define a2yrsinc
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e2ssofst e2ssofst;
label define e2ssofst
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Do not participate in Social"  
;
label values a2ssofst a2ssofst;
label define a2ssofst
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t2yrcont t2yrcont;
label define t2yrcont
	0           "Not in universe"               
;
label values a2yrcont a2yrcont;
label define a2yrcont
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t2totamt t2totamt;
label define t2totamt
	0           "Not in universe"               
;
label values a2totamt a2totamt;
label define a2totamt
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e3taxdef e3taxdef;
label define e3taxdef
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a3taxdef a3taxdef;
label define a3taxdef
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values e3partic e3partic;
label define e3partic
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values a3partic a3partic;
label define a3partic
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values enoinb01 enoinb0c;
label define enoinb0c
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb02 enoinb0k;
label define enoinb0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb03 enoinb0l;
label define enoinb0l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb04 enoinb0m;
label define enoinb0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb05 enoinb0n;
label define enoinb0n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb06 enoinb0o;
label define enoinb0o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb07 enoinb0p;
label define enoinb0p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb08 enoinb0q;
label define enoinb0q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb09 enoinb0r;
label define enoinb0r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb10 enoinb1c;
label define enoinb1c
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb11 enoinb1k;
label define enoinb1k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb12 enoinb1l;
label define enoinb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb13 enoinb1m;
label define enoinb1m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values enoinb14 enoinb1n;
label define enoinb1n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anoinb   anoinb; 
label define anoinb  
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values efutpart efutpart;
label define efutpart
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values afutpart afutpart;
label define afutpart
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tslfcon1 tslfcont;
label define tslfcont
	-4          "No contributions"              
	0           "Not in universe"               
;
label values eslfcon2 eslfcont;
label define eslfcont
	-1          "Not in universe"               
	1           "Week"                          
	2           "Biweekly"                      
	3           "Month"                         
	4           "Quarter"                       
	5           "Year"                          
;
label values eslfcon3 eslfconk;
label define eslfconk
	-1          "Not in universe"               
;
label values aslfcon  aslfcon;
label define aslfcon 
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eempcont eempcont;
label define eempcont
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aempcont aempcont;
label define aempcont
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values econtdep econtdep;
label define econtdep
	-1          "Not in universe"               
	1           "Depends entirely"              
	2           "Depends partly"                
	3           "Not at all"                    
;
label values acontdep acontdep;
label define acontdep
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tjbcont1 tjbcontp;
label define tjbcontp
	0           "Not in universe"               
;
label values ejbcont2 ejbcontp;
label define ejbcontp
	-1          "Not in universe"               
	1           "Week"                          
	2           "Biweekly"                      
	3           "Month"                         
	4           "Quarter"                       
	5           "Year"                          
;
label values ejbcont3 ejbcontk;
label define ejbcontk
	-1          "Not in universe"               
;
label values ejbcont4 ejbcontl;
label define ejbcontl
	-1          "Not in universe"               
	6           "Contributions out of profits"  
	7           "Contribution varies"           
;
label values ajbcont  ajbcont;
label define ajbcont 
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values einvchos einvchos;
label define einvchos
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ainvchos ainvchos;
label define ainvchos
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values einvsdec einvsdec;
label define einvsdec
	-1          "Not in universe"               
	1           "All of the money"              
	2           "Part of the money"             
;
label values ainvsdec ainvsdec;
label define ainvsdec
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehowinv1 ehowinvc;
label define ehowinvc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv2 ehowinvk;
label define ehowinvk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv3 ehowinvl;
label define ehowinvl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv4 ehowinvm;
label define ehowinvm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv5 ehowinvn;
label define ehowinvn
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv6 ehowinvo;
label define ehowinvo
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv7 ehowinvp;
label define ehowinvp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehowinv8 ehowinvq;
label define ehowinvq
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahowinvs ahowinvs;
label define ahowinvs
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rmostinv rmostinv;
label define rmostinv
	-1          "Not in universe"               
	1           "Employer company stock"        
	2           "Stock funds"                   
	3           "Corporate bonds or bond funds" 
	4           "Long term interest bearing"    
	5           "Diversified stock and bond funds"
	6           "Government securities"         
	7           "Money market funds"            
	8           "Other investments"             
;
label values amostinv amostinv;
label define amostinv
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values t3totamt t3totamt;
label define t3totamt
	0           "Not in universe"               
;
label values a3totamt a3totamt;
label define a3totamt
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epenloan epenloan;
label define epenloan
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apenloan apenloan;
label define apenloan
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eletloan eletloan;
label define eletloan
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aletloan aletloan;
label define aletloan
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tloanbal tloanbal;
label define tloanbal
	0           "Not in universe"               
;
label values aloanbal aloanbal;
label define aloanbal
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eothrpen eothrpen;
label define eothrpen
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aothrpen aothrpen;
label define aothrpen
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eprevpen eprevpen;
label define eprevpen
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aprevpen aprevpen;
label define aprevpen
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eprevexp eprevexp;
label define eprevexp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aprevexp aprevexp;
label define aprevexp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tprevyrs tprevyrs;
label define tprevyrs
	-1          "Not in universe"               
;
label values aprevyrs aprevyrs;
label define aprevyrs
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eprevtyp eprevtyp;
label define eprevtyp
	-1          "Not in universe"               
	1           "Based on a formula"            
	2           "Based on the amount of money in"
;
label values aprevtyp aprevtyp;
label define aprevtyp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tprevamt tprevamt;
label define tprevamt
	0           "Not in universe"               
;
label values aprevamt aprevamt;
label define aprevamt
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eprewith eprewith;
label define eprewith
	-1          "Not in universe"               
	1           "Could withdraw money now"      
	2           "Must wait until retirement"    
;
label values aprewith aprewith;
label define aprewith
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eprevlmp eprevlmp;
label define eprevlmp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aprevlmp aprevlmp;
label define aprevlmp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values esurvlmp esurvlmp;
label define esurvlmp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asurvlmp asurvlmp;
label define asurvlmp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elumpnum elumpnum;
label define elumpnum
	-1          "Not in universe"               
;
label values alumpnum alumpnum;
label define alumpnum
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elmpyear elmpyear;
label define elmpyear
	-1          "Not in universe"               
;
label values almpyear almpyear;
label define almpyear
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elumpn97 elumpn9r;
label define elumpn9r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values alumpn97 alumpn9r;
label define alumpn9r
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elumpsrc elumpsrc;
label define elumpsrc
	-1          "Not in universe"               
	1           "Private employer or union plan"
	2           "Military plan"                 
	3           "Other federal plans"           
	4           "State or local government"     
	5           "Other"                         
;
label values alumpsrc alumpsrc;
label define alumpsrc
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elumphow elumphow;
label define elumphow
	-1          "Not in universe"               
	1           "Voluntarily"                   
	2           "Required to withdraw"          
;
label values alumphow alumphow;
label define alumphow
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tlumptot tlumptot;
label define tlumptot
	0           "Not in universe"               
;
label values alumptot alumptot;
label define alumptot
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elumprec elumprec;
label define elumprec
	-1          "Not in universe"               
	1           "Actually received"             
	2           "Directly rolled over"          
;
label values alumprec alumprec;
label define alumprec
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elmproll elmproll;
label define elmproll
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almproll almproll;
label define almproll
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elmpwher elmpwher;
label define elmpwher
	-1          "Not in universe"               
	1           "Plan on job"                   
	2           "Individual annuity"            
	3           "IRA"                           
	4           "Other"                         
;
label values almpwher almpwher;
label define almpwher
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elumpent elumpent;
label define elumpent
	-1          "Not in universe"               
	1           "Entire amount"                 
	2           "Partial amount"                
;
label values alumpent alumpent;
label define alumpent
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elmpsp01 elmpsp0t;
label define elmpsp0t
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp02 elmpsp0k;
label define elmpsp0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp03 elmpsp0l;
label define elmpsp0l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp04 elmpsp0m;
label define elmpsp0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp05 elmpsp0n;
label define elmpsp0n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp06 elmpsp0o;
label define elmpsp0o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp07 elmpsp0p;
label define elmpsp0p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp08 elmpsp0q;
label define elmpsp0q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp09 elmpsp0r;
label define elmpsp0r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp10 elmpsp1t;
label define elmpsp1t
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp11 elmpsp1k;
label define elmpsp1k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp12 elmpsp1l;
label define elmpsp1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp13 elmpsp1m;
label define elmpsp1m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp14 elmpsp1n;
label define elmpsp1n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp15 elmpsp1o;
label define elmpsp1o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp16 elmpsp1p;
label define elmpsp1p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp17 elmpsp1q;
label define elmpsp1q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp18 elmpsp1r;
label define elmpsp1r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values elmpsp19 elmpsp1s;
label define elmpsp1s
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almpsp   almpsp; 
label define almpsp  
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epenlng1 epenlngp;
label define epenlngp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values epenlng2 epenlngk;
label define epenlngk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values epengng3 epengngp;
label define epengngp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apenlgth apenlgth;
label define apenlgth
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epennumb epennumb;
label define epennumb
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apennumb apennumb;
label define apennumb
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epennums epennums;
label define epennums
	-1          "Not in universe"               
;
label values apennums apennums;
label define apennums
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epensrce epensrce;
label define epensrce
	-1          "Not in universe"               
	1           "Respondent's job"              
	2           "Former spouse's job"           
	3           "Other"                         
;
label values apensrce apensrce;
label define apensrce
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epenwhen epenwhen;
label define epenwhen
	-1          "Not in universe"               
;
label values apenwhen apenwhen;
label define apenwhen
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epenbase epenbase;
label define epenbase
	-1          "Not in universe"               
	1           "Years of service and pay"      
	2           "Amount in individual account"  
;
label values apenbase apenbase;
label define apenbase
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epensurv epensurv;
label define epensurv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "No survivor's option offered"  
;
label values apensurv apensurv;
label define apensurv
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epenincr epenincr;
label define epenincr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apenincr apenincr;
label define apenincr
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values epencola epencola;
label define epencola
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apencola apencola;
label define apencola
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ependecr ependecr;
label define ependecr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apendecr apendecr;
label define apendecr
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tpensamt tpensamt;
label define tpensamt
	0           "Not in universe"               
;
label values apensamt apensamt;
label define apensamt
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tpenamt1 tpenamtt;
label define tpenamtt
	0           "Not in universe"               
;
label values apenamt1 apenamtt;
label define apenamtt
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values elmpsrce elmpsrce;
label define elmpsrce
	-1          "Not in universe"               
	1           "Respondent's former job"       
	2           "Former spouse's job"           
	3           "Other"                         
;
label values almpsrce almpsrce;
label define almpsrce
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ejobreti ejobreti;
label define ejobreti
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajobreti ajobreti;
label define ajobreti
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewrk5yrs ewrk5yrs;
label define ewrk5yrs
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awrk5yrs awrk5yrs;
label define awrk5yrs
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values escrepen escrepen;
label define escrepen
	-1          "Not in universe"               
	1           "Job"                           
	2           "Business"                      
;
label values ascrepen ascrepen;
label define ascrepen
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ejbindrp ejbindrp;
label define ejbindrp
	-1          "Not in universe"               
;
label values ajbindrp ajbindrp;
label define ajbindrp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tjboccrp tjboccrp;
label define tjboccrp
	-1          "Not in universe"               
;
label values ajboccrp ajboccrp;
label define ajboccrp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rclwrkr  rclwrkr;
label define rclwrkr 
	-1          "Not in universe"               
	1           "Private for profit employee"   
	2           "Private not for profit employee"
	3           "Local government worker"       
	4           "State government worker"       
	5           "Federal government worker"     
	6           "Family worker without pay"     
	7           "Active duty Armed Forces"      
;
label values aclwrkr  aclwrkr;
label define aclwrkr 
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values emultloc emultloc;
label define emultloc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amultloc amultloc;
label define amultloc
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tnumwork tnumwork;
label define tnumwork
	-1          "Not in universe"               
	1           "Less than 10"                  
	2           "10 to 24"                      
	3           "25 to 49"                      
	4           "50 to 99"                      
	5           "100 or more"                   
;
label values anumwork anumwork;
label define anumwork
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values templall templall;
label define templall
	-1          "Not in universe"               
	1           "Less than 10"                  
	2           "10 to 24"                      
	3           "25 to 49"                      
	4           "50 to 99"                      
	5           "100 or more"                   
;
label values aemplall aemplall;
label define aemplall
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eunionyn eunionyn;
label define eunionyn
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aunionyn aunionyn;
label define aunionyn
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values thrsweek thrsweek;
label define thrsweek
	-1          "Not in universe"               
;
label values ahrsweek ahrsweek;
label define ahrsweek
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ewksyrs  ewksyrs;
label define ewksyrs 
	-1          "Not in universe"               
;
label values awksyrs  awksyrs;
label define awksyrs 
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tyrswrkd tyrswrkd;
label define tyrswrkd
	-1          "Not in universe"               
;
label values ayrswrkd ayrswrkd;
label define ayrswrkd
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eyrlrftj eyrlrftj;
label define eyrlrftj
	-1          "Not in universe"               
;
label values ayrlrftj ayrlrftj;
label define ayrlrftj
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ternlev1 ternlevj;
label define ternlevj
	0           "Not in universe"               
;
label values eernlev2 eernlevj;
label define eernlevj
	-1          "Not in universe"               
	1           "Per week"                      
	2           "Biweekly"                      
	3           "Per month"                     
	4           "Per year"                      
;
label values aernleav aernleav;
label define aernleav
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ehlthpln ehlthpln;
label define ehlthpln
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahlthpln ahlthpln;
label define ahlthpln
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tbsindrp tbsindrp;
label define tbsindrp
	-1          "Not in universe"               
	1           "Agriculture, Forestry and"     
	2           "Mining"                        
	3           "Construction"                  
	4           "Manufacturing Nondurable Goods"
	5           "Manufacturing Durable Goods"   
	6           "Transportation, Communications"
	7           "Wholesale Trade Durable Goods" 
	8           "Wholesale trade Nondurable Goods"
	9           "Retail Trade"                  
	10          "Finance, Insurance, and Real"  
	11          "Business and Repair Services"  
	12          "Personal Services"             
	13          "Entertainment and Recreation"  
	14          "Professional and Related"      
	15          "Public Administration"         
;
label values absindrp absindrp;
label define absindrp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebsoccrp ebsoccrp;
label define ebsoccrp
	-1          "Not in universe"               
;
label values absoccrp absoccrp;
label define absoccrp
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tmakempl tmakempl;
label define tmakempl
	-1          "Not in universe"               
	1           "Less than 10"                  
	2           "10 to 24"                      
	3           "25 to 49"                      
	4           "50 to 99"                      
	5           "100 or more"                   
;
label values amakempl amakempl;
label define amakempl
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebusninc ebusninc;
label define ebusninc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abusninc abusninc;
label define abusninc
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tbushrsw tbushrsw;
label define tbushrsw
	-1          "Not in universe"               
;
label values abushrsw abushrsw;
label define abushrsw
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebuswksy ebuswksy;
label define ebuswksy
	-1          "Not in universe"               
;
label values abuswksy abuswksy;
label define abuswksy
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tbuslong tbuslong;
label define tbuslong
	-1          "Not in universe"               
;
label values abuslong abuslong;
label define abuslong
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebusleav ebusleav;
label define ebusleav
	-1          "Not in universe"               
;
label values abusleav abusleav;
label define abusleav
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values tbusern1 tbusernv;
label define tbusernv
	0           "Not in universe"               
;
label values ebusern2 ebusernv;
label define ebusernv
	-1          "Not in universe"               
	1           "Per week"                      
	2           "Biweekly"                      
	3           "Per month"                     
	4           "Per year"                      
;
label values abusern  abusern;
label define abusern 
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ebushlth ebushlth;
label define ebushlth
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abushlth abushlth;
label define abushlth
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values estdlvng estdlvng;
label define estdlvng
	-1          "Not in universe"               
;
label values astdlvng astdlvng;
label define astdlvng
	0           "Not imputed"                   
	1           "Statistical imputation (hotdeck)"
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
