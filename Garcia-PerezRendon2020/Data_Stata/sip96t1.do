log using sip96t1, text replace
set mem 500m
*This program reads the 1996 SIPP Wave 1 Topical Module Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*by Jean Roth Tue Nov  4 11:37:24 EST 2003
*Please report errors to jroth@nber.org
*run with do sip96t1
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp/1996\sip96t1.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96t1

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
label values ems      ems;    
label define ems     
	1           "Married, spouse present"       
	2           "Married, Spouse absent"        
	3           "Widowed"                       
	4           "Divorced"                      
	5           "Separated"                     
	6           "Never Married"                 
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
label values epnspous epnspous;
label define epnspous
	9999        "Spouse not in hhld or person not"
;
label values rdesgpnt rdesgpnt;
label define rdesgpnt
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values tage     tage;   
label define tage    
	0           "Less than 1 full year old"     
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
label values tlstwrky tlstwrky;
label define tlstwrky
	-1          "Not in universe"               
	0           "Never worked"                  
;
label values elstwrkm elstwrkm;
label define elstwrkm
	-1          "Not in Universe"               
;
label values tprvjbyr tprvjbyr;
label define tprvjbyr
	-1          "Not in universe"               
	0           "Never worked"                  
;
label values eprvjbmn eprvjbmn;
label define eprvjbmn
	-1          "Not in Universe"               
;
label values tfrmryr  tfrmryr;
label define tfrmryr 
	-1          "Not in Universe"               
;
label values efrmrmn  efrmrmn;
label define efrmrmn 
	-1          "Not in Universe"               
;
label values tmakmnyr tmakmnyr;
label define tmakmnyr
	-1          "Not in Universe"               
	0           "Never worked 6 straight months"
;
label values emnreson emnreson;
label define emnreson
	-1          "Not in Universe"               
	1           "Taking care of minor child"    
	2           "Taking care of an elderly family"
	3           "Taking care of disabled but"   
	4           "Other family or home"          
	5           "Own illness or disability"     
	6           "Could not find work"           
	7           "Did not want to work"          
	8           "Going to school"               
	9           "Other"                         
;
label values eyrsince eyrsince;
label define eyrsince
	-1          "Not in Universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eyrsinc2 eyrsinck;
label define eyrsinck
	-1          "Not in  Universe"              
;
label values ewrk35hr ewrk35hr;
label define ewrk35hr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eoff6mtn eoff6mtn;
label define eoff6mtn
	-1          "Not in Universe"               
	1           "Yes"                           
	2           "No"                            
;
label values tnowrkfr tnowrkfr;
label define tnowrkfr
	-1          "Not in Universe"               
;
label values tnowrkto tnowrkto;
label define tnowrkto
	-1          "Not in Universe"               
;
label values eothtime eothtime;
label define eothtime
	-1          "Not in Universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ecntothr ecntothr;
label define ecntothr
	-1          "Not in  Universe"              
;
label values tfstyrfr tfstyrfr;
label define tfstyrfr
	-1          "Not in Universe"               
;
label values tfstyrto tfstyrto;
label define tfstyrto
	-1          "Not in  Universe"              
;
label values enwresn  enwresn;
label define enwresn 
	-1          "Not in Universe"               
	1           "A  minor  child"               
	2           "An elderly family member"      
	3           "A disabled but non-elderly"    
;
label values efrstrsn efrstrsn;
label define efrstrsn
	-1          "Not in Universe"               
	1           "A  minor  child"               
	2           "An elderly family member"      
	3           "A disabled but non-elderly"    
;
label values alstwrky alstwrky;
label define alstwrky
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values alstwrkm alstwrkm;
label define alstwrkm
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values aprvjbyr aprvjbyr;
label define aprvjbyr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values aprvjbmn aprvjbmn;
label define aprvjbmn
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values afrmryr  afrmryr;
label define afrmryr 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values afrmrmn  afrmrmn;
label define afrmrmn 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values amakmnyr amakmnyr;
label define amakmnyr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation (Derivation)"
;
label values amnreson amnreson;
label define amnreson
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation (Derivation)"
;
label values ayrsince ayrsince;
label define ayrsince
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation (Derivation)"
;
label values ayrsinc2 ayrsinck;
label define ayrsinck
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold  Deck  Imputation"        
	3           "Logical Imputation  (Derivation)"
