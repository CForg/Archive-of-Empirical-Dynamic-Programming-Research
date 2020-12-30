log using sip96l4, text replace
set mem 1000m
*This program reads the 1996 SIPP4 Core Longitudnal Data File 
*Note:  This program is distributed under the GNU GPL. See end of
*this file and http://www.gnu.org/licenses/ for details.
*NOTE: The dictionary files and programs for Core 1996 Longitudnal Files 1-12 are all the same;
*by Jean Roth Wed Nov 30 14:15:33 EST 2005
*Please report errors to jroth@nber.org
*run with do sip96l4
*Change output file name/location as desired in the first line of the .dct file
*If you are using a PC, you may need to change the direction of the slashes, as in C:\
*  or "\\Nber\home\data\sipp\1996\sip96l4.dat"
* The following changes in variable names have been made, if necessary:
*      '$' to 'd';            '-' to '_';              '%' to 'p';
*For compatibility with other software, variable label definitions are the
*variable name unless the variable name ends in a digit. 
*'1' -> 'a', '2' -> 'b', '3' -> 'c', ... , '0' -> 'j'
* Note:  Variable names in Stata are case-sensitive
clear
quietly infile using sip96l4

*Everything below this point are value labels

#delimit ;

;
label values spanel   spanel; 
label define spanel  
	1996        "Panel Year"                    
;
label values srefmon  srefmon;
label define srefmon 
	1           "First Reference month"         
	2           "Second Reference month"        
	3           "Third Reference month"         
	4           "Fourth Reference month"        
;
label values rhcalmn  rhcalmn;
label define rhcalmn 
	1           "January"                       
	10          "October"                       
	11          "November"                      
	12          "December"                      
	2           "February"                      
	3           "March"                         
	4           "April"                         
	5           "May"                           
	6           "June"                          
	7           "July"                          
	8           "August"                        
	9           "September"                     
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
	215         "TYPE-A, insufficient parital"  
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
	262         "Merged with another SIPP household"
	270         "Mover, no longer located in same"
	271         "Mover, new address located in" 
;
label values rhtype   rhtype; 
label define rhtype  
	1           "Family hh - Married couple"    
	2           "Family hh - Male householder"  
	3           "Family hh - Female householder"
	4           "Nonfamily hh - Male hhlder"    
	5           "Nonfamily hh - Female hhlder"  
	6           "Group Quarters"                
;
label values whfnwgt  whfnwgt;
label define whfnwgt 
	0           "0000:999999.9999 .Weight"      
;
label values tmetro   tmetro; 
label define tmetro  
	1           "Metro"                         
	2           "Residual"                      
;
label values tmsa     tmsa;   
label define tmsa    
	0           "Not in MSA/CMSA/PMSA or not"   
	7           "Boston-Worcester-Lawrence, MA-NH"
	14          "Chicago-Gary-Kenosha (excl.PMSA"
	21          "Cincinnati-Hamilton, OH"       
	28          "Cleveland-Akron, OH"           
	31          "Dallas-Fort Worth, TX"         
	34          "Denver-Boulder-Greeley, CO"    
	35          "Detroit-Ann Arbor-Flint, MI"   
	42          "Houston-Galveston-Brazoria, TX"
	49          "Los Angeles-Riverside-Orange"  
	56          "Miami-Fort Laudersale, FL"     
	63          "Milwuakee-Racine, WI"          
	70          "NY-NJ-LI, NJ"                  
	77          "Philadelphia-Wilmington-Atlantic"
	79          "Portland-Salem, OR-WA"         
	82          "Sacramento-Yolo, CA"           
	84          "San Francisco-Oakland-San Jose, CA"
	91          "Seattle-Tacoma-Bremerton, WA"  
	0097        "Washington-Baltimore, DC"      
	160         "Albany-Schenectady-Troy, NY"   
	200         "Albequerque, NM"               
	0240        "Allentown-Bethlehem-Easton, PA"
	520         "Atlanta, GA"                   
	640         "Austin-San Marcos, TX"         
	0680        "Bakersfield, CA"               
	760         "Baton Rouge, LA"               
	840         "Beaumont-Port Arthur, TX"      
	1000        "Birmingham, AL"                
	1280        "Buffalo-Niagara Falls, NY"     
	1440        "Charleston-North Charleston, SC"
	1480        "Charleston, WV"                
	1520        "Charlotte-Gastonia-Rock Hill, NC"
	1720        "Colorado Springs, CO"          
	1840        "Columbus, OH"                  
	1880        "Corpus Christi, TX"            
	2000        "Dayton-Springfield, OH"        
	2020        "Daytona Beach, FL"             
	2120        "Des Moines, IA"                
	2320        "El Paso, TX"                   
	2400        "Eugene-Springfield, OR"        
	2560        "Fayetville, NC"                
	2700        "Fort Myers-Cape Coral, FL"     
	2710        "Fort Pierce-Port St. Lucie, FL"
	2760        "Fort Wayne, IN"                
	2840        "Fresno, CA"                    
	3000        "Grand Rapids-Muskegon-Holland, MI"
	3120        "Greensboro--Winston-Salem--High"
	3240        "Harrisburg-Lebanon-Carlisle, PA"
	3320        "Honolulu, HI"                  
	3480        "Indianapolis, IN"              
	3600        "Jacksonville, FL"              
	3660        "Johnson City-Kingsport-Bristol, TN"
	3760        "Kansas City, KS"               
	3810        "Killeen-Temple, TX"            
	3840        "Knoxville, TN"                 
	3980        "Lakeland-Winter Haven, FL"     
	4000        "Lancaster, PA"                 
	4040        "Lansing-East Lansing, MI"      
	4120        "Las Vegas, AZ"                 
	4280        "Lexington, KY"                 
	4520        "Louisville, KY"                
	4720        "Madison, WI"                   
	4880        "McAllen-Edinburg-Mission, TX"  
	4900        "Melbourne-Titusville-Palm Bay, FL"
	4920        "Memphis, MS"                   
	5120        "Minneapolis-St. Paul, WI"      
	5160        "Mobile, AL"                    
	5170        "Modesto, CA"                   
	5240        "Montgomery, AL"                
	5360        "Nashville, TN"                 
	5560        "New Orleans, LA"               
	5720        "Norfolk-Virginia Beach-Newport"
	5880        "Oklahoma City, OK"             
	5960        "Orlando, FL"                   
	6080        "Pensacola, FL"                 
	6200        "Phoenix-Mesa, AZ"              
	6280        "Pittsburgh, PA"                
	6520        "Provo-Orem, UT"                
	6640        "Raleigh-Durham-Chapel Hill, NC"
	6680        "Reading, PA"                   
	6760        "Richmond-Petersburg, VA"       
	6840        "Rochester, NY"                 
	6880        "Rockford, IL"                  
	7040        "St. Louis, IL"                 
	7160        "Salt Lake City-Ogden, UT"      
	7240        "San Antonio, TX"               
	7320        "San Diego, CA"                 
	7480        "Santa Barbara-Santa Maria-Lompoc,"
	7510        "Sarasota-Bradenton, FL"        
	7560        "Scranton--Wilkes-Barre--Hazelton,"
	8000        "Springfield, MA"               
	8120        "Stockton-Lodi, CA"             
	8160        "Syracuse, NY"                  
	8280        "Tampa-St. Petersburg-Clearwater,"
	8400        "Toledo, OH"                    
	8560        "Tulsa, OK"                     
	8680        "Utica-Rome, NY"                
	8960        "West Palm Beach-Boca Raton, FL"
;
label values rhchange rhchange;
label define rhchange
	1           "Change occurred"               
	2           "No change occurred"            
;
label values eaccess  eaccess;
label define eaccess 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaccess  aaccess;
label define aaccess 
	0           "No imputation"                 
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eunits   eunits; 
label define eunits  
	-1          "Not in universe"               
	1           "One, detached"                 
	2           "One, attached"                 
	3           "Two"                           
	4           "3:4"                           
	5           "5-9"                           
	6           "10-19"                         
	7           "20-49"                         
	8           "50 or more"                    
;
label values aunits   aunits; 
label define aunits  
	0           "No imputation"                 
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values elivqrt  elivqrt;
label define elivqrt 
	1           "HU in House, apartment, flat"  
	10          "GQ - Unoccupied tent or trailer"
	11          "GQ - Student quarters in college"
	12          "Group quarters unit not specified"
	2           "HU in nontransient hotel, motel,"
	3           "HU permanent, in transient hotel,"
	4           "HU in rooming house"           
	5           "Mobile home or trailer w/ no"  
	6           "Mobile Home or trailer w/ one or"
	7           "HU not specified above"        
	8           "GQ - Quarters not HU in rooming"
	9           "GQ - Unit not permanent in"    
;
label values alivqrt  alivqrt;
label define alivqrt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical Imputation (Derivation)"
	4           "Statistical or logical imputation"
;
label values etenure  etenure;
label define etenure 
	1           "Owned or being bought by you or"
	2           "Rented for cash"               
	3           "Occupied without payment of cash"
;
label values atenure  atenure;
label define atenure 
	0           "No imputation"                 
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epubhse  epubhse;
label define epubhse 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apubhse  apubhse;
label define apubhse 
	0           "No imputation"                 
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values egvtrnt  egvtrnt;
label define egvtrnt 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agvtrnt  agvtrnt;
label define agvtrnt 
	0           "No imputation"                 
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmthrnt  tmthrnt;
label define tmthrnt 
	0           "None or not in universe"       
;
label values amthrnt  amthrnt;
label define amthrnt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ewrsect8 ewrsectt;
label define ewrsectt
	-1          "Not in universe"               
	1           "Section 8"                     
	2           "Some other government program" 
;
label values awrsect8 awrsectt;
label define awrsectt
	0           "No imputation"                 
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eutilyn  eutilyn;
label define eutilyn 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values autilyn  autilyn;
label define autilyn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eegyast  eegyast;
label define eegyast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aegyast  aegyast;
label define aegyast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eegypmt1 eegypmtt;
label define eegypmtt
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eegypmt2 eegypmtk;
label define eegypmtk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eegypmt3 eegypmtl;
label define eegypmtl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aegypmt  aegypmt;
label define aegypmt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eegyamt  eegyamt;
label define eegyamt 
	0           "None or not in universe"       
;
label values aegyamt  aegyamt;
label define aegyamt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehotlunc ehotlunc;
label define ehotlunc
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahotlunc ahotlunc;
label define ahotlunc
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rnklun   rnklun; 
label define rnklun  
	-1          "Not in universe"               
;
label values efreelun efreelun;
label define efreelun
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values afreelun afreelun;
label define afreelun
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values efrerdln efrerdln;
label define efrerdln
	-1          "Not in universe"               
	1           "Free lunch"                    
	2           "Reduced-price lunch"           
;
label values afrerdln afrerdln;
label define afrerdln
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ebrkfst  ebrkfst;
label define ebrkfst 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abrkfst  abrkfst;
label define abrkfst 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation"            
	4           "Statistical or logical imputation"
;
label values rnkbrk   rnkbrk; 
label define rnkbrk  
	-1          "Not in universe"               
;
label values efreebrk efreebrk;
label define efreebrk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values afreebrk afreebrk;
label define afreebrk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values efrerdbk efrerdbk;
label define efrerdbk
	-1          "Not in universe"               
	1           "Free breakfast"                
	2           "Reduced-price breakfast"       
;
label values afrerdbk afrerdbk;
label define afrerdbk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rprgques rprgques;
label define rprgques
	0           "Residence this month not in"   
	1           "Res. this mo. was intrvwed"    
	2           "Res. this mo. in sample but"   
	3           "Res. this mo. not in sample at"
;
label values rhnbrf   rhnbrf; 
label define rhnbrf  
	1           "Yes"                           
	2           "No"                            
;
label values rhcbrf   rhcbrf; 
label define rhcbrf  
	1           "Yes"                           
	2           "No"                            
;
label values rhmtrf   rhmtrf; 
label define rhmtrf  
	1           "Yes"                           
	2           "No"                            
;
label values rfid2    rfid2l; 
label define rfid2l  
	-1          "Not in universe"               
;
label values efspouse efspouse;
label define efspouse
	9999        "Persons with EFKIND=2 or 3"    
;
label values eftype   eftype; 
label define eftype  
	1           "Primary family (including those"
	3           "Unrelated Subfamily"           
	4           "Primary Individual"            
	5           "Secondary Individual"          
;
label values rfchange rfchange;
label define rfchange
	1           "Change occurred"               
	2           "No change occurred"            
;
label values efkind   efkind; 
label define efkind  
	1           "Headed by Husband/Wife"        
	2           "Male Headed"                   
	3           "Female Headed"                 
;
label values wffinwgt wffinwgt;
label define wffinwgt
	0           "0000:999999.9999 .Person weight for family"
;
label values rsid     rsid;   
label define rsid    
	-1          "Not in universe"               
;
label values esfnp    esfnp;  
label define esfnp   
	-1          "Not in universe"               
;
label values esfrfper esfrfper;
label define esfrfper
	-1          "Not in universe"               
;
label values esfspse  esfspse;
label define esfspse 
	-1          "Not in universe"               
	9999        "No spouse in subfamily"        
;
label values esftype  esftype;
label define esftype 
	-1          "Not in universe"               
	2           "Related Subfamily"             
;
label values esfkind  esfkind;
label define esfkind 
	-1          "Not in universe"               
	1           "Headed by Husband/Wife"        
	2           "Male Headed"                   
	3           "Female Headed"                 
;
label values rschange rschange;
label define rschange
	0           "Not in universe"               
	1           "Change occurred"               
	2           "No change occurred"            
;
label values esownkid esownkid;
label define esownkid
	-1          "Not in universe"               
	0           "No children"                   
;
label values esoklt18 esoklt1d;
label define esoklt1d
	-1          "Not in universe"               
	0           "No children"                   
;
label values wsfinwgt wsfinwgt;
label define wsfinwgt
	-1          "Not in universe"               
	0           "0000:999999.9999 .Weight of rel. subfamily"
;
label values tsfearn  tsfearn;
label define tsfearn 
	0           "None or not in universe"       
;
label values tsprpinc tsprpinc;
label define tsprpinc
	0           "None or not in universe"       
;
label values tstrninc tstrninc;
label define tstrninc
	0           "None or not in universe"       
;
label values tsothinc tsothinc;
label define tsothinc
	0           "None or not in universe"       
;
label values tstotinc tstotinc;
label define tstotinc
	0           "None or not in universe"       
;
label values tsfpov   tsfpov; 
label define tsfpov  
	0           "Not in universe"               
;
label values tspndist tspndist;
label define tspndist
	0           "None or not in universe"       
;
label values tslumpsm tslumpsm;
label define tslumpsm
	0           "None or not in universe"       
;
label values tssocsec tssocsec;
label define tssocsec
	0           "None or not in universe"       
;
label values tsssi    tsssi;  
label define tsssi   
	0           "None or not in universe"       
;
label values tsvets   tsvets; 
label define tsvets  
	0           "None or not in universe"       
;
label values tsunemp  tsunemp;
label define tsunemp 
	0           "None or not in universe"       
;
label values tsafdc   tsafdc; 
label define tsafdc  
	0           "None or not in universe"       
;
label values tsfdstp  tsfdstp;
label define tsfdstp 
	0           "None or not in universe"       
;
label values eppintvw eppintvw;
label define eppintvw
	1           "Interview (self)"              
	2           "Interview (proxy)"             
	3           "Noninterview - Type Z"         
	4           "Nonintrvw - pseudo Type Z.  Left"
	5           "Children under 15 during"      
;
label values epopstat epopstat;
label define epopstat
	1           "Adult (15 years of age or older)"
	2           "Child (Under 15 years of age)" 
;
label values abmnth   abmnth; 
label define abmnth  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values abyear   abyear; 
label define abyear  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values esex     esex;   
label define esex    
	1           "Male"                          
	2           "Female"                        
;
label values asex     asex;   
label define asex    
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values erace    erace;  
label define erace   
	1           "White"                         
	2           "Black"                         
	3           "American Indian, Aleut, or Eskimo"
	4           "Asian or Pacific Islander"     
;
label values arace    arace;  
label define arace   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values eorigin  eorigin;
label define eorigin 
	1           "Canadian"                      
	10          "Polish"                        
	11          "Russian"                       
	12          "Scandinavian"                  
	13          "Scotch-Irish"                  
	14          "Scottish"                      
	15          "Slovak"                        
	16          "Welsh"                         
	17          "Other European"                
	2           "Dutch"                         
	20          "Mexican"                       
	21          "Mexican-American"              
	22          "Chicano"                       
	23          "Puerto Rican"                  
	24          "Cuban"                         
	25          "Central American"              
	26          "South American"                
	27          "Dominican Republic"            
	28          "Other Hispanic"                
	3           "English"                       
	30          "African-American or Afro-American"
	31          "American Indian, Eskimo, or Aleut"
	32          "Arab"                          
	33          "Asian"                         
	34          "Pacific Islander"              
	35          "West Indian"                   
	39          "Another group not listed"      
	4           "French"                        
	40          "American"                      
	5           "French-Canadian"               
	6           "German"                        
	7           "Hungarian"                     
	8           "Irish"                         
	9           "Italian"                       
;
label values aorigin  aorigin;
label define aorigin 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values uevrwid  uevrwid;
label define uevrwid 
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
	6           "Don't know"                    
	7           "Refused"                       
;
label values uevrdiv  uevrdiv;
label define uevrdiv 
	0           "Not answered"                  
	1           "Yes"                           
	2           "No"                            
	6           "Don't know"                    
	7           "Refused"                       
;
label values eafnow   eafnow; 
label define eafnow  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafnow   aafnow; 
label define aafnow  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eafever  eafever;
label define eafever 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafever  aafever;
label define aafever 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values uaf1     uaf1l;  
label define uaf1l   
	0           "Not answered"                  
	1           "August 1990 to present (including"
	2           "September 1980 to July 1990"   
	3           "May 1975 to Ausust 1980"       
	4           "Vietnam Era (Aug '64 - April '75)"
	5           "Other service  (All other periods)"
	6           "Don't know"                    
	7           "Refused"                       
;
label values uaf2     uaf2l;  
label define uaf2l   
	0           "Not answered"                  
	1           "August 1990 to present (including"
	2           "September 1980 to July 1990"   
	3           "May 1975 to Ausust 1980"       
	4           "Vietnam Era (Aug '64 - April '75)"
	5           "Other service  (All other periods)"
	8           "No other periods of service"   
;
label values uaf3     uaf3l;  
label define uaf3l   
	0           "Not answered"                  
	1           "August 1990 to present (including"
	2           "September 1980 to July 1990"   
	3           "May 1975 to Ausust 1980"       
	4           "Vietnam Era (Aug '64 - April '75)"
	5           "Other service  (All other periods)"
	8           "No other periods of service"   
;
label values uaf4     uaf4l;  
label define uaf4l   
	0           "Not answered"                  
	1           "August 1990 to present (including"
	2           "September 1980 to July 1990"   
	3           "May 1975 to Ausust 1980"       
	4           "Vietnam Era (Aug '64 - April '75)"
	5           "Other service  (All other periods)"
	8           "No other periods of service"   
;
label values uaf5     uaf5l;  
label define uaf5l   
	0           "Not answered"                  
	1           "August 1990 to present (including"
	2           "September 1980 to July 1990"   
	3           "May 1975 to Ausust 1980"       
	4           "Vietnam Era (Aug '64 - April '75)"
	5           "Other service  (All other periods)"
	8           "No other periods of service"   
;
label values evayn    evayn;  
label define evayn   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values avayn    avayn;  
label define avayn   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values evettyp  evettyp;
label define evettyp 
	-1          "Not in universe"               
	1           "Service-connected disability"  
	2           "Survivor Benefits"             
	3           "Veteran's Pension"             
	4           "Other Veteran's Payments"      
;
label values avettyp  avettyp;
label define avettyp 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values evaques  evaques;
label define evaques 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values avaques  avaques;
label define avaques 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eafsrvdi eafsrvdi;
label define eafsrvdi
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aafsrvdi aafsrvdi;
label define aafsrvdi
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values wpfinwgt wpfinwgt;
label define wpfinwgt
	0           "0000:999999.9999 .Final person weight"
;
label values esfr     esfr;   
label define esfr    
	0           "Not in universe"               
	1           "Reference person of a rel. or" 
	2           "Spouse of reference person of a"
	3           "Child (under 18) of reference" 
;
label values esft     esft;   
label define esft    
	0           "Primary family"                
	1           "Secondary indiv (not a family" 
	2           "Unrelated subfamily"           
	3           "Related subfamily"             
	4           "Primary individual"            
;
label values tage     tage;   
label define tage    
	0           "Less than 1 full year old"     
;
label values aage     aage;   
label define aage    
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values errp     errp;   
label define errp    
	1           "Reference person w/ rel. persons"
	10          "Unmarried partner of reference"
	11          "Housemate/roommate"            
	12          "Roomer/boarder"                
	13          "Other non-relative of reference"
	2           "Reference Person w/out rel."   
	3           "Spouse of reference person"    
	4           "Child of reference person"     
	5           "Grandchild of reference person"
	6           "Parent of reference person"    
	7           "Brother/sister of reference person"
	8           "Other relative of reference person"
	9           "Foster child of reference person"
;
label values arrp     arrp;   
label define arrp    
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
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
label values ams      ams;    
label define ams     
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values epnspous epnspous;
label define epnspous
	9999        "Spouse not in hhld or person not"
;
label values apnspous apnspous;
label define apnspous
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values epnmom   epnmom; 
label define epnmom  
	9999        "No mother in household"        
;
label values apnmom   apnmom; 
label define apnmom  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values epndad   epndad; 
label define epndad  
	9999        "No father in household"        
;
label values apndad   apndad; 
label define apndad  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values epnguard epnguard;
label define epnguard
	-1          "Not in universe"               
	9999        "Guardian not in household"     
;
label values apnguard apnguard;
label define apnguard
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values etypmom  etypmom;
label define etypmom 
	-1          "Not in universe"               
	1           "Biological or natural child"   
	2           "Stepchild"                     
	3           "Adopted child"                 
;
label values atypmom  atypmom;
label define atypmom 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values etypdad  etypdad;
label define etypdad 
	-1          "Not in universe"               
	1           "Biological or natural child"   
	2           "Stepchild"                     
	3           "Adopted child"                 
;
label values atypdad  atypdad;
label define atypdad 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values rdesgpnt rdesgpnt;
label define rdesgpnt
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ulftmain ulftmain;
label define ulftmain
	0           "Not answered"                  
	1           "Deceased"                      
	10          "Other"                         
	11          "Moved to type C household"     
	2           "Institutionalized"             
	3           "On active duty in the Armed Forces"
	4           "Moved outside of U.S."         
	5           "Separation or divorce"         
	6           "Marriage"                      
	7           "Became employed/unemployed"    
	8           "Due to job change - other"     
	9           "Listed in error in prior wave" 
;
label values uentmain uentmain;
label define uentmain
	0           "Not answered"                  
	1           "Birth"                         
	10          "Job change - other"            
	11          "Lived at this address before"  
	12          "Other"                         
	2           "Marriage"                      
	3           "Returned to hhld after missing"
	4           "Due to separation or divorce"  
	5           "From an institution"           
	6           "From Armed  Forces barracks"   
	7           "From outside the U.S."         
	8           "Should have been listed as member"
	9           "Became employed/unemployed"    
