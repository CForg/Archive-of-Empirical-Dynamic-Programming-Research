log using sip96t8, text replace
set mem 500m
*This program reads the 1996 SIPP Wave 8 Topical Module Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*by Jean Roth Tue Nov  4 11:38:40 EST 2003
*Please report errors to jroth@nber.org
*run with do sip96t8
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp/1996\sip96t8.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96t8

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
label values eawbunv  eawbunv;
label define eawbunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values radwash  radwash;
label define radwash 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "Not in home, but one is provided"
	3           "No, no washing machine"        
;
label values aadwash  aadwash;
label define aadwash 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values raddryr  raddryr;
label define raddryr 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "Not in home, but one is provided"
	3           "No, no clothes dryer"          
;
label values aaddryr  aaddryr;
label define aaddryr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eaddish  eaddish;
label define eaddish 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no dishwasher"             
;
label values aaddish  aaddish;
label define aaddish 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadrefr  eadrefr;
label define eadrefr 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no refrigerator"           
;
label values aadrefr  aadrefr;
label define aadrefr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadfrz   eadfrz; 
label define eadfrz  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no food freezer"           
;
label values aadfrz   aadfrz; 
label define aadfrz  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadtelv  eadtelv;
label define eadtelv 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no television"             
;
label values aadtelv  aadtelv;
label define aadtelv 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadstov  eadstov;
label define eadstov 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no stove"                  
;
label values aadstov  aadstov;
label define aadstov 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadmicr  eadmicr;
label define eadmicr 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no microwave"              
;
label values aadmicr  aadmicr;
label define aadmicr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadvcr   eadvcr; 
label define eadvcr  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no videocassette recorder" 
;
label values aadvcr   aadvcr; 
label define aadvcr  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadair   eadair; 
label define eadair  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no air conditioning"       
;
label values aadair   aadair; 
label define aadair  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadcomp  eadcomp;
label define eadcomp 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no personal computer"      
;
label values aadcomp  aadcomp;
label define aadcomp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eadcell  eadcell;
label define eadcell 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No, no cell phone"             
;
label values aadcell  aadcell;
label define aadcell 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values radphon  radphon;
label define radphon 
	-1          "Not in universe"               
	1           "Phone in home"                 
	2           "Can be reached at neighbor's," 
	3           "Can be reached on cell phone." 
	4           "Can be reached by other device."
	5           "No, cannot be reached by"      
;
label values aadphon  aadphon;
label define aadphon 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahroom  eahroom;
label define eahroom 
	-1          "Not in universe"               
	20          "Twenty or more rooms"          
;
label values aahroom  aahroom;
label define aahroom 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahpest  eahpest;
label define eahpest 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eahleak  eahleak;
label define eahleak 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eahwind  eahwind;
label define eahwind 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eahwire  eahwire;
label define eahwire 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eahplum  eahplum;
label define eahplum 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eahcrac  eahcrac;
label define eahcrac 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eahhole  eahhole;
label define eahhole 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aahouse  aahouse;
label define aahouse 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahrepr  eahrepr;
label define eahrepr 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aahrepr  aahrepr;
label define aahrepr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahspac  eahspac;
label define eahspac 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aahspac  aahspac;
label define aahspac 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahfurn  eahfurn;
label define eahfurn 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aahfurn  aahfurn;
label define aahfurn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahwarm  eahwarm;
label define eahwarm 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aahwarm  aahwarm;
label define aahwarm 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahcool  eahcool;
label define eahcool 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aahcool  aahcool;
label define aahcool 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahpriv  eahpriv;
label define eahpriv 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aahpriv  aahpriv;
label define aahpriv 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahsat   eahsat; 
label define eahsat  
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
;
label values aahsat   aahsat; 
label define aahsat  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rahmove  rahmove;
label define rahmove 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aahmove  aahmove;
label define aahmove 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eacwalk  eacwalk;
label define eacwalk 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aacwalk  aacwalk;
label define aacwalk 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eacstay  eacstay;
label define eacstay 
	-1          "Not in universe"               
	1           "Stayed in our home at certain" 
	2           "Did not stay in home."         
;
label values aacstay  aacstay;
label define aacstay 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eacwith  eacwith;
label define eacwith 
	-1          "Not in universe"               
	1           "Has taken someone with."       
	2           "Did not take someone with."    
;
label values aacwith  aacwith;
label define aacwith 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eacarry  eacarry;
label define eacarry 
	-1          "Not in universe"               
	1           "Carried anything to protect"   
	2           "Did not carry anything."       
;
label values aacarry  aacarry;
label define aacarry 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eacnsaf  eacnsaf;
label define eacnsaf 
	-1          "Not in universe"               
	1           "Very safe"                     
	2           "Somewhat safe"                 
	3           "Somewhat unsafe"               
	4           "Very unsafe"                   
;
label values aacnsaf  aacnsaf;
label define aacnsaf 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eachsaf  eachsaf;
label define eachsaf 
	-1          "Not in universe"               
	1           "Very safe"                     
	2           "Somewhat safe"                 
	3           "Somewhat unsafe"               
	4           "Very unsafe"                   
;
label values aachsaf  aachsaf;
label define aachsaf 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values racwdog  racwdog;
label define racwdog 
	-1          "Not in universe"               
	1           "Has dog to keep home safe from"
	2           "Has dog, not to keep home safe"
	3           "Does not have dog"             
;
label values aacwdog  aacwdog;
label define aacwdog 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eacalrm  eacalrm;
label define eacalrm 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aacalrm  aacalrm;
label define aacalrm 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values racmove  racmove;
label define racmove 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aacmove  aacmove;
label define aacmove 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eantraf  eantraf;
label define eantraf 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eanstrt  eanstrt;
label define eanstrt 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eantrsh  eantrsh;
label define eantrsh 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eanaban  eanaban;
label define eanaban 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eanind   eanind; 
label define eanind  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eanodor  eanodor;
label define eanodor 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aancond  aancond;
label define aancond 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eanghbr  eanghbr;
label define eanghbr 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
;
label values aanghbr  aanghbr;
label define aanghbr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eansat   eansat; 
label define eansat  
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
;
label values aansat   aansat; 
label define aansat  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ranmove  ranmove;
label define ranmove 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aanmove  aanmove;
label define aanmove 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapschl  eapschl;
label define eapschl 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
;
label values aapschl  aapschl;
label define aapschl 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eappriv  eappriv;
label define eappriv 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aappriv  aappriv;
label define aappriv 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapmagn  eapmagn;
label define eapmagn 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aapmagn  aapmagn;
label define aapmagn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eappubs  eappubs;
label define eappubs 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aappubs  aappubs;
label define aappubs 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eaphoms  eaphoms;
label define eaphoms 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaphoms  aaphoms;
label define aaphoms 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapnosc  eapnosc;
label define eapnosc 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aapnosc  aapnosc;
label define aapnosc 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapdiff  eapdiff;
label define eapdiff 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aapdiff  aapdiff;
label define aapdiff 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eaphosp  eaphosp;
label define eaphosp 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aaphosp  aaphosp;
label define aaphosp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapolic  eapolic;
label define eapolic 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aapolic  aapolic;
label define aapolic 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapfire  eapfire;
label define eapfire 
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
	5           "Haven't lived here long enough"