;
label values awrk35hr awrk35hr;
label define awrk35hr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values aoff6mtn aoff6mtn;
label define aoff6mtn
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold  Deck  Imputation"        
	3           "Logical Imputation (Derivation)"
;
label values anowrkfr anowrkfr;
label define anowrkfr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical  Imputation"           
;
label values anowrkto anowrkto;
label define anowrkto
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical  Imputation"           
;
label values aothtime aothtime;
label define aothtime
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold  Deck  Imputation"        
	3           "Logical  Imputation"           
;
label values acntothr acntothr;
label define acntothr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical  Imputation"           
;
label values afstyrfr afstyrfr;
label define afstyrfr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation  (Derivation)"
;
label values afstyrto afstyrto;
label define afstyrto
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation  (Derivation)"
;
label values anwresn  anwresn;
label define anwresn 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation  (Derivation)"
;
label values afrstrsn afrstrsn;
label define afrstrsn
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck  Imputation"         
	3           "Logical Imputation  (Derivation)"
;
label values eystp21  eystp21l;
label define eystp21l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values aystp21  aystp21l;
label define aystp21l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eybg2101 eybg210n;
label define eybg210n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2102 eybg210k;
label define eybg210k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2103 eybg210l;
label define eybg210l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2104 eybg210m;
label define eybg210m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2105 eybg210o;
label define eybg210o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2106 eybg210p;
label define eybg210p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2107 eybg210q;
label define eybg210q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2108 eybg210r;
label define eybg210r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2109 eybg210s;
label define eybg210s
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2110 eybg211n;
label define eybg211n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values aybg21   aybg21l;
label define aybg21l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eystp22  eystp22l;
label define eystp22l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values aystp22  aystp22l;
label define aystp22l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eybg2201 eybg220n;
label define eybg220n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2202 eybg220k;
label define eybg220k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2203 eybg220l;
label define eybg220l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2204 eybg220m;
label define eybg220m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2205 eybg220o;
label define eybg220o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2206 eybg220p;
label define eybg220p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2207 eybg220q;
label define eybg220q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2208 eybg220r;
label define eybg220r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2209 eybg220s;
label define eybg220s
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2210 eybg221n;
label define eybg221n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values aybg22   aybg22l;
label define aybg22l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eystp23  eystp23l;
label define eystp23l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values aystp23  aystp23l;
label define aystp23l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eybg2301 eybg230n;
label define eybg230n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2302 eybg230k;
label define eybg230k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2303 eybg230l;
label define eybg230l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2304 eybg230m;
label define eybg230m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2305 eybg230o;
label define eybg230o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2306 eybg230p;
label define eybg230p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2307 eybg230q;
label define eybg230q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2308 eybg230r;
label define eybg230r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2309 eybg230s;
label define eybg230s
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eybg2310 eybg231n;
label define eybg231n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values aybg23   aybg23l;
label define aybg23l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values tybg120y tybg120y;
label define tybg120y
	-1          "Not in universe"               
;
label values eybg120m eybg120m;
label define eybg120m
	-1          "Not in universe"               