;
label values ulftday  ulftday;
label define ulftday 
	0           "Not answered"                  
;
label values ulftmon  ulftmon;
label define ulftmon 
	0           "Not answered"                  
;
label values uentday  uentday;
label define uentday 
	0           "Not answered"                  
;
label values uentmon  uentmon;
label define uentmon 
	0           "Not answered"                  
	13          "Entered before reference period"
;
label values tpearn   tpearn; 
label define tpearn  
	0           "None or not in universe"       
;
label values tpprpinc tpprpinc;
label define tpprpinc
	0           "None or not in universe"       
;
label values tptrninc tptrninc;
label define tptrninc
	0           "None or not in universe"       
;
label values tpothinc tpothinc;
label define tpothinc
	0           "None or not in universe"       
;
label values tptotinc tptotinc;
label define tptotinc
	0           "None or not in universe"       
;
label values tppndist tppndist;
label define tppndist
	0           "None or not in universe"       
;
label values tplumpsm tplumpsm;
label define tplumpsm
	0           "None or not in universe"       
;
label values ehtlnyn  ehtlnyn;
label define ehtlnyn 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahtlnyn  ahtlnyn;
label define ahtlnyn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ebkfsyn  ebkfsyn;
label define ebkfsyn 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abkfsyn  abkfsyn;
label define abkfsyn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rcutyp01 rcutyp0n;
label define rcutyp0n
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown01 rcuown0n;
label define rcuown0n
	0           "Not in universe"               
;
label values rcutyp03 rcutyp0k;
label define rcutyp0k
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown03 rcuown0k;
label define rcuown0k
	0           "Not in universe"               
;
label values rcutyp04 rcutyp0l;
label define rcutyp0l
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown04 rcuown0l;
label define rcuown0l
	0           "Not in universe"               
;
label values rcutyp08 rcutyp0m;
label define rcutyp0m
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown8a rcuown8a;
label define rcuown8a
	0           "Not in universe"               
;
label values rcuown8b rcuown8b;
label define rcuown8b
	0           "Not in universe"               
;
label values rcutyp20 rcutyp2b;
label define rcutyp2b
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown20 rcuown2b;
label define rcuown2b
	0           "Not in universe"               
;
label values rcutyp21 rcutyp2k;
label define rcutyp2k
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuow21a rcuow21a;
label define rcuow21a
	0           "Not in universe"               
;
label values rcuow21b rcuow21b;
label define rcuow21b
	0           "Not in universe"               
;
label values rcutyp23 rcutyp2l;
label define rcutyp2l
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown23 rcuown2k;
label define rcuown2k
	0           "Not in universe"               
;
label values rcutyp24 rcutyp2m;
label define rcutyp2m
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuow24a rcuow24a;
label define rcuow24a
	0           "Not in universe"               
;
label values rcuow24b rcuow24b;
label define rcuow24b
	0           "Not in universe"               
;
label values rcutyp25 rcutyp2n;
label define rcutyp2n
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown25 rcuown2l;
label define rcuown2l
	0           "Not in universe"               
;
label values rcutyp27 rcutyp2o;
label define rcutyp2o
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown27 rcuown2m;
label define rcuown2m
	0           "Not in universe"               
;
label values rcutyp57 rcutyp5b;
label define rcutyp5b
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuown57 rcuown5b;
label define rcuown5b
	0           "Not in universe"               
;
label values rcutyp58 rcutyp5k;
label define rcutyp5k
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values rcuow58a rcuow58a;
label define rcuow58a
	0           "Not in universe"               
;
label values rcuow58b rcuow58b;
label define rcuow58b
	0           "Not in universe"               
;
label values renroll  renroll;
label define renroll 
	-1          "Not in universe"               
	1           "Enrolled full-time"            
	2           "Enrolled part-time"            
	3           "Not enrolled"                  
;
label values arenroll arenroll;
label define arenroll
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values eenrlm   eenrlm; 
label define eenrlm  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aenrlm   aenrlm; 
label define aenrlm  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values renrlma  renrlma;
label define renrlma 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eenlevel eenlevel;
label define eenlevel
	-1          "Not in universe"               
	1           "Elementary grades 1-8"         
	10          "Enrolled in college, but not"  
	2           "High school grades 9-12"       
	3           "College year 1 (freshman)"     
	4           "College year 2 (sophomore)"    
	5           "College year 3 (junior)"       
	6           "College year 4 (senior)"       
	7           "College year 5 (first year"    
	8           "College year 6+ (second year or"
	9           "Vocational, technical, or"     
;
label values aenlevel aenlevel;
label define aenlevel
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values eedfund  eedfund;
label define eedfund 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aedfund  aedfund;
label define aedfund 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values easst01  easst01l;
label define easst01l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst03  easst03l;
label define easst03l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst04  easst04l;
label define easst04l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst05  easst05l;
label define easst05l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst06  easst06l;
label define easst06l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst07  easst07l;
label define easst07l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst08  easst08l;
label define easst08l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst09  easst09l;
label define easst09l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst10  easst10l;
label define easst10l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values easst11  easst11l;
label define easst11l
	-1          "Not in universe"               
	0           "Data suppressed"               
	1           "Received"                      
	2           "Did not receive"               
;
label values aedasst  aedasst;
label define aedasst 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
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
	45          "Master's degree (For example: MA,"
	46          "Professional School Degree (For"
	47          "Doctorate degree (For example:"
;
label values aeducate aeducate;
label define aeducate
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
	5           "Longitudinal statistical"      
	6           "Longitudinal logical imputation"
;
label values epdjbthn epdjbthn;
label define epdjbthn
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apdjbthn apdjbthn;
label define apdjbthn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ejobsrch ejobsrch;
label define ejobsrch
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajobsrch ajobsrch;
label define ajobsrch
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ejobtrn  ejobtrn;
label define ejobtrn 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajobtrn  ajobtrn;
label define ajobtrn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values rjobhelp rjobhelp;
label define rjobhelp
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values eppflag  eppflag;
label define eppflag 
	-1          "Not in universe or not applicable"
	1           "Yes"                           
;
label values emax     emax;   
label define emax    
	-1          "Not in universe"               
;
label values ebuscntr ebuscntr;
label define ebuscntr
	-1          "Not in universe"               
	0           "Contingent business"           
;
label values ejobcntr ejobcntr;
label define ejobcntr
	-1          "Not in universe"               
	0           "Contingent workers"            
;
label values eeveret  eeveret;
label define eeveret 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aeveret  aeveret;
label define aeveret 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values edisabl  edisabl;
label define edisabl 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adisabl  adisabl;
label define adisabl 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values edisprev edisprev;
label define edisprev
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values adisprev adisprev;
label define adisprev
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ersnowrk ersnowrk;
label define ersnowrk
	-1          "Not in universe"               
	1           "Temporarily unable to work"    
	10          "Not interested in working at a job"
	11          "Other"                         
	2           "Temporarily not able to work"  
	3           "Unable to work because of chronic"
	4           "Retired"                       
	5           "Pregnancy/childbirth"          
	6           "Taking care of children/other" 
	7           "Going to school"               
	8           "Unable to find work"           
	9           "On layoff (temporary or"       
;
label values arsnowrk arsnowrk;
label define arsnowrk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eawop    eawop;  
label define eawop   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aawop    aawop;  
label define aawop   
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eabre    eabre;  
label define eabre   
	-1          "Not in universe"               
	1           "On layoff (temporary or"       
	10          "New job to begin within 30 days"
	11          "Participated in a job-sharing" 
	12          "Other"                         
	2           "Slack work or business conditions"
	3           "Own injury"                    
	4           "Own illness/injury/medical"    
	5           "Pregnancy/childbirth"          
	6           "Taking care of children"       
	7           "On vacation/personal days"     
	8           "Bad weather"                   
	9           "Labor dispute"                 
;
label values aabre    aabre;  
label define aabre   
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eptwrk   eptwrk; 
label define eptwrk  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aptwrk   aptwrk; 
label define aptwrk  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eptresn  eptresn;
label define eptresn 
	-1          "Not in universe"               
	1           "Could not find full-time job"  
	10          "On vacation"                   
	11          "In school"                     
	12          "Other"                         
	2           "Wanted to work part time"      
	3           "Temporarily unable to work"    
	4           "Temporarily not able to work"  
	5           "Unable to work full-time because"
	6           "Taking care of children/other" 
	7           "Full-time workweek less than 35"
	8           "Slack work or material shortage"
	9           "Participated in a job sharing" 
;
label values aptresn  aptresn;
label define aptresn 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values elkwrk   elkwrk; 
label define elkwrk  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values alkwrk   alkwrk; 
label define alkwrk  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values elayoff  elayoff;
label define elayoff 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values alayoff  alayoff;
label define alayoff 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values rtakjob  rtakjob;
label define rtakjob 
	-1          "Not in universe"               
	0           "Not reported"                  
	1           "Yes"                           
	2           "No"                            
;
label values rnotake  rnotake;
label define rnotake 
	-1          "Not in universe"               
	0           "Not reported"                  
	1           "Waiting for a new job to begin"
	2           "Own temporary illness"         
	3           "School"                        
	4           "Other"                         
;
label values emoonlit emoonlit;
label define emoonlit
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amoonlit amoonlit;
label define amoonlit
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tmlmsum  tmlmsum;
label define tmlmsum 
	0           "None or not in universe"       
;
label values amlmsum  amlmsum;
label define amlmsum 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ebflag   ebflag; 
label define ebflag  
	-1          "Not in universe or not applicable"
	1           "Yes"                           
;
label values ecflag   ecflag; 
label define ecflag  
	-1          "Not in universe"               
	1           "Yes"                           
;
label values rmesr    rmesr;  
label define rmesr   
	-1          "Not in universe"               
	1           "With a job entire month, worked"
	2           "With a job all month, absent from"
	3           "With job all month, absent from"
	4           "With a job at least 1 but not all"
	5           "With job at least 1 but not all"
	6           "No job all month, on layoff or"
	7           "No job, at least one but not all"
	8           "No job, no time on layoff and no"
;
label values rwkesr1  rwkesr1l;
label define rwkesr1l
	-1          "Not in universe"               
	1           "With job/bus - working"        
	2           "With job/bus - not on layoff," 
	3           "With job/bus - on layoff, absent"
	4           "No job/bus - looking for work or"
	5           "No job/bus - not looking and not"
;
label values rwkesr2  rwkesr2l;
label define rwkesr2l
	-1          "Not in universe"               
	1           "With job/bus - working"        
	2           "With job/bus - not on layoff," 
	3           "With job/bus - on layoff, absent"
	4           "No job/bus - looking for work or"
	5           "No job/bus - not looking and not"
;
label values rwkesr3  rwkesr3l;
label define rwkesr3l
	-1          "Not in universe"               
	1           "With job/bus - working"        
	2           "With job/bus - not on layoff," 
	3           "With job/bus - on layoff, absent"
	4           "No job/bus - looking for work or"
	5           "No job/bus - not looking and not"
;
label values rwkesr4  rwkesr4l;
label define rwkesr4l
	-1          "Not in universe"               
	1           "With job/bus - working"        
	2           "With job/bus - not on layoff," 
	3           "With job/bus - on layoff, absent"
	4           "No job/bus - looking for work or"
	5           "No job/bus - not looking and not"
;
label values rwkesr5  rwkesr5l;
label define rwkesr5l
	-1          "Not in universe"               
	1           "With job/bus - working"        
	2           "With job/bus - not on layoff," 
	3           "With job/bus - on layoff, absent"
	4           "No job/bus - looking for work or"
	5           "No job/bus - not looking and not"
;
label values rmwkwjb  rmwkwjb;
label define rmwkwjb 
	-1          "Not in universe"               
	0           "0 weeks (that is, did not have a"
	1           "1 week"                        
	2           "2 weeks"                       
	3           "3 weeks"                       
	4           "4 weeks"                       
	5           "5 weeks (if applicable)"       
;
label values rmwksab  rmwksab;
label define rmwksab 
	-1          "Not in universe"               
	0           "0 weeks (that is, not absent"  
	1           "1 week"                        
	2           "2 weeks"                       
	3           "3 weeks"                       
	4           "4 weeks"                       
	5           "5 weeks (if applicable)"       
;
label values awksab   awksab; 
label define awksab  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values rmwklkg  rmwklkg;
label define rmwklkg 
	-1          "Not in universe"               
	0           "0 weeks (that is, did not look"
	1           "1 week"                        
	2           "2 weeks"                       
	3           "3 weeks"                       
	4           "4 weeks"                       
	5           "5 weeks (if applicable)"       
;
label values awklkg   awklkg; 
label define awklkg  
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values rmhrswk  rmhrswk;
label define rmhrswk 
	-1          "Not in universe"               
	0           "Did not work"                  
	1           "All weeks 35+"                 
	2           "All weeks 1-34 hours"          
	3           "Some weeks 35+ and some weeks" 
	4           "Some weeks 35+, some 1-34 hours,"
	5           "At least 1, but not all, weeks"
	6           "At least 1 week, but not all"  
;
label values rwksperm rwksperm;
label define rwksperm
	-1          "Not in universe"               
	4           "four weeks"                    
	5           "five weeks"                    
;
label values eeno1    eeno1l; 
label define eeno1l  
	-1          "Not in universe"               
;
label values estlemp1 estlempm;
label define estlempm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values astlemp1 astlempm;
label define astlempm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tsjdate1 tsjdatem;
label define tsjdatem
	-1          "Not in universe"               
;
label values asjdate1 asjdatem;
label define asjdatem
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tejdate1 tejdatem;
label define tejdatem
	-1          "Not in universe"               
;
label values aejdate1 aejdatem;
label define aejdatem
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ersend1  ersend1l;
label define ersend1l
	-1          "Not in universe"               
	1           "On layoff"                     
	10          "Employer sold business"        
	11          "Job was temporary and ended"   
	12          "Quit to take another job"      
	13          "Slack work or business conditions"
	14          "Unsatisfactory work arrangements"
	15          "Quit for some other reason"    
	2           "Retirement or old age"         
	3           "Childcare problems"            
	4           "Other family/personal obligations"
	5           "Own illness"                   
	6           "Own injury"                    
	7           "School/training"               
	8           "Discharged/fired"              
	9           "Employer bankrupt"             
;
label values arsend1  arsend1l;
label define arsend1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ejbhrs1  ejbhrs1l;
label define ejbhrs1l
	-1          "Not in universe"               
;
label values ajbhrs1  ajbhrs1l;
label define ajbhrs1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eemploc1 eemplocm;
label define eemplocm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aemploc1 aemplocm;
label define aemplocm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tempall1 tempallm;
label define tempallm
	-1          "Not in universe"               
	1           "Under 25 employees"            
	2           "25 to 99 employees"            
	3           "100+ employees"                
;
label values aempall1 aempallm;
label define aempallm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tempsiz1 tempsizm;
label define tempsizm
	-1          "Not in universe"               
	1           "Under 25 employees"            
	2           "25 to 99 employees"            
	3           "100+ employees"                
;
label values aempsiz1 aempsizm;
label define aempsizm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eocctim1 eocctimm;
label define eocctimm
	-1          "Not in universe"               
;
label values aocctim1 aocctimm;
label define aocctimm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
;
label values eclwrk1  eclwrk1l;
label define eclwrk1l
	-1          "Not in universe"               
	1           "Private for profit employee"   
	2           "Private not for profit employee"
	3           "Local government worker"       
	4           "State government worker"       
	5           "Federal government worker"     
	6           "Family worker without pay"     
;
label values aclwrk1  aclwrk1l;
label define aclwrk1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eunion1  eunion1l;
label define eunion1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aunion1  aunion1l;
label define aunion1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ecntrc1  ecntrc1l;
label define ecntrc1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acntrc1  acntrc1l;
label define acntrc1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tpmsum1  tpmsum1l;
label define tpmsum1l
	0           "None or not in universe"       
;
label values apmsum1  apmsum1l;
label define apmsum1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values epayhr1  epayhr1l;
label define epayhr1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayhr1  apayhr1l;
label define apayhr1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tpyrate1 tpyratem;
label define tpyratem
	0           "Not in universe or none 0.01:30.00 .Dollars and cents (two implied"
;
label values apyrate1 apyratem;
label define apyratem
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values rpyper1  rpyper1l;
label define rpyper1l
	-1          "Not in universe"               
	1           "Once a week"                   
	2           "Once every two weeks"          
	3           "Once a month"                  
	4           "Twice a month"                 
	5           "Unpaid in a family business or"
	6           "On commission"                 
	7           "Some other way"                
	8           "Not reported"                  
;
label values ejbind1  ejbind1l;
label define ejbind1l
	-1          "Not in universe"               
	10          "Agricultural production, crops"
	100         "Meat products (201)"           
	101         "Dairy products (202)"          
	102         "Canned, frozen and preserved"  
	11          "Agriculturl production, livestock"
	110         "Grain mill products (204)"     
	111         "Bakery products (205)"         
	112         "Sugar and confectionery products"
	12          "Veterinary services (074)"     
	120         "Beverage industries (208)"     
	121         "Miscellaneous food preparations"
	122         "Not specified food industries" 
	130         "Tobacco manufactures (21)"     
	132         "Knitting mills (225)"          
	140         "Dyeing and finishing textiles,"
	141         "Carpets and rugs (227)"        
	142         "Yarn, thread, and fabric mills"
	150         "Miscellaneous textile mill"    
	151         "Apparel and accessories, except"
	152         "Miscellaneous fabricated textile"
	160         "Pulp, paper, and paperboard mills"
	161         "Miscellaneous paper and pulp"  
	162         "Paperboard containers and boxes"
	171         "Newspaper publishing and printing"
	172         "Printing, publishing, and allied"
	180         "Plastics, synthetics, and resins"
	181         "Drugs (283)"                   
	182         "Soaps and cosmetics (284)"     
	190         "Paints, varnishes, and rel."   
	191         "Agricultural chemicals (287)"  
	192         "Industrial and miscellaneous"  
	20          "Landscape and horticultural"   
	200         "Petroleum refining (291)"      
	201         "Miscellaneous petroleum and coal"
	210         "Tires and inner tubes (301)"   
	211         "Other rubber products, and"    
	212         "Miscellaneous plastics products"
	220         "Leather tanning and finishing" 
	221         "Footwear, except rubber and"   
	222         "Leather products, except footwear"
	230         "Logging (241)"                 
	231         "Sawmills, planing mills, and"  
	232         "Wood buildings and mobile homes"
	241         "Miscellaneous wood products (244,"
	242         "Furniture and fixtures (25)"   
	250         "Glass and glass products (321-323)"
	251         "Cement, concrete, gypsum, and" 
	252         "Structural clay products (325)"
	261         "Pottery and related products (326)"
	262         "Miscellaneous nonmetallic mineral"
	270         "Blast furnaces, steelworks,"   
	271         "Iron and steel foundries (332)"
	272         "Primary aluminum industries"   
	280         "Other primary metal industries"
	281         "Cutlery, handtools, and general"
	282         "Fabricated structural metal"   
	290         "Screw machine products (345)"  
	291         "Metal forgings and stampings (346)"
	292         "Ordnance (348)"                
	30          "Agricultural services, n.e.c." 
	300         "Misc fabricated metal products"
	301         "Not specified metal industries"
	31          "Forestry (08)"                 
	310         "Engines and turbines (351)"    
	311         "Farm machinery and equipment (352)"
	312         "Construction and material"     
	32          "Fishing, hunting, and trapping"
	320         "Metalworking machinery (354)"  
	321         "Office and accounting machines"
	322         "Computers and rel. equipment"  
	331         "Machinery, except electrical," 
	332         "Not specified machinery"       
	340         "Household appliances (363)"    
	341         "Radio, TV, and communication"  
	342         "Electrical machinery, equipment,"
	350         "Not specified electrical"      
	351         "Motor vehicles and motor vehicle"
	352         "Aircraft and parts (372)"      
	360         "Ship and boat building and"    
	361         "Railroad locomotives and"      
	362         "Guided missiles, space vehicles,"
	370         "Cycles and miscellaneous"      
	371         "Scientific and controlling"    
	372         "Medical, dental, and optical"  
	380         "Photographic equipment and"    
	381         "Watches, clocks, and clockwork"
	390         "Toys, amusement, and sporting" 
	391         "Miscellaneous manufacturing"   
	392         "Not spec manufacturing industries"
	40          "Metal mining (10)"             
	400         "Railroads (40)"                
	401         "Bus service and urban transit" 
	402         "Taxicab service (412)"         
	41          "Coal mining (12)"              
	410         "Trucking service (421, 423)"   
	411         "Warehousing and storage (422)" 
	412         "U.S. Postal Service (43)"      
	42          "Oil and gas extraction (13)"   
	420         "Water transportation (44)"     
	421         "Air transportation (45)"       
	422         "Pipe lines, except natural gas"
	432         "Services incidental to"        
	440         "Radio and television broadcasting"
	441         "Telephone communications (481)"
	442         "Telegraph and miscellaneous"   
	450         "Electric light and power (491)"
	451         "Gas and steam supply systems"  
	452         "Electric and gas, and other"   
	470         "Water supply and irrigation (494,"
	471         "Sanitary services (495)"       
	472         "Not specified utilities"       
	50          "Nonmetallic mining and quarrying,"
	500         "Motor Vehicles and equipment (501)"
	501         "Furniture and home furnishings"
	502         "Lumber and construction materials"
	510         "Professional and commercial"   
	511         "Metals and minerals, except"   
	512         "Electrical goods (506)"        
	521         "Hardware, plumbing and heating"
	530         "Machinery, equipment, and"     
	531         "Scrap and waste materials (5093)"
	532         "Miscellaneous wholesale, durable"
	540         "Paper and paper products (511)"
	541         "Drugs, chemicals and allied"   
	542         "Apparel, fabrics, and notions" 
	550         "Groceries and related products"
	551         "Farm-product raw materials (515)"
	552         "Petroleum products (517)"      
	560         "Alcoholic beverages (518)"     
	561         "Farm supplies (5191)"          
	562         "Misc wholesale, nondurable goods"
	571         "Not specified wholesale trade" 
	580         "Lumber and building material"  
	581         "Hardware stores (525)"         
	582         "Stores, retail nurseries and"  
	590         "Mobile home dealers (527)"     
	591         "Department stores (531)"       
	592         "Variety stores (533)"          
	60          "Construction (15, 16, 17)"     
	600         "Stores, misc general merchandise"
	601         "Grocery stores (541)"          
	602         "Stores, dairy products (545)"  
	610         "Retail bakeries (546)"         
	611         "Food stores, n.e.c. (542, 543,"
	612         "Motor vehicle dealers (551, 552)"
	620         "Stores, auto and home supply (553)"
	621         "Gasoline service stations (554)"
	622         "Miscellaneous vehicle dealers" 
	623         "Stores, apparel and accessory,"
	630         "Shoe stores (566)"             
	631         "Stores, furniture and home"    
	632         "Stores, household appliance (572)"
	633         "Stores, radio, TV, and computer"
	640         "Music stores (5735, 5736)"     
	641         "Eating and drinking places (58)"
	642         "Drug stores (591)"             
	650         "Liquor stores (592)"           
	651         "Stores, sporting goods, bicycles,"
	652         "Stores, book and stationery"   
	660         "Jewelry stores (5944)"         
	661         "Gift, novelty, and souvenir shops"
	662         "Sewing, needlework and piece"  
	663         "Catalog and mail order houses" 
	670         "Vending machine operators (5962)"
	671         "Direct selling establishments" 
	672         "Fuel dealers (598)"            
	681         "Retail florists (5992)"        
	682         "Stores, Miscellaneous retail"  
	691         "Not specified retail trade"    
	700         "Banking (60 except 603 and 606)"
	701         "Savings institutions, including"
	702         "Credit agencies, n.e.c. (61)"  
	710         "Security, commodity brokerage,"
	711         "Insurance (63, 64)"            
	712         "Real estate, including real"   
	721         "Advertising (731)"             
	722         "Services to dwellings and other"
	731         "Personnel supply services (736)"
	732         "Computer and data processing"  
	740         "Detective and protective services"
	741         "Business services, n.e.c. (732,"
	742         "Automotive rental and leasing,"
	750         "Automotive parking and carwashes"
	751         "Automotive repair and rel."    
	752         "Electrical repair shops (762," 
	760         "Misc repair services (763, 764,"
	761         "Private Households (88)"       
	762         "Hotels and motels (701)"       
	770         "Lodging places, except hotels and"
	771         "Laundry, cleaning, and garment"
	772         "Beauty shops (723)"            
	780         "Barber shops (724)"            
	781         "Funeral service and crematories"
	782         "Shoe repair shops (725)"       
	790         "Dressmaking shops (part 7219)" 
	791         "Misc personal services (722, 729)"
	800         "Theaters and motion pictures"  
	801         "Video tape rental (784)"       
	802         "Bowling centers (793)"         
	810         "Miscellaneous entertainment and"
	812         "Physicians offices and clinics"
	820         "Dentists offices and clinics (802)"
	821         "Chiropractors offices and clinics"
	822         "Optometrists offices and clinics"
	830         "Health practitioners offices and"
	831         "Hospitals (806)"               
	832         "Nursing and personal care"     
	840         "Health services, n.e.c. (807," 
	841         "Legal services (81)"           
	842         "Elementary and secondary schools"
	850         "Colleges and universities (822)"
	851         "Vocational schools (824)"      
	852         "Libraries (823)"               
	860         "Educational services, n.e.c. (829)"
	861         "Job training and vocational"   
	862         "Child day care services (part 835)"
	863         "Family child care homes (part 835)"
	870         "Residential care facilities,"  
	871         "Social services, n.e.c. (832, 839)"
	872         "Museums, art galleries, and zoos"
	873         "Labor unions (863)"            
	880         "Religious organizations (866)" 
	881         "Membership organizations, n.e.c."
	882         "Engineering, architectural, and"
	890         "Accounting, auditing, and"     
	891         "Research, development, and"    
	892         "Management and public relations"
	893         "Miscellaneous professional and"
	900         "Executive and legislative offices"
	901         "General government, n.e.c. (919)"
	910         "Justice, public order, and safety"
	921         "Public finance, taxation, and" 
	922         "Human resources programs"      
	930         "Environmental quality and housing"
	931         "Economic programs"             
	932         "National security and"         
	991         "Persons whose labor force status"