;
label values aapfire  aapfire;
label define aapfire 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eaptran  eaptran;
label define eaptran 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Not sure because you do not use"
;
label values aaptran  aaptran;
label define aaptran 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eapsat   eapsat; 
label define eapsat  
	-1          "Not in universe"               
	1           "Very satisfied"                
	2           "Somewhat satisfied"            
	3           "Somewhat dissatisfied"         
	4           "Very dissatisfied"             
;
label values aapsat   aapsat; 
label define aapsat  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rapmove  rapmove;
label define rapmove 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aapmove  aapmove;
label define aapmove 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabmeet  eabmeet;
label define eabmeet 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabmeet  aabmeet;
label define aabmeet 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabrent  eabrent;
label define eabrent 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabrent  aabrent;
label define aabrent 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabrhlp1 rabrhlpt;
label define rabrhlpt
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabrhlp2 rabrhlpk;
label define rabrhlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabrhlp3 rabrhlpl;
label define rabrhlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabrhlp4 rabrhlpm;
label define rabrhlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabrhlp5 rabrhlpn;
label define rabrhlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values aabrhlp  aabrhlp;
label define aabrhlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabevct  eabevct;
label define eabevct 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabevct  aabevct;
label define aabevct 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabehlp1 rabehlpt;
label define rabehlpt
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not  received from this"  
	3           "No help received from any source"
;
label values rabehlp2 rabehlpk;
label define rabehlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not  received from this"  
	3           "No help received from any source"
;
label values rabehlp3 rabehlpl;
label define rabehlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not  received from this"  
	3           "No help received from any source"
;
label values rabehlp4 rabehlpm;
label define rabehlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not  received from this"  
	3           "No help received from any source"
;
label values rabehlp5 rabehlpn;
label define rabehlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not  received from this"  
	3           "No help received from any source"
;
label values aabehlp  aabehlp;
label define aabehlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabgas   eabgas; 
label define eabgas  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabgas   aabgas; 
label define aabgas  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabghlp1 rabghlps;
label define rabghlps
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabghlp2 rabghlpk;
label define rabghlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabghlp3 rabghlpl;
label define rabghlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabghlp4 rabghlpm;
label define rabghlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabghlp5 rabghlpn;
label define rabghlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values aabghlp  aabghlp;
label define aabghlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabcut   eabcut; 
label define eabcut  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabcut   aabcut; 
label define aabcut  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabchlp1 rabchlpt;
label define rabchlpt
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabchlp2 rabchlpk;
label define rabchlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabchlp3 rabchlpl;
label define rabchlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabchlp4 rabchlpm;
label define rabchlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabchlp5 rabchlpn;
label define rabchlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values aabchlp  aabchlp;
label define aabchlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabphon  eabphon;
label define eabphon 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabphon  aabphon;
label define aabphon 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabphlp1 rabphlpn;
label define rabphlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabphlp2 rabphlpk;
label define rabphlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabphlp3 rabphlpl;
label define rabphlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabphlp4 rabphlpm;
label define rabphlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabphlp5 rabphlpo;
label define rabphlpo
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values aabphlp  aabphlp;
label define aabphlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabdoct  eabdoct;
label define eabdoct 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabdoct  aabdoct;
label define aabdoct 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabdhlp1 rabdhlpt;
label define rabdhlpt
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabdhlp2 rabdhlpk;
label define rabdhlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabdhlp3 rabdhlpl;
label define rabdhlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabdhlp4 rabdhlpm;
label define rabdhlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabdhlp5 rabdhlpn;
label define rabdhlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values aabdhlp  aabdhlp;
label define aabdhlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eabdent  eabdent;
label define eabdent 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aabdent  aabdent;
label define aabdent 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rabthlp1 rabthlpt;
label define rabthlpt
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabthlp2 rabthlpk;
label define rabthlpk
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabthlp3 rabthlpl;
label define rabthlpl
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabthlp4 rabthlpm;
label define rabthlpm
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values rabthlp5 rabthlpn;
label define rabthlpn
	-1          "Not in universe"               
	1           "Help received from this source"
	2           "Help not received from this"   
	3           "No help received from any source"
;
label values aabthlp  aabthlp;
label define aabthlp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahlpfm  eahlpfm;
label define eahlpfm 
	-1          "Not in universe"               
	1           "All of the help needed"        
	2           "Most of the help needed"       
	3           "Very little of the help needed"
	4           "No help"                       
;
label values aahlpfm  aahlpfm;
label define aahlpfm 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahlpfr  eahlpfr;
label define eahlpfr 
	-1          "Not in universe"               
	1           "All of the help needed"        
	2           "Most of the help needed"       
	3           "Very little of the help needed"
	4           "No help"                       
;
label values aahlpfr  aahlpfr;
label define aahlpfr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eahlpag  eahlpag;
label define eahlpag 
	-1          "Not in universe"               
	1           "All of the help needed"        
	2           "Most of the help needed"       
	3           "Very little of the help needed"
	4           "No help"                       
;
label values aahlpag  aahlpag;
label define aahlpag 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eafood1  eafood1l;
label define eafood1l
	-1          "Not in universe"               
	1           "Enough of the kinds of food we"
	2           "Enough but not always the kinds"
	3           "Sometimes not enough to eat"   
	4           "Often not enough to eat"       
;
label values aafood1  aafood1l;
label define aafood1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eafdm1   eafdm1l;
label define eafdm1l 
	-1          "Not in universe"               
	1           "Yes, did not have enough to eat"
	2           "No, enough to eat"             
;
label values eafdm2   eafdm2l;
label define eafdm2l 
	-1          "Not in universe"               
	1           "Yes, did not have enough to eat"
	2           "No, enough to eat"             
;
label values eafdm3   eafdm3l;
label define eafdm3l 
	-1          "Not in universe"               
	1           "Yes, did not have enough to eat"
	2           "No, enough to eat"             
;
label values eafdm4   eafdm4l;
label define eafdm4l 
	-1          "Not in universe"               
	1           "Yes, did not have enough to eat"
	2           "No, enough to eat"             
;
label values eafdm5   eafdm5l;
label define eafdm5l 
	-1          "Not in universe"               
	1           "Yes, did not have enough to eat"
	2           "No, enough to eat"             
;
label values aafdm    aafdm;  
label define aafdm   
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)}"
;
label values eaflast  eaflast;
label define eaflast 
	-1          "Not in universe"               
	1           "Often true"                    
	2           "Sometimes true"                
	3           "Never true"                    
;
label values aaflast  aaflast;
label define aaflast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)}"
;
label values eafbaln  eafbaln;
label define eafbaln 
	-1          "Not in universe"               
	1           "Often true"                    
	2           "Sometimes true"                
	3           "Never true"                    
;
label values aafbaln  aafbaln;
label define aafbaln 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eafchld  eafchld;
label define eafchld 
	-1          "Not in universe"               
	1           "Often true"                    
	2           "Sometimes true"                
	3           "Never true"                    
