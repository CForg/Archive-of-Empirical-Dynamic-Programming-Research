log using sip96t2, text replace
set mem 500m
*This program reads the 1996 SIPP Wave 2 Topical Module Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*by Jean Roth Tue Nov  4 11:38:01 EST 2003
*Please report errors to jroth@nber.org
*run with do sip96t2
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp/1996\sip96t2.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96t2

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
label values eprlunv  eprlunv;
label define eprlunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values erelat01 erelat0v;
label define erelat0v
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat01 arelat0v;
label define arelat0v
	0           "Not imputed"                   
	1           "Statistical imputation (hot"   
	2           "Cold deck"                     
	3           "Logical imputation (derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn01 eprlpn0v;
label define eprlpn0v
	-1          "Not in universe"               
;
label values erelat02 erelat0k;
label define erelat0k
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat02 arelat0k;
label define arelat0k
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn02 eprlpn0k;
label define eprlpn0k
	-1          "Not in universe"               
;
label values erelat03 erelat0l;
label define erelat0l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat03 arelat0l;
label define arelat0l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn03 eprlpn0l;
label define eprlpn0l
	-1          "Not in universe"               
;
label values erelat04 erelat0m;
label define erelat0m
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat04 arelat0m;
label define arelat0m
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn04 eprlpn0m;
label define eprlpn0m
	-1          "Not in universe"               
;
label values erelat05 erelat0n;
label define erelat0n
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat05 arelat0n;
label define arelat0n
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn05 eprlpn0n;
label define eprlpn0n
	-1          "Not in universe"               
;
label values erelat06 erelat0o;
label define erelat0o
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat06 arelat0o;
label define arelat0o
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn06 eprlpn0o;
label define eprlpn0o
	-1          "Not in universe"               
;
label values erelat07 erelat0p;
label define erelat0p
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat07 arelat0p;
label define arelat0p
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn07 eprlpn0p;
label define eprlpn0p
	-1          "Not in universe"               
;
label values erelat08 erelat0q;
label define erelat0q
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat08 arelat0q;
label define arelat0q
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn08 eprlpn0q;
label define eprlpn0q
	-1          "Not in universe"               
;
label values erelat09 erelat0r;
label define erelat0r
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat09 arelat0r;
label define arelat0r
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn09 eprlpn0r;
label define eprlpn0r
	-1          "Not in universe"               
;
label values erelat10 erelat1v;
label define erelat1v
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat10 arelat1v;
label define arelat1v
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn10 eprlpn1v;
label define eprlpn1v
	-1          "Not in universe"               
;
label values erelat11 erelat1k;
label define erelat1k
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat11 arelat1k;
label define arelat1k
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn11 eprlpn1k;
label define eprlpn1k
	-1          "Not in universe"               
;
label values erelat12 erelat1l;
label define erelat1l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat12 arelat1l;
label define arelat1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn12 eprlpn1l;
label define eprlpn1l
	-1          "Not in universe"               
;
label values erelat13 erelat1m;
label define erelat1m
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat13 arelat1m;
label define arelat1m
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn13 eprlpn1m;
label define eprlpn1m
	-1          "Not in universe"               
;
label values erelat14 erelat1n;
label define erelat1n
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat14 arelat1n;
label define arelat1n
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn14 eprlpn1n;
label define eprlpn1n
	-1          "Not in universe"               
;
label values erelat15 erelat1o;
label define erelat1o
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat15 arelat1o;
label define arelat1o
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn15 eprlpn1o;
label define eprlpn1o
	-1          "Not in universe"               
;
label values erelat16 erelat1p;
label define erelat1p
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat16 arelat1p;
label define arelat1p
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn16 eprlpn1p;
label define eprlpn1p
	-1          "Not in universe"               
;
label values erelat17 erelat1q;
label define erelat1q
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat17 arelat1q;
label define arelat1q
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn17 eprlpn1q;
label define eprlpn1q
	-1          "Not in universe"               
;
label values erelat18 erelat1r;
label define erelat1r
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat18 arelat1r;
label define arelat1r
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn18 eprlpn1r;
label define eprlpn1r
	-1          "Not in universe"               
;
label values erelat19 erelat1s;
label define erelat1s
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat19 arelat1s;
label define arelat1s
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn19 eprlpn1s;
label define eprlpn1s
	-1          "Not in universe"               
;
label values erelat20 erelat2v;
label define erelat2v
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat20 arelat2v;
label define arelat2v
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn20 eprlpn2v;
label define eprlpn2v
	-1          "Not in universe"               
;
label values erelat21 erelat2k;
label define erelat2k
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat21 arelat2k;
label define arelat2k
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn21 eprlpn2k;
label define eprlpn2k
	-1          "Not in universe"               
;
label values erelat22 erelat2l;
label define erelat2l
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat22 arelat2l;
label define arelat2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn22 eprlpn2l;
label define eprlpn2l
	-1          "Not in universe"               
;
label values erelat23 erelat2m;
label define erelat2m
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat23 arelat2m;
label define arelat2m
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn23 eprlpn2m;
label define eprlpn2m
	-1          "Not in universe"               