;
label values ajbind1  ajbind1l;
label define ajbind1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tjbocc1  tjbocc1l;
label define tjbocc1l
	-1          "Not in universe"               
	103         "Physical therapists (3033)"    
	104         "Speech therapists (3034)"      
	105         "Therapists, n.e.c. (3039)"     
	106         "Physicians' assistants (304)"  
	113         "Earth, environmental, and marine"
	114         "Biological science teachers (2213)"
	115         "Chemistry teachers (2214)"     
	116         "Physics teachers (2215)"       
	117         "Natural science teachers, n.e.c."
	118         "Psychology teachers (2217)"    
	119         "Economics teachers (2218)"     
	123         "History teachers (2222)"       
	124         "Political science teachers (2223)"
	125         "Sociology teachers (2224)"     
	126         "Social science teachers, n.e.c."
	127         "Engineering teachers (2226)"   
	128         "Math. science teachers (2227)" 
	129         "Computer science teachers (2228)"
	13          "Managers, marketing, advertising,"
	133         "Medical science teachers (2231)"
	134         "Health specialties teachers (2232)"
	135         "Business, commerce, and marketing"
	136         "Agriculture and forestry teachers"
	137         "Art, drama, and music teachers"
	138         "Physical education teachers (2236)"
	139         "Education teachers (2237)"     
	14          "Admin, education and rel. fields"
	143         "English teachers (2238)"       
	144         "Foreign language teachers (2242)"
	145         "Law teachers (2243)"           
	146         "Social work teachers (2244)"   
	147         "Theology teachers (2245)"      
	148         "Trade and industrial teachers" 
	149         "Home economics teachers (2247)"
	15          "Managers, medicine and health" 
	153         "Teachers, postsecondary, n.e.c."
	154         "Postsecondary teachers, subject"
	155         "Teachers, prekindergarten and" 
	156         "Teachers, elementary school (232)"
	157         "Teachers, secondary school (233)"
	158         "Teachers, special education (235)"
	159         "Teachers, n.e.c. (236, 239)"   
	163         "Counselors, Educational and"   
	164         "Librarians (251)"              
	165         "Archivists and curators (252)" 
	166         "Economists (1912)"             
	167         "Psychologists (1915)"          
	168         "Sociologists (1916)"           
	169         "Social scientists, n.e.c. (1913,"
	17          "Managers, food serving and"    
	173         "Urban planners (192)"          
	174         "Social workers (2032)"         
	175         "Recreation workers (2033)"     
	176         "Clergy (2042)"                 
	177         "Religious workers, n.e.c. (2049)"
	178         "Lawyers and Judges (211, 212)" 
	18          "Managers, properties and real" 
	183         "Authors (321)"                 
	184         "Technical writers (398)"       
	185         "Designers (322)"               
	186         "Musicians and composers (323)" 
	187         "Actors and directors (324)"    
	188         "Painters, sculptors,"          
	189         "Photographers (326)"           
	19          "Funeral directors (part 1359)" 
	193         "Dancers (327)"                 
	194         "Artists, performers, and rel." 
	195         "Editors and reporters (331)"   
	197         "Public relations specialists (332)"
	198         "Announcers (333)"              
	199         "Athletes (34)"                 
	203         "Clinical laboratory technologists"
	204         "Dental hygienists (363)"       
	205         "Health record technologists and"
	206         "Radiologic technicians (365)"  
	207         "Licensed practical nurses (366)"
	208         "Health technologists and"      
	21          "Managers, service organizations,"
	213         "Electrical and electronic"     
	214         "Industrial engineering"        
	215         "Mechanical engineering"        
	216         "Engineering technicians, n.e.c."
	217         "Drafting occupations (372)"    
	218         "Surveying and mapping technicians"
	22          "Managers and administrators,"  
	223         "Biological technicians (382)"  
	224         "Chemical technicians (3831)"   
	225         "Science technicians, n.e.c."   
	226         "Airplane pilots and navigators"
	227         "Air traffic controllers (392)" 
	228         "Broadcast equipment operators" 
	229         "Computer programmers (3971, 3972)"
	23          "Accountants and auditors (1412)"
	233         "Tool programmers, numerical"   
	234         "Legal assistants (396)"        
	235         "Technicians, n.e.c. (399)"     
	24          "Underwriters (1414)"           
	243         "Supervisors and Proprietors,"  
	25          "Other financial officers (1415,"
	253         "Insurance sales occupations (4122)"
	254         "Real estate sales occupations" 
	255         "Securities and financial services"
	256         "Advertising and rel. sales"    
	257         "Sales occupations, other business"
	258         "Sales engineers (421)"         
	259         "Sales representatives, mining,"
	26          "Management analysts (142)"     
	263         "Sales workers, motor vehicles and"
	264         "Sales workers, apparel (4346)" 
	265         "Sales workers, shoes (4351)"   
	266         "Sales workers, furniture and home"
	267         "Sales workers, radio, TV, hi-fi,"
	268         "Sales workers, hardware and"   
	269         "Sales workers, parts (4367)"   
	27          "Personnel, training, and labor"
	274         "Sales workers, other commodities"
	275         "Sales counter clerks (4363)"   
	276         "Cashiers (4364)"               
	277         "Street and door-to-door sales" 
	278         "News vendors (4365)"           
	28          "Purchasing agents and buyers," 
	283         "Demonstrators, promoters and"  
	284         "Auctioneers (447)"             
	285         "Sales support occupations, n.e.c."
	29          "Buyers, wholesale and retail"  
	303         "Supervisors, general office"   
	304         "Supervisors, computer equipment"
	305         "Supervisors, financial records"
	306         "Chief communications operators"
	307         "Supervisors, distribution,"    
	308         "Computer operators (4612)"     
	309         "Peripheral equipment operators"
	313         "Secretaries (4622)"            
	314         "Stenographers (4623)"          
	315         "Typists (4624)"                
	316         "Interviewers (4642)"           
	317         "Hotel clerks (4643)"           
	318         "Transportation ticket and"     
	319         "Receptionists (4645)"          
	323         "Information clerks, n.e.c. (4649)"
	325         "Classified-ad clerks (4662)"   
	326         "Correspondence clerks (4663)"  
	327         "Order clerks (4664)"           
	328         "Personnel clerks, except payroll"
	329         "Library clerks (4694)"         
	33          "Purch. agents and buyers, n.e.c."
	335         "File clerks (4696)"            
	336         "Records clerks (4699)"         
	337         "Bookkeepers, accounting, and"  
	338         "Payroll and timekeeping clerks"
	339         "Billing clerks (4715)"         
	34          "Business and promotion agents" 
	343         "Cost and rate clerks (4716)"   
	344         "Billing, posting, and calculating"
	345         "Duplicating machine operators" 
	346         "Mail preparing and paper handling"
	347         "Office mach. operators, n.e.c."
	348         "Telephone operators (4732)"    
	35          "Construction inspectors (1472)"
	353         "Communications equipment"      
	354         "Postal clerks, except mail"    
	355         "Mail carriers, postal service" 
	356         "Mail clerks, except postal"    
	357         "Messengers (4745)"             
	359         "Dispatchers (4751)"            
	36          "Inspectors and compliance"     
	363         "Production coordinators (4752)"
	364         "Traffic, shipping, and receiving"
	365         "Stock and inventory clerks (4754)"
	366         "Meter readers (4755)"          
	368         "Weighers, measurers, checkers,"
	37          "Management rel. occupations,"  
	373         "Expediters (4758)"             
	374         "Material recording, scheduling,"
	375         "Insurance adjusters, examiners,"
	376         "Investigators and adjusters,"  
	377         "Eligibility clerks, social"    
	378         "Bill and account collectors (4786)"
	379         "General office clerks (463)"   
	383         "Bank tellers (4791)"           
	384         "Proofreaders (4792)"           
	385         "Data-entry keyers (4793)"      
	386         "Statistical clerks (4794)"     
	387         "Teachers' aides (4795)"        
	389         "Administrative support"        
	4           "Chief executives and general"  
	403         "Launderers and ironers (503)"  
	404         "Cooks, private household (504)"
	405         "Housekeepers and butlers (505)"
	406         "Child care workers, private hhld"
	407         "Private hhld cleaners and"     
	413         "Supervisors, firefighting and" 
	414         "Supervisors, police and"       
	415         "Supervisors, guards (5113)"    
	416         "Fire inspection and fire"      
	417         "Firefighting occupations (5123)"
	418         "Police and detectives, public" 
	423         "Sheriffs, bailiffs, and other law"
	424         "Correctional institution officers"
	425         "Crossing guards (5142)"        
	426         "Guards and police, except public"
	427         "Protective service occupations,"
	43          "Architects (161)"              
	433         "Supervisors, food preparation and"
	434         "Bartenders (5212)"             
	435         "Waiters and waitresses (5213)" 
	436         "Cooks (5214, 5215)"            
	438         "Food counter, fountain and rel."
	439         "Kitchen workers, food preparation"
	44          "Aerospace engineers(1622)"     
	443         "Waiters'/waitresses' assistants"
	444         "Miscellaneous food preparation"
	445         "Dental assistants (5232)"      
	446         "Health aides, except nursing"  
	447         "Nursing aides, orderlies, and" 
	448         "Supervisors, cleaning and"     
	449         "Maids and housemen (5242, 5249)"
	45          "Metallurgical and materials"   
	453         "Janitors and cleaners (5244)"  
	454         "Elevator operators (5245)"     
	455         "Pest control occupations (5246)"
	456         "Supervisors, personal service" 
	457         "Barbers (5252)"                
	458         "Hairdressers and cosmetologists"
	459         "Attendants, amusement and"     
	46          "Mining engineers (1624)"       
	461         "Guides (5255)"                 
	462         "Ushers (5256)"                 
	463         "Public transportation attendants"
	464         "Baggage porters and bellhops"  
	465         "Welfare service aides (5263)"  
	466         "Family child care providers (part"
	467         "Early childhood teacher's"     
	468         "Child care workers, n.e.c. (part"
	469         "Personal service occupations," 
	47          "Petroleum engineers (1625)"    
	473         "Farmers, except horticultural" 
	474         "Horticultural specialty farmers"
	475         "Managers, farms, except"       
	476         "Managers, horticultural specialty"
	477         "Supervisors, farm workers (5611)"
	479         "Farm workers (5612-5617)"      
	48          "Chemical engineers (1626)"     
	483         "Marine life cultivation workers"
	484         "Nursery workers (5619)"        
	485         "Supervisors, rel. agricultural"
	486         "Groundskeepers and gardeners," 
	487         "Animal caretakers, except farm"
	488         "Graders and sorters, agricultural"
	489         "Inspectors, agricultural products"
	49          "Nuclear engineers (1627)"      
	494         "Supervisors, forestry and logging"
	495         "Forestry workers, except logging"
	496         "Timber cutting and logging"    
	497         "Captains and other officers,"  
	498         "Fishers (583)"                 
	499         "Hunters and trappers (584)"    
	5           "Administrators and officials," 
	503         "Supervisors, mechanics and"    
	505         "Automobile mechanics (part 6111)"
	506         "Auto mechanic apprentices (part"
	507         "Bus, truck, and stationary engine"
	508         "Aircraft engine mechanics (6113)"
	509         "Small engine repairers (6114)" 
	514         "Automobile body and rel."      
	515         "Aircraft mechanics, except engine"
	516         "Heavy equipment mechanics (6117)"
	517         "Farm equipment mechanics (6118)"
	518         "Industrial machinery repairers"
	519         "Machinery maintenance occupations"
	523         "Electronic repairers,"         
	525         "Data processing equipment"     
	526         "Hhld appliance and power tool" 
	527         "Telephone line installers and" 
	529         "Telephone installers and"      
	53          "Civil engineers (1628)"        
	533         "Miscellaneous electrical and"  
	534         "Heating, air conditioning, and"
	535         "Camera, watch, and musical"    
	536         "Locksmiths and safe repairers" 
	538         "Office machine repairers (6174)"
	539         "Mechanical controls and valve" 
	54          "Agricultural engineers (1632)" 
	543         "Elevator installers and repairers"
	544         "Millwrights (6178)"            
	547         "Specified mechanics and"       
	549         "Not specified mechanics and"   
	55          "Engineers, electrical and"     
	553         "Supervisors, brickmasons,"     
	554         "Supervisors, carpenters and rel."
	555         "Supervisors, electricians and" 
	556         "Supervisors, painters,"        
	557         "Supervisors, plumbers,"        
	558         "Supervisors, construction, n.e.c."
	56          "Engineers, industrial (1634)"  
	563         "Brickmasons and stonemasons (part"
	564         "Brickmason and stonemason"     
	565         "Tile setters, hard and soft (part"
	566         "Carpet installers (part 6462)" 
	567         "Carpenters (part 6422)"        
	569         "Carpenter apprentices (part 6422)"
	57          "Engineers, mechanical (1635)"  
	573         "Drywall installers (6424)"     
	575         "Electricians (part 6432)"      
	576         "Electrician apprentices (part" 
	577         "Electrical power installers and"
	579         "Painters, construction and"    
	58          "Marine and naval architects (1637)"
	583         "Paperhangers (6443)"           
	584         "Plasterers (6444)"             
	585         "Plumbers, pipefitters, and"    
	587         "Plumber, pipefitter, and"      
	588         "Concrete and terrazzo finishers"
	589         "Glaziers (6464)"               
	59          "Engineers, n.e.c. (1639)"      
	593         "Insulation workers (6465)"     
	594         "Paving, surfacing, and tamping"
	595         "Roofers (6468)"                
	596         "Sheetmetal duct installers (6472)"
	597         "Structural metal workers (6473)"
	598         "Drillers, earth (6474)"        
	599         "Construction trades, n.e.c."   
	6           "Administrators, protective"    
	613         "Supervisors, extractive"       
	614         "Drillers, oil well (652)"      
	615         "Explosives workers (653)"      
	616         "Mining machine operators (654)"
	617         "Mining occupations, n.e.c. (656)"
	628         "Supervisors, production"       
	63          "Surveyors and mapping scientists"
	634         "Tool and die makers (part 6811)"
	635         "Tool and die mkr apprentices"  
	636         "Precision assemblers, metal (6812)"
	637         "Machinists (part 6813)"        
	639         "Machinist apprentices (part 6813)"
	64          "Computer systems analysts and" 
	643         "Boilermakers (6814)"           
	644         "Precision grinders, filers, and"
	645         "Patternmakers and model makers,"
	646         "Lay-out workers (6821)"        
	647         "Precious stones and metals"    
	649         "Engravers, metal (6823)"       
	65          "Operations and systems"        
	653         "Sheet metal workers (part 6824)"
	654         "Sheet metal wrker apprentices" 
	655         "Misc precision metal workers"  
	656         "Patternmkrs and model makers," 
	657         "Cabinet makers and bench"      
	658         "Furniture and wood finishers"  
	659         "Misc precision woodworkers (6839)"
	66          "Actuaries (1732)"              
	666         "Dressmakers (part 6852, part 7752)"
	667         "Tailors (part 6852)"           
	668         "Upholsterers (6853)"           
	669         "Shoe repairers (6854)"         
	67          "Statisticians (1733)"          
	674         "Misc precision apparel and fabric"
	675         "Hand molders and shapers, except"
	676         "Patternmakers, lay-out workers,"
	677         "Optical goods workers (6864, part"
	678         "Dental laboratory and medical" 
	679         "Bookbinders (6844)"            
	68          "Mathematical scientists, n.e.c."
	683         "Electrical/electronic equipment"
	684         "Miscellaneous precision workers,"
	686         "Butchers and meat cutters (6871)"
	687         "Bakers (6872)"                 
	688         "Food batchmakers (6873, 6879)" 
	689         "Inspectors, testers, and graders"
	69          "Physicists and astronomers (1842,"
	693         "Adjusters and calibrators (6882)"
	694         "Water and sewage treatment plant"
	695         "Power plant operators (part 693)"
	696         "Stationary engineers (part 693,"
	699         "Miscellaneous plant and system"
	7           "Financial managers (122)"      
	703         "Set-up operators, lathe and"   
	704         "Operators, lathe and turning"  
	705         "Milling and planing machine"   
	706         "Punching and stamping press"   
	707         "Rolling machine operators (7316,"
	708         "Drilling and boring machine"   
	709         "Grinding, abrading, buffing, and"
	713         "Forging machine operators (7319,"
	714         "Numerical control machine"     
	715         "Miscellaneous metal, plastic," 
	717         "Fabricating machine operators,"
	719         "Molding and casting machine"   
	723         "Metal plating machine operators"
	724         "Heat treating equipment operators"
	725         "Misc metal and plastic processing"
	726         "Wood lathe, routing, and planing"
	727         "Sawing machine operators (7433,"
	728         "Shaping and joining machine"   
	729         "Nailing and tacking machine"   
	73          "Chemists, except biochemists"  
	733         "Miscellaneous woodworking machine"
	734         "Printing press operators (7443,"
	735         "Photoengravers and lithographers"
	736         "Typesetters and compositors"   
	737         "Miscellaneous printing machine"
	738         "Winding and twisting machine"  
	739         "Knitting, looping, taping, and"
	74          "Atmospheric and space scientists"
	743         "Textile cutting machine operators"
	744         "Textile sewing machine operators"
	745         "Shoe machine operators (7656)" 
	747         "Pressing machine operators (7657)"
	748         "Laundering and dry cleaning"   
	749         "Miscellaneous textile machine" 
	75          "Geologists and geodesists (1847)"
	753         "Cementing and gluing machine"  
	754         "Packaging and filling machine" 
	755         "Extruding and forming machine" 
	756         "Mixing and blending machine"   
	757         "Separating, filtering, and"    
	758         "Compressing and compacting"    
	759         "Painting and paint spraying"   
	76          "Physical scientists, n.e.c. (1849)"
	763         "Roasting and baking machine"   
	764         "Washing, cleaning, and pickling"
	765         "Folding machine operators (7474,"
	766         "Furnace, kiln, and oven"       
	768         "Crushing and grinding machine" 
	769         "Slicing and cutting machine"   
	77          "Agricultural and food scientists"
	773         "Motion picture projectionists" 
	774         "Photographic process machine"  
	777         "Miscellaneous machine operators,"
	779         "Machine operators, not specified"
	78          "Biological and life scientists"
	783         "Welders and cutters (7332, 7532,"
	784         "Solderers and brazers (7333,"  
	785         "Assemblers (772, 774)"         
	786         "Hand cutting and trimming"     
	787         "Hand molding, casting, and"    
	789         "Hand painting, coating, and"   
	79          "Forestry and conservation"     
	793         "Hand engraving and printing"   
	795         "Miscellaneous hand working"    
	796         "Production inspectors, checkers,"
	797         "Production testers (783)"      
	798         "Production samplers and weighers"
	799         "Graders and sorters, except"   
	8           "Personnel and labor relations" 
	803         "Supervisors, motor vehicle"    
	804         "Truck drivers (8212-8214)"     
	806         "Driver-sales workers (8218)"   
	808         "Bus drivers (8215)"            
	809         "Taxicab drivers and chauffeurs"
	813         "Parking lot attendants (874)"  
	814         "Motor transportation occupations,"
	823         "Railroad conductors and"       
	824         "Locomotive operating occupations"
	825         "Railroad brake, signal, and"   
	826         "Rail vehicle operators, n.e.c."
	828         "Ship captains and mates, except"
	829         "Sailors and deckhands (8243)"  
	83          "Medical scientists (1855)"     
	833         "Marine engineers (8244)"       
	834         "Bridge, lock, and lighthouse"  
	84          "Physicians (261)"              
	843         "Supervisors, material moving"  
	844         "Operating engineers (8312)"    
	845         "Longshore equipment operators" 
	848         "Hoist and winch operators (8314)"
	849         "Crane and tower operators (8315)"
	85          "Dentists (262)"                
	853         "Excavating and loading machine"
	855         "Grader, dozer, and scraper"    
	856         "Industrial truck and tractor"  
	859         "Misc material moving equipment"
	86          "Veterinarians (27)"            
	864         "Supervisors, handlers, equipment"
	865         "Helpers, mechanics, and repairers"
	866         "Helpers, construction trades"  
	867         "Helpers, surveyor (8646)"      
	868         "Helpers, extractive occupations"
	869         "Construction laborers (871)"   
	87          "Optometrists (281)"            
	874         "Production helpers (861, 862)" 
	875         "Garbage collectors (8722)"     
	876         "Stevedores (8723)"             
	877         "Stock handlers and baggers (8724)"
	878         "Machine feeders and offbearers"
	88          "Podiatrists (283)"             
	883         "Freight, stock, and material"  
	885         "Garage and service station rel."
	887         "Vehicle washers and equipment" 
	888         "Hand packers and packagers (8761)"
	889         "Laborers, except construction" 
	89          "Health diagnosing practitioners,"
	9           "Purchasing managers (124)"     
	905         "Persons whose current labor force"
	95          "Registered nurses (29)"        
	96          "Pharmacists (301)"             
	97          "Dietitians (302)"              
	98          "Respiratory therapists (3031)" 
	99          "Occupational therapists (3032)"