;
label values aafchld  aafchld;
label define aafchld 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eafskip  eafskip;
label define eafskip 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafskip  aafskip;
label define aafskip 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eafless  eafless;
label define eafless 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafless  aafless;
label define aafless 
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eafday   eafday; 
label define eafday  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafday   aafday; 
label define aafday  
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values eawrunv  eawrunv;
label define eawrunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values iinccat  iinccat;
label define iinccat 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "less than  $10,000"            
	2           "$10,000 to $19,999"            
	3           "$20,000 to $29,999"            
	4           "$30,000 to $39,999"            
	5           "$40,000 to $49,999"            
	6           "$50,000 or more"               
;
label values ipayn    ipayn;  
label define ipayn   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ipayn2   ipayn2l;
label define ipayn2l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijobhyn  ijobhyn;
label define ijobhyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ivochyn  ivochyn;
label define ivochyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itraihyn itraihyn;
label define itraihyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itranhyn itranhyn;
label define itranhyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ichilhyn ichilhyn;
label define ichilhyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ifoodhyn ifoodhyn;
label define ifoodhyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iclothyn iclothyn;
label define iclothyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ihoushyn ihoushyn;
label define ihoushyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values idivehyn idivehyn;
label define idivehyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icsuphyn icsuphyn;
label define icsuphyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothhyn  iothhyn;
label define iothhyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijobhelp ijobhelp;
label define ijobhelp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ireqinc  ireqinc;
label define ireqinc 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ireqcs   ireqcs; 
label define ireqcs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ireqpat  ireqpat;
label define ireqpat 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ireqdt   ireqdt; 
label define ireqdt  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ireqad   ireqad; 
label define ireqad  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ireqoth  ireqoth;
label define ireqoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icstype  icstype;
label define icstype 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Required to do workfare"       
	2           "Chose to do workfare"          
	3           "Both required and chose"       
;
label values ilwtype  ilwtype;
label define ilwtype 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Required to look for work"     
	2           "Chose to look for work"        
	3           "Both required and chose"       
;
label values iwktype  iwktype;
label define iwktype 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Required to work"              
	2           "Chose to work"                 
	3           "Both required and chose"       
;
label values itrtype  itrtype;
label define itrtype 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Required to attend school /"   
	2           "Chose to attend school/ training"
	3           "Both required and chose"       
;
label values ihcpyn   ihcpyn; 
label define ihcpyn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iedcc    iedcc;  
label define iedcc   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iedgo    iedgo;  
label define iedgo   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iedpc    iedpc;  
label define iedpc   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iedoth   iedoth; 
label define iedoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhrusu  ijhrusu;
label define ijhrusu 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhint   ijhint; 
label define ijhint  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhdres  ijhdres;
label define ijhdres 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhself  ijhself;
label define ijhself 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhcomp  ijhcomp;
label define ijhcomp 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhcler  ijhcler;
label define ijhcler 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhmach  ijhmach;
label define ijhmach 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhojs   ijhojs; 
label define ijhojs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhged   ijhged; 
label define ijhged  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhcol   ijhcol; 
label define ijhcol  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhlit   ijhlit; 
label define ijhlit  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhjlis  ijhjlis;
label define ijhjlis 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijheng   ijheng; 
label define ijheng  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhoth   ijhoth; 
label define ijhoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhjobyn ijhjobyn;
label define ijhjobyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhpayyn ijhpayyn;
label define ijhpayyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhhrs   ijhhrs; 
label define ijhhrs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ijhpart  ijhpart;
label define ijhpart 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ijhsmon  ijhsmon;
label define ijhsmon 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ijhsyear ijhsyear;
label define ijhsyear
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ijhfmon  ijhfmon;
label define ijhfmon 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ijhfyear ijhfyear;
label define ijhfyear
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ijhfwhen ijhfwhen;
label define ijhfwhen
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "When respondent finds a job"   
;
label values itrhrs   itrhrs; 
label define itrhrs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itrfmon  itrfmon;
label define itrfmon 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itrweek  itrweek;
label define itrweek 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itrmon   itrmon; 
label define itrmon  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itryear  itryear;
label define itryear 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itrhrs2  itrhrs2l;
label define itrhrs2l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itrcomyn itrcomyn;
label define itrcomyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Completed the program"         
	2           "Left before it was over"       
;
label values ilvjob   ilvjob; 
label define ilvjob  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilveduc  ilveduc;
label define ilveduc 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvtran  ilvtran;
label define ilvtran 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvchil  ilvchil;
label define ilvchil 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvill   ilvill; 
label define ilvill  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvnohel ilvnohel;
label define ilvnohel
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvnoins ilvnoins;
label define ilvnoins
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvdis   ilvdis; 
label define ilvdis  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvexemp ilvexemp;
label define ilvexemp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ilvoth   ilvoth; 
label define ilvoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values inumpay  inumpay;
label define inumpay 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Single payment"                
	2           "More than one"                 
;
label values ipayyn   ipayyn; 
label define ipayyn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ipayamt  ipayamt;
label define ipayamt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itpayyn  itpayyn;
label define itpayyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itpayamt itpayamt;
label define itpayamt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ieasst1  ieasst1l;
label define ieasst1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ieasst2  ieasst2l;
label define ieasst2l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ieasst3  ieasst3l;
label define ieasst3l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values igasvyn  igasvyn;
label define igasvyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itokyn   itokyn; 
label define itokyn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icaryn   icaryn; 
label define icaryn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values irideyn  irideyn;
label define irideyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothtyn  iothtyn;
label define iothtyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values igovgas  igovgas;
label define igovgas 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothgas  iothgas;
label define iothgas 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values igasamt  igasamt;
label define igasamt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values igsamot  igsamot;
label define igsamot 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Other"                         
;
label values igovtok  igovtok;
label define igovtok 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothtok  iothtok;
label define iothtok 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itokamt  itokamt;
label define itokamt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itoknum  itoknum;
label define itoknum 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itokoth  itokoth;
label define itokoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Other"                         
;
label values igovcar  igovcar;
label define igovcar 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothcar  iothcar;
label define iothcar 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icaramt  icaramt;
label define icaramt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icaroth  icaroth;
label define icaroth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Other"                         
;
label values igovrid  igovrid;
label define igovrid 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values imedirid imedirid;
label define imedirid
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothrid  iothrid;
label define iothrid 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values igovtrn  igovtrn;
label define igovtrn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iothtrn  iothtrn;
label define iothtrn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values itrnamt  itrnamt;
label define itrnamt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values itrnoth  itrnoth;
label define itrnoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Other"                         
;
label values icctype  icctype;
label define icctype 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Paid part of the cost"         
	2           "Free child care"               
	3           "Neither"                       
	4           "Both"                          
;
label values iccpayyn iccpayyn;
label define iccpayyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iccempyn iccempyn;
label define iccempyn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iccwho   iccwho; 
label define iccwho  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "An employer"                   
	2           "A charity"                     
	3           "A relative"                    
	4           "A friend"                      
	5           "Other"                         