;
label values erelat24 erelat2n;
label define erelat2n
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat24 arelat2n;
label define arelat2n
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn24 eprlpn2n;
label define eprlpn2n
	-1          "Not in universe"               
;
label values erelat25 erelat2o;
label define erelat2o
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat25 arelat2o;
label define arelat2o
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn25 eprlpn2o;
label define eprlpn2o
	-1          "Not in universe"               
;
label values erelat26 erelat2p;
label define erelat2p
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat26 arelat2p;
label define arelat2p
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn26 eprlpn2p;
label define eprlpn2p
	-1          "Not in universe"               
;
label values erelat27 erelat2q;
label define erelat2q
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat27 arelat2q;
label define arelat2q
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn27 eprlpn2q;
label define eprlpn2q
	-1          "Not in universe"               
;
label values erelat28 erelat2r;
label define erelat2r
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat28 arelat2r;
label define arelat2r
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn28 eprlpn2r;
label define eprlpn2r
	-1          "Not in universe"               
;
label values erelat29 erelat2s;
label define erelat2s
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat29 arelat2s;
label define arelat2s
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn29 eprlpn2s;
label define eprlpn2s
	-1          "Not in universe"               
;
label values erelat30 erelat3v;
label define erelat3v
	-1          "Not in universe"               
	1           "Spouse"                        
	2           "Unmarried partner"             
	10          "Biological parent"             
	11          "Stepparent"                    
	12          "Step and adoptive parent"      
	13          "Adoptive parent"               
	14          "Foster parent"                 
	15          "Other parent"                  
	20          "Biological child"              
	21          "Stepchild"                     
	22          "Step and adopted child"        
	23          "Adopted child"                 
	24          "Foster child"                  
	25          "Other child"                   
	30          "Biological brother/sister"     
	31          "Half brother/sister"           
	32          "Step brother/sister"           
	33          "Adopted brother/sister"        
	34          "Other brother/sister"          
	40          "Grandparent"                   
	41          "Grandchild"                    
	42          "Uncle/aunt"                    
	43          "Nephew/niece"                  
	50          "Father/mother-in-law"          
	51          "Daughter/son-in-law"           
	52          "Brother/sister-in-law"         
	55          "Other relative"                
	61          "Roommate/housemate"            
	62          "Roomer/boarder"                
	63          "Paid employee"                 
	65          "Other non-relative"            
	99          "Self"                          
;
label values arelat30 arelat3v;
label define arelat3v
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprlpn30 eprlpn3v;
label define eprlpn3v
	-1          "Not in universe"               
;
label values epwkunv  epwkunv;
label define epwkunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values elmtver  elmtver;
label define elmtver 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almtver  almtver;
label define almtver 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values elmtmo   elmtmo; 
label define elmtmo  
	-4          "Person became limited before age"
	-1          "Not in universe"               
;
label values almtmo   almtmo; 
label define almtmo  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tlmtyr   tlmtyr; 
label define tlmtyr  
	-4          "Limited at working since age 16"
	-1          "Not in universe"               
;
label values almtyr   almtyr; 
label define almtyr  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values elmtemp  elmtemp;
label define elmtemp 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almtemp  almtemp;
label define almtemp 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ewkltmo  ewkltmo;
label define ewkltmo 
	-3          "Had never been employed before"
	-1          "Not in universe"               
;
label values awkltmo  awkltmo;
label define awkltmo 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values twkltyr  twkltyr;
label define twkltyr 
	-3          "Had never been employed before"
	-1          "Not in universe"               
;
label values awkltyr  awkltyr;
label define awkltyr 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values emncond  emncond;
label define emncond 
	-1          "Not in universe"               
	1           "Alcohol or drug problem or"    
	2           "AIDS or AIDS Related Condition"
	3           "Arthritis or rheumatism"       
	4           "Back or spine problems"        
	5           "Blindness or vision"           
	6           "Broken bone/fracture"          
	7           "Cancer"                        
	8           "Cerebral Palsy"                
	9           "Deafness or serious trouble"   
	10          "Diabetes"                      
	11          "Epilepsy"                      
	12          "Head or spinal cord injury"    
	13          "Heart trouble , hardening the" 
	14          "Hernia or spinal injury"       
	15          "High blood pressure"           
	16          "Kidney stones or chronic kidney"
	17          "Learning disability"           
	18          "Lung or respiratory ,"         
	19          "Mental or emotional problem or"
	20          "Mental retardation"            
	21          "Missing legs, feet, arms, hands,"
	22          "Paralysis of any kind"         
	23          "Senility/Dementia/Alzheimer's" 
	24          "Speech Disorder"               
	25          "Stiffness or deformity of the" 
	26          "Stomach trouble"               
	27          "Stroke"                        
	28          "Thyroid trouble or goiter"     
	29          "Tumor, cyst or growth"         
	30          "Other"                         
;
label values amncond  amncond;
label define amncond 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values emncaus  emncaus;
label define emncaus 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amncaus  amncaus;
label define amncaus 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values emnloc   emnloc; 
label define emnloc  
	-1          "Not in universe"               
	1           "On the job"                    
	2           "During service in the Armed"   
	3           "In the home"                   
	4           "Somewhere else"                