;
label values ajbocc1  ajbocc1l;
label define ajbocc1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eeno2    eeno2l; 
label define eeno2l  
	-1          "Not in universe"               
;
label values estlemp2 estlempk;
label define estlempk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values astlemp2 astlempk;
label define astlempk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tsjdate2 tsjdatek;
label define tsjdatek
	-1          "Not in universe"               
;
label values asjdate2 asjdatek;
label define asjdatek
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tejdate2 tejdatek;
label define tejdatek
	-1          "Not in universe"               
;
label values aejdate2 aejdatek;
label define aejdatek
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ersend2  ersend2l;
label define ersend2l
	-1          "Not in universe"               
	1           "On layoff"                     
	10          "Employer sold business"        
	11          "Job was temporary and ended"   
	12          "Quit to take another job"      
	13          "Slack work or business conditions"
	14          "Unsatisfactory work arrangements"
	15          "Quit for some other reason"    
	2           "Retirement or old age"         
	3           "Childcare problems"            
	4           "Other family/personal obligations"
	5           "Own illness"                   
	6           "Own injury"                    
	7           "School/training"               
	8           "Discharged/fired"              
	9           "Employer bankrupt"             
;
label values arsend2  arsend2l;
label define arsend2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ejbhrs2  ejbhrs2l;
label define ejbhrs2l
	-1          "Not in universe"               
;
label values ajbhrs2  ajbhrs2l;
label define ajbhrs2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eemploc2 eemplock;
label define eemplock
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aemploc2 aemplock;
label define aemplock
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tempall2 tempallk;
label define tempallk
	-1          "Not in universe"               
	1           "Under 25 employees"            
	2           "25 to 99 employees"            
	3           "100+ employees"                
;
label values aempall2 aempallk;
label define aempallk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tempsiz2 tempsizk;
label define tempsizk
	-1          "Not in universe"               
	1           "Under 25 employees"            
	2           "25 to 99 employees"            
	3           "100+ employees"                
;
label values aempsiz2 aempsizk;
label define aempsizk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eclwrk2  eclwrk2l;
label define eclwrk2l
	-1          "Not in universe"               
	1           "Private for profit employee"   
	2           "Private not for profit employee"
	3           "Local government worker"       
	4           "State government worker"       
	5           "Federal government worker"     
	6           "Family worker without pay"     
;
label values aclwrk2  aclwrk2l;
label define aclwrk2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eunion2  eunion2l;
label define eunion2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aunion2  aunion2l;
label define aunion2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ecntrc2  ecntrc2l;
label define ecntrc2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acntrc2  acntrc2l;
label define acntrc2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tpmsum2  tpmsum2l;
label define tpmsum2l
	0           "None or not in universe"       
;
label values apmsum2  apmsum2l;
label define apmsum2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values epayhr2  epayhr2l;
label define epayhr2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apayhr2  apayhr2l;
label define apayhr2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tpyrate2 tpyratek;
label define tpyratek
	0           "Not in universe or none 0.01:30.00 .Dollars and cents (two implied"
;
label values apyrate2 apyratek;
label define apyratek
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values rpyper2  rpyper2l;
label define rpyper2l
	-1          "Not in universe"               
	1           "Once a week"                   
	2           "Once every two weeks"          
	3           "Once a month"                  
	4           "Twice a month"                 
	5           "Unpaid in a family business or"
	6           "On commission"                 
	7           "Some other way"                
	8           "Not reported"                  
;
label values ejbind2  ejbind2l;
label define ejbind2l
	-1          "Not in universe"               
	10          "Agricultural production, crops"
	100         "Meat products (201)"           
	101         "Dairy products (202)"          
	102         "Canned, frozen and preserved"  
	11          "Agricltrl production, livestock"
	110         "Grain mill products (204)"     
	111         "Bakery products (205)"         
	112         "Sugar and confectionery products"
	12          "Veterinary services (074)"     
	120         "Beverage industries (208)"     
	121         "Miscellaneous food preparations"
	122         "Not specified food industries" 
	130         "Tobacco manufactures (21)"     
	132         "Knitting mills (225)"          
	140         "Dyeing and finishing textiles,"
	141         "Carpets and rugs (227)"        
	142         "Yarn, thread, and fabric mills"
	150         "Miscellaneous textile mill"    
	151         "Apparel and accessories, except"
	152         "Miscellaneous fabricated textile"
	160         "Pulp, paper, and paperboard mills"
	161         "Miscellaneous paper and pulp"  
	162         "Paperboard containers and boxes"
	171         "Newspaper publishing and printing"
	172         "Printing, publishing, and allied"
	180         "Plastics, synthetics, and resins"
	181         "Drugs (283)"                   
	182         "Soaps and cosmetics (284)"     
	190         "Paints, varnishes, and rel."   
	191         "Agricultural chemicals (287)"  
	192         "Industrial and miscellaneous"  
	20          "Landscape and horticultural"   
	200         "Petroleum refining (291)"      
	201         "Miscellaneous petroleum and coal"
	210         "Tires and inner tubes (301)"   
	211         "Other rubber products, and"    
	212         "Miscellaneous plastics products"
	220         "Leather tanning and finishing" 
	221         "Footwear, except rubber and"   
	222         "Leather products, except footwear"
	230         "Logging (241)"                 
	231         "Sawmills, planing mills, and"  
	232         "Wood buildings and mobile homes"
	241         "Miscellaneous wood products (244,"
	242         "Furniture and fixtures (25)"   
	250         "Glass and glass products (321-323)"
	251         "Cement, concrete, gypsum, and" 
	252         "Structural clay products (325)"
	261         "Pottery and related products (326)"
	262         "Miscellaneous nonmetallic mineral"
	270         "Blast furnaces, steelworks,"   
	271         "Iron and steel foundries (332)"
	272         "Primary aluminum industries"   
	280         "Other primary metal industries"
	281         "Cutlery, handtools, and general"
	282         "Fabricated structural metal"   
	290         "Screw machine products (345)"  
	291         "Metal forgings and stampings (346)"
	292         "Ordnance (348)"                
	30          "Agricultural services, n.e.c." 
	300         "Misc fabricated metal products"
	301         "Not specified metal industries"
	31          "Forestry (08)"                 
	310         "Engines and turbines (351)"    
	311         "Farm machinery and equipment (352)"
	312         "Construction and material"     
	32          "Fishing, hunting, and trapping"
	320         "Metalworking machinery (354)"  
	321         "Office and accounting machines"
	322         "Computers and rel. equipment"  
	331         "Machinery, except electrical," 
	332         "Not specified machinery"       
	340         "Household appliances (363)"    
	341         "Radio, TV, and communication"  
	342         "Electrical machinery, equipment,"
	350         "Not specified electrical"      
	351         "Motor vehicles and motor vehicle"
	352         "Aircraft and parts (372)"      
	360         "Ship and boat building and"    
	361         "Railroad locomotives and"      
	362         "Guided missiles, space vehicles,"
	370         "Cycles and miscellaneous"      
	371         "Scientific and controlling"    
	372         "Medical, dental, and optical"  
	380         "Photographic equipment and"    
	381         "Watches, clocks, and clockwork"
	390         "Toys, amusement, and sporting" 
	391         "Miscellaneous manufacturing"   
	392         "Not spec manufacturing industries"
	40          "Metal mining (10)"             
	400         "Railroads (40)"                
	401         "Bus service and urban transit" 
	402         "Taxicab service (412)"         
	41          "Coal mining (12)"              
	410         "Trucking service (421, 423)"   
	411         "Warehousing and storage (422)" 
	412         "U.S. Postal Service (43)"      
	42          "Oil and gas extraction (13)"   
	420         "Water transportation (44)"     
	421         "Air transportation (45)"       
	422         "Pipe lines, except natural gas"
	432         "Services incidental to"        
	440         "Radio and television broadcasting"
	441         "Telephone communications (481)"
	442         "Telegraph and miscellaneous"   
	450         "Electric light and power (491)"
	451         "Gas and steam supply systems"  
	452         "Electric and gas, and other"   
	470         "Water supply and irrigation (494,"
	471         "Sanitary services (495)"       
	472         "Not specified utilities"       
	50          "Nonmetallic mining and quarrying,"
	500         "Motor vehcls and equipment (501)"
	501         "Furniture and home furnishings"
	502         "Lumber and construction materials"
	510         "Professional and commercial"   
	511         "Metals and minerals, except"   
	512         "Electrical goods (506)"        
	521         "Hardware, plumbing and heating"
	530         "Machinery, equipment, and"     
	531         "Scrap and waste materials (5093)"
	532         "Miscellaneous wholesale, durable"
	540         "Paper and paper products (511)"
	541         "Drugs, chemicals and allied"   
	542         "Apparel, fabrics, and notions" 
	550         "Groceries and related products"
	551         "Farm-product raw materials (515)"
	552         "Petroleum products (517)"      
	560         "Alcoholic beverages (518)"     
	561         "Farm supplies (5191)"          
	562         "Misc wholesale, nondurable goods"
	571         "Not specified wholesale trade" 
	580         "Lumber and building material"  
	581         "Hardware stores (525)"         
	582         "Stores, retail nurseries and"  
	590         "Mobile home dealers (527)"     
	591         "Department stores (531)"       
	592         "Variety stores (533)"          
	60          "Construction (15, 16, 17)"     
	600         "Stores, misc general merchandise"
	601         "Grocery stores (541)"          
	602         "Stores, dairy products (545)"  
	610         "Retail bakeries (546)"         
	611         "Food stores, n.e.c. (542, 543,"
	612         "Motor vehicle dealers (551, 552)"
	620         "Stores, auto and home supply (553)"
	621         "Gasoline service stations (554)"
	622         "Miscellaneous vehicle dealers" 
	623         "Stores, apparel and accessory,"
	630         "Shoe stores (566)"             
	631         "Stores, furniture and home"    
	632         "Stores, household appliance (572)"
	633         "Stores, radio, TV, and computer"
	640         "Music stores (5735, 5736)"     
	641         "Eating and drinking places (58)"
	642         "Drug stores (591)"             
	650         "Liquor stores (592)"           
	651         "Stores, sporting goods, bicycles,"
	652         "Stores, book and stationery"   
	660         "Jewelry stores (5944)"         
	661         "Gift, novelty, and souvenir shops"
	662         "Sewing, needlework and piece"  
	663         "Catalog and mail order houses" 
	670         "Vending machine operators (5962)"
	671         "Direct selling establishments" 
	672         "Fuel dealers (598)"            
	681         "Retail florists (5992)"        
	682         "Stores, Miscellaneous retail"  
	691         "Not specified retail trade"    
	700         "Banking (60 except 603 and 606)"
	701         "Savings institutions, including"
	702         "Credit agencies, n.e.c. (61)"  
	710         "Security, commodity brokerage,"
	711         "Insurance (63, 64)"            
	712         "Real estate, including real"   
	721         "Advertising (731)"             
	722         "Services to dwellings and other"
	731         "Personnel supply services (736)"
	732         "Computer and data processing"  
	740         "Detective and protective services"
	741         "Business services, n.e.c. (732,"
	742         "Automotive rental and leasing,"
	750         "Automotive parking and carwashes"
	751         "Automotive repair and rel."    
	752         "Electrical repair shops (762," 
	760         "Misc repair services (763, 764,"
	761         "Private Households (88)"       
	762         "Hotels and motels (701)"       
	770         "Lodging places, except hotels and"
	771         "Laundry, cleaning, and garment"
	772         "Beauty shops (723)"            
	780         "Barber shops (724)"            
	781         "Funeral service and crematories"
	782         "Shoe repair shops (725)"       
	790         "Dressmaking shops (part 7219)" 
	791         "Misc personal services (722, 729)"
	800         "Theaters and motion pictures"  
	801         "Video tape rental (784)"       
	802         "Bowling centers (793)"         
	810         "Miscellaneous entertainment and"
	812         "Physicians offices and clinics"
	820         "Dentists offices and clinics (802)"
	821         "Chiropractors offices and clinics"
	822         "Optometrists offices and clinics"
	830         "Health practitioners offices and"
	831         "Hospitals (806)"               
	832         "Nursing and personal care"     
	840         "Health services, n.e.c. (807," 
	841         "Legal services (81)"           
	842         "Elementary and secondary schools"
	850         "Colleges and universities (822)"
	851         "Vocational schools (824)"      
	852         "Libraries (823)"               
	860         "Educational services, n.e.c. (829)"
	861         "Job training and vocational"   
	862         "Child day care services (part 835)"
	863         "Family child care homes (part 835)"
	870         "Residential care facilities,"  
	871         "Social services, n.e.c. (832, 839)"
	872         "Museums, art galleries, and zoos"
	873         "Labor unions (863)"            
	880         "Religious organizations (866)" 
	881         "Membership organizations, n.e.c."
	882         "Engineering, architectural, and"
	890         "Accounting, auditing, and"     
	891         "Research, development, and"    
	892         "Management and public relations"
	893         "Miscellaneous professional and"
	900         "Executive and legislative offices"
	901         "General government, n.e.c. (919)"
	910         "Justice, public order, and safety"
	921         "Public finance, taxation, and" 
	922         "Human resources programs"      
	930         "Environmental quality and housing"
	931         "Economic programs"             
	932         "National security and"         
	991         "Persons whose labor force status"