;
label values icccov01 icccov0o;
label define icccov0o
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icccov02 icccov0k;
label define icccov0k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icccov03 icccov0l;
label define icccov0l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icccov04 icccov0m;
label define icccov0m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icccov05 icccov0n;
label define icccov0n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icccov06 icccov0p;
label define icccov0p
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icccov07 icccov0q;
label define icccov0q
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iccrel   iccrel; 
label define iccrel  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iccdayc  iccdayc;
label define iccdayc 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iccsitt  iccsitt;
label define iccsitt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iccaft   iccaft; 
label define iccaft  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ifavou   ifavou; 
label define ifavou  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ifagroc  ifagroc;
label define ifagroc 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ifameal  ifameal;
label define ifameal 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ifaoth   ifaoth; 
label define ifaoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ivouga   ivouga; 
label define ivouga  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ivouhar  ivouhar;
label define ivouhar 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ivoufam  ivoufam;
label define ivoufam 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ivouoth  ivouoth;
label define ivouoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ivouamt  ivouamt;
label define ivouamt 
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values ivouamtn ivouamtn;
label define ivouamtn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "No cash value"                 
;
label values ifaga1   ifaga1l;
label define ifaga1l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifachar1 ifacharn;
label define ifacharn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifafam1  ifafam1l;
label define ifafam1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifaoth1  ifaoth1l;
label define ifaoth1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifaho1   ifaho1l;
label define ifaho1l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Once"                          
	2           "Two or three times"            
	3           "Four or more times"            
;
label values ifaga2   ifaga2l;
label define ifaga2l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifachar2 ifachark;
label define ifachark
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifafam2  ifafam2l;
label define ifafam2l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifaoth2  ifaoth2l;
label define ifaoth2l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifaho2   ifaho2l;
label define ifaho2l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Once"                          
	2           "Two or three times"            
	3           "Four or more times"            
;
label values ifaga3   ifaga3l;
label define ifaga3l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifachar3 ifacharl;
label define ifacharl
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifafam3  ifafam3l;
label define ifafam3l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifaoth3  ifaoth3l;
label define ifaoth3l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ifaho3   ifaho3l;
label define ifaho3l 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Once"                          
	2           "Two or three times"            
	3           "Four or more times"            
;
label values icaga    icaga;  
label define icaga   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icachar  icachar;
label define icachar 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icafam   icafam; 
label define icafam  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icaemp   icaemp; 
label define icaemp  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icaoth   icaoth; 
label define icaoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icaamt   icaamt; 
label define icaamt  
	-3          "None"                          
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icanamt  icanamt;
label define icanamt 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Didn't receive money-received" 
;
label values ihatype  ihatype;
label define ihatype 
	-2          "Refused"                       
	0           "Not answered"                  
	1           "Section 8"                     
	2           "Other rental assistance"       
	3           "Not sure/Don't know"           
;
label values ihatype2 ihatypee;
label define ihatypee
	-2          "Refused"                       
	0           "Not answered"                  
	1           "Section 8"                     
	2           "Other rental assistance"       
	3           "Other housing program"         
	4           "Not sure/Don't know"           
;
label values ihaga    ihaga;  
label define ihaga   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihahous  ihahous;
label define ihahous 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihachar  ihachar;
label define ihachar 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihaoth   ihaoth; 
label define ihaoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icashsc  icashsc;
label define icashsc 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Government agency"             
	2           "Family or friends"             
	3           "Someplace else"                
;
label values icashgov icashgov;
label define icashgov
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Federal"                       
	2           "State"                         
	3           "Local"                         
;
label values icashhm  icashhm;
label define icashhm 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icashamt icashamt;
label define icashamt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icashal  icashal;
label define icashal 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icashuse icashuse;
label define icashuse
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Particular use"                
	2           "Whatever was needed"           
;
label values icashren icashren;
label define icashren
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icashfoo icashfoo;
label define icashfoo
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icashcs  icashcs;
label define icashcs 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icashck  icashck;
label define icashck 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icashcar icashcar;
label define icashcar
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icashoth icashoth;
label define icashoth
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsagen  icsagen;
label define icsagen 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icswelf  icswelf;
label define icswelf 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsoth   icsoth; 
label define icsoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icshowm  icshowm;
label define icshowm 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Just one time"                 
	2           "2 or 3 times"                  
	3           "4 or more times"               
;
label values icspat   icspat; 
label define icspat  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icsabs   icsabs; 
label define icsabs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icscourt icscourt;
label define icscourt
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icscoll  icscoll;
label define icscoll 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icsoth2  icsoth2l;
label define icsoth2l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icsgov   icsgov; 
label define icsgov  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icschar  icschar;
label define icschar 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsfam   icsfam; 
label define icsfam  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icselse  icselse;
label define icselse 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsamt   icsamt; 
label define icsamt  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values icsncash icsncash;
label define icsncash
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "No cash value"                 
;
label values icsearl  icsearl;
label define icsearl 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icspart  icspart;
label define icspart 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Particular use"                
	2           "Whatever was needed"           
;
label values icsrent  icsrent;
label define icsrent 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsfood  icsfood;
label define icsfood 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsclos  icsclos;
label define icsclos 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icsclok  icsclok;
label define icsclok 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values icscar   icscar; 
label define icscar  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values isouse   isouse; 
label define isouse  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihcyn    ihcyn;  
label define ihcyn   
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ihcrout  ihcrout;
label define ihcrout 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ihcdrug  ihcdrug;
label define ihcdrug 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values ihcclin  ihcclin;
label define ihcclin 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihcemer  ihcemer;
label define ihcemer 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihcdoct  ihcdoct;
label define ihcdoct 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihcoth   ihcoth; 
label define ihcoth  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ihcpaid  ihcpaid;
label define ihcpaid 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Free"                          
	2           "Paid something"                
	3           "Both"                          
;
label values ihcfull  ihcfull;
label define ihcfull 
	-2          "Refused"                       
	0           "Not answered"                  
	1           "Full price"                    
	2           "Reduced price"                 
	3           "Don't know"                    
;
label values ihcpric  ihcpric;
label define ihcpric 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iwftype  iwftype;
label define iwftype 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "A Government organization,"    
	2           "A private, for profit company" 
	3           "Or a non-profit organization," 
;
label values iwfgtype iwfgtype;
label define iwfgtype
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Federal"                       
	2           "State"                         
	3           "Local (County, City, Township)"
;
label values iwforg   iwforg; 
label define iwforg  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Education"                     
	2           "Social Service"                
	3           "Public Safety"                 
	4           "Recreation"                    
	5           "Health"                        
	6           "Religion"                      
	7           "Or something else?"            