;
label values aybg120m aybg120m;
label define aybg120m
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values aybg120y aybg120y;
label define aybg120y
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eyb22001 eyb2200y;
label define eyb2200y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22002 eyb2200k;
label define eyb2200k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22003 eyb2200l;
label define eyb2200l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22004 eyb2200m;
label define eyb2200m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22005 eyb2200n;
label define eyb2200n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22006 eyb2200o;
label define eyb2200o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22007 eyb2200p;
label define eyb2200p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22008 eyb2200q;
label define eyb2200q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22009 eyb2200r;
label define eyb2200r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eyb22010 eyb2201y;
label define eyb2201y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values aybg220  aybg220l;
label define aybg220l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewstp21  ewstp21l;
label define ewstp21l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values awstp21  awstp21l;
label define awstp21l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewbg2101 ewbg210y;
label define ewbg210y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2102 ewbg210k;
label define ewbg210k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2103 ewbg210l;
label define ewbg210l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2104 ewbg210m;
label define ewbg210m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2105 ewbg210n;
label define ewbg210n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2106 ewbg210o;
label define ewbg210o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2107 ewbg210p;
label define ewbg210p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2108 ewbg210q;
label define ewbg210q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2109 ewbg210r;
label define ewbg210r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2110 ewbg211y;
label define ewbg211y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values awbg21   awbg21l;
label define awbg21l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewstp22  ewstp22l;
label define ewstp22l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values awstp22  awstp22l;
label define awstp22l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewbg2201 ewbg220y;
label define ewbg220y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2202 ewbg220k;
label define ewbg220k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2203 ewbg220l;
label define ewbg220l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2204 ewbg220m;
label define ewbg220m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2205 ewbg220n;
label define ewbg220n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2206 ewbg220o;
label define ewbg220o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2207 ewbg220p;
label define ewbg220p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2208 ewbg220q;
label define ewbg220q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2209 ewbg220r;
label define ewbg220r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2210 ewbg221y;
label define ewbg221y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values awbg22   awbg22l;
label define awbg22l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewstp23  ewstp23l;
label define ewstp23l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values awstp23  awstp23l;
label define awstp23l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewbg2301 ewbg230y;
label define ewbg230y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2302 ewbg230k;
label define ewbg230k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2303 ewbg230l;
label define ewbg230l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2304 ewbg230m;
label define ewbg230m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2305 ewbg230n;
label define ewbg230n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2306 ewbg230o;
label define ewbg230o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2307 ewbg230p;
label define ewbg230p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2308 ewbg230q;
label define ewbg230q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2309 ewbg230r;
label define ewbg230r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewbg2310 ewbg231y;
label define ewbg231y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values awbg23   awbg23l;
label define awbg23l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewbg120m ewbg120m;
label define ewbg120m
	-1          "Not in universe"               
;
label values twbg120y twbg120y;
label define twbg120y
	-1          "Not in universe"               
;
label values awbg120m awbg120m;
label define awbg120m
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values awbg120y awbg120y;
label define awbg120y
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ewb22001 ewb2200y;
label define ewb2200y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22002 ewb2200k;
label define ewb2200k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22003 ewb2200l;
label define ewb2200l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22004 ewb2200m;
label define ewb2200m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22005 ewb2200n;
label define ewb2200n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22006 ewb2200o;
label define ewb2200o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22007 ewb2200p;
label define ewb2200p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22008 ewb2200q;
label define ewb2200q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22009 ewb2200r;
label define ewb2200r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ewb22010 ewb2201y;
label define ewb2201y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values awbg220  awbg220l;
label define awbg220l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efstp21  efstp21l;
label define efstp21l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values afstp21  afstp21l;
label define afstp21l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efbg2101 efbg210y;
label define efbg210y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2102 efbg210k;
label define efbg210k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2103 efbg210l;
label define efbg210l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2104 efbg210m;
label define efbg210m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2105 efbg210n;
label define efbg210n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2106 efbg210o;
label define efbg210o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2107 efbg210p;
label define efbg210p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2108 efbg210q;
label define efbg210q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2109 efbg210r;
label define efbg210r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2110 efbg211y;
label define efbg211y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values afbg21   afbg21l;
label define afbg21l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efstp22  efstp22l;
label define efstp22l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values afstp22  afstp22l;
label define afstp22l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efbg2201 efbg220y;
label define efbg220y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2202 efbg220k;
label define efbg220k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2203 efbg220l;
label define efbg220l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2204 efbg220m;
label define efbg220m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2205 efbg220n;
label define efbg220n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2206 efbg220o;
label define efbg220o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2207 efbg220p;
label define efbg220p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2208 efbg220q;
label define efbg220q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2209 efbg220r;
label define efbg220r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2210 efbg221y;
label define efbg221y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values afbg22   afbg22l;
label define afbg22l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efstp23  efstp23l;
label define efstp23l
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values afstp23  afstp23l;
label define afstp23l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efbg2301 efbg230y;
label define efbg230y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2302 efbg230k;
label define efbg230k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2303 efbg230l;
label define efbg230l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2304 efbg230m;
label define efbg230m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2305 efbg230n;
label define efbg230n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2306 efbg230o;
label define efbg230o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2307 efbg230p;
label define efbg230p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2308 efbg230q;
label define efbg230q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2309 efbg230r;
label define efbg230r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efbg2310 efbg231y;
label define efbg231y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values afbg23   afbg23l;
label define afbg23l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efbg120m efbg120m;
label define efbg120m
	-1          "Not in universe"               
;
label values tfbg120y tfbg120y;
label define tfbg120y
	-1          "Not in universe"               