;
label values ajbind2  ajbind2l;
label define ajbind2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tjbocc2  tjbocc2l;
label define tjbocc2l
	-1          "Not in universe"               
	103         "Physical therapists (3033)"    
	104         "Speech therapists (3034)"      
	105         "Therapists, n.e.c. (3039)"     
	106         "Physicians' assistants (304)"  
	113         "Earth, environmental, and marine"
	114         "Biological science teachers (2213)"
	115         "Chemistry teachers (2214)"     
	116         "Physics teachers (2215)"       
	117         "Natural science teachers, n.e.c."
	118         "Psychology teachers (2217)"    
	119         "Economics teachers (2218)"     
	123         "History teachers (2222)"       
	124         "Political science teachers (2223)"
	125         "Sociology teachers (2224)"     
	126         "Social science teachers, n.e.c."
	127         "Engineering teachers (2226)"   
	128         "Math. science teachers (2227)" 
	129         "Computer science teachers (2228)"
	13          "Managers, marketing, advertising,"
	133         "Medical science teachers (2231)"
	134         "Health specialties teachers (2232)"
	135         "Business, commerce, and marketing"
	136         "Agriculture and forestry teachers"
	137         "Art, drama, and music teachers"
	138         "Physical education teachers (2236)"
	139         "Education teachers (2237)"     
	14          "Admin, education and rel. fields"
	143         "English teachers (2238)"       
	144         "Foreign language teachers (2242)"
	145         "Law teachers (2243)"           
	146         "Social work teachers (2244)"   
	147         "Theology teachers (2245)"      
	148         "Trade and industrial teachers" 
	149         "Home economics teachers (2247)"
	15          "Managers, medicine and health" 
	153         "Teachers, postsecondary, n.e.c."
	154         "Postsecondary teachers, subject"
	155         "Teachers, prekindergarten and" 
	156         "Teachers, elementary school (232)"
	157         "Teachers, secondary school (233)"
	158         "Teachers, special education (235)"
	159         "Teachers, n.e.c. (236, 239)"   
	163         "Counselors, Educational and"   
	164         "Librarians (251)"              
	165         "Archivists and curators (252)" 
	166         "Economists (1912)"             
	167         "Psychologists (1915)"          
	168         "Sociologists (1916)"           
	169         "Social scientists, n.e.c. (1913,"
	17          "Managers, food serving and"    
	173         "Urban planners (192)"          
	174         "Social workers (2032)"         
	175         "Recreation workers (2033)"     
	176         "Clergy (2042)"                 
	177         "Religious workers, n.e.c. (2049)"
	178         "Lawyers and Judges (211, 212)" 
	18          "Managers, properties and real" 
	183         "Authors (321)"                 
	184         "Technical writers (398)"       
	185         "Designers (322)"               
	186         "Musicians and composers (323)" 
	187         "Actors and directors (324)"    
	188         "Painters, sculptors,"          
	189         "Photographers (326)"           
	19          "Funeral directors (part 1359)" 
	193         "Dancers (327)"                 
	194         "Artists, performers, and rel." 
	195         "Editors and reporters (331)"   
	197         "Public relations specialists (332)"
	198         "Announcers (333)"              
	199         "Athletes (34)"                 
	203         "Clinical laboratory technologists"
	204         "Dental hygienists (363)"       
	205         "Health record technologists and"
	206         "Radiologic technicians (365)"  
	207         "Licensed practical nurses (366)"
	208         "Health technologists and"      
	21          "Managers, service organizations,"
	213         "Electrical and electronic"     
	214         "Industrial engineering"        
	215         "Mechanical engineering"        
	216         "Engineering technicians, n.e.c."
	217         "Drafting occupations (372)"    
	218         "Surveying and mapping technicians"
	22          "Managers and administrators,"  
	223         "Biological technicians (382)"  
	224         "Chemical technicians (3831)"   
	225         "Science technicians, n.e.c."   
	226         "Airplane pilots and navigators"
	227         "Air traffic controllers (392)" 
	228         "Broadcast equipment operators" 
	229         "Computer programmers (3971, 3972)"
	23          "Accountants and auditors (1412)"
	233         "Tool programmers, numerical"   
	234         "Legal assistants (396)"        
	235         "Technicians, n.e.c. (399)"     
	24          "Underwriters (1414)"           
	243         "Supervisors and Proprietors,"  
	25          "Other financial officers (1415,"
	253         "Insurance sales occupations (4122)"
	254         "Real estate sales occupations" 
	255         "Securities and financial services"
	256         "Advertising and rel. sales"    
	257         "Sales occupations, other business"
	258         "Sales engineers (421)"         
	259         "Sales representatives, mining,"
	26          "Management analysts (142)"     
	263         "Sales workers, motor vehicles and"
	264         "Sales workers, apparel (4346)" 
	265         "Sales workers, shoes (4351)"   
	266         "Sales workers, furniture and home"
	267         "Sales workers, radio, Tv, hi-fi,"
	268         "Sales workers, hardware and"   
	269         "Sales workers, parts (4367)"   
	27          "Personnel, training, and labor"
	274         "Sales workers, other commodities"
	275         "Sales counter clerks (4363)"   
	276         "Cashiers (4364)"               
	277         "Street and door-to-door sales" 
	278         "News vendors (4365)"           
	28          "Purchasing agents and buyers," 
	283         "Demonstrators, promoters and"  
	284         "Auctioneers (447)"             
	285         "Sales support occupations, n.e.c."
	29          "Buyers, wholesale and retail"  
	303         "Supervisors, general office"   
	304         "Supervisors, computer equipment"
	305         "Supervisors, financial records"
	306         "Chief communications operators"
	307         "Supervisors, distribution,"    
	308         "Computer operators (4612)"     
	309         "Peripheral equipment operators"
	313         "Secretaries (4622)"            
	314         "Stenographers (4623)"          
	315         "Typists (4624)"                
	316         "Interviewers (4642)"           
	317         "Hotel clerks (4643)"           
	318         "Transportation ticket and"     
	319         "Receptionists (4645)"          
	323         "Information clerks, n.e.c. (4649)"
	325         "Classified-ad clerks (4662)"   
	326         "Correspondence clerks (4663)"  
	327         "Order clerks (4664)"           
	328         "Personnel clerks, except payroll"
	329         "Library clerks (4694)"         
	33          "Purch. agents and buyers, n.e.c."
	335         "File clerks (4696)"            
	336         "Records clerks (4699)"         
	337         "Bookkeepers, accounting, and"  
	338         "Payroll and timekeeping clerks"
	339         "Billing clerks (4715)"         
	34          "Business and promotion agents" 
	343         "Cost and rate clerks (4716)"   
	344         "Billing, posting, and calculating"
	345         "Duplicating machine operators" 
	346         "Mail preparing and paper handling"
	347         "Office mach. operators, n.e.c."
	348         "Telephone operators (4732)"    
	35          "Construction inspectors (1472)"
	353         "Communications equipment"      
	354         "Postal clerks, except mail"    
	355         "Mail carriers, postal service" 
	356         "Mail clerks, except postal"    
	357         "Messengers (4745)"             
	359         "Dispatchers (4751)"            
	36          "Inspectors and compliance"     
	363         "Production coordinators (4752)"
	364         "Traffic, shipping, and receiving"
	365         "Stock and inventory clerks (4754)"
	366         "Meter readers (4755)"          
	368         "Weighers, measurers, checkers,"
	37          "Management rel. occupations,"  
	373         "Expediters (4758)"             
	374         "Material recording, scheduling,"
	375         "Insurance adjusters, examiners,"
	376         "Investigators and adjusters,"  
	377         "Eligibility clerks, social"    
	378         "Bill and account collectors (4786)"
	379         "General office clerks (463)"   
	383         "Bank tellers (4791)"           
	384         "Proofreaders (4792)"           
	385         "Data-entry keyers (4793)"      
	386         "Statistical clerks (4794)"     
	387         "Teachers' aides (4795)"        
	389         "Administrative support"        
	4           "Chief executives and general"  
	403         "Launderers and ironers (503)"  
	404         "Cooks, private household (504)"
	405         "Housekeepers and butlers (505)"
	406         "Child care workers, private hhld"
	407         "Private hhld cleaners and"     
	413         "Supervisors, firefighting and" 
	414         "Supervisors, police and"       
	415         "Supervisors, guards (5113)"    
	416         "Fire inspection and fire"      
	417         "Firefighting occupations (5123)"
	418         "Police and detectives, public" 
	423         "Sheriffs, bailiffs, and other law"
	424         "Correctional institution officers"
	425         "Crossing guards (5142)"        
	426         "Guards and police, except public"
	427         "Protective service occupations,"
	43          "Architects (161)"              
	433         "Supervisors, food preparation and"
	434         "Bartenders (5212)"             
	435         "Waiters and waitresses (5213)" 
	436         "Cooks (5214, 5215)"            
	438         "Food counter, fountain and rel."
	439         "Kitchen workers, food preparation"
	44          "Aerospace engineers(1622)"     
	443         "Waiters'/waitresses' assistants"
	444         "Miscellaneous food preparation"
	445         "Dental assistants (5232)"      
	446         "Health aides, except nursing"  
	447         "Nursing aides, orderlies, and" 
	448         "Supervisors, cleaning and"     
	449         "Maids and housemen (5242, 5249)"
	45          "Metallurgical and materials"   
	453         "Janitors and cleaners (5244)"  
	454         "Elevator operators (5245)"     
	455         "Pest control occupations (5246)"
	456         "Supervisors, personal service" 
	457         "Barbers (5252)"                
	458         "Hairdressers and cosmetologists"
	459         "Attendants, amusement and"     
	46          "Mining engineers (1624)"       
	461         "Guides (5255)"                 
	462         "Ushers (5256)"                 
	463         "Public transportation attendants"
	464         "Baggage porters and bellhops"  
	465         "Welfare service aides (5263)"  
	466         "Family child care providers (part"
	467         "Early childhood teacher's"     
	468         "Child care workers, n.e.c. (part"
	469         "Personal service occupations," 
	47          "Petroleum engineers (1625)"    
	473         "Farmers, except horticultural" 
	474         "Horticultural specialty farmers"
	475         "Managers, farms, except"       
	476         "Managers, horticultural specialty"
	477         "Supervisors, farm workers (5611)"
	479         "Farm workers (5612-5617)"      
	48          "Chemical engineers (1626)"     
	483         "Marine life cultivation workers"
	484         "Nursery workers (5619)"        
	485         "Supervisors, rel. agricultural"
	486         "Groundskeepers and gardeners," 
	487         "Animal caretakers, except farm"
	488         "Grader and sorter, agricultural"
	489         "Inspectors, agricultural products"
	49          "Nuclear engineers (1627)"      
	494         "Supervisors, forestry and logging"
	495         "Forestry workers, except logging"
	496         "Timber cutting and logging"    
	497         "Captains and other officers,"  
	498         "Fishers (583)"                 
	499         "Hunters and trappers (584)"    
	5           "Administrators and officials," 
	503         "Supervisors, mechanics and"    
	505         "Automobile mechanics (part 6111)"
	506         "Auto mechanic apprentices (part"
	507         "Bus, truck, and stationary engine"
	508         "Aircraft engine mechanics (6113)"
	509         "Small engine repairers (6114)" 
	514         "Automobile body and rel."      
	515         "Aircraft mechanics, except engine"
	516         "Heavy equipment mechanics (6117)"
	517         "Farm equipment mechanics (6118)"
	518         "Industrial machinery repairers"
	519         "Machinery maintenance occupations"
	523         "Electronic repairers,"         
	525         "Data processing equipment"     
	526         "Hhld appliance and power tool" 
	527         "Telephone line installers and" 
	529         "Telephone installers and"      
	53          "Civil engineers (1628)"        
	533         "Miscellaneous electrical and"  
	534         "Heating, air conditioning, and"
	535         "Camera, watch, and musical"    
	536         "Locksmiths and safe repairers" 
	538         "Office machine repairers (6174)"
	539         "Mechanical controls and valve" 
	54          "Agricultural engineers (1632)" 
	543         "Elevator installers and repairers"
	544         "Millwrights (6178)"            
	547         "Specified mechanics and"       
	549         "Not specified mechanics and"   
	55          "Engineers, electrical and"     
	553         "Supervisors, brickmasons,"     
	554         "Supervisors, carpenters and rel."
	555         "Supervisors, electricians and" 
	556         "Supervisors, painters,"        
	557         "Supervisors, plumbers,"        
	558         "Supervisors, construction, n.e.c."
	56          "Engineers, industrial (1634)"  
	563         "Brickmasons and stonemasons (part"
	564         "Brickmason and stonemason"     
	565         "Tile setters, hard and soft (part"
	566         "Carpet installers (part 6462)" 
	567         "Carpenters (part 6422)"        
	569         "Carpenter apprentices (part 6422)"
	57          "Engineers, mechanical (1635)"  
	573         "Drywall installers (6424)"     
	575         "Electricians (part 6432)"      
	576         "Electrician apprentices (part" 
	577         "Electrical power installers and"
	579         "Painters, construction and"    
	58          "Marine and naval architects (1637)"
	583         "Paperhangers (6443)"           
	584         "Plasterers (6444)"             
	585         "Plumbers, pipefitters, and"    
	587         "Plumber, pipefitter, and"      
	588         "Concrete and terrazzo finishers"
	589         "Glaziers (6464)"               
	59          "Engineers, n.e.c. (1639)"      
	593         "Insulation workers (6465)"     
	594         "Paving, surfacing, and tamping"
	595         "Roofers (6468)"                
	596         "Sheetmetal duct installers (6472)"
	597         "Structural metal workers (6473)"
	598         "Drillers, earth (6474)"        
	599         "Construction trades, n.e.c."   
	6           "Administrators, protective"    
	613         "Supervisors, extractive"       
	614         "Drillers, oil well (652)"      
	615         "Explosives workers (653)"      
	616         "Mining machine operators (654)"
	617         "Mining occupations, n.e.c. (656)"
	628         "Supervisors, production"       
	63          "Surveyors and mapping scientists"
	634         "Tool and die makers (part 6811)"
	635         "Tool and die mkr apprentices"  
	636         "Precision assemblers, metal (6812)"
	637         "Machinists (part 6813)"        
	639         "Machinist apprentices (part 6813)"
	64          "Computer systems analysts and" 
	643         "Boilermakers (6814)"           
	644         "Precision grinders, filers, and"
	645         "Patternmakers and model makers,"
	646         "Lay-out workers (6821)"        
	647         "Precious stones and metals"    
	649         "Engravers, metal (6823)"       
	65          "Operations and systems"        
	653         "Sheet metal workers (part 6824)"
	654         "Sheet metal wrker apprentices" 
	655         "Misc precision metal workers"  
	656         "Patternmkrs and model makers," 
	657         "Cabinet makers and bench"      
	658         "Furniture and wood finishers"  
	659         "Misc precision woodworkers (6839)"
	66          "Actuaries (1732)"              
	666         "Dressmakers (part 6852, part 7752)"
	667         "Tailors (part 6852)"           
	668         "Upholsterers (6853)"           
	669         "Shoe repairers (6854)"         
	67          "Statisticians (1733)"          
	674         "Misc precision apparel and fabric"
	675         "Hand molders and shapers, except"
	676         "Patternmakers, lay-out workers,"
	677         "Optical goods workers (6864, part"
	678         "Dental laboratory and medical" 
	679         "Bookbinders (6844)"            
	68          "Mathematical scientists, n.e.c."
	683         "Electrical/electronic equipment"
	684         "Msc precision workers, n.e.c." 
	686         "Butchers and meat cutters (6871)"
	687         "Bakers (6872)"                 
	688         "Food batchmakers (6873, 6879)" 
	689         "Inspectors, testers, and graders"
	69          "Physicists and astronomers (1842,"
	693         "Adjusters and calibrators (6882)"
	694         "Water and sewage treatment plant"
	695         "Power plant operators (part 693)"
	696         "Stationary engineers (part 693,"
	699         "Miscellaneous plant and system"
	7           "Financial managers (122)"      
	703         "Set-up operators, lathe and"   
	704         "Operators, lathe and turning"  
	705         "Milling and planing machine"   
	706         "Punching and stamping press"   
	707         "Rolling machine operators (7316,"
	708         "Drilling and boring machine"   
	709         "Grinding, abrading, buffing, and"
	713         "Forging machine operators (7319,"
	714         "Numerical control machine"     
	715         "Miscellaneous metal, plastic," 
	717         "Fabricating machine operators,"
	719         "Molding and casting machine"   
	723         "Metal plating machine operators"
	724         "Heat treating equipment operators"
	725         "Misc metal and plastic processing"
	726         "Wood lathe, routing, and planing"
	727         "Sawing machine operators (7433,"
	728         "Shaping and joining machine"   
	729         "Nailing and tacking machine"   
	73          "Chemists, except biochemists"  
	733         "Miscellaneous woodworking machine"
	734         "Printing press operators (7443,"
	735         "Photoengravers and lithographers"
	736         "Typesetters and compositors"   
	737         "Miscellaneous printing machine"
	738         "Winding and twisting machine"  
	739         "Knitting, looping, taping, and"
	74          "Atmospheric and space scientists"
	743         "Textile cutting machine operators"
	744         "Textile sewing machine operators"
	745         "Shoe machine operators (7656)" 
	747         "Pressing machine operators (7657)"
	748         "Laundering and dry cleaning"   
	749         "Miscellaneous textile machine" 
	75          "Geologists and geodesists (1847)"
	753         "Cementing and gluing machine"  
	754         "Packaging and filling machine" 
	755         "Extruding and forming machine" 
	756         "Mixing and blending machine"   
	757         "Separating, filtering, and"    
	758         "Compressing and compacting"    
	759         "Painting and paint spraying"   
	76          "Physical scientists, n.e.c. (1849)"
	763         "Roasting and baking machine"   
	764         "Washing, cleaning, and pickling"
	765         "Folding machine operators (7474,"
	766         "Furnace, kiln, and oven"       
	768         "Crushing and grinding machine" 
	769         "Slicing and cutting machine"   
	77          "Agricultural and food scientists"
	773         "Motion picture projectionists" 
	774         "Photographic process machine"  
	777         "Miscellaneous machine operators,"
	779         "Machine operators, not specified"
	78          "Biological and life scientists"
	783         "Welders and cutters (7332, 7532,"
	784         "Solderers and brazers (7333,"  
	785         "Assemblers (772, 774)"         
	786         "Hand cutting and trimming"     
	787         "Hand molding, casting, and"    
	789         "Hand painting, coating, and"   
	79          "Forestry and conservation"     
	793         "Hand engraving and printing"   
	795         "Miscellaneous hand working"    
	796         "Production inspectors, checkers,"
	797         "Production testers (783)"      
	798         "Production samplers and weighers"
	799         "Graders and sorters, except"   
	8           "Personnel and labor relations" 
	803         "Supervisors, motor vehicle"    
	804         "Truck drivers (8212-8214)"     
	806         "Driver-sales workers (8218)"   
	808         "Bus drivers (8215)"            
	809         "Taxicab drivers and chauffeurs"
	813         "Parking lot attendants (874)"  
	814         "Motor transportation occupations,"
	823         "Railroad conductors and"       
	824         "Locomotive operating occupations"
	825         "Railroad brake, signal, and"   
	826         "Rail vehicle operators, n.e.c."
	828         "Ship captains and mates, except"
	829         "Sailors and deckhands (8243)"  
	83          "Medical scientists (1855)"     
	833         "Marine engineers (8244)"       
	834         "Bridge, lock, and lighthouse"  
	84          "Physicians (261)"              
	843         "Supervisors, material moving"  
	844         "Operating engineers (8312)"    
	845         "Longshore equipment operators" 
	848         "Hoist and winch operators (8314)"
	849         "Crane and tower operators (8315)"
	85          "Dentists (262)"                
	853         "Excavating and loading machine"
	855         "Grader, dozer, and scraper"    
	856         "Industrial truck and tractor"  
	859         "Misc material moving equipment"
	86          "Veterinarians (27)"            
	864         "Supervisors, handlers, equipment"
	865         "Helpers, mechanics, and repairers"
	866         "Helpers, construction trades"  
	867         "Helpers, surveyor (8646)"      
	868         "Helpers, extractive occupations"
	869         "Construction laborers (871)"   
	87          "Optometrists (281)"            
	874         "Production helpers (861, 862)" 
	875         "Garbage collectors (8722)"     
	876         "Stevedores (8723)"             
	877         "Stock handlers and baggers (8724)"
	878         "Machine feeders and offbearers"
	88          "Podiatrists (283)"             
	883         "Freight, stock, and material"  
	885         "Garage and service station rel."
	887         "Vehicle washers and equipment" 
	888         "Hand packers and packagers (8761)"
	889         "Laborers, except construction" 
	89          "Health diagnosing practitioners,"
	9           "Purchasing managers (124)"     
	905         "Persons whose current labor force"
	95          "Registered nurses (29)"        
	96          "Pharmacists (301)"             
	97          "Dietitians (302)"              
	98          "Respiratory therapists (3031)" 
	99          "Occupational therapists (3032)"
;
label values ajbocc2  ajbocc2l;
label define ajbocc2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ebno1    ebno1l; 
label define ebno1l  
	-1          "Not in universe"               
;
label values ebiznow1 ebiznowm;
label define ebiznowm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abiznow1 abiznowm;
label define abiznowm
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tsbdate1 tsbdatem;
label define tsbdatem
	-1          "Not in universe"               
;
label values asbdate1 asbdatem;
label define asbdatem
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tebdate1 tebdatem;
label define tebdatem
	-1          "Not in universe"               
;
label values aebdate1 aebdatem;
label define aebdatem
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values erendb1  erendb1l;
label define erendb1l
	-1          "Not in universe"               
	1           "Retirement or old age"         
	10          "Season ended for a seasonal"   
	11          "Quit for some other reason"    
	2           "Childcare problems"            
	3           "Other family/personal problems"
	4           "Own illness"                   
	5           "Own injury"                    
	6           "School/training"               
	7           "Went bankrupt/business failed" 
	8           "Sold business or transferred"  
	9           "To start other business/take job"
;
label values arendb1  arendb1l;
label define arendb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ehrsbs1  ehrsbs1l;
label define ehrsbs1l
	-1          "Not in universe"               
;
label values ahrsbs1  ahrsbs1l;
label define ahrsbs1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values egrosb1  egrosb1l;
label define egrosb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agrosb1  agrosb1l;
label define agrosb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values egrssb1  egrssb1l;
label define egrssb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agrssb1  agrssb1l;
label define agrssb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tempb1   tempb1l;
label define tempb1l 
	-1          "Not in universe"               
	1           "Under 25 employees"            
	2           "25:99 employees"               
	3           "100+ employees"                
;
label values aempb1   aempb1l;
label define aempb1l 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eincpb1  eincpb1l;
label define eincpb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aincpb1  aincpb1l;
label define aincpb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values epropb1  epropb1l;
label define epropb1l
	-1          "Not in universe"               
	1           "alone"                         
	2           "partnership"                   
;
label values apropb1  apropb1l;
label define apropb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ehprtb1  ehprtb1l;
label define ehprtb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahprtb1  ahprtb1l;
label define ahprtb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eslryb1  eslryb1l;
label define eslryb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aslryb1  aslryb1l;
label define aslryb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eoincb1  eoincb1l;
label define eoincb1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aoincb1  aoincb1l;
label define aoincb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tprftb1  tprftb1l;
label define tprftb1l
	0           "None or not in universe"       
;
label values aprftb1  aprftb1l;
label define aprftb1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tbmsum1  tbmsum1l;
label define tbmsum1l
	0           "None or not in universe"       
;
label values abmsum1  abmsum1l;
label define abmsum1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values epartb11 epartb1m;
label define epartb1m
	-1          "Not in universe"               
	9999        "Unable to identify person # of"
;
label values epartb21 epartb2m;
label define epartb2m
	-1          "Not in universe"               
	9999        "Unable to identify person # of"
;
label values epartb31 epartb3m;
label define epartb3m
	-1          "Not in universe"               
	9999        "Unable to identify person # of"
;
label values tbsind1  tbsind1l;
label define tbsind1l
	-1          "Not in universe"               
	1           "Agriculture, forestry and"     
	10          "Finance, insurance and real estate"
	11          "Business and repair services"  
	12          "Personal services"             
	13          "Entertainment and recreation"  
	14          "Professional and related services"
	15          "Public administration"         
	2           "Mining"                        
	3           "Construction"                  
	4           "Manufacturing: nondurable goods"
	5           "Manufacturing: durable goods"  
	6           "Transportation, communications"
	7           "Wholesale Trade: durable goods"
	8           "Wholesale trade: nondurable goods"
	9           "Retail trade"                  