;
label values amnloc   amnloc; 
label define amnloc  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprevwk  eprevwk;
label define eprevwk 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aprevwk  aprevwk;
label define aprevwk 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eprevmo  eprevmo;
label define eprevmo 
	-3          "Had never been able to work at a"
	-1          "Not in universe"               
;
label values aprevmo  aprevmo;
label define aprevmo 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tprevyr  tprevyr;
label define tprevyr 
	-3          "Had never been able to work at a"
	-1          "Not in universe"               
;
label values aprevyr  aprevyr;
label define aprevyr 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values enowfpt  enowfpt;
label define enowfpt 
	-1          "Not in universe"               
	1           "Full-time"                     
	2           "Part-time"                     
	3           "Not able to work"              
;
label values anowfpt  anowfpt;
label define anowfpt 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values enowocc  enowocc;
label define enowocc 
	-1          "Not in universe"               
	1           "Regularly"                     
	2           "Only occasionally or irregularly"
	3           "Not able to work"              
;
label values anowocc  anowocc;
label define anowocc 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values enowsame enowsame;
label define enowsame
	-1          "Not in universe"               
	1           "Yes, able to work same kind of"
	2           "No, not able to work same kind"
	3           "Did not work before limitation"
;
label values anowsame anowsame;
label define anowsame
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values epedunv  epedunv;
label define epedunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values eattain  eattain;
label define eattain 
	-1          "Not in universe"               
	31          "Less than 1st grade"           
	32          "1st, 2nd, 3rd, or 4th grade"   
	33          "5th or 6th grade"              
	34          "7th or 8th grade"              
	35          "9th grade"                     
	36          "10th grade"                    
	37          "11th grade"                    
	38          "12th grade, no diploma"        
	39          "High school graduate - high"   
	40          "Some college but no degree"    
	41          "Diploma or certificate from a" 
	42          "Associate degree in college -" 
	43          "Associate Degree in college -" 
	44          "Bachelor's degree (For example:"
	45          "Master's degree (For example:" 
	46          "Professional School degree (For"
	47          "Doctorate degree (For example:"
;
label values aattain  aattain;
label define aattain 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eadvncfd eadvncfd;
label define eadvncfd
	-1          "Not in universe"               
	1           "Agriculture"                   
	2           "Art/Architecture"              
	3           "Business/Management"           
	4           "Communications"                
	5           "Computer and Information"      
	6           "Education"                     
	7           "Engineering"                   
	8           "English/Literature"            
	9           "Foreign Languages"             
	10          "Law"                           
	11          "Liberal Arts/Humanities"       
	12          "Math/Statistics"               
	13          "Medicine/Dentistry"            
	14          "Nature Sciences(Biological and"
	15          "Nursing/Pharmacy/Public Health"
	16          "Philosophy/Religion/Theology"  
	17          "Psychology"                    
	18          "Social Sciences/History"       
	19          "Other"                         
;
label values aadvncfd aadvncfd;
label define aadvncfd
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values evocfld  evocfld;
label define evocfld 
	-1          "Not in universe"               
	1           "Agriculture/Forestry"          
	2           "Auto mechanics"                
	3           "Aviation"                      
	4           "Business/Office Management"    
	5           "Computer and Information"      
	6           "Construction Trades"           
	7           "Cosmetology"                   
	8           "Drafting"                      
	9           "Electronics"                   
	10          "Food Service"                  
	11          "Health Care"                   
	12          "Home Economics"                
	13          "Hotel and Restaurant Management"
	14          "Marketing and Distribution"    
	15          "Metal Working"                 
	16          "Police/Protective Services"    
	17          "Refrigeration, Heating, or Air"
	18          "Transportation and Materials"  
	19          "Other"                         
;
label values avocfld  avocfld;
label define avocfld 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eassocfd eassocfd;
label define eassocfd
	-1          "Not in universe"               
	1           "Agriculture/Forestry"          
	2           "Business/Office Management"    
	3           "Communications"                
	4           "Computer and Information"      
	5           "Education"                     
	6           "Engineering/Drafting"          
	7           "Health Sciences"               
	8           "Liberal Art/Humanities"        
	9           "Nature Sciences(Biological and"
	10          "Police/Protective Services"    
	11          "Social Sciences/History"       
	12          "Visual and Commercial Arts"    
	13          "Other Vocational/Technical"    
	14          "Other"                         
;
label values aassocfd aassocfd;
label define aassocfd
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ebachfld ebachfld;
label define ebachfld
	-1          "Not in universe"               
	1           "Agriculture/Forestry"          
	2           "Art/Architecture"              
	3           "Business/Management"           
	4           "Communications"                
	5           "Computer and Information"      
	6           "Education"                     
	7           "Engineering"                   
	8           "English/Literature"            
	9           "Foreign Languages"             
	10          "Health Sciences"               
	11          "Liberal Arts/Humanities"       
	12          "Math/Statistics"               
	13          "Nature Sciences(Biological and"
	14          "Philosophy/Religion/Theology"  
	15          "Pre-Professional"              
	16          "Psychology"                    
	17          "Social Sciences/History"       
	18          "Other"                         