;
label values iwfjob   iwfjob; 
label define iwfjob  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iwfstill iwfstill;
label define iwfstill
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iwfsmon  iwfsmon;
label define iwfsmon 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwfsyear iwfsyear;
label define iwfsyear
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwffmon  iwffmon;
label define iwffmon 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwffyear iwffyear;
label define iwffyear
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwffwhen iwffwhen;
label define iwffwhen
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "When respondent finds a regular,"
;
label values iwfhrs   iwfhrs; 
label define iwfhrs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwfstop  iwfstop;
label define iwfstop 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwfhweek iwfhweek;
label define iwfhweek
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwfhmon  iwfhmon;
label define iwfhmon 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwfhyear iwfhyear;
label define iwfhyear
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwfhhrs  iwfhhrs;
label define iwfhhrs 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
;
label values iwflreg  iwflreg;
label define iwflreg 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwfleduc iwfleduc;
label define iwfleduc
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwfltran iwfltran;
label define iwfltran
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwflcc   iwflcc; 
label define iwflcc  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwflill  iwflill;
label define iwflill 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwfllead iwfllead;
label define iwfllead
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwflsup  iwflsup;
label define iwflsup 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwfldis  iwfldis;
label define iwfldis 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwflexem iwflexem;
label define iwflexem
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwfloth  iwfloth;
label define iwfloth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iwfcore  iwfcore;
label define iwfcore 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
	3           "Not Sure"                      
;
label values idebyn   idebyn; 
label define idebyn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values idebfssi idebfssi;
label define idebfssi
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebsssi idebsssi;
label define idebsssi
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebener idebener;
label define idebener
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebafdc idebafdc;
label define idebafdc
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebga   idebga; 
label define idebga  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebopa  idebopa;
label define idebopa 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebwic  idebwic;
label define idebwic 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebcsp  idebcsp;
label define idebcsp 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebfs   idebfs; 
label define idebfs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ideboth  ideboth;
label define ideboth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebone  idebone;
label define idebone 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values idebstat idebstat;
label define idebstat
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebatm  idebatm;
label define idebatm 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebrecp idebrecp;
label define idebrecp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebot   idebot; 
label define idebot  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values idebdk   idebdk; 
label define idebdk  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqyn   iinqyn; 
label define iinqyn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iinqoyn  iinqoyn;
label define iinqoyn 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iinqafdc iinqafdc;
label define iinqafdc
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqga   iinqga; 
label define iinqga  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqssi  iinqssi;
label define iinqssi 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqfs   iinqfs; 
label define iinqfs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqmcd  iinqmcd;
label define iinqmcd 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqwic  iinqwic;
label define iinqwic 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqunem iinqunem;
label define iinqunem
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqph   iinqph; 
label define iinqph  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqener iinqener;
label define iinqener
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqeduc iinqeduc;
label define iinqeduc
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqcc   iinqcc; 
label define iinqcc  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqtran iinqtran;
label define iinqtran
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqmeal iinqmeal;
label define iinqmeal
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqoth  iinqoth;
label define iinqoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iinqapp  iinqapp;
label define iinqapp 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iappafdc iappafdc;
label define iappafdc
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappga   iappga; 
label define iappga  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappssi  iappssi;
label define iappssi 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappfs   iappfs; 
label define iappfs  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappmcd  iappmcd;
label define iappmcd 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappwic  iappwic;
label define iappwic 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappunem iappunem;
label define iappunem
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappph   iappph; 
label define iappph  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappener iappener;
label define iappener
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappeduc iappeduc;
label define iappeduc
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappcc   iappcc; 
label define iappcc  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iapptran iapptran;
label define iapptran
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappmeal iappmeal;
label define iappmeal
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappoth  iappoth;
label define iappoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappfsmd iappfsmd;
label define iappfsmd
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values iappfood iappfood;
label define iappfood
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values iappmedi iappmedi;
label define iappmedi
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values inindn   inindn; 
label define inindn  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininimm  ininimm;
label define ininimm 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininelig ininelig;
label define ininelig
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values inindk   inindk; 
label define inindk  
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininhas  ininhas;
label define ininhas 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values inintran inintran;
label define inintran
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininchar ininchar;
label define ininchar
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininwort ininwort;
label define ininwort
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininplan ininplan;
label define ininplan
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values ininoth  ininoth;
label define ininoth 
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not answered"                  
	1           "Yes"                           
;
label values inapimm1 inapimmh;
label define inapimmh
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli1 inapelih;
label define inapelih
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas1 inaphash;
label define inaphash
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra1 inaptrah;
label define inaptrah
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor1 inapworh;
label define inapworh
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla1 inapplah;
label define inapplah
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth1 inapothh;
label define inapothh
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm2 inapimmk;
label define inapimmk
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli2 inapelik;
label define inapelik
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas2 inaphask;
label define inaphask
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra2 inaptrak;
label define inaptrak
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor2 inapwork;
label define inapwork
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla2 inapplak;
label define inapplak
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth2 inapothk;
label define inapothk
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm3 inapimml;
label define inapimml
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli3 inapelil;
label define inapelil
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas3 inaphasl;
label define inaphasl
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra3 inaptral;
label define inaptral
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor3 inapworl;
label define inapworl
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla3 inapplal;
label define inapplal
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth3 inapothl;
label define inapothl
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm4 inapimmm;
label define inapimmm
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli4 inapelim;
label define inapelim
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas4 inaphasm;
label define inaphasm
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra4 inaptram;
label define inaptram
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor4 inapworm;
label define inapworm
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla4 inapplam;
label define inapplam
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth4 inapothm;
label define inapothm
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm5 inapimmn;
label define inapimmn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli5 inapelin;
label define inapelin
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas5 inaphasn;
label define inaphasn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra5 inaptran;
label define inaptran
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor5 inapworn;
label define inapworn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla5 inapplan;
label define inapplan
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth5 inapothn;
label define inapothn
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm6 inapimmo;
label define inapimmo
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli6 inapelio;
label define inapelio
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas6 inaphaso;
label define inaphaso
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra6 inaptrao;
label define inaptrao
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor6 inapworo;
label define inapworo
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla6 inapplao;
label define inapplao
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth6 inapotho;
label define inapotho
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm7 inapimmp;
label define inapimmp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli7 inapelip;
label define inapelip
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas7 inaphasp;
label define inaphasp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra7 inaptrap;
label define inaptrap
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor7 inapworp;
label define inapworp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla7 inapplap;
label define inapplap
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth7 inapothp;
label define inapothp
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm8 inapimmq;
label define inapimmq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli8 inapeliq;
label define inapeliq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas8 inaphasq;
label define inaphasq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra8 inaptraq;
label define inaptraq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor8 inapworq;
label define inapworq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla8 inapplaq;
label define inapplaq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth8 inapothq;
label define inapothq
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapimm9 inapimmr;
label define inapimmr
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapeli9 inapelir;
label define inapelir
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaphas9 inaphasr;
label define inaphasr
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptra9 inaptrar;
label define inaptrar
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwor9 inapworr;
label define inapworr
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappla9 inapplar;
label define inapplar
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapoth9 inapothr;
label define inapothr
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapim10 inapim1h;
label define inapim1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapel10 inapel1h;
label define inapel1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapha10 inapha1h;
label define inapha1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptr10 inaptr1h;
label define inaptr1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwo10 inapwo1h;
label define inapwo1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappl10 inappl1h;
label define inappl1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapot10 inapot1h;
label define inapot1h
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapim11 inapim1k;
label define inapim1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapel11 inapel1k;
label define inapel1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapha11 inapha1k;
label define inapha1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptr11 inaptr1k;
label define inaptr1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwo11 inapwo1k;
label define inapwo1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappl11 inappl1k;
label define inappl1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapot11 inapot1k;
label define inapot1k
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapim12 inapim1l;
label define inapim1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapel12 inapel1l;
label define inapel1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapha12 inapha1l;
label define inapha1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptr12 inaptr1l;
label define inaptr1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwo12 inapwo1l;
label define inapwo1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappl12 inappl1l;
label define inappl1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapot12 inapot1l;
label define inapot1l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapim13 inapim1m;
label define inapim1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapel13 inapel1m;
label define inapel1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapha13 inapha1m;
label define inapha1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptr13 inaptr1m;
label define inaptr1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwo13 inapwo1m;
label define inapwo1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappl13 inappl1m;
label define inappl1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapot13 inapot1m;
label define inapot1m
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapim14 inapim1n;
label define inapim1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapel14 inapel1n;
label define inapel1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapha14 inapha1n;
label define inapha1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inaptr14 inaptr1n;
label define inaptr1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapwo14 inapwo1n;
label define inapwo1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inappl14 inappl1n;
label define inappl1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values inapot14 inapot1n;
label define inapot1n
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapst1   iapst1l;
label define iapst1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst2   iapst2l;
label define iapst2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst3   iapst3l;
label define iapst3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst4   iapst4l;
label define iapst4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst5   iapst5l;
label define iapst5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst6   iapst6l;
label define iapst6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst7   iapst7l;
label define iapst7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst8   iapst8l;
label define iapst8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst9   iapst9l;
label define iapst9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst10  iapst10l;
label define iapst10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst11  iapst11l;
label define iapst11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst12  iapst12l;
label define iapst12l
	-2          "Refused"                       
	-1          "Don't know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst13  iapst13l;