;
label values absind1  absind1l;
label define absind1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tbsocc1  tbsocc1l;
label define tbsocc1l
	-1          "Not in universe"               
	103         "Physical therapists (3033)"    
	104         "Speech therapists (3034)"      
	105         "Therapists, n.e.c. (3039)"     
	106         "Physicians' assistants (304)"  
	113         "Earth, environmental, and marine"
	114         "Biological science teachers (2213)"
	115         "Chemistry teachers (2214)"     
	116         "Physics teachers (2215)"       
	117         "Natural science teachers, n.e.c."
	118         "Psychology teachers (2217)"    
	119         "Economics teachers (2218)"     
	123         "History teachers (2222)"       
	124         "Political science teachers (2223)"
	125         "Sociology teachers (2224)"     
	126         "Social science teachers, n.e.c."
	127         "Engineering teachers (2226)"   
	128         "Math. science teachers (2227)" 
	129         "Computer science teachers (2228)"
	13          "Managers, marketing, advertising,"
	133         "Medical science teachers (2231)"
	134         "Health specialties teachers (2232)"
	135         "Business, commerce, and marketing"
	136         "Agriculture and forestry teachers"
	137         "Art, drama, and music teachers"
	138         "Physical education teachers (2236)"
	139         "Education teachers (2237)"     
	14          "Admin, education and rel. fields"
	143         "English teachers (2238)"       
	144         "Foreign language teachers (2242)"
	145         "Law teachers (2243)"           
	146         "Social work teachers (2244)"   
	147         "Theology teachers (2245)"      
	148         "Trade and industrial teachers" 
	149         "Home economics teachers (2247)"
	15          "Managers, medicine and health" 
	153         "Teachers, postsecondary, n.e.c."
	154         "Postsecondary teachers, subject"
	155         "Teachers, prekindergarten and" 
	156         "Teachers, elementary school (232)"
	157         "Teachers, secondary school (233)"
	158         "Teachers, special education (235)"
	159         "Teachers, n.e.c. (236, 239)"   
	163         "Counselors, Educational and"   
	164         "Librarians (251)"              
	165         "Archivists and curators (252)" 
	166         "Economists (1912)"             
	167         "Psychologists (1915)"          
	168         "Sociologists (1916)"           
	169         "Social scientists, n.e.c. (1913,"
	17          "Managers, food serving and"    
	173         "Urban planners (192)"          
	174         "Social workers (2032)"         
	175         "Recreation workers (2033)"     
	176         "Clergy (2042)"                 
	177         "Religious workers, n.e.c. (2049)"
	178         "Lawyers and Judges (211, 212)" 
	18          "Managers, properties and real" 
	183         "Authors (321)"                 
	184         "Technical writers (398)"       
	185         "Designers (322)"               
	186         "Musicians and composers (323)" 
	187         "Actors and directors (324)"    
	188         "Painters, sculptors,"          
	189         "Photographers (326)"           
	19          "Funeral directors (part 1359)" 
	193         "Dancers (327)"                 
	194         "Artists, performers, and rel." 
	195         "Editors and reporters (331)"   
	197         "Public relations specialists (332)"
	198         "Announcers (333)"              
	199         "Athletes (34)"                 
	203         "Clinical laboratory technologists"
	204         "Dental hygienists (363)"       
	205         "Health record technologists and"
	206         "Radiologic technicians (365)"  
	207         "Licensed practical nurses (366)"
	208         "Health technologists and"      
	21          "Managers, service organizations,"
	213         "Electrical and electronic"     
	214         "Industrial engineering"        
	215         "Mechanical engineering"        
	216         "Engineering technicians, n.e.c."
	217         "Drafting occupations (372)"    
	218         "Surveying and mapping technicians"
	22          "Managers and administrators,"  
	223         "Biological technicians (382)"  
	224         "Chemical technicians (3831)"   
	225         "Science technicians, n.e.c."   
	226         "Airplane pilots and navigators"
	227         "Air traffic controllers (392)" 
	228         "Broadcast equipment operators" 
	229         "Computer programmers (3971, 3972)"
	23          "Accountants and auditors (1412)"
	233         "Tool programmers, numerical"   
	234         "Legal assistants (396)"        
	235         "Technicians, n.e.c. (399)"     
	24          "Underwriters (1414)"           
	243         "Supervisors and Proprietors,"  
	25          "Other financial officers (1415,"
	253         "Insurance sales occupations (4122)"
	254         "Real estate sales occupations" 
	255         "Securities and financial services"
	256         "Advertising and rel. sales"    
	257         "Sales occupations, other business"
	258         "Sales engineers (421)"         
	259         "Sales representatives, mining,"
	26          "Management analysts (142)"     
	263         "Sales workers, motor vehicles and"
	264         "Sales workers, apparel (4346)" 
	265         "Sales workers, shoes (4351)"   
	266         "Sales workers, furniture and home"
	267         "Sales workers, radio, Tv, hi-fi,"
	268         "Sales workers, hardware and"   
	269         "Sales workers, parts (4367)"   
	27          "Personnel, training, and labor"
	274         "Sales workers, other commodities"
	275         "Sales counter clerks (4363)"   
	276         "Cashiers (4364)"               
	277         "Street and door-to-door sales" 
	278         "News vendors (4365)"           
	28          "Purchasing agents and buyers," 
	283         "Demonstrators, promoters and"  
	284         "Auctioneers (447)"             
	285         "Sales support occupations, n.e.c."
	29          "Buyers, wholesale and retail"  
	303         "Supervisors, general office"   
	304         "Supervisors, computer equipment"
	305         "Supervisors, financial records"
	306         "Chief communications operators"
	307         "Supervisors, distribution,"    
	308         "Computer operators (4612)"     
	309         "Peripheral equipment operators"
	313         "Secretaries (4622)"            
	314         "Stenographers (4623)"          
	315         "Typists (4624)"                
	316         "Interviewers (4642)"           
	317         "Hotel clerks (4643)"           
	318         "Transportation ticket and"     
	319         "Receptionists (4645)"          
	323         "Information clerks, n.e.c. (4649)"
	325         "Classified-ad clerks (4662)"   
	326         "Correspondence clerks (4663)"  
	327         "Order clerks (4664)"           
	328         "Personnel clerks, except payroll"
	329         "Library clerks (4694)"         
	33          "Purch. agents and buyers, n.e.c."
	335         "File clerks (4696)"            
	336         "Records clerks (4699)"         
	337         "Bookkeepers, accounting, and"  
	338         "Payroll and timekeeping clerks"
	339         "Billing clerks (4715)"         
	34          "Business and promotion agents" 
	343         "Cost and rate clerks (4716)"   
	344         "Billing, posting, and calculating"
	345         "Duplicating machine operators" 
	346         "Mail preparing and paper handling"
	347         "Office mach. operators, n.e.c."
	348         "Telephone operators (4732)"    
	35          "Construction inspectors (1472)"
	353         "Communications equipment"      
	354         "Postal clerks, except mail"    
	355         "Mail carriers, postal service" 
	356         "Mail clerks, except postal"    
	357         "Messengers (4745)"             
	359         "Dispatchers (4751)"            
	36          "Inspectors and compliance"     
	363         "Production coordinators (4752)"
	364         "Traffic, shipping, and receiving"
	365         "Stock and inventory clerks (4754)"
	366         "Meter readers (4755)"          
	368         "Weighers, measurers, checkers,"
	37          "Management rel. occupations,"  
	373         "Expediters (4758)"             
	374         "Material recording, scheduling,"
	375         "Insurance adjusters, examiners,"
	376         "Investigators and adjusters,"  
	377         "Eligibility clerks, social"    
	378         "Bill and account collectors (4786)"
	379         "General office clerks (463)"   
	383         "Bank tellers (4791)"           
	384         "Proofreaders (4792)"           
	385         "Data-entry keyers (4793)"      
	386         "Statistical clerks (4794)"     
	387         "Teachers' aides (4795)"        
	389         "Administrative support"        
	4           "Chief executives and general"  
	403         "Launderers and ironers (503)"  
	404         "Cooks, private household (504)"
	405         "Housekeepers and butlers (505)"
	406         "Child care workers, private hhld"
	407         "Private hhld cleaners and"     
	413         "Supervisors, firefighting and" 
	414         "Supervisors, police and"       
	415         "Supervisors, guards (5113)"    
	416         "Fire inspection and fire"      
	417         "Firefighting occupations (5123)"
	418         "Police and detectives, public" 
	423         "Sheriffs, bailiffs, and other law"
	424         "Correctional institution officers"
	425         "Crossing guards (5142)"        
	426         "Guards and police, except public"
	427         "Protective service occupations,"
	43          "Architects (161)"              
	433         "Supervisors, food preparation and"
	434         "Bartenders (5212)"             
	435         "Waiters and waitresses (5213)" 
	436         "Cooks (5214, 5215)"            
	438         "Food counter, fountain and rel."
	439         "Kitchen workers, food preparation"
	44          "Aerospace engineers(1622)"     
	443         "Waiters'/waitresses' assistants"
	444         "Miscellaneous food preparation"
	445         "Dental assistants (5232)"      
	446         "Health aides, except nursing"  
	447         "Nursing aides, orderlies, and" 
	448         "Supervisors, cleaning and"     
	449         "Maids and housemen (5242, 5249)"
	45          "Metallurgical and materials"   
	453         "Janitors and cleaners (5244)"  
	454         "Elevator operators (5245)"     
	455         "Pest control occupations (5246)"
	456         "Supervisors, personal service" 
	457         "Barbers (5252)"                
	458         "Hairdressers and cosmetologists"
	459         "Attendants, amusement and"     
	46          "Mining engineers (1624)"       
	461         "Guides (5255)"                 
	462         "Ushers (5256)"                 
	463         "Public transportation attendants"
	464         "Baggage porters and bellhops"  
	465         "Welfare service aides (5263)"  
	466         "Family child care providers (part"
	467         "Early childhood teacher's"     
	468         "Child care workers, n.e.c. (part"
	469         "Personal service occupations," 
	47          "Petroleum engineers (1625)"    
	473         "Farmers, except horticultural" 
	474         "Horticultural specialty farmers"
	475         "Managers, farms, except"       
	476         "Managers, horticultural specialty"
	477         "Supervisors, farm workers (5611)"
	479         "Farm workers (5612-5617)"      
	48          "Chemical engineers (1626)"     
	483         "Marine life cultivation workers"
	484         "Nursery workers (5619)"        
	485         "Supervisors, rel. agricultural"
	486         "Groundskeepers and gardeners," 
	487         "Animal caretakers, except farm"
	488         "Grader and sorter, agricultural"
	489         "Inspectors, agricultural products"
	49          "Nuclear engineers (1627)"      
	494         "Supervisors, forestry and logging"
	495         "Forestry workers, except logging"
	496         "Timber cutting and logging"    
	497         "Captains and other officers,"  
	498         "Fishers (583)"                 
	499         "Hunters and trappers (584)"    
	5           "Administrators and officials," 
	503         "Supervisors, mechanics and"    
	505         "Automobile mechanics (part 6111)"
	506         "Auto mechanic apprentices (part"
	507         "Bus, truck, and stationary engine"
	508         "Aircraft engine mechanics (6113)"
	509         "Small engine repairers (6114)" 
	514         "Automobile body and rel."      
	515         "Aircraft mechanics, except engine"
	516         "Heavy equipment mechanics (6117)"
	517         "Farm equipment mechanics (6118)"
	518         "Industrial machinery repairers"
	519         "Machinery maintenance occupations"
	523         "Electronic repairers,"         
	525         "Data processing equipment"     
	526         "Hhld appliance and power tool" 
	527         "Telephone line installers and" 
	529         "Telephone installers and"      
	53          "Civil engineers (1628)"        
	533         "Miscellaneous electrical and"  
	534         "Heating, air conditioning, and"
	535         "Camera, watch, and musical"    
	536         "Locksmiths and safe repairers" 
	538         "Office machine repairers (6174)"
	539         "Mechanical controls and valve" 
	54          "Agricultural engineers (1632)" 
	543         "Elevator installers and repairers"
	544         "Millwrights (6178)"            
	547         "Specified mechanics and"       
	549         "Not specified mechanics and"   
	55          "Engineers, electrical and"     
	553         "Supervisors, brickmasons,"     
	554         "Supervisors, carpenters and rel."
	555         "Supervisors, electricians and" 
	556         "Supervisors, painters,"        
	557         "Supervisors, plumbers,"        
	558         "Supervisors, construction, n.e.c."
	56          "Engineers, industrial (1634)"  
	563         "Brickmasons and stonemasons (part"
	564         "Brickmason and stonemason"     
	565         "Tile setters, hard and soft (part"
	566         "Carpet installers (part 6462)" 
	567         "Carpenters (part 6422)"        
	569         "Carpenter apprentices (part 6422)"
	57          "Engineers, mechanical (1635)"  
	573         "Drywall installers (6424)"     
	575         "Electricians (part 6432)"      
	576         "Electrician apprentices (part" 
	577         "Electrical power installers and"
	579         "Painters, construction and"    
	58          "Marine and naval architects (1637)"
	583         "Paperhangers (6443)"           
	584         "Plasterers (6444)"             
	585         "Plumbers, pipefitters, and"    
	587         "Plumber, pipefitter, and"      
	588         "Concrete and terrazzo finishers"
	589         "Glaziers (6464)"               
	59          "Engineers, n.e.c. (1639)"      
	593         "Insulation workers (6465)"     
	594         "Paving, surfacing, and tamping"
	595         "Roofers (6468)"                
	596         "Sheetmetal duct installers (6472)"
	597         "Structural metal workers (6473)"
	598         "Drillers, earth (6474)"        
	599         "Construction trades, n.e.c."   
	6           "Administrators, protective"    
	613         "Supervisors, extractive"       
	614         "Drillers, oil well (652)"      
	615         "Explosives workers (653)"      
	616         "Mining machine operators (654)"
	617         "Mining occupations, n.e.c. (656)"
	628         "Supervisors, production"       
	63          "Surveyors and mapping scientists"
	634         "Tool and die makers (part 6811)"
	635         "Tool and die mkr apprentices"  
	636         "Precision assemblers, metal (6812)"
	637         "Machinists (part 6813)"        
	639         "Machinist apprentices (part 6813)"
	64          "Computer systems analysts and" 
	643         "Boilermakers (6814)"           
	644         "Precision grinders, filers, and"
	645         "Patternmakers and model makers,"
	646         "Lay-out workers (6821)"        
	647         "Precious stones and metals"    
	649         "Engravers, metal (6823)"       
	65          "Operations and systems"        
	653         "Sheet metal workers (part 6824)"
	654         "Sheet metal wrker apprentices" 
	655         "Misc precision metal workers"  
	656         "Patternmkrs and model makers," 
	657         "Cabinet makers and bench"      
	658         "Furniture and wood finishers"  
	659         "Misc precision woodworkers (6839)"
	66          "Actuaries (1732)"              
	666         "Dressmakers (part 6852, part 7752)"
	667         "Tailors (part 6852)"           
	668         "Upholsterers (6853)"           
	669         "Shoe repairers (6854)"         
	67          "Statisticians (1733)"          
	674         "Misc precision apparel and fabric"
	675         "Hand molders and shapers, except"
	676         "Patternmakers, lay-out workers,"
	677         "Optical goods workers (6864, part"
	678         "Dental laboratory and medical" 
	679         "Bookbinders (6844)"            
	68          "Mathematical scientists, n.e.c."
	683         "Electrical/electronic equipment"
	684         "Msc precision workers, n.e.c." 
	686         "Butchers and meat cutters (6871)"
	687         "Bakers (6872)"                 
	688         "Food batchmakers (6873, 6879)" 
	689         "Inspectors, testers, and graders"
	69          "Physicists and astronomers (1842,"
	693         "Adjusters and calibrators (6882)"
	694         "Water and sewage treatment plant"
	695         "Power plant operators (part 693)"
	696         "Stationary engineers (part 693,"
	699         "Miscellaneous plant and system"
	7           "Financial managers (122)"      
	703         "Set-up operators, lathe and"   
	704         "Operators, lathe and turning"  
	705         "Milling and planing machine"   
	706         "Punching and stamping press"   
	707         "Rolling machine operators (7316,"
	708         "Drilling and boring machine"   
	709         "Grinding, abrading, buffing, and"
	713         "Forging machine operators (7319,"
	714         "Numerical control machine"     
	715         "Miscellaneous metal, plastic," 
	717         "Fabricating machine operators,"
	719         "Molding and casting machine"   
	723         "Metal plating machine operators"
	724         "Heat treating equipment operators"
	725         "Misc metal and plastic processing"
	726         "Wood lathe, routing, and planing"
	727         "Sawing machine operators (7433,"
	728         "Shaping and joining machine"   
	729         "Nailing and tacking machine"   
	73          "Chemists, except biochemists"  
	733         "Miscellaneous woodworking machine"
	734         "Printing press operators (7443,"
	735         "Photoengravers and lithographers"
	736         "Typesetters and compositors"   
	737         "Miscellaneous printing machine"
	738         "Winding and twisting machine"  
	739         "Knitting, looping, taping, and"
	74          "Atmospheric and space scientists"
	743         "Textile cutting machine operators"
	744         "Textile sewing machine operators"
	745         "Shoe machine operators (7656)" 
	747         "Pressing machine operators (7657)"
	748         "Laundering and dry cleaning"   
	749         "Miscellaneous textile machine" 
	75          "Geologists and geodesists (1847)"
	753         "Cementing and gluing machine"  
	754         "Packaging and filling machine" 
	755         "Extruding and forming machine" 
	756         "Mixing and blending machine"   
	757         "Separating, filtering, and"    
	758         "Compressing and compacting"    
	759         "Painting and paint spraying"   
	76          "Physical scientists, n.e.c. (1849)"
	763         "Roasting and baking machine"   
	764         "Washing, cleaning, and pickling"
	765         "Folding machine operators (7474,"
	766         "Furnace, kiln, and oven"       
	768         "Crushing and grinding machine" 
	769         "Slicing and cutting machine"   
	77          "Agricultural and food scientists"
	773         "Motion picture projectionists" 
	774         "Photographic process machine"  
	777         "Miscellaneous machine operators,"
	779         "Machine operators, not specified"
	78          "Biological and life scientists"
	783         "Welders and cutters (7332, 7532,"
	784         "Solderers and brazers (7333,"  
	785         "Assemblers (772, 774)"         
	786         "Hand cutting and trimming"     
	787         "Hand molding, casting, and"    
	789         "Hand painting, coating, and"   
	79          "Forestry and conservation"     
	793         "Hand engraving and printing"   
	795         "Miscellaneous hand working"    
	796         "Production inspectors, checkers,"
	797         "Production testers (783)"      
	798         "Production samplers and weighers"
	799         "Graders and sorters, except"   
	8           "Personnel and labor relations" 
	803         "Supervisors, motor vehicle"    
	804         "Truck drivers (8212-8214)"     
	806         "Driver-sales workers (8218)"   
	808         "Bus drivers (8215)"            
	809         "Taxicab drivers and chauffeurs"
	813         "Parking lot attendants (874)"  
	814         "Motor transportation occupations,"
	823         "Railroad conductors and"       
	824         "Locomotive operating occupations"
	825         "Railroad brake, signal, and"   
	826         "Rail vehicle operators, n.e.c."
	828         "Ship captains and mates, except"
	829         "Sailors and deckhands (8243)"  
	83          "Medical scientists (1855)"     
	833         "Marine engineers (8244)"       
	834         "Bridge, lock, and lighthouse"  
	84          "Physicians (261)"              
	843         "Supervisors, material moving"  
	844         "Operating engineers (8312)"    
	845         "Longshore equipment operators" 
	848         "Hoist and winch operators (8314)"
	849         "Crane and tower operators (8315)"
	85          "Dentists (262)"                
	853         "Excavating and loading machine"
	855         "Grader, dozer, and scraper"    
	856         "Industrial truck and tractor"  
	859         "Misc material moving equipment"
	86          "Veterinarians (27)"            
	864         "Supervisors, handlers, equipment"
	865         "Helpers, mechanics, and repairers"
	866         "Helpers, construction trades"  
	867         "Helpers, surveyor (8646)"      
	868         "Helpers, extractive occupations"
	869         "Construction laborers (871)"   
	87          "Optometrists (281)"            
	874         "Production helpers (861, 862)" 
	875         "Garbage collectors (8722)"     
	876         "Stevedores (8723)"             
	877         "Stock handlers and baggers (8724)"
	878         "Machine feeders and offbearers"
	88          "Podiatrists (283)"             
	883         "Freight, stock, and material"  
	885         "Garage and service station rel."
	887         "Vehicle washers and equipment" 
	888         "Hand packers and packagers (8761)"
	889         "Laborers, except construction" 
	89          "Health diagnosing practitioners,"
	9           "Purchasing managers (124)"     
	905         "Persons whose current labor force"
	95          "Registered nurses (29)"        
	96          "Pharmacists (301)"             
	97          "Dietitians (302)"              
	98          "Respiratory therapists (3031)" 
	99          "Occupational therapists (3032)"
;
label values absocc1  absocc1l;
label define absocc1l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ebno2    ebno2l; 
label define ebno2l  
	-1          "Not in universe"               
;
label values ebiznow2 ebiznowk;
label define ebiznowk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abiznow2 abiznowk;
label define abiznowk
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tsbdate2 tsbdatek;
label define tsbdatek
	-1          "Not in universe"               
;
label values asbdate2 asbdatek;
label define asbdatek
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tebdate2 tebdatek;
label define tebdatek
	-1          "Not in universe"               
;
label values aebdate2 aebdatek;
label define aebdatek
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values erendb2  erendb2l;
label define erendb2l
	-1          "Not in universe"               
	1           "Retirement or old age"         
	10          "Season ended for a seasonal"   
	11          "Quit for some other reason"    
	2           "Childcare problems"            
	3           "Other family/personal problems"
	4           "Own illness"                   
	5           "Own injury"                    
	6           "School/training"               
	7           "Went bankrupt/business failed" 
	8           "Sold business or transferred"  
	9           "To start other business/take job"
;
label values arendb2  arendb2l;
label define arendb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ehrsbs2  ehrsbs2l;
label define ehrsbs2l
	-1          "Not in universe"               
;
label values ahrsbs2  ahrsbs2l;
label define ahrsbs2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values egrosb2  egrosb2l;
label define egrosb2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agrosb2  agrosb2l;
label define agrosb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values egrssb2  egrssb2l;
label define egrssb2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agrssb2  agrssb2l;
label define agrssb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tempb2   tempb2l;
label define tempb2l 
	-1          "Not in universe"               
	1           "Under 25 employees"            
	2           "25:99 employees"               
	3           "100+ employees"                
;
label values aempb2   aempb2l;
label define aempb2l 
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eincpb2  eincpb2l;
label define eincpb2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aincpb2  aincpb2l;
label define aincpb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values epropb2  epropb2l;
label define epropb2l
	-1          "Not in universe"               
	1           "alone"                         
	2           "partnership"                   
;
label values apropb2  apropb2l;
label define apropb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values ehprtb2  ehprtb2l;
label define ehprtb2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahprtb2  ahprtb2l;
label define ahprtb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eslryb2  eslryb2l;
label define eslryb2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aslryb2  aslryb2l;
label define aslryb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values eoincb2  eoincb2l;
label define eoincb2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aoincb2  aoincb2l;
label define aoincb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tprftb2  tprftb2l;
label define tprftb2l
	0           "None or not in universe"       
;
label values aprftb2  aprftb2l;
label define aprftb2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tbmsum2  tbmsum2l;
label define tbmsum2l
	0           "None or not in universe"       
;
label values abmsum2  abmsum2l;
label define abmsum2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values epartb12 epartb1k;
label define epartb1k
	-1          "Not in universe"               
	9999        "Unable to identify person # of"
;
label values epartb22 epartb2k;
label define epartb2k
	-1          "Not in universe"               
	9999        "Unable to identify person # of"
;
label values epartb32 epartb3k;
label define epartb3k
	-1          "Not in universe"               
	9999        "Unable to identify person # of"
;
label values tbsind2  tbsind2l;
label define tbsind2l
	-1          "Not in universe"               
	1           "Agriculture, forestry and"     
	10          "Finance, insurance and real estate"
	11          "Business and repair services"  
	12          "Personal services"             
	13          "Entertainment and recreation"  
	14          "Professional and related services"
	15          "Public administration"         
	2           "Mining"                        
	3           "Construction"                  
	4           "Manufacturing: nondurable goods"
	5           "Manufacturing: durable goods"  
	6           "Transportation, communications"
	7           "Wholesale Trade: durable goods"
	8           "Wholesale trade: nondurable goods"
	9           "Retail trade"                  