;
label values abachfld abachfld;
label define abachfld
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values econenrl econenrl;
label define econenrl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aconenrl aconenrl;
label define aconenrl
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values egedtm   egedtm; 
label define egedtm  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agedtm   agedtm; 
label define agedtm  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values epubhs   epubhs; 
label define epubhs  
	-1          "Not in universe"               
	1           "Public"                        
	2           "Private"                       
	3           "Did not attend high school"    
;
label values apubhs   apubhs; 
label define apubhs  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ecourse1 ecourses;
label define ecourses
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values ecourse2 ecoursek;
label define ecoursek
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values ecourse3 ecoursel;
label define ecoursel
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values ecourse4 ecoursem;
label define ecoursem
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values ecourse5 ecoursen;
label define ecoursen
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values ecourse6 ecourseo;
label define ecourseo
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values ecourse7 ecoursep;
label define ecoursep
	-1          "Not in universe"               
	1           "Took course"                   
	2           "Didn't take courses"           
;
label values acourse  acourse;
label define acourse 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eprogram eprogram;
label define eprogram
	-1          "Not in universe"               
	1           "Academic or college preparatory"
	2           "Vocational"                    
	3           "Business"                      
	4           "General"                       
	5           "Other"                         
;
label values aprogram aprogram;
label define aprogram
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ercvtrn1 ercvtrnm;
label define ercvtrnm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arcvtrn1 arcvtrnm;
label define arcvtrnm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values enumtrn1 enumtrnm;
label define enumtrnm
	-1          "Not in universe"               
;
label values anumtrn1 anumtrnm;
label define anumtrnm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values etrn1tim etrn1tim;
label define etrn1tim
	-1          "Not in universe"               
	1           "Less than 1 full day"          
	2           "1 Day to 1 week"               
	3           "More than 1 week"              
	4           "Currently in training"         
;
label values atrn1tim atrn1tim;
label define atrn1tim
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eweekt1  eweekt1l;
label define eweekt1l
	-1          "Not in universe"               
;
label values aweekt1  aweekt1l;
label define aweekt1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eintrn1  eintrn1l;
label define eintrn1l
	-1          "Not in universe"               
	1           "Less than 1 full day"          
	2           "1 Day to 1 week"               
	3           "More than 1 week"              
;
label values aintrn1  aintrn1l;
label define aintrn1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ewhotrn1 ewhotrnm;
label define ewhotrnm
	-1          "Not in universe"               
	1           "Federal, state, or local"      
	2           "Self or family"                
	3           "Current or previous employer"  
	4           "Other"                         
;
label values awhotrn1 awhotrnm;
label define awhotrnm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rgovtrn1 rgovtrnm;
label define rgovtrnm
	-1          "Not in universe"               
	1           "Job Training Partnership"      
	2           "Job Opportunities and Basic"   
	4           "Food Stamps work and other"    
	5           "Veteran's training programs"   
;
label values agovtrn1 agovtrnm;
label define agovtrnm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values elctntr1 elctntrm;
label define elctntrm
	-1          "Not in universe"               
	1           "Business, technical, or"       
	2           "High school"                   
	3           "Two-year or community college" 
	4           "Four-year college or university"
	5           "At current or previous"        
	6           "Correspondence course"         
	7           "Sheltered workshop"            
	8           "Vocational rehabilitation center"
	9           "Other"                         
;
label values alctntr1 alctntrm;
label define alctntrm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values etyp1tr  etyp1tr;
label define etyp1tr 
	-1          "Not in universe"               
	1           "To aid in looking for a"       
	2           "To teach skills for a specific"
;
label values atyp1tr  atyp1tr;
label define atyp1tr 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ejbatrn1 ejbatrnr;
label define ejbatrnr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajbatrn1 ajbatrnr;
label define ajbatrnr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values enwatrn1 enwatrnr;
label define enwatrnr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anwatrn1 anwatrnr;
label define anwatrnr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ejbbtrn1 ejbbtrnr;
label define ejbbtrnr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajbbtrn1 ajbbtrnr;
label define ajbbtrnr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values enwbtrn1 enwbtrnr;
label define enwbtrnr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anwbtrn1 anwbtrnr;
label define anwbtrnr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rtrn1use rtrn1use;
label define rtrn1use
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values atrn1use atrn1use;
label define atrn1use
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ercvtrn2 ercvtrne;
label define ercvtrne
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arcvtrn2 arcvtrne;
label define arcvtrne
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values enumtrn2 enumtrne;
label define enumtrne
	-1          "Not in universe"               
;
label values anumtrn2 anumtrne;
label define anumtrne
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values etrn2tim etrn2tim;
label define etrn2tim
	-1          "Not in universe"               
	1           "Less than 1 full day"          
	2           "1 Day to 1 week"               
	3           "More than 1 week"              
	4           "Currently in training"         
;
label values atrn2tim atrn2tim;
label define atrn2tim
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eweekt2  eweekt2l;
label define eweekt2l
	-1          "Not in universe"               