label define iapst13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapst14  iapst14l;
label define iapst14l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Approved"                      
	2           "Denied"                        
	3           "Still waiting to hear"         
;
label values iapwhy1  iapwhy1l;
label define iapwhy1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy2  iapwhy2l;
label define iapwhy2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy3  iapwhy3l;
label define iapwhy3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy4  iapwhy4l;
label define iapwhy4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy5  iapwhy5l;
label define iapwhy5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy6  iapwhy6l;
label define iapwhy6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy7  iapwhy7l;
label define iapwhy7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy8  iapwhy8l;
label define iapwhy8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy9  iapwhy9l;
label define iapwhy9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy10 iapwhy1h;
label define iapwhy1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy11 iapwhy1k;
label define iapwhy1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy12 iapwhy1m;
label define iapwhy1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy13 iapwhy1n;
label define iapwhy1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapwhy14 iapwhy1o;
label define iapwhy1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Decided not to receive the"    
	2           "On waiting list"               
	3           "Have not arrived or started yet"
	4           "Other"                         
;
label values iapinc1  iapinc1l;
label define iapinc1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen1  iappen1l;
label define iappen1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea1  iaphea1l;
label define iaphea1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm1  iapimm1l;
label define iapimm1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor1  iapnor1l;
label define iapnor1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf1  iapinf1l;
label define iapinf1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr1   iapwr1l;
label define iapwr1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs1   iapcs1l;
label define iapcs1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad1   iapad1l;
label define iapad1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa1   iapsa1l;
label define iapsa1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax1  iapmax1l;
label define iapmax1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun1  iapfun1l;
label define iapfun1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth1  iapoth1l;
label define iapoth1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc2  iapinc2l;
label define iapinc2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen2  iappen2l;
label define iappen2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea2  iaphea2l;
label define iaphea2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm2  iapimm2l;
label define iapimm2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor2  iapnor2l;
label define iapnor2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf2  iapinf2l;
label define iapinf2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr2   iapwr2l;
label define iapwr2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs2   iapcs2l;
label define iapcs2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad2   iapad2l;
label define iapad2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa2   iapsa2l;
label define iapsa2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax2  iapmax2l;
label define iapmax2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun2  iapfun2l;
label define iapfun2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth2  iapoth2l;
label define iapoth2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc3  iapinc3l;
label define iapinc3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen3  iappen3l;
label define iappen3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea3  iaphea3l;
label define iaphea3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm3  iapimm3l;
label define iapimm3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor3  iapnor3l;
label define iapnor3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf3  iapinf3l;
label define iapinf3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr3   iapwr3l;
label define iapwr3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs3   iapcs3l;
label define iapcs3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad3   iapad3l;
label define iapad3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa3   iapsa3l;
label define iapsa3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax3  iapmax3l;
label define iapmax3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun3  iapfun3l;
label define iapfun3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth3  iapoth3l;
label define iapoth3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc4  iapinc4l;
label define iapinc4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen4  iappen4l;
label define iappen4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea4  iaphea4l;
label define iaphea4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm4  iapimm4l;
label define iapimm4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor4  iapnor4l;
label define iapnor4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf4  iapinf4l;
label define iapinf4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr4   iapwr4l;
label define iapwr4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs4   iapcs4l;
label define iapcs4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad4   iapad4l;
label define iapad4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa4   iapsa4l;
label define iapsa4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax4  iapmax4l;
label define iapmax4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun4  iapfun4l;
label define iapfun4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth4  iapoth4l;
label define iapoth4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc5  iapinc5l;
label define iapinc5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen5  iappen5l;
label define iappen5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea5  iaphea5l;
label define iaphea5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm5  iapimm5l;
label define iapimm5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor5  iapnor5l;
label define iapnor5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf5  iapinf5l;
label define iapinf5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr5   iapwr5l;
label define iapwr5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs5   iapcs5l;
label define iapcs5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad5   iapad5l;
label define iapad5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa5   iapsa5l;
label define iapsa5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax5  iapmax5l;
label define iapmax5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun5  iapfun5l;
label define iapfun5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth5  iapoth5l;
label define iapoth5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc6  iapinc6l;
label define iapinc6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen6  iappen6l;
label define iappen6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea6  iaphea6l;
label define iaphea6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm6  iapimm6l;
label define iapimm6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor6  iapnor6l;
label define iapnor6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf6  iapinf6l;
label define iapinf6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr6   iapwr6l;
label define iapwr6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs6   iapcs6l;
label define iapcs6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad6   iapad6l;
label define iapad6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa6   iapsa6l;
label define iapsa6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax6  iapmax6l;
label define iapmax6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun6  iapfun6l;
label define iapfun6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth6  iapoth6l;
label define iapoth6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc7  iapinc7l;
label define iapinc7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen7  iappen7l;
label define iappen7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea7  iaphea7l;
label define iaphea7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm7  iapimm7l;
label define iapimm7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor7  iapnor7l;
label define iapnor7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf7  iapinf7l;
label define iapinf7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr7   iapwr7l;
label define iapwr7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs7   iapcs7l;
label define iapcs7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad7   iapad7l;
label define iapad7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa7   iapsa7l;
label define iapsa7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax7  iapmax7l;
label define iapmax7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun7  iapfun7l;
label define iapfun7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth7  iapoth7l;
label define iapoth7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc8  iapinc8l;
label define iapinc8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen8  iappen8l;
label define iappen8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea8  iaphea8l;
label define iaphea8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm8  iapimm8l;
label define iapimm8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor8  iapnor8l;
label define iapnor8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf8  iapinf8l;
label define iapinf8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr8   iapwr8l;
label define iapwr8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs8   iapcs8l;
label define iapcs8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad8   iapad8l;
label define iapad8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa8   iapsa8l;
label define iapsa8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax8  iapmax8l;
label define iapmax8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun8  iapfun8l;
label define iapfun8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth8  iapoth8l;
label define iapoth8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc9  iapinc9l;
label define iapinc9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen9  iappen9l;
label define iappen9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea9  iaphea9l;
label define iaphea9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm9  iapimm9l;
label define iapimm9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor9  iapnor9l;
label define iapnor9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf9  iapinf9l;
label define iapinf9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr9   iapwr9l;
label define iapwr9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs9   iapcs9l;
label define iapcs9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad9   iapad9l;
label define iapad9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa9   iapsa9l;
label define iapsa9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax9  iapmax9l;
label define iapmax9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun9  iapfun9l;
label define iapfun9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth9  iapoth9l;
label define iapoth9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc10 iapinc1h;
label define iapinc1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen10 iappen1h;
label define iappen1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea10 iaphea1h;
label define iaphea1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm10 iapimm1h;
label define iapimm1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor10 iapnor1h;
label define iapnor1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf10 iapinf1h;
label define iapinf1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr10  iapwr10l;
label define iapwr10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs10  iapcs10l;
label define iapcs10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad10  iapad10l;
label define iapad10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa10  iapsa10l;
label define iapsa10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax10 iapmax1h;
label define iapmax1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun10 iapfun1h;
label define iapfun1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth10 iapoth1h;
label define iapoth1h
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc11 iapinc1k;
label define iapinc1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen11 iappen1k;
label define iappen1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea11 iaphea1k;
label define iaphea1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm11 iapimm1k;
label define iapimm1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor11 iapnor1k;
label define iapnor1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf11 iapinf1k;
label define iapinf1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr11  iapwr11l;
label define iapwr11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs11  iapcs11l;
label define iapcs11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad11  iapad11l;
label define iapad11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa11  iapsa11l;
label define iapsa11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax11 iapmax1k;
label define iapmax1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun11 iapfun1k;
label define iapfun1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth11 iapoth1k;
label define iapoth1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc12 iapinc1m;
label define iapinc1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen12 iappen1m;
label define iappen1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea12 iaphea1m;
label define iaphea1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm12 iapimm1m;
label define iapimm1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor12 iapnor1m;
label define iapnor1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf12 iapinf1m;
label define iapinf1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr12  iapwr12l;
label define iapwr12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs12  iapcs12l;
label define iapcs12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad12  iapad12l;
label define iapad12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa12  iapsa12l;
label define iapsa12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax12 iapmax1m;
label define iapmax1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun12 iapfun1m;
label define iapfun1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth12 iapoth1m;
label define iapoth1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc13 iapinc1n;
label define iapinc1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen13 iappen1n;
label define iappen1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea13 iaphea1n;
label define iaphea1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm13 iapimm1n;
label define iapimm1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor13 iapnor1n;
label define iapnor1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf13 iapinf1n;
label define iapinf1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr13  iapwr13l;
label define iapwr13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs13  iapcs13l;
label define iapcs13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad13  iapad13l;
label define iapad13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa13  iapsa13l;
label define iapsa13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax13 iapmax1n;
label define iapmax1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun13 iapfun1n;
label define iapfun1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth13 iapoth1n;
label define iapoth1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinc14 iapinc1o;
label define iapinc1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iappen14 iappen1o;
label define iappen1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not in universe"               
	1           "Yes"                           