;
label values absind2  absind2l;
label define absind2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values tbsocc2  tbsocc2l;
label define tbsocc2l
	-1          "Not in universe"               
	103         "Physical therapists (3033)"    
	104         "Speech therapists (3034)"      
	105         "Therapists, n.e.c. (3039)"     
	106         "Physicians' assistants (304)"  
	113         "Earth, environmental, and marine"
	114         "Biological science teachers (2213)"
	115         "Chemistry teachers (2214)"     
	116         "Physics teachers (2215)"       
	117         "Natural science teachers, n.e.c."
	118         "Psychology teachers (2217)"    
	119         "Economics teachers (2218)"     
	123         "History teachers (2222)"       
	124         "Political science teachers (2223)"
	125         "Sociology teachers (2224)"     
	126         "Social science teachers, n.e.c."
	127         "Engineering teachers (2226)"   
	128         "Math. science teachers (2227)" 
	129         "Computer science teachers (2228)"
	13          "Managers, marketing, advertising,"
	133         "Medical science teachers (2231)"
	134         "Health specialties teachers (2232)"
	135         "Business, commerce, and marketing"
	136         "Agriculture and forestry teachers"
	137         "Art, drama, and music teachers"
	138         "Physical education teachers (2236)"
	139         "Education teachers (2237)"     
	14          "Admin, education and rel. fields"
	143         "English teachers (2238)"       
	144         "Foreign language teachers (2242)"
	145         "Law teachers (2243)"           
	146         "Social work teachers (2244)"   
	147         "Theology teachers (2245)"      
	148         "Trade and industrial teachers" 
	149         "Home economics teachers (2247)"
	15          "Managers, medicine and health" 
	153         "Teachers, postsecondary, n.e.c."
	154         "Postsecondary teachers, subject"
	155         "Teachers, prekindergarten and" 
	156         "Teachers, elementary school (232)"
	157         "Teachers, secondary school (233)"
	158         "Teachers, special education (235)"
	159         "Teachers, n.e.c. (236, 239)"   
	163         "Counselors, Educational and"   
	164         "Librarians (251)"              
	165         "Archivists and curators (252)" 
	166         "Economists (1912)"             
	167         "Psychologists (1915)"          
	168         "Sociologists (1916)"           
	169         "Social scientists, n.e.c. (1913,"
	17          "Managers, food serving and"    
	173         "Urban planners (192)"          
	174         "Social workers (2032)"         
	175         "Recreation workers (2033)"     
	176         "Clergy (2042)"                 
	177         "Religious workers, n.e.c. (2049)"
	178         "Lawyers and Judges (211, 212)" 
	18          "Managers, properties and real" 
	183         "Authors (321)"                 
	184         "Technical writers (398)"       
	185         "Designers (322)"               
	186         "Musicians and composers (323)" 
	187         "Actors and directors (324)"    
	188         "Painters, sculptors,"          
	189         "Photographers (326)"           
	19          "Funeral directors (part 1359)" 
	193         "Dancers (327)"                 
	194         "Artists, performers, and rel." 
	195         "Editors and reporters (331)"   
	197         "Public relations specialists (332)"
	198         "Announcers (333)"              
	199         "Athletes (34)"                 
	203         "Clinical laboratory technologists"
	204         "Dental hygienists (363)"       
	205         "Health record technologists and"
	206         "Radiologic technicians (365)"  
	207         "Licensed practical nurses (366)"
	208         "Health technologists and"      
	21          "Managers, service organizations,"
	213         "Electrical and electronic"     
	214         "Industrial engineering"        
	215         "Mechanical engineering"        
	216         "Engineering technicians, n.e.c."
	217         "Drafting occupations (372)"    
	218         "Surveying and mapping technicians"
	22          "Managers and administrators,"  
	223         "Biological technicians (382)"  
	224         "Chemical technicians (3831)"   
	225         "Science technicians, n.e.c."   
	226         "Airplane pilots and navigators"
	227         "Air traffic controllers (392)" 
	228         "Broadcast equipment operators" 
	229         "Computer programmers (3971, 3972)"
	23          "Accountants and auditors (1412)"
	233         "Tool programmers, numerical"   
	234         "Legal assistants (396)"        
	235         "Technicians, n.e.c. (399)"     
	24          "Underwriters (1414)"           
	243         "Supervisors and Proprietors,"  
	25          "Other financial officers (1415,"
	253         "Insurance sales occupations (4122)"
	254         "Real estate sales occupations" 
	255         "Securities and financial services"
	256         "Advertising and rel. sales"    
	257         "Sales occupations, other business"
	258         "Sales engineers (421)"         
	259         "Sales representatives, mining,"
	26          "Management analysts (142)"     
	263         "Sales workers, motor vehicles and"
	264         "Sales workers, apparel (4346)" 
	265         "Sales workers, shoes (4351)"   
	266         "Sales workers, furniture and home"
	267         "Sales workers, radio, Tv, hi-fi,"
	268         "Sales workers, hardware and"   
	269         "Sales workers, parts (4367)"   
	27          "Personnel, training, and labor"
	274         "Sales workers, other commodities"
	275         "Sales counter clerks (4363)"   
	276         "Cashiers (4364)"               
	277         "Street and door-to-door sales" 
	278         "News vendors (4365)"           
	28          "Purchasing agents and buyers," 
	283         "Demonstrators, promoters and"  
	284         "Auctioneers (447)"             
	285         "Sales support occupations, n.e.c."
	29          "Buyers, wholesale and retail"  
	303         "Supervisors, general office"   
	304         "Supervisors, computer equipment"
	305         "Supervisors, financial records"
	306         "Chief communications operators"
	307         "Supervisors, distribution,"    
	308         "Computer operators (4612)"     
	309         "Peripheral equipment operators"
	313         "Secretaries (4622)"            
	314         "Stenographers (4623)"          
	315         "Typists (4624)"                
	316         "Interviewers (4642)"           
	317         "Hotel clerks (4643)"           
	318         "Transportation ticket and"     
	319         "Receptionists (4645)"          
	323         "Information clerks, n.e.c. (4649)"
	325         "Classified-ad clerks (4662)"   
	326         "Correspondence clerks (4663)"  
	327         "Order clerks (4664)"           
	328         "Personnel clerks, except payroll"
	329         "Library clerks (4694)"         
	33          "Purch. agents and buyers, n.e.c."
	335         "File clerks (4696)"            
	336         "Records clerks (4699)"         
	337         "Bookkeepers, accounting, and"  
	338         "Payroll and timekeeping clerks"
	339         "Billing clerks (4715)"         
	34          "Business and promotion agents" 
	343         "Cost and rate clerks (4716)"   
	344         "Billing, posting, and calculating"
	345         "Duplicating machine operators" 
	346         "Mail preparing and paper handling"
	347         "Office mach. operators, n.e.c."
	348         "Telephone operators (4732)"    
	35          "Construction inspectors (1472)"
	353         "Communications equipment"      
	354         "Postal clerks, except mail"    
	355         "Mail carriers, postal service" 
	356         "Mail clerks, except postal"    
	357         "Messengers (4745)"             
	359         "Dispatchers (4751)"            
	36          "Inspectors and compliance"     
	363         "Production coordinators (4752)"
	364         "Traffic, shipping, and receiving"
	365         "Stock and inventory clerks (4754)"
	366         "Meter readers (4755)"          
	368         "Weighers, measurers, checkers,"
	37          "Management rel. occupations,"  
	373         "Expediters (4758)"             
	374         "Material recording, scheduling,"
	375         "Insurance adjusters, examiners,"
	376         "Investigators and adjusters,"  
	377         "Eligibility clerks, social"    
	378         "Bill and account collectors (4786)"
	379         "General office clerks (463)"   
	383         "Bank tellers (4791)"           
	384         "Proofreaders (4792)"           
	385         "Data-entry keyers (4793)"      
	386         "Statistical clerks (4794)"     
	387         "Teachers' aides (4795)"        
	389         "Administrative support"        
	4           "Chief executives and general"  
	403         "Launderers and ironers (503)"  
	404         "Cooks, private household (504)"
	405         "Housekeepers and butlers (505)"
	406         "Child care workers, private hhld"
	407         "Private hhld cleaners and"     
	413         "Supervisors, firefighting and" 
	414         "Supervisors, police and"       
	415         "Supervisors, guards (5113)"    
	416         "Fire inspection and fire"      
	417         "Firefighting occupations (5123)"
	418         "Police and detectives, public" 
	423         "Sheriffs, bailiffs, and other law"
	424         "Correctional institution officers"
	425         "Crossing guards (5142)"        
	426         "Guards and police, except public"
	427         "Protective service occupations,"
	43          "Architects (161)"              
	433         "Supervisors, food preparation and"
	434         "Bartenders (5212)"             
	435         "Waiters and waitresses (5213)" 
	436         "Cooks (5214, 5215)"            
	438         "Food counter, fountain and rel."
	439         "Kitchen workers, food preparation"
	44          "Aerospace engineers(1622)"     
	443         "Waiters'/waitresses' assistants"
	444         "Miscellaneous food preparation"
	445         "Dental assistants (5232)"      
	446         "Health aides, except nursing"  
	447         "Nursing aides, orderlies, and" 
	448         "Supervisors, cleaning and"     
	449         "Maids and housemen (5242, 5249)"
	45          "Metallurgical and materials"   
	453         "Janitors and cleaners (5244)"  
	454         "Elevator operators (5245)"     
	455         "Pest control occupations (5246)"
	456         "Supervisors, personal service" 
	457         "Barbers (5252)"                
	458         "Hairdressers and cosmetologists"
	459         "Attendants, amusement and"     
	46          "Mining engineers (1624)"       
	461         "Guides (5255)"                 
	462         "Ushers (5256)"                 
	463         "Public transportation attendants"
	464         "Baggage porters and bellhops"  
	465         "Welfare service aides (5263)"  
	466         "Family child care providers (part"
	467         "Early childhood teacher's"     
	468         "Child care workers, n.e.c. (part"
	469         "Personal service occupations," 
	47          "Petroleum engineers (1625)"    
	473         "Farmers, except horticultural" 
	474         "Horticultural specialty farmers"
	475         "Managers, farms, except"       
	476         "Managers, horticultural specialty"
	477         "Supervisors, farm workers (5611)"
	479         "Farm workers (5612-5617)"      
	48          "Chemical engineers (1626)"     
	483         "Marine life cultivation workers"
	484         "Nursery workers (5619)"        
	485         "Supervisors, rel. agricultural"
	486         "Groundskeepers and gardeners," 
	487         "Animal caretakers, except farm"
	488         "Grader and sorter, agricultural"
	489         "Inspectors, agricultural products"
	49          "Nuclear engineers (1627)"      
	494         "Supervisors, forestry and logging"
	495         "Forestry workers, except logging"
	496         "Timber cutting and logging"    
	497         "Captains and other officers,"  
	498         "Fishers (583)"                 
	499         "Hunters and trappers (584)"    
	5           "Administrators and officials," 
	503         "Supervisors, mechanics and"    
	505         "Automobile mechanics (part 6111)"
	506         "Auto mechanic apprentices (part"
	507         "Bus, truck, and stationary engine"
	508         "Aircraft engine mechanics (6113)"
	509         "Small engine repairers (6114)" 
	514         "Automobile body and rel."      
	515         "Aircraft mechanics, except engine"
	516         "Heavy equipment mechanics (6117)"
	517         "Farm equipment mechanics (6118)"
	518         "Industrial machinery repairers"
	519         "Machinery maintenance occupations"
	523         "Electronic repairers,"         
	525         "Data processing equipment"     
	526         "Hhld appliance and power tool" 
	527         "Telephone line installers and" 
	529         "Telephone installers and"      
	53          "Civil engineers (1628)"        
	533         "Miscellaneous electrical and"  
	534         "Heating, air conditioning, and"
	535         "Camera, watch, and musical"    
	536         "Locksmiths and safe repairers" 
	538         "Office machine repairers (6174)"
	539         "Mechanical controls and valve" 
	54          "Agricultural engineers (1632)" 
	543         "Elevator installers and repairers"
	544         "Millwrights (6178)"            
	547         "Specified mechanics and"       
	549         "Not specified mechanics and"   
	55          "Engineers, electrical and"     
	553         "Supervisors, brickmasons,"     
	554         "Supervisors, carpenters and rel."
	555         "Supervisors, electricians and" 
	556         "Supervisors, painters,"        
	557         "Supervisors, plumbers,"        
	558         "Supervisors, construction, n.e.c."
	56          "Engineers, industrial (1634)"  
	563         "Brickmasons and stonemasons (part"
	564         "Brickmason and stonemason"     
	565         "Tile setters, hard and soft (part"
	566         "Carpet installers (part 6462)" 
	567         "Carpenters (part 6422)"        
	569         "Carpenter apprentices (part 6422)"
	57          "Engineers, mechanical (1635)"  
	573         "Drywall installers (6424)"     
	575         "Electricians (part 6432)"      
	576         "Electrician apprentices (part" 
	577         "Electrical power installers and"
	579         "Painters, construction and"    
	58          "Marine and naval architects (1637)"
	583         "Paperhangers (6443)"           
	584         "Plasterers (6444)"             
	585         "Plumbers, pipefitters, and"    
	587         "Plumber, pipefitter, and"      
	588         "Concrete and terrazzo finishers"
	589         "Glaziers (6464)"               
	59          "Engineers, n.e.c. (1639)"      
	593         "Insulation workers (6465)"     
	594         "Paving, surfacing, and tamping"
	595         "Roofers (6468)"                
	596         "Sheetmetal duct installers (6472)"
	597         "Structural metal workers (6473)"
	598         "Drillers, earth (6474)"        
	599         "Construction trades, n.e.c."   
	6           "Administrators, protective"    
	613         "Supervisors, extractive"       
	614         "Drillers, oil well (652)"      
	615         "Explosives workers (653)"      
	616         "Mining machine operators (654)"
	617         "Mining occupations, n.e.c. (656)"
	628         "Supervisors, production"       
	63          "Surveyors and mapping scientists"
	634         "Tool and die makers (part 6811)"
	635         "Tool and die mkr apprentices"  
	636         "Precision assemblers, metal (6812)"
	637         "Machinists (part 6813)"        
	639         "Machinist apprentices (part 6813)"
	64          "Computer systems analysts and" 
	643         "Boilermakers (6814)"           
	644         "Precision grinders, filers, and"
	645         "Patternmakers and model makers,"
	646         "Lay-out workers (6821)"        
	647         "Precious stones and metals"    
	649         "Engravers, metal (6823)"       
	65          "Operations and systems"        
	653         "Sheet metal workers (part 6824)"
	654         "Sheet metal wrker apprentices" 
	655         "Misc precision metal workers"  
	656         "Patternmkrs and model makers," 
	657         "Cabinet makers and bench"      
	658         "Furniture and wood finishers"  
	659         "Misc precision woodworkers (6839)"
	66          "Actuaries (1732)"              
	666         "Dressmakers (part 6852, part 7752)"
	667         "Tailors (part 6852)"           
	668         "Upholsterers (6853)"           
	669         "Shoe repairers (6854)"         
	67          "Statisticians (1733)"          
	674         "Misc precision apparel and fabric"
	675         "Hand molders and shapers, except"
	676         "Patternmakers, lay-out workers,"
	677         "Optical goods workers (6864, part"
	678         "Dental laboratory and medical" 
	679         "Bookbinders (6844)"            
	68          "Mathematical scientists, n.e.c."
	683         "Electrical/electronic equipment"
	684         "Msc precision workers, n.e.c." 
	686         "Butchers and meat cutters (6871)"
	687         "Bakers (6872)"                 
	688         "Food batchmakers (6873, 6879)" 
	689         "Inspectors, testers, and graders"
	69          "Physicists and astronomers (1842,"
	693         "Adjusters and calibrators (6882)"
	694         "Water and sewage treatment plant"
	695         "Power plant operators (part 693)"
	696         "Stationary engineers (part 693,"
	699         "Miscellaneous plant and system"
	7           "Financial managers (122)"      
	703         "Set-up operators, lathe and"   
	704         "Operators, lathe and turning"  
	705         "Milling and planing machine"   
	706         "Punching and stamping press"   
	707         "Rolling machine operators (7316,"
	708         "Drilling and boring machine"   
	709         "Grinding, abrading, buffing, and"
	713         "Forging machine operators (7319,"
	714         "Numerical control machine"     
	715         "Miscellaneous metal, plastic," 
	717         "Fabricating machine operators,"
	719         "Molding and casting machine"   
	723         "Metal plating machine operators"
	724         "Heat treating equipment operators"
	725         "Misc metal and plastic processing"
	726         "Wood lathe, routing, and planing"
	727         "Sawing machine operators (7433,"
	728         "Shaping and joining machine"   
	729         "Nailing and tacking machine"   
	73          "Chemists, except biochemists"  
	733         "Miscellaneous woodworking machine"
	734         "Printing press operators (7443,"
	735         "Photoengravers and lithographers"
	736         "Typesetters and compositors"   
	737         "Miscellaneous printing machine"
	738         "Winding and twisting machine"  
	739         "Knitting, looping, taping, and"
	74          "Atmospheric and space scientists"
	743         "Textile cutting machine operators"
	744         "Textile sewing machine operators"
	745         "Shoe machine operators (7656)" 
	747         "Pressing machine operators (7657)"
	748         "Laundering and dry cleaning"   
	749         "Miscellaneous textile machine" 
	75          "Geologists and geodesists (1847)"
	753         "Cementing and gluing machine"  
	754         "Packaging and filling machine" 
	755         "Extruding and forming machine" 
	756         "Mixing and blending machine"   
	757         "Separating, filtering, and"    
	758         "Compressing and compacting"    
	759         "Painting and paint spraying"   
	76          "Physical scientists, n.e.c. (1849)"
	763         "Roasting and baking machine"   
	764         "Washing, cleaning, and pickling"
	765         "Folding machine operators (7474,"
	766         "Furnace, kiln, and oven"       
	768         "Crushing and grinding machine" 
	769         "Slicing and cutting machine"   
	77          "Agricultural and food scientists"
	773         "Motion picture projectionists" 
	774         "Photographic process machine"  
	777         "Miscellaneous machine operators,"
	779         "Machine operators, not specified"
	78          "Biological and life scientists"
	783         "Welders and cutters (7332, 7532,"
	784         "Solderers and brazers (7333,"  
	785         "Assemblers (772, 774)"         
	786         "Hand cutting and trimming"     
	787         "Hand molding, casting, and"    
	789         "Hand painting, coating, and"   
	79          "Forestry and conservation"     
	793         "Hand engraving and printing"   
	795         "Miscellaneous hand working"    
	796         "Production inspectors, checkers,"
	797         "Production testers (783)"      
	798         "Production samplers and weighers"
	799         "Graders and sorters, except"   
	8           "Personnel and labor relations" 
	803         "Supervisors, motor vehicle"    
	804         "Truck drivers (8212-8214)"     
	806         "Driver-sales workers (8218)"   
	808         "Bus drivers (8215)"            
	809         "Taxicab drivers and chauffeurs"
	813         "Parking lot attendants (874)"  
	814         "Motor transportation occupations,"
	823         "Railroad conductors and"       
	824         "Locomotive operating occupations"
	825         "Railroad brake, signal, and"   
	826         "Rail vehicle operators, n.e.c."
	828         "Ship captains and mates, except"
	829         "Sailors and deckhands (8243)"  
	83          "Medical scientists (1855)"     
	833         "Marine engineers (8244)"       
	834         "Bridge, lock, and lighthouse"  
	84          "Physicians (261)"              
	843         "Supervisors, material moving"  
	844         "Operating engineers (8312)"    
	845         "Longshore equipment operators" 
	848         "Hoist and winch operators (8314)"
	849         "Crane and tower operators (8315)"
	85          "Dentists (262)"                
	853         "Excavating and loading machine"
	855         "Grader, dozer, and scraper"    
	856         "Industrial truck and tractor"  
	859         "Misc material moving equipment"
	86          "Veterinarians (27)"            
	864         "Supervisors, handlers, equipment"
	865         "Helpers, mechanics, and repairers"
	866         "Helpers, construction trades"  
	867         "Helpers, surveyor (8646)"      
	868         "Helpers, extractive occupations"
	869         "Construction laborers (871)"   
	87          "Optometrists (281)"            
	874         "Production helpers (861, 862)" 
	875         "Garbage collectors (8722)"     
	876         "Stevedores (8723)"             
	877         "Stock handlers and baggers (8724)"
	878         "Machine feeders and offbearers"
	88          "Podiatrists (283)"             
	883         "Freight, stock, and material"  
	885         "Garage and service station rel."
	887         "Vehicle washers and equipment" 
	888         "Hand packers and packagers (8761)"
	889         "Laborers, except construction" 
	89          "Health diagnosing practitioners,"
	9           "Purchasing managers (124)"     
	905         "Persons whose current labor force"
	95          "Registered nurses (29)"        
	96          "Pharmacists (301)"             
	97          "Dietitians (302)"              
	98          "Respiratory therapists (3031)" 
	99          "Occupational therapists (3032)"
;
label values absocc2  absocc2l;
label define absocc2l
	0           "Not imputed"                   
	1           "Statistical imputation(hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation(derivation)"
	4           "Statistical or logical imputation"
;
label values euectyp5 euectypm;
label define euectypm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values auectyp5 auectypm;
label define auectypm
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values euectyp7 euectypk;
label define euectypk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values auectyp7 auectypk;
label define auectypk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values elmptyp1 elmptypm;
label define elmptypm
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almptyp1 almptypm;
label define almptypm
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values elmptyp2 elmptypk;
label define elmptypk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almptyp2 almptypk;
label define almptypk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values elmptyp3 elmptypl;
label define elmptypl
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values almptyp3 almptypl;
label define almptypl
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values essself  essself;
label define essself 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values assself  assself;
label define assself 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values esschild esschild;
label define esschild
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asschild asschild;
label define asschild
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values essichld essichld;
label define essichld
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values assichld assichld;
label define assichld
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values essiself essiself;
label define essiself
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values assiself assiself;
label define assiself
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values estssi   estssi; 
label define estssi  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values astssi   astssi; 
label define astssi  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rwcmprsn rwcmprsn;
label define rwcmprsn
	-1          "Not in universe"               
	1           "Disability"                    
	3           "Suvivor"                       
	5           "Disability and Suvivor"        
	8           "No payment"                    
;
label values awcmprsn awcmprsn;
label define awcmprsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rinsrsn  rinsrsn;
label define rinsrsn 
	-1          "Not in universe"               
	1           "Disability"                    
	8           "No payment received"           
;
label values ainsrsn  ainsrsn;
label define ainsrsn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rempdrsn rempdrsn;
label define rempdrsn
	-1          "Not in universe"               
	1           "Disability"                    
	8           "No payment"                    
;
label values aempdrsn aempdrsn;
label define aempdrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rpensrsn rpensrsn;
label define rpensrsn
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Survivor"                      
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values apensrsn apensrsn;
label define apensrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rfcsrsn  rfcsrsn;
label define rfcsrsn 
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Survivor"                      
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values afcsrsn  afcsrsn;
label define afcsrsn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rstatrsn rstatrsn;
label define rstatrsn
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Survivor"                      
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values astatrsn astatrsn;
label define astatrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rlgovrsn rlgovrsn;
label define rlgovrsn
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Survivor"                      
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values algovrsn algovrsn;
label define algovrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rmilrsn  rmilrsn;
label define rmilrsn 
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Survivor"                      
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values amilrsn  amilrsn;
label define amilrsn 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rrrsn    rrrsn;  
label define rrrsn   
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Survivor"                      
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values arrrsn   arrrsn; 
label define arrrsn  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rblklrsn rblklrsn;
label define rblklrsn
	-1          "Not in universe"               
	1           "Disability"                    
	3           "Survivor"                      
	5           "Disability and survivor"       
	8           "No payment received"           
;
label values ablklrsn ablklrsn;
label define ablklrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rothrrsn rothrrsn;
label define rothrrsn
	-1          "Not in universe"               
	1           "Disability"                    
	2           "Retirement"                    
	3           "Suvivor"                       
	4           "Disability and retirement"     
	5           "Disability and survivor"       
	6           "Retirement and survivor"       
	7           "Disability, retirement, and"   
	8           "No payment received"           
;
label values aothrrsn aothrrsn;
label define aothrrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rlifirsn rlifirsn;
label define rlifirsn
	-1          "Not in universe"               
	2           "Retirement"                    
	3           "Suvivor"                       
	6           "Retirement and survivor"       
	8           "No payment received"           
;
label values alifirsn alifirsn;
label define alifirsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rvetsrsn rvetsrsn;
label define rvetsrsn
	-1          "Not in universe"               
	3           "Suvivor"                       
	8           "No payment received"           
;
label values avetsrsn avetsrsn;
label define avetsrsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values restarsn restarsn;
label define restarsn
	-1          "Not in universe"               
	3           "Suvivor"                       
	8           "No payment received"           
;
label values aestarsn aestarsn;
label define aestarsn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values efccyn   efccyn; 
label define efccyn  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values afccyn   afccyn; 
label define afccyn  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ecsagree ecsagree;
label define ecsagree
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acsagree acsagree;
label define acsagree
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ecsyn    ecsyn;  
label define ecsyn   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acsyn    acsyn;  
label define acsyn   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ealiyn   ealiyn; 
label define ealiyn  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aaliyn   aaliyn; 
label define aaliyn  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values efsyn    efsyn;  
label define efsyn   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values afsyn    afsyn;  
label define afsyn   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epssthru epssthru;
label define epssthru
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apssthru apssthru;
label define apssthru
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ewicyn   ewicyn; 
label define ewicyn  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values awicyn   awicyn; 
label define awicyn  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyn   epatyn; 
label define epatyn  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyn   apatyn; 
label define apatyn  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp1  epatyp1l;
label define epatyp1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp1  apatyp1l;
label define apatyp1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp2  epatyp2l;
label define epatyp2l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp2  apatyp2l;
label define apatyp2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp3  epatyp3l;
label define epatyp3l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp3  apatyp3l;
label define apatyp3l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp4  epatyp4l;
label define epatyp4l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp4  apatyp4l;
label define apatyp4l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp5  epatyp5l;
label define epatyp5l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp5  apatyp5l;
label define apatyp5l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp6  epatyp6l;
label define epatyp6l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp6  apatyp6l;
label define apatyp6l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values epatyp7  epatyp7l;
label define epatyp7l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values apatyp7  apatyp7l;
label define apatyp7l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ecomserv ecomserv;
label define ecomserv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acomserv acomserv;
label define acomserv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ecomtype ecomtype;
label define ecomtype
	-1          "Not in universe"               
	1           "Community service or an unpaid job"
	2           "Some other kind of job-training"
;
label values acomtype acomtype;
label define acomtype
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values easetdrw easetdrw;
label define easetdrw
	-1          "Not in universe"               
	1           "Lump Sum"                      
	2           "Regular distribution"          
	3           "Both"                          
	4           "No"                            
;
label values aasetdrw aasetdrw;
label define aasetdrw
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eresnss1 eresnssw;
label define eresnssw
	-1          "Not in universe"               
	1           "Retired"                       
	2           "Disabled"                      
	3           "Widowed or surviving child"    
	4           "Spouse or dependent child"     
	5           "Some other reason"             
;
label values aresnss1 aresnssw;
label define aresnssw
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eresnss2 eresnssk;
label define eresnssk
	-1          "Not in universe"               
	0           "Persons providing only one reason"
	1           "Retired"                       
	2           "Disabled"                      
	3           "Widowed or surviving child"    
	4           "Spouse or dependent child"     
	5           "Some other reason"             
;
label values aresnss2 aresnssk;
label define aresnssk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tagess   tagess; 
label define tagess  
	-1          "Not in universe"               
;
label values aagess   aagess; 
label define aagess  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
;
label values ejntssyn ejntssyn;
label define ejntssyn
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajntssyn ajntssyn;
label define ajntssyn
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er01a    er01a;  
label define er01a   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar01a    ar01a;  
label define ar01a   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er01k    er01k;  
label define er01k   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar01k    ar01k;  
label define ar01k   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er02     er02l;  
label define er02l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar02     ar02l;  
label define ar02l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er03a    er03a;  
label define er03a   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar03a    ar03a;  
label define ar03a   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er03k    er03k;  
label define er03k   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar03k    ar03k;  
label define ar03k   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er04     er04l;  
label define er04l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar04     ar04l;  
label define ar04l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er05     er05l;  
label define er05l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar05     ar05l;  
label define ar05l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er07     er07l;  
label define er07l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar07     ar07l;  
label define ar07l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er08     er08l;  
label define er08l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar08     ar08l;  
label define ar08l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er09     er09l;  
label define er09l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar09     ar09l;  
label define ar09l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er10     er10l;  
label define er10l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar10     ar10l;  
label define ar10l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er12     er12l;  
label define er12l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar12     ar12l;  
label define ar12l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er13     er13l;  
label define er13l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar13     ar13l;  
label define ar13l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er14     er14l;  
label define er14l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar14     ar14l;  
label define ar14l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er15     er15l;  
label define er15l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar15     ar15l;  
label define ar15l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er20     er20l;  
label define er20l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar20     ar20l;  
label define ar20l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er21     er21l;  
label define er21l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar21     ar21l;  
label define ar21l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er23     er23l;  
label define er23l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar23     ar23l;  
label define ar23l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er24     er24l;  
label define er24l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar24     ar24l;  
label define ar24l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er25     er25l;  
label define er25l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar25     ar25l;  
label define ar25l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er26     er26l;  
label define er26l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar26     ar26l;  
label define ar26l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er27     er27l;  
label define er27l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar27     ar27l;  
label define ar27l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er28     er28l;  
label define er28l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar28     ar28l;  
label define ar28l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er29     er29l;  
label define er29l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar29     ar29l;  
label define ar29l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er30     er30l;  
label define er30l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar30     ar30l;  
label define ar30l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er31     er31l;  
label define er31l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar31     ar31l;  
label define ar31l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er32     er32l;  
label define er32l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar32     ar32l;  
label define ar32l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er34     er34l;  
label define er34l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar34     ar34l;  
label define ar34l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er35     er35l;  
label define er35l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar35     ar35l;  
label define ar35l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er36     er36l;  
label define er36l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar36     ar36l;  
label define ar36l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er37     er37l;  
label define er37l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar37     ar37l;  
label define ar37l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er38     er38l;  
label define er38l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar38     ar38l;  
label define ar38l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er39     er39l;  
label define er39l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar39     ar39l;  
label define ar39l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er42     er42l;  
label define er42l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar42     ar42l;  
label define ar42l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er50     er50l;  
label define er50l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar50     ar50l;  
label define ar50l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er51     er51l;  
label define er51l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar51     ar51l;  
label define ar51l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er52     er52l;  
label define er52l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar52     ar52l;  
label define ar52l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er53     er53l;  
label define er53l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar53     ar53l;  
label define ar53l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er55     er55l;  
label define er55l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar55     ar55l;  
label define ar55l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er56     er56l;  
label define er56l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar56     ar56l;  
label define ar56l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values er75     er75l;  
label define er75l   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ar75     ar75l;  
label define ar75l   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t01amta  t01amta;
label define t01amta 
	0           "None or not in universe"       