;
label values aweekt2  aweekt2l;
label define aweekt2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eintrn2  eintrn2l;
label define eintrn2l
	-1          "Not in universe"               
	1           "Less than 1 full day"          
	2           "1 Day to 1 week"               
	3           "More than 1 week"              
;
label values aintrn2  aintrn2l;
label define aintrn2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ewhotrn2 ewhotrnk;
label define ewhotrnk
	-1          "Not in universe"               
	1           "Federal, state, or local"      
	2           "Self or family"                
	3           "Current or previous employer"  
	4           "Other"                         
;
label values awhotrn2 awhotrnk;
label define awhotrnk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rgovtrn2 rgovtrnk;
label define rgovtrnk
	-1          "Not in universe"               
	1           "Job Training Partnership"      
	2           "Job Opportunities and Basic"   
	4           "Food Stamps work and other"    
	5           "Veteran's training programs"   
	6           "No - not sponsored by any of the"
;
label values agovtrn2 agovtrnk;
label define agovtrnk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values elctntr2 elctntrk;
label define elctntrk
	-1          "Not in universe"               
	1           "Business, technical, or"       
	2           "High school"                   
	3           "Two-year or community college" 
	4           "Four-year college or university"
	5           "At current or previous"        
	6           "Correspondence course"         
	7           "Sheltered workshop"            
	8           "= Vocational rehabilitation"   
	9           "= Other"                       
;
label values alctntr2 alctntrk;
label define alctntrk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values etyp2tr1 etyp2trm;
label define etyp2trm
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values etyp2tr2 etyp2trk;
label define etyp2trk
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values etyp2tr3 etyp2trl;
label define etyp2trl
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values etyp2tr4 etyp2trn;
label define etyp2trn
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values etyp2tr5 etyp2tro;
label define etyp2tro
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values etyp2tr6 etyp2trp;
label define etyp2trp
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values etyp2tr7 etyp2trq;
label define etyp2trq
	-1          "Not in universe"               
	1           "Program had this purpose."     
	2           "Program didn't have this"      
;
label values atyp2tr  atyp2tr;
label define atyp2tr 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ejobtrn2 ejobtrnr;
label define ejobtrnr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajobtrn2 ajobtrnr;
label define ajobtrnr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values enwtrn2  enwtrn2l;
label define enwtrn2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values anwtrn2  anwtrn2l;
label define anwtrn2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rtrn2use rtrn2use;
label define rtrn2use
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values atrn2use atrn2use;
label define atrn2use
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ercvtr10 ercvtr1e;
label define ercvtr1e
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arcvtr10 arcvtr1e;
label define arcvtr1e
	0           "Not imputation"                
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tlstschl tlstschl;
label define tlstschl
	-1          "Not in universe"               
	1           "Currently attending school"    
	9999        "Never attended school"         
;
label values alstschl alstschl;
label define alstschl
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values thsyr    thsyr;  
label define thsyr   
	-1          "Not in universe"               
;
label values ahsyr    ahsyr;  
label define ahsyr   
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tcollstr tcollstr;
label define tcollstr
	-1          "Not in universe"               
;
label values acollstr acollstr;
label define acollstr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tlastcol tlastcol;
label define tlastcol
	-1          "Not in universe"               
;
label values alastcol alastcol;
label define alastcol
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tvocyr   tvocyr; 
label define tvocyr  
	-1          "Not in universe"               
;
label values avocyr   avocyr; 
label define avocyr  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tassocyr tassocyr;
label define tassocyr
	-1          "Not in universe"               
;
label values aassocyr aassocyr;
label define aassocyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tbachyr  tbachyr;
label define tbachyr 
	-1          "Not in universe"               
;
label values abachyr  abachyr;
label define abachyr 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tadvncyr tadvncyr;
label define tadvncyr
	-1          "Not in universe"               
;
label values aadvncyr aadvncyr;
label define aadvncyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values epmrunv  epmrunv;
label define epmrunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values emarpth  emarpth;
label define emarpth 
	0           "No marital path"               
;
label values exmar    exmar;  
label define exmar   
	-1          "Not in universe"               
	1           "Married once"                  
	2           "Married twice"                 
	3           "Married thrice"                
	4           "Married four or more times"    
;
label values axmar    axmar;  
label define axmar   
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ewidiv1  ewidiv1l;
label define ewidiv1l
	-1          "Not in universe"               
	1           "Widowhood"                     
	2           "Divorce"                       
;
label values awidiv1  awidiv1l;
label define awidiv1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ewidiv2  ewidiv2l;
label define ewidiv2l
	-1          "Not in universe"               
	1           "Widowhood"                     
	2           "Divorce"                       
;
label values awidiv2  awidiv2l;
label define awidiv2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tas      tas;    
label define tas     
	-1          "Not in universe"               
;
label values efmmon   efmmon; 
label define efmmon  
	-1          "Not in universe"               
;
label values afmmon   afmmon; 
label define afmmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tfmyear  tfmyear;
label define tfmyear 
	-1          "Not in universe"               