;
label values iaphea14 iaphea1o;
label define iaphea1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapimm14 iapimm1o;
label define iapimm1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapnor14 iapnor1o;
label define iapnor1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapinf14 iapinf1o;
label define iapinf1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapwr14  iapwr14l;
label define iapwr14l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapcs14  iapcs14l;
label define iapcs14l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapad14  iapad14l;
label define iapad14l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapsa14  iapsa14l;
label define iapsa14l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapmax14 iapmax1o;
label define iapmax1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapfun14 iapfun1o;
label define iapfun1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iapoth14 iapoth1o;
label define iapoth1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ibencut  ibencut;
label define ibencut 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
	2           "No"                            
;
label values icutafdc icutafdc;
label define icutafdc
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutga   icutga; 
label define icutga  
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "not Answered"                  
	1           "Yes"                           
;
label values icutssi  icutssi;
label define icutssi 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutfs   icutfs; 
label define icutfs  
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutmd   icutmd; 
label define icutmd  
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutwic  icutwic;
label define icutwic 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutunem icutunem;
label define icutunem
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutph   icutph; 
label define icutph  
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutener icutener;
label define icutener
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icuteduc icuteduc;
label define icuteduc
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutcc   icutcc; 
label define icutcc  
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icuttran icuttran;
label define icuttran
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutmeal icutmeal;
label define icutmeal
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values icutwh1  icutwh1l;
label define icutwh1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh2  icutwh2l;
label define icutwh2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh3  icutwh3l;
label define icutwh3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh4  icutwh4l;
label define icutwh4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh5  icutwh5l;
label define icutwh5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh6  icutwh6l;
label define icutwh6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh7  icutwh7l;
label define icutwh7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "Within the next month"         
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh8  icutwh8l;
label define icutwh8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh9  icutwh9l;
label define icutwh9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh10 icutwh1k;
label define icutwh1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh11 icutwh1m;
label define icutwh1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh12 icutwh1n;
label define icutwh1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values icutwh13 icutwh1o;
label define icutwh1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Already happened"              
	2           "In the next month"             
	3           "In the next 3 months"          
	4           "In the next 6 months"          
	5           "In the next year"              
	6           "Later than a year"             
	7           "Not going to happen"           