;
label values a01amta  a01amta;
label define a01amta 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t01amtk  t01amtk;
label define t01amtk 
	0           "None or not in universe"       
;
label values a01amtk  a01amtk;
label define a01amtk 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t02amt   t02amt; 
label define t02amt  
	0           "None or not in universe"       
;
label values a02amt   a02amt; 
label define a02amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t03amta  t03amta;
label define t03amta 
	0           "None or not in universe"       
;
label values a03amta  a03amta;
label define a03amta 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t03amtk  t03amtk;
label define t03amtk 
	0           "None or not in universe"       
;
label values a03amtk  a03amtk;
label define a03amtk 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t04amt   t04amt; 
label define t04amt  
	0           "None or not in universe"       
;
label values a04amt   a04amt; 
label define a04amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t05amt   t05amt; 
label define t05amt  
	0           "None or not in universe"       
;
label values a05amt   a05amt; 
label define a05amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t07amt   t07amt; 
label define t07amt  
	0           "None or not in universe"       
;
label values a07amt   a07amt; 
label define a07amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t08amt   t08amt; 
label define t08amt  
	0           "None or not in universe"       
;
label values a08amt   a08amt; 
label define a08amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t09amt   t09amt; 
label define t09amt  
	0           "None or not in universe"       
;
label values a09amt   a09amt; 
label define a09amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t10amt   t10amt; 
label define t10amt  
	0           "None or not in universe"       
;
label values a10amt   a10amt; 
label define a10amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t12amt   t12amt; 
label define t12amt  
	0           "None or not in universe"       
;
label values a12amt   a12amt; 
label define a12amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t13amt   t13amt; 
label define t13amt  
	0           "None or not in universe"       
;
label values a13amt   a13amt; 
label define a13amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t14amt   t14amt; 
label define t14amt  
	0           "None or not in universe"       
;
label values a14amt   a14amt; 
label define a14amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t15amt   t15amt; 
label define t15amt  
	0           "None or not in universe"       
;
label values a15amt   a15amt; 
label define a15amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t20amt   t20amt; 
label define t20amt  
	0           "None or not in universe"       
;
label values a20amt   a20amt; 
label define a20amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t21amt   t21amt; 
label define t21amt  
	0           "None or not in universe"       
;
label values a21amt   a21amt; 
label define a21amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t23amt   t23amt; 
label define t23amt  
	0           "None or not in universe"       
;
label values a23amt   a23amt; 
label define a23amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t24amt   t24amt; 
label define t24amt  
	0           "None or not in universe"       
;
label values a24amt   a24amt; 
label define a24amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t25amt   t25amt; 
label define t25amt  
	0           "None or not in universe"       
;
label values a25amt   a25amt; 
label define a25amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t26amt   t26amt; 
label define t26amt  
	0           "None or not in universe"       
;
label values a26amt   a26amt; 
label define a26amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t27amt   t27amt; 
label define t27amt  
	0           "None or not in universe"       
;
label values a27amt   a27amt; 
label define a27amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t28amt   t28amt; 
label define t28amt  
	0           "None or not in universe"       
;
label values a28amt   a28amt; 
label define a28amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t29amt   t29amt; 
label define t29amt  
	0           "None or not in universe"       
;
label values a29amt   a29amt; 
label define a29amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t30amt   t30amt; 
label define t30amt  
	0           "None or not in universe"       
;
label values a30amt   a30amt; 
label define a30amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t31amt   t31amt; 
label define t31amt  
	0           "None or not in universe"       
;
label values a31amt   a31amt; 
label define a31amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t32amt   t32amt; 
label define t32amt  
	0           "None or not in universe"       
;
label values a32amt   a32amt; 
label define a32amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t34amt   t34amt; 
label define t34amt  
	0           "None or not in universe"       
;
label values a34amt   a34amt; 
label define a34amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t35amt   t35amt; 
label define t35amt  
	0           "None or not in universe"       
;
label values a35amt   a35amt; 
label define a35amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t36amt   t36amt; 
label define t36amt  
	0           "None or not in universe"       
;
label values a36amt   a36amt; 
label define a36amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t37amt   t37amt; 
label define t37amt  
	0           "None or not in universe"       
;
label values a37amt   a37amt; 
label define a37amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t38amt   t38amt; 
label define t38amt  
	0           "None or not in universe"       
;
label values a38amt   a38amt; 
label define a38amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t39amt   t39amt; 
label define t39amt  
	0           "None or not in universe"       
;
label values a39amt   a39amt; 
label define a39amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t42amt   t42amt; 
label define t42amt  
	0           "None or not in universe"       
;
label values a42amt   a42amt; 
label define a42amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t50amt   t50amt; 
label define t50amt  
	0           "None or not in universe"       
;
label values a50amt   a50amt; 
label define a50amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t51amt   t51amt; 
label define t51amt  
	0           "None or not in universe"       
;
label values a51amt   a51amt; 
label define a51amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t52amt   t52amt; 
label define t52amt  
	0           "None or not in universe"       
;
label values a52amt   a52amt; 
label define a52amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t53amt   t53amt; 
label define t53amt  
	0           "None or not in universe"       
;
label values a53amt   a53amt; 
label define a53amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t55amt   t55amt; 
label define t55amt  
	0           "None or not in universe"       
;
label values a55amt   a55amt; 
label define a55amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t56amt   t56amt; 
label define t56amt  
	0           "None or not in universe"       
;
label values a56amt   a56amt; 
label define a56amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values t75amt   t75amt; 
label define t75amt  
	0           "None or not in universe"       
;
label values a75amt   a75amt; 
label define a75amt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tcsagy   tcsagy; 
label define tcsagy  
	0           "None or not in universe"       
;
label values acsagy   acsagy; 
label define acsagy  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values erolovr1 erolovry;
label define erolovry
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arolovr1 arolovry;
label define arolovry
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values erolovr2 erolovrk;
label define erolovrk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values arolovr2 arolovrk;
label define arolovrk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values trollamt trollamt;
label define trollamt
	0           "None or not in universe"       
;
label values arollamt arollamt;
label define arollamt
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rab1r1   rab1r1l;
label define rab1r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rab1r2   rab1r2l;
label define rab1r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rab2r1   rab2r1l;
label define rab2r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rab2r2   rab2r2l;
label define rab2r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values ras1     ras1l;  
label define ras1l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values ras2     ras2l;  
label define ras2l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rwb1r1   rwb1r1l;
label define rwb1r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rwb1r2   rwb1r2l;
label define rwb1r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rwb2r1   rwb2r1l;
label define rwb2r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rwb2r2   rwb2r2l;
label define rwb2r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rws1     rws1l;  
label define rws1l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rws2     rws2l;  
label define rws2l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rfb1r1   rfb1r1l;
label define rfb1r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rfb1r2   rfb1r2l;
label define rfb1r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rfb2r1   rfb2r1l;
label define rfb2r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rfb2r2   rfb2r2l;
label define rfb2r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rfs1     rfs1l;  
label define rfs1l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rfs2     rfs2l;  
label define rfs2l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rgb1r1   rgb1r1l;
label define rgb1r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rgb1r2   rgb1r2l;
label define rgb1r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rgb2r1   rgb2r1l;
label define rgb2r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rgb2r2   rgb2r2l;
label define rgb2r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rgs1     rgs1l;  
label define rgs1l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rgs2     rgs2l;  
label define rgs2l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rob1r1   rob1r1l;
label define rob1r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rob1r2   rob1r2l;
label define rob1r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rob2r1   rob2r1l;
label define rob2r1l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values rob2r2   rob2r2l;
label define rob2r2l 
	-1          "Not in universe"               
	10          "Other, specify"                
	2           "Pregnancy/birth of child"      
	3           "Began receiving for another"   
	4           "Separated or divorced from"    
	5           "Loss of job/wages/other income"
	6           "Loss of other support income"  
	7           "Just learned about program"    
	8           "Just got around to applying"   
	9           "Became disabled"               
;
label values ros1     ros1l;  
label define ros1l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values ros2     ros2l;  
label define ros2l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rsb1r1   rsb1r1l;
label define rsb1r1l 
	-1          "Not in universe"               
	2           "Became disabled/blind"         
	3           "Over 65"                       
	4           "Other, specify"                
;
label values rsb1r2   rsb1r2l;
label define rsb1r2l 
	-1          "Not in universe"               
	2           "Became disabled/blind"         
	3           "Over 65"                       
	4           "Other, specify"                
;
label values rsb2r1   rsb2r1l;
label define rsb2r1l 
	-1          "Not in universe"               
	2           "Became disabled/blind"         
	3           "Over 65"                       
	4           "Other, specify"                
;
label values rsb2r2   rsb2r2l;
label define rsb2r2l 
	-1          "Not in universe"               
	2           "Became disabled/blind"         
	3           "Over 65"                       
	4           "Other, specify"                
;
label values rss1     rss1l;  
label define rss1l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values rss2     rss2l;  
label define rss2l   
	-1          "Not in Universe"               
	1           "Became ineligible because of"  
	2           "Because of family changes"     
	3           "Still eligible but could/chose"
	4           "Became ineligible because program"
	5           "Eligibility ran out because of"
	6           "Other, specify"                
;
label values east1a   east1a; 
label define east1a  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast1a   aast1a; 
label define aast1a  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east1b   east1b; 
label define east1b  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast1b   aast1b; 
label define aast1b  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east1c   east1c; 
label define east1c  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast1c   aast1c; 
label define aast1c  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east2a   east2a; 
label define east2a  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast2a   aast2a; 
label define aast2a  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east2b   east2b; 
label define east2b  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast2b   aast2b; 
label define aast2b  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east2c   east2c; 
label define east2c  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast2c   aast2c; 
label define aast2c  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east2d   east2d; 
label define east2d  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast2d   aast2d; 
label define aast2d  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east3a   east3a; 
label define east3a  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast3a   aast3a; 
label define aast3a  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east3b   east3b; 
label define east3b  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast3b   aast3b; 
label define aast3b  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east3c   east3c; 
label define east3c  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast3c   aast3c; 
label define aast3c  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east3d   east3d; 
label define east3d  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast3d   aast3d; 
label define aast3d  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east3e   east3e; 
label define east3e  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast3e   aast3e; 
label define aast3e  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east4a   east4a; 
label define east4a  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast4a   aast4a; 
label define aast4a  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east4b   east4b; 
label define east4b  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast4b   aast4b; 
label define aast4b  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values east4c   east4c; 
label define east4c  
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aast4c   aast4c; 
label define aast4c  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ejntrnt  ejntrnt;
label define ejntrnt 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ajntrnt  ajntrnt;
label define ajntrnt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tjarnt   tjarnt; 
label define tjarnt  
	0           "None or not in universe"       
;
label values ajarnt   ajarnt; 
label define ajarnt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tjaclr   tjaclr; 
label define tjaclr  
	0           "None or not in universe"       
;
label values ajaclr   ajaclr; 
label define ajaclr  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eownrnt  eownrnt;
label define eownrnt 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values aownrnt  aownrnt;
label define aownrnt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values toarnt   toarnt; 
label define toarnt  
	0           "None or not in universe"       
;
label values aoarnt   aoarnt; 
label define aoarnt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values toaclr   toaclr; 
label define toaclr  
	0           "None or not in universe"       
;
label values aoaclr   aoaclr; 
label define aoaclr  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ejrnt2   ejrnt2l;
label define ejrnt2l 
	-1          "Not universe"                  
	1           "Yes"                           
	2           "No"                            
;
label values ajrnt2   ajrnt2l;
label define ajrnt2l 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tjaclr2  tjaclr2l;
label define tjaclr2l
	0           "None or not in universe"       
;
label values ajaclr2  ajaclr2l;
label define ajaclr2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values emrtjnt  emrtjnt;
label define emrtjnt 
	-1          "Not universe"                  
	1           "Yes"                           
	2           "No"                            
;
label values amrtjnt  amrtjnt;
label define amrtjnt 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmijnt   tmijnt; 
label define tmijnt  
	0           "None or not in universe"       
;
label values amijnt   amijnt; 
label define amijnt  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values emrtown  emrtown;
label define emrtown 
	-1          "Not universe"                  
	1           "Yes"                           
	2           "No"                            
;
label values amrtown  amrtown;
label define amrtown 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmiown   tmiown; 
label define tmiown  
	0           "None or not in universe"       
;
label values amiown   amiown; 
label define amiown  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values trndup1  trndup1l;
label define trndup1l
	0           "None or not in universe"       
;
label values arndup1  arndup1l;
label define arndup1l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values trndup2  trndup2l;
label define trndup2l
	0           "None or not in universe"       
;
label values arndup2  arndup2l;
label define arndup2l
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tothprop tothprop;
label define tothprop
	0           "None or not in universe"       
;
label values eckjt    eckjt;  
label define eckjt   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ackjt    ackjt;  
label define ackjt   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tckjtint tckjtint;
label define tckjtint
	0           "None or not in universe"       
;
label values ackjtint ackjtint;
label define ackjtint
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values eckoast  eckoast;
label define eckoast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ackoast  ackoast;
label define ackoast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tckoint  tckoint;
label define tckoint 
	0           "None or not in universe"       
;
label values ackoint  ackoint;
label define ackoint 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values esvjt    esvjt;  
label define esvjt   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asvjt    asvjt;  
label define asvjt   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tsvjtint tsvjtint;
label define tsvjtint
	0           "None or not in universe"       
;
label values asvjtint asvjtint;
label define asvjtint
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values esvoast  esvoast;
label define esvoast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asvoast  asvoast;
label define asvoast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tsvoint  tsvoint;
label define tsvoint 
	0           "None or not in universe"       
;
label values asvoint  asvoint;
label define asvoint 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values emdjt    emdjt;  
label define emdjt   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amdjt    amdjt;  
label define amdjt   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmdjtint tmdjtint;
label define tmdjtint
	0           "None or not in universe"       
;
label values amdjtint amdjtint;
label define amdjtint
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values emdoast  emdoast;
label define emdoast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amdoast  amdoast;
label define amdoast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmdoint  tmdoint;
label define tmdoint 
	0           "None or not in universe"       
;
label values amdoint  amdoint;
label define amdoint 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ecdjt    ecdjt;  
label define ecdjt   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acdjt    acdjt;  
label define acdjt   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tcdjtint tcdjtint;
label define tcdjtint
	0           "None or not in universe"       
;
label values acdjtint acdjtint;
label define acdjtint
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ecdoast  ecdoast;
label define ecdoast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values acdoast  acdoast;
label define acdoast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tcdoint  tcdoint;
label define tcdoint 
	0           "None or not in universe"       
;
label values acdoint  acdoint;
label define acdoint 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ebdjt    ebdjt;  
label define ebdjt   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abdjt    abdjt;  
label define abdjt   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tbdjtint tbdjtint;
label define tbdjtint
	0           "None or not in universe"       
;
label values abdjtint abdjtint;
label define abdjtint
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ebdoast  ebdoast;
label define ebdoast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values abdoast  abdoast;
label define abdoast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tbdoint  tbdoint;
label define tbdoint 
	0           "None or not in universe"       
;
label values abdoint  abdoint;
label define abdoint 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values egvjt    egvjt;  
label define egvjt   
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agvjt    agvjt;  
label define agvjt   
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tgvjtint tgvjtint;
label define tgvjtint
	0           "None or not in universe"       
;
label values agvjtint agvjtint;
label define agvjtint
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values egvoast  egvoast;
label define egvoast 
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values agvoast  agvoast;
label define agvoast 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tgvoint  tgvoint;
label define tgvoint 
	0           "None or not in universe"       
;
label values agvoint  agvoint;
label define agvoint 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tintinc  tintinc;
label define tintinc 
	0           "None or not in univerese"      
;
label values emanychk emanychk;
label define emanychk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amanychk amanychk;
label define amanychk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmjntdiv tmjntdiv;
label define tmjntdiv
	0           "None or not in universe"       
;
label values amjntdiv amjntdiv;
label define amjntdiv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmowndiv tmowndiv;
label define tmowndiv
	0           "None or not in universe"       
;
label values amowndiv amowndiv;
label define amowndiv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values emothdiv emothdiv;
label define emothdiv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values amothdiv amothdiv;
label define amothdiv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmjadiv  tmjadiv;
label define tmjadiv 
	0           "None or not in universe"       
;
label values amjadiv  amjadiv;
label define amjadiv 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tmownadv tmownadv;
label define tmownadv
	0           "None or not in universe"       
;
label values amownadv amownadv;
label define amownadv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values esanychk esanychk;
label define esanychk
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asanychk asanychk;
label define asanychk
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tsjntdiv tsjntdiv;
label define tsjntdiv
	0           "None or not in universe"       
;
label values asjntdiv asjntdiv;
label define asjntdiv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tsowndiv tsowndiv;
label define tsowndiv
	0           "None or not in universe"       
;
label values asowndiv asowndiv;
label define asowndiv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values esothdiv esothdiv;
label define esothdiv
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values asothdiv asothdiv;
label define asothdiv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tsjadiv  tsjadiv;
label define tsjadiv 
	0           "None or not in universe"       
;
label values asjadiv  asjadiv;
label define asjadiv 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tsownadv tsownadv;
label define tsownadv
	0           "None or not in universe"       
;
label values asownadv asownadv;
label define asownadv
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values tdivinc  tdivinc;
label define tdivinc 
	0           "None or not in universe"       
;
label values ecrmth   ecrmth; 
label define ecrmth  
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values acrmth   acrmth; 
label define acrmth  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rmedcode rmedcode;
label define rmedcode
	-1          "Not in universe"               
	1           "Retired or disabled worker"    
	2           "Spouse of retired or disabled" 
	3           "Widow of retired or disabled"  
	4           "Adult disabled as a child"     
	5           "Uninsured"                     
	7           "Other or invalid code"         
	9           "Missing code"                  
;
label values ecdmth   ecdmth; 
label define ecdmth  
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values acdmth   acdmth; 
label define acdmth  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ecdunt1  ecdunt1l;
label define ecdunt1l
	-1          "Not in universe"               
;
label values ecdunt2  ecdunt2l;
label define ecdunt2l
	-1          "Not in universe"               
;
label values ecdunt3  ecdunt3l;
label define ecdunt3l
	-1          "Not in universe"               
;
label values ehimth   ehimth; 
label define ehimth  
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values ahimth   ahimth; 
label define ahimth  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehiowner ehiowner;
label define ehiowner
	1           "Covered in own name"           
	2           "Covered by someone else's plan"
	3           "Covered both in own name and by"
	4           "Not covered"                   
;
label values ahiowner ahiowner;
label define ahiowner
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values enonhh   enonhh; 
label define enonhh  
	1           "Yes"                           
	2           "No"                            
;
label values rchampm  rchampm;
label define rchampm 
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No"                            
;
label values ehiunt1  ehiunt1l;
label define ehiunt1l
	-1          "Not in universe"               
;
label values ehiunt2  ehiunt2l;
label define ehiunt2l
	-1          "Not in universe"               
;
label values ehiunt3  ehiunt3l;
label define ehiunt3l
	-1          "Not in universe"               
;
label values ehemply  ehemply;
label define ehemply 
	-1          "Not in universe"               
	1           "Current employer or work"      
	2           "Former employer"               
	3           "Union"                         
	4           "CHAMPUS"                       
	5           "CHAMPVA"                       
	6           "Military/VA health care"       
	7           "Privately purchased"           
	8           "Other"                         
;
label values ahemply  ahemply;
label define ahemply 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehicost  ehicost;
label define ehicost 
	-1          "Not in universe"               
	1           "All"                           
	2           "Part"                          
	3           "None"                          
;
label values ahicost  ahicost;
label define ahicost 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehiother ehiother;
label define ehiother
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahiother ahiother;
label define ahiother
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehispse  ehispse;
label define ehispse 
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values ahispse  ahispse;
label define ahispse 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehioldkd ehioldkd;
label define ehioldkd
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values ahioldkd ahioldkd;
label define ahioldkd
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehiyngkd ehiyngkd;
label define ehiyngkd
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values ahiyngkd ahiyngkd;
label define ahiyngkd
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehiothr  ehiothr;
label define ehiothr 
	-1          "Not in universe"               
	1           "Yes, covered"                  
	2           "No, not covered"               
;
label values ahiothr  ahiothr;
label define ahiothr 
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values ehirsn01 ehirsn0r;
label define ehirsn0r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn02 ehirsn0k;
label define ehirsn0k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn03 ehirsn0l;
label define ehirsn0l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn04 ehirsn0m;
label define ehirsn0m
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn05 ehirsn0n;
label define ehirsn0n
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn06 ehirsn0o;
label define ehirsn0o
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn07 ehirsn0p;
label define ehirsn0p
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn08 ehirsn0q;
label define ehirsn0q
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn09 ehirsn0s;
label define ehirsn0s
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn10 ehirsn1r;
label define ehirsn1r
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn11 ehirsn1k;
label define ehirsn1k
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ehirsn12 ehirsn1l;
label define ehirsn1l
	-1          "Not in universe"               
	1           "Yes"                           
	2           "No"                            
;
label values ahirsn   ahirsn; 
label define ahirsn  
	0           "Not imputed"                   
	1           "Statistical imputation (hot deck)"
	2           "Cold deck imputation"          
	3           "Logical imputation (derivation)"
	4           "Statistical or logical imputation"
;
label values rprvhi   rprvhi; 
label define rprvhi  
	-1          "Not in universe"               
	1           "Employer or union provided"    
	2           "Privately purchased"           
;

/*
Copyright 2005 shared by the National Bureau of Economic Research and Jean Roth

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