;
label values afbg120m afbg120m;
label define afbg120m
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values afbg120y afbg120y;
label define afbg120y
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efb22001 efb2200y;
label define efb2200y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22002 efb2200k;
label define efb2200k
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22003 efb2200l;
label define efb2200l
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22004 efb2200m;
label define efb2200m
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22005 efb2200n;
label define efb2200n
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22006 efb2200o;
label define efb2200o
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22007 efb2200p;
label define efb2200p
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22008 efb2200q;
label define efb2200q
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22009 efb2200r;
label define efb2200r
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values efb22010 efb2201y;
label define efb2201y
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values afb220   afb220l;
label define afb220l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp03m4 estp03my;
label define estp03my
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp03m4 astp03my;
label define astp03my
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp04m4 estp04my;
label define estp04my
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp04m4 astp04my;
label define astp04my
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp21m4 estp21my;
label define estp21my
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp21m4 astp21my;
label define astp21my
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp24m4 estp24my;
label define estp24my
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp24m4 astp24my;
label define astp24my
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2101m4 eb2101my;
label define eb2101my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2102m4 eb2102my;
label define eb2102my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2103m4 eb2103my;
label define eb2103my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2104m4 eb2104my;
label define eb2104my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2105m4 eb2105my;
label define eb2105my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2106m4 eb2106my;
label define eb2106my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2107m4 eb2107my;
label define eb2107my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2108m4 eb2108my;
label define eb2108my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2109m4 eb2109my;
label define eb2109my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2110m4 eb2110my;
label define eb2110my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab21m4   ab21m4l;
label define ab21m4l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2401m4 eb2401my;
label define eb2401my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2402m4 eb2402my;
label define eb2402my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2403m4 eb2403my;
label define eb2403my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2404m4 eb2404my;
label define eb2404my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2405m4 eb2405my;
label define eb2405my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2406m4 eb2406my;
label define eb2406my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2407m4 eb2407my;
label define eb2407my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2408m4 eb2408my;
label define eb2408my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2409m4 eb2409my;
label define eb2409my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2410m4 eb2410my;
label define eb2410my
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab24m4   ab24m4l;
label define ab24m4l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb03s1m4 eb03s1my;
label define eb03s1my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s2m4 eb03s2my;
label define eb03s2my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s3m4 eb03s3my;
label define eb03s3my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s4m4 eb03s4my;
label define eb03s4my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab03sm4  ab03sm4l;
label define ab03sm4l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb04s1m4 eb04s1my;
label define eb04s1my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s2m4 eb04s2my;
label define eb04s2my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s3m4 eb04s3my;
label define eb04s3my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s4m4 eb04s4my;
label define eb04s4my
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab04sm4  ab04sm4l;
label define ab04sm4l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp03m3 estp03mk;
label define estp03mk
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family chges(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp03m3 astp03mk;
label define astp03mk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp04m3 estp04mk;
label define estp04mk
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family chges(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp04m3 astp04mk;
label define astp04mk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp21m3 estp21mk;
label define estp21mk
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family chges(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp21m3 astp21mk;
label define astp21mk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp24m3 estp24mk;
label define estp24mk
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family chges(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp24m3 astp24mk;
label define astp24mk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2101m3 eb2101mk;
label define eb2101mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2102m3 eb2102mk;
label define eb2102mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2103m3 eb2103mk;
label define eb2103mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2104m3 eb2104mk;
label define eb2104mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2105m3 eb2105mk;
label define eb2105mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2106m3 eb2106mk;
label define eb2106mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2107m3 eb2107mk;
label define eb2107mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2108m3 eb2108mk;
label define eb2108mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2109m3 eb2109mk;
label define eb2109mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2110m3 eb2110mk;
label define eb2110mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab21m3   ab21m3l;
label define ab21m3l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2401m3 eb2401mk;
label define eb2401mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2402m3 eb2402mk;
label define eb2402mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2403m3 eb2403mk;
label define eb2403mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2404m3 eb2404mk;
label define eb2404mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2405m3 eb2405mk;
label define eb2405mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2406m3 eb2406mk;
label define eb2406mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2407m3 eb2407mk;
label define eb2407mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2408m3 eb2408mk;
label define eb2408mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2409m3 eb2409mk;
label define eb2409mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2410m3 eb2410mk;
label define eb2410mk
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab24m3   ab24m3l;
label define ab24m3l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb03s1m3 eb03s1mk;
label define eb03s1mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s2m3 eb03s2mk;
label define eb03s2mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s3m3 eb03s3mk;
label define eb03s3mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s4m3 eb03s4mk;
label define eb03s4mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab03sm3  ab03sm3l;
label define ab03sm3l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb04s1m3 eb04s1mk;
label define eb04s1mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s2m3 eb04s2mk;
label define eb04s2mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s3m3 eb04s3mk;
label define eb04s3mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s4m3 eb04s4mk;
label define eb04s4mk
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab04sm3  ab04sm3l;
label define ab04sm3l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp03m2 estp03ml;
label define estp03ml
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family chges(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp03m2 astp03ml;
label define astp03ml
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp04m2 estp04ml;
label define estp04ml
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp04m2 astp04ml;
label define astp04ml
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp21m2 estp21ml;
label define estp21ml
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp21m2 astp21ml;
label define astp21ml
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values estp24m2 estp24ml;
label define estp24ml
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes(family"
	3           "Still eligible but could not"  
	4           "Other, specify"                
;
label values astp24m2 astp24ml;
label define astp24ml
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2101m2 eb2101ml;
label define eb2101ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2102m2 eb2102ml;
label define eb2102ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2103m2 eb2103ml;
label define eb2103ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2104m2 eb2104ml;
label define eb2104ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2105m2 eb2105ml;
label define eb2105ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2106m2 eb2106ml;
label define eb2106ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2107m2 eb2107ml;
label define eb2107ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2108m2 eb2108ml;
label define eb2108ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2109m2 eb2109ml;
label define eb2109ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2110m2 eb2110ml;
label define eb2110ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab21m2   ab21m2l;
label define ab21m2l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2401m2 eb2401ml;
label define eb2401ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2402m2 eb2402ml;
label define eb2402ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2403m2 eb2403ml;
label define eb2403ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2404m2 eb2404ml;
label define eb2404ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2405m2 eb2405ml;
label define eb2405ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2406m2 eb2406ml;
label define eb2406ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2407m2 eb2407ml;
label define eb2407ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2408m2 eb2408ml;
label define eb2408ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2409m2 eb2409ml;
label define eb2409ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2410m2 eb2410ml;
label define eb2410ml
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab24m2   ab24m2l;
label define ab24m2l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb03s1m2 eb03s1ml;
label define eb03s1ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s2m2 eb03s2ml;
label define eb03s2ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s3m2 eb03s3ml;
label define eb03s3ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s4m2 eb03s4ml;
label define eb03s4ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab03sm2  ab03sm2l;
label define ab03sm2l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb04s1m2 eb04s1ml;
label define eb04s1ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s2m2 eb04s2ml;
label define eb04s2ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s3m2 eb04s3ml;
label define eb04s3ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s4m2 eb04s4ml;
label define eb04s4ml
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab04sm2  ab04sm2l;
label define ab04sm2l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2101m1 eb2101mm;
label define eb2101mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2102m1 eb2102mm;
label define eb2102mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2103m1 eb2103mm;
label define eb2103mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2104m1 eb2104mm;
label define eb2104mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2105m1 eb2105mm;
label define eb2105mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2106m1 eb2106mm;
label define eb2106mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2107m1 eb2107mm;
label define eb2107mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2108m1 eb2108mm;
label define eb2108mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2109m1 eb2109mm;
label define eb2109mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2110m1 eb2110mm;
label define eb2110mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab21m1   ab21m1l;
label define ab21m1l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb2401m1 eb2401mm;
label define eb2401mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2402m1 eb2402mm;
label define eb2402mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2403m1 eb2403mm;
label define eb2403mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2404m1 eb2404mm;
label define eb2404mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2405m1 eb2405mm;
label define eb2405mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2406m1 eb2406mm;
label define eb2406mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2407m1 eb2407mm;
label define eb2407mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2408m1 eb2408mm;
label define eb2408mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2409m1 eb2409mm;
label define eb2409mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb2410m1 eb2410mm;
label define eb2410mm
	-1          "Not in universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab24m1   ab24m1l;
label define ab24m1l 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb03s1m1 eb03s1mm;
label define eb03s1mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s2m1 eb03s2mm;
label define eb03s2mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s3m1 eb03s3mm;
label define eb03s3mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb03s4m1 eb03s4mm;
label define eb03s4mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab03sm1  ab03sm1l;
label define ab03sm1l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eb04s1m1 eb04s1mm;
label define eb04s1mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s2m1 eb04s2mm;
label define eb04s2mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s3m1 eb04s3mm;
label define eb04s3mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values eb04s4m1 eb04s4mm;
label define eb04s4mm
	-1          "Not in Universe"               
	1           "Circumstance for applying"     
	2           "Not a circumstance for applying"
;
label values ab04sm1  ab04sm1l;
label define ab04sm1l
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ecovb1m  ecovb1m;
label define ecovb1m 
	-1          "Not in universe"               
;
label values tcovb1y  tcovb1y;
label define tcovb1y 
	-1          "Not in universe"               
;
label values acovb1m  acovb1m;
label define acovb1m 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values acovb1y  acovb1y;
label define acovb1y 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ecovb3m  ecovb3m;
label define ecovb3m 
	-1          "Not in universe"               
;
label values tcovb3y  tcovb3y;
label define tcovb3y 
	-1          "Not in universe"               
;
label values acovb3m  acovb3m;
label define acovb3m 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values acovb3y  acovb3y;
label define acovb3y 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ecovb4m  ecovb4m;
label define ecovb4m 
	-1          "Not in universe"               
;
label values tcovb4y  tcovb4y;
label define tcovb4y 
	-1          "Not in universe"               
;
label values acovb4m  acovb4m;
label define acovb4m 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values acovb4y  acovb4y;
label define acovb4y 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eaplfs   eaplfs; 
label define eaplfs  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaplfs   aaplfs; 
label define aaplfs  
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values erecvfs  erecvfs;
label define erecvfs 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arecvfs  arecvfs;
label define arecvfs 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efsstrmn efsstrmn;
label define efsstrmn
	-1          "Not in universe"               
;
label values afsstrmn afsstrmn;
label define afsstrmn
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values tfsstryr tfsstryr;
label define tfsstryr
	-1          "Not in universe"               
;
label values afsstryr afsstryr;
label define afsstryr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efslong1 efslongr;
label define efslongr
	-1          "Not in universe"               
;
label values afslong1 afslongr;
label define afslongr
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efslong2 efslongk;
label define efslongk
	-1          "Not in universe"               
;
label values afslong2 afslongk;
label define afslongk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values efstimes efstimes;
label define efstimes
	-1          "Not in universe"               
;
label values afstimes afstimes;
label define afstimes
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eaplafdc eaplafdc;
label define eaplafdc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaplafdc aaplafdc;
label define aaplafdc
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values ercvafdc ercvafdc;
label define ercvafdc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arcvafdc arcvafdc;
label define arcvafdc
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eafdcstm eafdcstm;
label define eafdcstm
	-1          "Not in universe"               
;
label values aafdcstm aafdcstm;
label define aafdcstm
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values tafdcsty tafdcsty;
label define tafdcsty
	-1          "Not in universe"               
;
label values aafdcsty aafdcsty;
label define aafdcsty
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eafdclg1 eafdclgy;
label define eafdclgy
	-1          "Not in universe"               
;
label values aafdclg1 aafdclgy;
label define aafdclgy
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eafdclg2 eafdclgk;
label define eafdclgk
	-1          "Not in universe"               
;
label values aafdclg2 aafdclgk;
label define aafdclgk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eafdctim eafdctim;
label define eafdctim
	-1          "Not in universe"               
;
label values aafdctim aafdctim;
label define aafdctim
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values eaplssi  eaplssi;
label define eaplssi 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaplssi  aaplssi;
label define aaplssi 
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values erecvssi erecvssi;
label define erecvssi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arecvssi arecvssi;
label define arecvssi
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values essistrm essistrm;
label define essistrm
	-1          "Not in universe"               
;
label values assistrm assistrm;
label define assistrm
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values tssistry tssistry;
label define tssistry
	-1          "Not in universe"               
;
label values assistry assistry;
label define assistry
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values essilng1 essilngy;
label define essilngy
	-1          "Not in universe"               
;
label values assilng1 assilngy;
label define assilngy
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
;
label values essilng2 essilngk;
label define essilngk
	-1          "Not in universe"               
;
label values assilng2 assilngk;
label define assilngk
	0           "Not imputed"                   
	1           "Imputed"                       
	2           "Cold Deck Imputation"          
	3           "Logical Imputation (Derivation)"
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