;
label values ireinc1  ireinc1l;
label define ireinc1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen1  irepen1l;
label define irepen1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea1  irehea1l;
label define irehea1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm1  ireimm1l;
label define ireimm1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor1  irenor1l;
label define irenor1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf1  ireinf1l;
label define ireinf1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr1   irewr1l;
label define irewr1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs1   irecs1l;
label define irecs1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread1   iread1l;
label define iread1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa1   iresa1l;
label define iresa1l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax1  iremax1l;
label define iremax1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun1  irefun1l;
label define irefun1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth1  ireoth1l;
label define ireoth1l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc2  ireinc2l;
label define ireinc2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen2  irepen2l;
label define irepen2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea2  irehea2l;
label define irehea2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm2  ireimm2l;
label define ireimm2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor2  irenor2l;
label define irenor2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf2  ireinf2l;
label define ireinf2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr2   irewr2l;
label define irewr2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs2   irecs2l;
label define irecs2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread2   iread2l;
label define iread2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa2   iresa2l;
label define iresa2l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax2  iremax2l;
label define iremax2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun2  irefun2l;
label define irefun2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth2  ireoth2l;
label define ireoth2l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc3  ireinc3l;
label define ireinc3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen3  irepen3l;
label define irepen3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea3  irehea3l;
label define irehea3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm3  ireimm3l;
label define ireimm3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor3  irenor3l;
label define irenor3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf3  ireinf3l;
label define ireinf3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr3   irewr3l;
label define irewr3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs3   irecs3l;
label define irecs3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread3   iread3l;
label define iread3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa3   iresa3l;
label define iresa3l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax3  iremax3l;
label define iremax3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun3  irefun3l;
label define irefun3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth3  ireoth3l;
label define ireoth3l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc4  ireinc4l;
label define ireinc4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen4  irepen4l;
label define irepen4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea4  irehea4l;
label define irehea4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm4  ireimm4l;
label define ireimm4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor4  irenor4l;
label define irenor4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf4  ireinf4l;
label define ireinf4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr4   irewr4l;
label define irewr4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs4   irecs4l;
label define irecs4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread4   iread4l;
label define iread4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa4   iresa4l;
label define iresa4l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax4  iremax4l;
label define iremax4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun4  irefun4l;
label define irefun4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth4  ireoth4l;
label define ireoth4l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc5  ireinc5l;
label define ireinc5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen5  irepen5l;
label define irepen5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea5  irehea5l;
label define irehea5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm5  ireimm5l;
label define ireimm5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor5  irenor5l;
label define irenor5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf5  ireinf5l;
label define ireinf5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr5   irewr5l;
label define irewr5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs5   irecs5l;
label define irecs5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread5   iread5l;
label define iread5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa5   iresa5l;
label define iresa5l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax5  iremax5l;
label define iremax5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun5  irefun5l;
label define irefun5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth5  ireoth5l;
label define ireoth5l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc6  ireinc6l;
label define ireinc6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen6  irepen6l;
label define irepen6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea6  irehea6l;
label define irehea6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm6  ireimm6l;
label define ireimm6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor6  irenor6l;
label define irenor6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf6  ireinf6l;
label define ireinf6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr6   irewr6l;
label define irewr6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs6   irecs6l;
label define irecs6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread6   iread6l;
label define iread6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa6   iresa6l;
label define iresa6l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax6  iremax6l;
label define iremax6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun6  irefun6l;
label define irefun6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth6  ireoth6l;
label define ireoth6l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc7  ireinc7l;
label define ireinc7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen7  irepen7l;
label define irepen7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea7  irehea7l;
label define irehea7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm7  ireimm7l;
label define ireimm7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor7  irenor7l;
label define irenor7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf7  ireinf7l;
label define ireinf7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr7   irewr7l;
label define irewr7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs7   irecs7l;
label define irecs7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread7   iread7l;
label define iread7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa7   iresa7l;
label define iresa7l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax7  iremax7l;
label define iremax7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun7  irefun7l;
label define irefun7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth7  ireoth7l;
label define ireoth7l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc8  ireinc8l;
label define ireinc8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen8  irepen8l;
label define irepen8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea8  irehea8l;
label define irehea8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm8  ireimm8l;
label define ireimm8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor8  irenor8l;
label define irenor8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf8  ireinf8l;
label define ireinf8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr8   irewr8l;
label define irewr8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs8   irecs8l;
label define irecs8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread8   iread8l;
label define iread8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa8   iresa8l;
label define iresa8l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax8  iremax8l;
label define iremax8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun8  irefun8l;
label define irefun8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth8  ireoth8l;
label define ireoth8l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc9  ireinc9l;
label define ireinc9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen9  irepen9l;
label define irepen9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea9  irehea9l;
label define irehea9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm9  ireimm9l;
label define ireimm9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor9  irenor9l;
label define irenor9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf9  ireinf9l;
label define ireinf9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr9   irewr9l;
label define irewr9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs9   irecs9l;
label define irecs9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread9   iread9l;
label define iread9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa9   iresa9l;
label define iresa9l 
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax9  iremax9l;
label define iremax9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun9  irefun9l;
label define irefun9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth9  ireoth9l;
label define ireoth9l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc10 ireinc1k;
label define ireinc1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen10 irepen1k;
label define irepen1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea10 irehea1k;
label define irehea1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm10 ireimm1k;
label define ireimm1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor10 irenor1k;
label define irenor1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf10 ireinf1k;
label define ireinf1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr10  irewr10l;
label define irewr10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs10  irecs10l;
label define irecs10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread10  iread10l;
label define iread10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa10  iresa10l;
label define iresa10l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax10 iremax1k;
label define iremax1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun10 irefun1k;
label define irefun1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth10 ireoth1k;
label define ireoth1k
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc11 ireinc1m;
label define ireinc1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen11 irepen1m;
label define irepen1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea11 irehea1m;
label define irehea1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm11 ireimm1m;
label define ireimm1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor11 irenor1m;
label define irenor1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf11 ireinf1m;
label define ireinf1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr11  irewr11l;
label define irewr11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs11  irecs11l;
label define irecs11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread11  iread11l;
label define iread11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa11  iresa11l;
label define iresa11l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax11 iremax1m;
label define iremax1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun11 irefun1m;
label define irefun1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth11 ireoth1m;
label define ireoth1m
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc12 ireinc1n;
label define ireinc1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen12 irepen1n;
label define irepen1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea12 irehea1n;
label define irehea1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm12 ireimm1n;
label define ireimm1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor12 irenor1n;
label define irenor1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf12 ireinf1n;
label define ireinf1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr12  irewr12l;
label define irewr12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs12  irecs12l;
label define irecs12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread12  iread12l;
label define iread12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa12  iresa12l;
label define iresa12l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax12 iremax1n;
label define iremax1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun12 irefun1n;
label define irefun1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth12 ireoth1n;
label define ireoth1n
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinc13 ireinc1o;
label define ireinc1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irepen13 irepen1o;
label define irepen1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irehea13 irehea1o;
label define irehea1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireimm13 ireimm1o;
label define ireimm1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irenor13 irenor1o;
label define irenor1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireinf13 ireinf1o;
label define ireinf1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irewr13  irewr13l;
label define irewr13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irecs13  irecs13l;
label define irecs13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iread13  iread13l;
label define iread13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iresa13  iresa13l;
label define iresa13l
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values iremax13 iremax1o;
label define iremax1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values irefun13 irefun1o;
label define irefun1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
;
label values ireoth13 ireoth1o;
label define ireoth1o
	-2          "Refused"                       
	-1          "Don't Know"                    
	0           "Not Answered"                  
	1           "Yes"                           
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