;
label values afmyear  afmyear;
label define afmyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values efsmon   efsmon; 
label define efsmon  
	-1          "Not in universe"               
;
label values afsmon   afsmon; 
label define afsmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tfsyear  tfsyear;
label define tfsyear 
	-1          "Not in universe"               
;
label values afsyear  afsyear;
label define afsyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eftmon   eftmon; 
label define eftmon  
	-1          "Not in universe"               
;
label values aftmon   aftmon; 
label define aftmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tftyear  tftyear;
label define tftyear 
	-1          "Not in universe"               
;
label values aftyear  aftyear;
label define aftyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values esmmon   esmmon; 
label define esmmon  
	-1          "Not in universe"               
;
label values asmmon   asmmon; 
label define asmmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tsmyear  tsmyear;
label define tsmyear 
	-1          "Not in universe"               
;
label values asmyear  asmyear;
label define asmyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values essmon   essmon; 
label define essmon  
	-1          "Not in universe"               
;
label values assmon   assmon; 
label define assmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tssyear  tssyear;
label define tssyear 
	-1          "Not in universe"               
;
label values assyear  assyear;
label define assyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values estmon   estmon; 
label define estmon  
	-1          "Not in universe"               
;
label values astmon   astmon; 
label define astmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tstyear  tstyear;
label define tstyear 
	-1          "Not in universe"               
;
label values astyear  astyear;
label define astyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values elmmon   elmmon; 
label define elmmon  
	-1          "Not in universe"               
;
label values almmon   almmon; 
label define almmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tlmyear  tlmyear;
label define tlmyear 
	-1          "Not in universe"               
;
label values almyear  almyear;
label define almyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values elsmon   elsmon; 
label define elsmon  
	-1          "Not in universe"               
;
label values alsmon   alsmon; 
label define alsmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tlsyear  tlsyear;
label define tlsyear 
	-1          "Not in universe"               
;
label values alsyear  alsyear;
label define alsyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eltmon   eltmon; 
label define eltmon  
	-1          "Not in universe"               
;
label values altmon   altmon; 
label define altmon  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tltyear  tltyear;
label define tltyear 
	-1          "Not in universe"               
;
label values altyear  altyear;
label define altyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values talm     talm;   
label define talm    
	-1          "Not in universe"               
;
label values aalm     aalm;   
label define aalm    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values talt     talt;   
label define talt    
	-1          "Not in universe"               
;
label values aalt     aalt;   
label define aalt    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tals     tals;   
label define tals    
	-1          "Not in universe"               
;
label values aals     aals;   
label define aals    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tafm     tafm;   
label define tafm    
	-1          "Not in universe"               
;
label values aafm     aafm;   
label define aafm    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tafs     tafs;   
label define tafs    
	-1          "Not in universe"               
;
label values aafs     aafs;   
label define aafs    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values taft     taft;   
label define taft    
	-1          "Not in universe"               
;
label values aaft     aaft;   
label define aaft    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tasm     tasm;   
label define tasm    
	-1          "Not in universe"               
;
label values aasm     aasm;   
label define aasm    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tass     tass;   
label define tass    
	-1          "Not in universe"               
;
label values aass     aass;   
label define aass    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tast     tast;   
label define tast    
	-1          "Not in universe"               
;
label values aast     aast;   
label define aast    
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values epfrunv  epfrunv;
label define epfrunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values tfrchl   tfrchl; 
label define tfrchl  
	-1          "Not in universe"               
;
label values afrchl   afrchl; 
label define afrchl  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tfrinhh  tfrinhh;
label define tfrinhh 
	-1          "Not in universe"               
;
label values afrinhh  afrinhh;
label define afrinhh 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tmomchl  tmomchl;
label define tmomchl 
	-1          "Not in universe"               
;
label values amomchl  amomchl;
label define amomchl 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values emomlivh emomlivh;
label define emomlivh
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amomlivh amomlivh;
label define amomlivh
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values efbrthmo efbrthmo;
label define efbrthmo
	-1          "Not in universe"               
;
label values afbrthmo afbrthmo;
label define afbrthmo
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tfbrthyr tfbrthyr;
label define tfbrthyr
	-1          "Not in universe"               
;
label values ragfbrth ragfbrth;
label define ragfbrth
	-1          "Not in universe"               
;
label values afbrthyr afbrthyr;
label define afbrthyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values elbirtmo elbirtmo;
label define elbirtmo
	-1          "Not in universe"               
;
label values albirtmo albirtmo;
label define albirtmo
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tlbirtyr tlbirtyr;
label define tlbirtyr
	-1          "Not in universe"               
;
label values albirtyr albirtyr;
label define albirtyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values raglbrth raglbrth;
label define raglbrth
	-1          "Not in universe"               
;
label values efblivnw efblivnw;
label define efblivnw
	-1          "Not in universe"               
	1           "In this household"             
	2           "In his/her own household"      
	3           "With own father"               
	4           "With own grandparent(s)"       
	5           "With an adoptive parent(s)"    
	6           "With other relatives"          
	7           "In foster care/foster family"  
	8           "In an institution (hospital)"  
	9           "In school"                     
	10          "In correctional facility"      
	11          "Deceased"                      
	12          "Other"                         
	13          "Don't know"                    
	14          "Refused"                       
;
label values afblivnw afblivnw;
label define afblivnw
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values elblivnw elblivnw;
label define elblivnw
	-1          "Not in universe"               
	1           "In this household"             
	2           "In his/her own household"      
	3           "With own father"               
	4           "With own grandparent(s)"       
	5           "With an adoptive parent(s)"    
	6           "With other relatives"          
	7           "In foster care/foster family"  
	8           "In an institution (hospital)"  
	9           "In school dormitory"           
	10          "In correctional facility"      
	11          "Deceased"                      
	12          "Other"                         
	13          "Don't know"                    
	14          "Refused"                       
;
label values alblivnw alblivnw;
label define alblivnw
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ebfbctwk ebfbctwk;
label define ebfbctwk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abfbctwk abfbctwk;
label define abfbctwk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ebfbwkpr ebfbwkpr;
label define ebfbwkpr
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abfbwkpr abfbwkpr;
label define abfbwkpr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ebfbpgft ebfbpgft;
label define ebfbpgft
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abfbpgft abfbpgft;
label define abfbpgft
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ebfbwsm1 ebfbwsmt;
label define ebfbwsmt
	-1          "Not in universe"               
;
label values abfbwsm1 abfbwsmt;
label define abfbwsmt
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tbfbwsy1 tbfbwsyt;
label define tbfbwsyt
	-1          "Not in universe"               
;
label values abfbwsy1 abfbwsyt;
label define abfbwsyt
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ebfbstop ebfbstop;
label define ebfbstop
	-1          "Not in universe"               
	1           "Stopped when she was found to be"
	2           "Never stopped/ worked right up"
;
label values abfbstop abfbstop;
label define abfbstop
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ragestop ragestop;
label define ragestop
	-1          "Not in universe"               
;
label values ebtsit01 ebtsit0p;
label define ebtsit0p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit02 ebtsit0k;
label define ebtsit0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit03 ebtsit0l;
label define ebtsit0l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit04 ebtsit0m;
label define ebtsit0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit05 ebtsit0n;
label define ebtsit0n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit06 ebtsit0o;
label define ebtsit0o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit07 ebtsit0q;
label define ebtsit0q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit08 ebtsit0r;
label define ebtsit0r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit09 ebtsit0s;
label define ebtsit0s
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit10 ebtsit1p;
label define ebtsit1p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit11 ebtsit1k;
label define ebtsit1k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit12 ebtsit1l;
label define ebtsit1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit13 ebtsit1m;
label define ebtsit1m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit14 ebtsit1n;
label define ebtsit1n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ebtsit15 ebtsit1o;
label define ebtsit1o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abfbsit  abfbsit;
label define abfbsit 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbst01 eafbst0t;
label define eafbst0t
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst02 eafbst0k;
label define eafbst0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst03 eafbst0l;
label define eafbst0l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst04 eafbst0m;
label define eafbst0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst05 eafbst0n;
label define eafbst0n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst06 eafbst0o;
label define eafbst0o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst07 eafbst0p;
label define eafbst0p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst08 eafbst0q;
label define eafbst0q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst09 eafbst0r;
label define eafbst0r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst10 eafbst1t;
label define eafbst1t
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst11 eafbst1k;
label define eafbst1k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst12 eafbst1l;
label define eafbst1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst13 eafbst1m;
label define eafbst1m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst14 eafbst1n;
label define eafbst1n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eafbst15 eafbst1o;
label define eafbst1o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafbjst  aafbjst;
label define aafbjst 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwrk  eafbwrk;
label define eafbwrk 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafbwrk  aafbwrk;
label define aafbwrk 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwkm1 eafbwkmk;
label define eafbwkmk
	-1          "Not in universe"               
;
label values aafbwkm1 aafbwkmk;
label define aafbwkmk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tafbwky1 tafbwkyk;
label define tafbwkyk
	-1          "Not in universe"               
;
label values aafbwky1 aafbwkyk;
label define aafbwkyk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ragertwk ragertwk;
label define ragertwk
	-1          "Not in universe"               
;
label values eafbwkft eafbwkft;
label define eafbwkft
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafbwkft aafbwkft;
label define aafbwkft
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwkhr eafbwkhr;
label define eafbwkhr
	-1          "Not in universe"               
	1           "About the same hours"          
	2           "More hours than the last job"  
	3           "Fewer hours than the last job" 
;
label values aafbwkhr aafbwkhr;
label define aafbwkhr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwkem eafbwkem;
label define eafbwkem
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
	3           "Self-Employed"                 
	4           "Employer went out of business" 
;
label values aafbwkem aafbwkem;
label define aafbwkem
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwkps eafbwkps;
label define eafbwkps
	-1          "Not in universe"               
	1           "About the same"                
	2           "Increased skill/responsibility"
	3           "Decreased skill/responsibility"
;
label values aafbwkps aafbwkps;
label define aafbwkps
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwkpy eafbwkpy;
label define eafbwkpy
	-1          "Not in universe"               
	1           "Same pay rate"                 
	2           "Higher pay rate"               
	3           "Lower pay rate"                
;
label values aafbwkpy aafbwkpy;
label define aafbwkpy
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafbwkse eafbwkse;
label define eafbwkse
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafbwkse aafbwkse;
label define aafbwkse
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values eafblvmo eafblvmo;
label define eafblvmo
	-1          "Not in universe"               
;
label values aafblvmo aafblvmo;
label define aafblvmo
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values tafblvyr tafblvyr;
label define tafblvyr
	-1          "Not in universe"               
;
label values aafblvyr aafblvyr;
label define aafblvyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
	4           "Imputed based on previous wave"
;
label values ragelvem ragelvem;
label define ragelvem
	-1          "Not in universe"               
;
label values epmgunv  epmgunv;
label define epmgunv 
	-1          "Not in universe"               
	1           "In universe"                   
;
label values eprstate eprstate;
label define eprstate
	-5          "Lived here since birth"        
	-1          "Not in universe"               
;
label values aprstate aprstate;
label define aprstate
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eprevres eprevres;
label define eprevres
	-5          "Always lived here"             
	-1          "Not in universe"               
	1           "Same state, same country, as"  
	2           "Same state, different country,"
	3           "Different state"               
	4           "Outside U. S."                 
;
label values aprevres aprevres;
label define aprevres
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values ebrstate ebrstate;
label define ebrstate
	-1          "Not in universe"               
;
label values abrstate abrstate;
label define abrstate
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rcitiznt rcitiznt;
label define rcitiznt
	-1          "Not in universe"               
	1           "Native"                        
	2           "Naturalized citizen"           
	3           "Not a naturalized citizen"     
;
label values acitiznt acitiznt;
label define acitiznt
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rimstat  rimstat;
label define rimstat 
	-1          "Not in universe"               
	1           "Permanent resident"            
	2           "Other"                         
;
label values aimstat  aimstat;
label define aimstat 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eadjust  eadjust;
label define eadjust 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aadjust  aadjust;
label define aadjust 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tmovyryr tmovyryr;
label define tmovyryr
	-5          "Always lived there"            
	-1          "Not in universe"               
	9999        "Respondent didn't supply valid"
;
label values amovyryr amovyryr;
label define amovyryr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values emovyrmo emovyrmo;
label define emovyrmo
	-5          "Always lived there"            
	-1          "Not in universe"               
	99          "Respondent didn't supply valid"
;
label values amovyrmo amovyrmo;
label define amovyrmo
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values toutotyr toutotyr;
label define toutotyr
	-5          "Always lived there"            
	-1          "Not in universe"               
;
label values aoutotyr aoutotyr;
label define aoutotyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eoutotmo eoutotmo;
label define eoutotmo
	-5          "Always lived there"            
	-1          "Not in universe/Month not known"
;
label values aoutotmo aoutotmo;
label define aoutotmo
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values toutinyr toutinyr;
label define toutinyr
	-5          "Always lived there"            
	-1          "Not in universe"               
	9999        "Respondent didn't supply valid"
;
label values aoutinyr aoutinyr;
label define aoutinyr
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eoutinmo eoutinmo;
label define eoutinmo
	-5          "Always lived there"            
	-1          "Not in universe"               
	99          "Respondent didn't supply valid"
;
label values aoutinmo aoutinmo;
label define aoutinmo
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values tmovest  tmovest;
label define tmovest 
	-5          "Always lived there"            
	-1          "Not in universe"               
	9999        "Respondent didn't supply valid"
;
label values amovest  amovest;
label define amovest 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values radyear  radyear;
label define radyear 
	-1          "Not in universe"               
	1           "Before 1973"                   
	2           "1973-1978"                     
	3           "1979-1980"                     
	4           "1981-1982"                     
	5           "1983-1984"                     
	6           "1985"                          
	7           "1986"                          
	8           "1987"                          
	9           "1988"                          
	10          "1989"                          
	11          "1990"                          
	12          "1991"                          
	13          "1992"                          
	14          "1993"                          
	15          "1994"                          
	16          "1995"                          
	17          "1996"                          
	9999        "Respondent didn't supply valid"
;
label values aadyear  aadyear;
label define aadyear 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values rmoveus  rmoveus;
label define rmoveus 
	-1          "Not in universe"               
	1           "Before 1960"                   
	2           "1960-1964"                     
	3           "1965-1969"                     
	4           "1970-1974"                     
	5           "1975-1979"                     
	6           "1980-1984"                     
	7           "1985-1989"                     
	8           "1990-1996"                     
	9999        "Respondent didn't supply valid"
;
label values amoveus  amoveus;
label define amoveus 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
;
label values eprevten eprevten;
label define eprevten
	-5          "Always lived here"             
	-1          "Not in universe"               
	1           "Owned or being bought by someone"
	2           "Rented for cash"               
	3           "Occupied without payment of cash"
;
label values aprevten aprevten;
label define aprevten
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck"                     
	3           "Logical imputation(derivation)"
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
