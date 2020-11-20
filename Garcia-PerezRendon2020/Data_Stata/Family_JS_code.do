* program to extract household information from SIPP-1996
clear all
capture log close
log using stataoutput, replace

global main "C:\Users\silvio\Documents\Nacho\resubjoin\finalsub"

global stata "${main}\Data_Stata"
global finaloutput "${main}\Estim_Fortran"

cd "${stata}"

*****************Topical modules to be linked to the longitudinal ones (3, 6, 9 & 12)
run sip96t3
keep swave ssuseq ssuid epppnum esex erace eorigin tage ems eeducate eppidx errp thh* rhhuscbt srotaton 
sort ssuid epppnum
save sipp96t3_mio.dta, replace

clear
run sip96t6
keep swave ssuseq ssuid epppnum esex erace eorigin tage ems eeducate eppidx errp thh* rhhuscbt srotaton 
sort ssuid epppnum
save sipp96t6_mio.dta, replace

clear
run sip96t9
keep swave ssuseq ssuid epppnum esex erace eorigin tage ems eeducate eppidx errp thh* rhhuscbt srotaton 
sort ssuid epppnum
save sipp96t9_mio.dta, replace

clear
run sip96t12
keep swave ssuseq ssuid epppnum esex erace eorigin tage ems eeducate eppidx errp thh* rhhuscbt srotaton 
sort ssuid epppnum
save sipp96t12_mio.dta, replace


*****************Longitudinal files
clear
run sip96l1
keep rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2 ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l1_mio.dta, replace

clear
run sip96l2
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l2_mio.dta, replace

clear
run sip96l3
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l3_mio.dta, replace
merge ssuid epppnum using sipp96t3_mio.dta
save sipp96l3_mio.dta, replace

clear
run sip96l4
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l4_mio.dta, replace

clear
run sip96l5
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l5_mio.dta, replace

clear
run sip96l6
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l6_mio.dta, replace
merge ssuid epppnum using sipp96t6_mio.dta
save sipp96l6_mio.dta, replace

clear
run sip96l7
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l7_mio.dta, replace

clear
run sip96l8
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l8_mio.dta, replace

clear
run sip96l9
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l9_mio.dta, replace
merge ssuid epppnum using sipp96t9_mio.dta
save sipp96l9_mio.dta, replace

clear
run sip96l10
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l10_mio.dta, replace

clear
run sip96l11
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l11_mio.dta, replace

clear
run sip96l12
keep ebmnth tbyear rmesr efnp efrefper efspouse eftype rfchange swave ssuseq eeducate ssuid rhcalmn rhcalyr tfipsst ehhnumpp rhtype etenure thearn thtotinc thunemp efkind rfnkids tfearn tftotinc tfunemp epppnum ebmnth tbyear esex erace eorigin tage errp ems epnspous tpearn tptotinc epdjbthn ejobcntr ersnowrk rwkesr? tsjdate? tejdate? ersend? ejbhrs? eclwrk? tpmsum? tpyrate? ejbind? tjbocc? euectyp5 euectyp7 er05 er07  ecrmth rmedcode ecdmth ehimth rprvhi lgtmon epayhr* eafever eafnow eenlevel  renrlma renroll epatyn epdjbthn ejobsrch ejobtrn eeveret edisabl srotaton  ejobcntr ebuscntr eptresn er10 er05 er07 er08   euectyp5 euectyp7 ebiznow1 ebiznow2 ebno1 ebno2 epropb1 epropb2 tprftb1 tprftb2 epartb11 epartb12 tempb1 tempb2 tbmsum1 tbmsum2 eoincb1 eoincb2  ///
eeno1 eeno2 estlemp1 estlemp2
rename rhcalmn month
rename rhcalyr year
sort ssuid epppnum
rename tfipsst state
save sipp96l12_mio.dta, replace
merge ssuid epppnum using sipp96t12_mio.dta
save sipp96l12_mio.dta, replace

clear all
set more off
use sipp96l1_mio.dta, replace
append using sipp96l2_mio.dta
append using sipp96l3_mio.dta
append using sipp96l4_mio.dta
append using sipp96l5_mio.dta
append using sipp96l6_mio.dta
append using sipp96l7_mio.dta
append using sipp96l8_mio.dta
append using sipp96l9_mio.dta
append using sipp96l10_mio.dta
append using sipp96l11_mio.dta
append using sipp96l12_mio.dta
sort ssuid epppnum swave
compress
save sipp96_total.dta, replace


******************************************************************************************************


//	use sipp96_total.dta, replace
	
	* (1) SELECTING THE INITIAL SAMPLE
	keep if efkind==1
	destring epppnum, gen(codind)
	keep if codind==efrefper | codind==efspouse
	drop if rhtype>1
	keep if codind==101 | codind==102

	* date of birth
	gen moh=.
	replace moh=ebmnth if esex==1
	gen mow=.
	replace mow=ebmnth if esex==2
	gen yeh=.
	replace yeh=tbyear if esex==1
	gen yew=.
	replace yew=tbyear if esex==2
	
	* (2) GENERATING LABOR STATUS: =1 IF EMPLOYED, =0 IF NOT EMPLOYED (INCLUDED OUT OF THE LABOR FORCE)
	gen hebien=rmesr<=3
	replace hebien=. if esex==2
	
	gen webien=rmesr<=3
	replace webien=. if esex==1

	gen he=hebien
	drop hebien
	gen we=webien
	drop webien
	
	* (3) REASON FOR BEING NOT-EMPLOYED: la mayoría hace quit!!
	gen hreason1=.
	replace hreason1=1 if ersend1==1 /*layoff*/
	replace hreason1=2 if (ersend1>=8 & ersend1<=11) | ersend1==13 /* fired */
	replace hreason1=3 if ersend1==12 | ersend1==14 | ersend1==15 /* quit */
	replace hreason1=4 if ersend1>=2 & ersend1<=7 /* quit OLF */
	
	gen hreason2=.
	replace hreason2=1 if ersend2==1 /*layoff*/
	replace hreason2=2 if (ersend2>=8 & ersend2<=11) | ersend2==13 /* fired */
	replace hreason2=3 if ersend2==12 | ersend2==14 | ersend2==15 /* quit */
	replace hreason2=4 if ersend2>=2 & ersend2<=7 /* quit OLF */

	g left1=-1 if hreason1==.
	replace left1=1 if hreason1==3 | hreason1==4
	replace left1=0 if hreason1==1 | hreason1==2

	g left2=-1 if hreason2==.
	replace left2=1 if hreason2==3 | hreason2==3
	replace left2=0 if hreason2==1 | hreason2==2
	
		
	* (4) COMPUTING LABOR INCOME
	gen ylh=.
	replace ylh=tpmsum1 if esex==1 & ((tpmsum1>tpmsum2 & ~missing(tpmsum1) & ~missing(tpmsum2)) | (~missing(tpmsum1) & tpmsum2==.))
	replace ylh=. if he==0
	gen ylw=.
	replace ylw=tpmsum1 if esex==2 & ((tpmsum1>tpmsum2 & ~missing(tpmsum1) & ~missing(tpmsum2)) | (~missing(tpmsum1) & tpmsum2==.))
	replace ylw=. if we==0

	g hjob=.
	g wjob=.
	replace hjob=1 if esex==1 & ~missing(tpmsum1)
	replace wjob=1 if esex==2 & ~missing(tpmsum1)	

	
	replace hjob=2 if ylh==0 & esex==1 & he==1  & ((tpmsum1<=tpmsum2 & ~missing(tpmsum1) & ~missing(tpmsum2)) | (~missing(tpmsum2) & tpmsum1==.))

	replace ylh=tpmsum2 if ylh==0 & esex==1 & he==1 & ((tpmsum1<=tpmsum2 & ~missing(tpmsum1) & ~missing(tpmsum2)) | (~missing(tpmsum2) & tpmsum1==.))

	replace hjob=1 if ylh==0 & esex==1 & he==1 & ~missing(tpyrate1)	 & ((ejbhrs1>ejbhrs2 & ~missing(ejbhrs1) & ~missing(ejbhrs2)) | (~missing(ejbhrs1) & ejbhrs2==.))
		
	replace ylh=tpyrate1*(4.34)*ejbhrs1 if ylh==0 & esex==1 & he==1
	
	replace hjob=2 if ylh==0 & esex==1 & he==1 & ~missing(tpyrate2)	 & ((ejbhrs1<=ejbhrs2 & ~missing(ejbhrs1) & ~missing(ejbhrs2)) | (~missing(ejbhrs2) & ejbhrs1==.))
		
	replace ylh=tpyrate2*(4.34)*ejbhrs2 if ylh==0 & esex==1 & he==1

	replace ylh=tpearn if  ylh==0 & esex==1 & he==1
	
	* we drop observations with zeros in labor income
	drop if ylh==0 & esex==1 & he==1

	
	replace wjob=2 if ylh==0 & esex==2 & we==1 & ((tpmsum1<=tpmsum2 & ~missing(tpmsum1) & ~missing(tpmsum2)) | (~missing(tpmsum2) & tpmsum1==.))
	
	replace ylw=tpmsum2 if ylw==0 & esex==2 & we==1 & ((tpmsum1<=tpmsum2 & ~missing(tpmsum1) & ~missing(tpmsum2)) | (~missing(tpmsum2) & tpmsum1==.))
	
	replace wjob=1 if ylh==0 & esex==2 & we==1 & ~missing(tpyrate1)	 & ((ejbhrs1>ejbhrs2 & ~missing(ejbhrs1) & ~missing(ejbhrs2)) | (~missing(ejbhrs1) & ejbhrs2==.))
	
	replace ylw=tpyrate1*(4.34)*ejbhrs1 if ylw==0 & esex==2 & we==1
	
	replace wjob=2 if ylw==0 & esex==2 & we==1 & ~missing(tpyrate2)	 & ((ejbhrs1<=ejbhrs2 & ~missing(ejbhrs1) & ~missing(ejbhrs2)) | (~missing(ejbhrs2) & ejbhrs1==.))
	
	replace ylw=tpyrate2*(4.34)*ejbhrs2 if ylw==0 & esex==2 & we==1
	

	replace ylw=tpearn if  ylw==0 & esex==2 & we==1

	* we drop observations with zeros in labor income
	drop if ylw==0 & esex==2 & we==1
	
	
	* (5) DEFINING EMPLOYMENT STATUS AND WEALTH
	g hemp=eeno1 if esex==1 & hjob==1
	replace hemp=eeno2 if esex==1 & hjob==2	
	g wemp=eeno1 if esex==2 & wjob==1	
	replace wemp=eeno2 if esex==2 & wjob==2

	g hleft=left1 if esex==1 & hjob==1
	replace hleft=left2 if esex==1 & hjob==2	
	g wleft=left1 if esex==2 & wjob==1	
	replace wleft=left2 if esex==2 & wjob==2
	
		
	gen byte holf=0
	replace holf=1 if he==0 & rmesr==8
	
	gen byte wolf=0
	replace wolf=1 if we==0 & rmesr==8

	rename thhtnw networth
	rename thhtwlth wealth

	* (6) JOINING DATA FOR COUPLES
	sort ssuid swave year month epppnum
	by ssuid swave year month: gen n=_n 
	drop if n==1 & n[_n+1]!=2
	by ssuid swave year month: gen webien=we[_n+1] if we==. & we[_n+1]<. 
	by ssuid swave year month: gen hebien=he[_n+1] if he==. & he[_n+1]<. 
	by ssuid swave year month: replace hebien=he if he<. & hebien==. 
	by ssuid swave year month: replace webien=we if we<. & webien==.  

	by ssuid swave year month: gen wolfbien=wolf[_n+1] if wolf==. & wolf[_n+1]<. 
	by ssuid swave year month: gen holfbien=holf[_n+1] if holf==. & holf[_n+1]<. 
	by ssuid swave year month: replace holfbien=holf if holf<. & holfbien==. 
	by ssuid swave year month: replace wolfbien=wolf if wolf<. & wolfbien==.  

	by ssuid swave year month: gen ylwbien=ylw[_n+1] if ylw==. & ylw[_n+1]<. 
	by ssuid swave year month: gen ylhbien=ylh[_n+1] if ylh==. & ylh[_n+1]<. 
	by ssuid swave year month: replace ylhbien=ylh if ylh<. & ylhbien==. 
	by ssuid swave year month: replace ylwbien=ylw if ylw<. & ylwbien==.  

	
	by ssuid swave year month: gen mohbien=moh[_n+1] if moh==. & moh[_n+1]<. 
	by ssuid swave year month: gen mowbien=mow[_n+1] if mow==. & mow[_n+1]<. 
	by ssuid swave year month: replace mohbien=moh if moh<. & mohbien==. 
	by ssuid swave year month: replace mowbien=mow if mow<. & mowbien==. 

	by ssuid swave year month: gen yehbien=yeh[_n+1] if yeh==. & yeh[_n+1]<. 
	by ssuid swave year month: gen yewbien=yew[_n+1] if yew==. & yew[_n+1]<. 
	by ssuid swave year month: replace yehbien=yeh if yeh<. & yehbien==. 
	by ssuid swave year month: replace yewbien=yew if yew<. & yewbien==. 

	by ssuid swave year month: gen wleftbien=wleft[_n+1] if wleft==. & wleft[_n+1]<. 
	by ssuid swave year month: gen hleftbien=hleft[_n+1] if hleft==. & hleft[_n+1]<. 
	by ssuid swave year month: replace hleftbien=hleft if hleft<. & hleftbien==. 
	by ssuid swave year month: replace wleftbien=wleft if wleft<. & wleftbien==.  

	
	by ssuid swave year month: gen wempbien=wemp[_n+1] if wemp==. & wemp[_n+1]<. 
	by ssuid swave year month: gen hempbien=hemp[_n+1] if hemp==. & hemp[_n+1]<. 
	by ssuid swave year month: replace hempbien=hemp if hemp<. & hempbien==. 
	by ssuid swave year month: replace wempbien=wemp if wemp<. & wempbien==.  

	by ssuid swave year month: gen wjobbien=wjob[_n+1] if wjob==. & wjob[_n+1]<. 
	by ssuid swave year month: gen hjobbien=hjob[_n+1] if hjob==. & hjob[_n+1]<. 
	by ssuid swave year month: replace hjobbien=hemp if hjob<. & hjobbien==. 
	by ssuid swave year month: replace wjobbien=wemp if wjob<. & wjobbien==.  

	keep if n==1

	* (7) SELECTING THE VARIABLES AND THE SAMPLE: aged 25-50

	drop  wolf holf we he ylh ylw n _merge moh mow yeh yew hleft wleft hemp wemp hjob wjob ebmnth tbyear

	rename mohbien moh
	rename mowbien mow
	rename yehbien yeh
	rename yewbien yew

	rename hebien he
	rename webien we
	rename ylhbien ylh
	rename ylwbien ylw
	rename holfbien holf
	rename wolfbien wolf

	rename hleftbien hleft
	rename wleftbien wleft
	rename hempbien hemp
	rename wempbien wemp
	rename hjobbien hjob
	rename wjobbien wjob
		
	*****************************
	recode hleft .=-1
	recode wleft .=-1
	recode holf .=-1
	recode wolf .=-1
	
	*****************************	
	gen time=(year-1995)*12+month-11
	gen timew=4*swave+srotaton-1

	replace wealth=. if time~=timew
	replace networth=. if time~=timew
	
	drop if tage<=25 | tage>50
	compress

	save family_sample.dta, replace

	
	
**GENERATING ESTIMATION SAMPLES

//use family_sample.dta, replace
set more off

*(1) SAMPLING CRITERIA

	*drop if ever in armed forces
	keep if eafever ==2

	*drop if enrolled
	keep if renroll==3
	
	*no welfare
	keep if epatyn==2
	drop if ejobsrch==1
	
	*no disabled
	keep if edisabl==2

	*ever retired
	drop if eeveret==1
	
	*Contingent workers 
	drop if ejobcntr==0
	
	*Contingent business 
	drop if ebuscntr==0

	*Business
	keep if ebiznow1==-1
	keep if ebiznow2==-1
	keep if ebno1==-1
	keep if ebno2==-1
	keep if epropb1==-1
	keep if epropb2==-1
	keep if tprftb1==0
	keep if tprftb2==0
	keep if epartb11==-1
	keep if epartb12==-1
	keep if tempb1==-1
	keep if tempb2==-1
	keep if tbmsum1==0
	keep if tbmsum2==0
	keep if eoincb1==-1
	keep if eoincb2==-1


*(2) GENERATING THE ESTIMATION SAMPLES

	gen eduhigh=eeducate>=44

	*number of children
	g hijos=1 if rfnkids==0 | rfnkids==1       /* zero or one child*/
	replace hijos=2 if rfnkids>=2 & ~missing(rfnkids)   /* two or more children*/

	forval i=1/2{                // Education
	forval j=1/2{               //Children

	preserve

	//Education
	if `i'==1{     					//only High School Graduates
	local edu "h"
	keep if eeducate==39    //highschool
	}
	else if `i'==2{                           // only University degrees
	local edu "u"
	keep if eeducate>=44  
	}

	//Hijos 
	keep if hijos==`j'   // seleccion segun numero de hijos

	quietly by ssuid: g t=_n
	sort ssuid  swave  year  month  epppnum
	sort t ssuid
	quietly by t: g i=_n
	sort ssuid  swave  year  month  epppnum
	quietly by ssuid: replace i=i[_n-1] if t~=1

	destring ssuid, replace

	sort i t
	quietly by i: gen wolfsum=sum(wolf)
	quietly by i: gen holfsum=sum(holf)
	quietly by i: replace wolfsum=wolfsum[_N]
	quietly by i: replace holfsum=holfsum[_N]
	
	quietly by i: gen ttot=t[_N]
	drop if ttot<8
	

	quietly by i: gen wealthsum=sum(wealth)
	quietly by i: replace wealthsum=wealthsum[_N]
	drop if wealthsum==0
	drop wealthsum

	recode wealth .=-9
	gen iwealth=0
	replace iwealth=1 if wealth~=-9 & wealth~=0
	quietly by i: gen iwsum=sum(iwealth)
	quietly by i: replace iwsum=iwsum[_N]
	drop if iwsum==0

	
	replace ylw=0 if ylw==. & we==0
	replace ylh=0 if ylh==. & he==0
	replace ylw=0 if ylw==. 
	replace ylh=0 if ylh==.
	replace we=0 if we==.
	replace he=0 if he==.

	sort i t
	quietly by i: gen i1=1 if _n==_N
	summ i1
	
	do "deflator"	
	replace ylh=100*ylh/cpi
	replace ylw=100*ylw/cpi
	replace wealth=100*wealth/cpi if wealth~=-9
	

	replace wealth=round(wealth)	
	replace ylh=round(ylh)	
	replace ylw=round(ylw)	
	compress
	************************
	* Evaluating ee' transitions
	g hee=-1
	by i: replace hee=0 if he==1 & he[_n-1]==1 & hemp==hemp[_n-1] & hemp>0 & hemp ~=. & hemp[_n-1]>0 & hemp[_n-1] ~=.
	by i: replace hee=1 if he==1 & he[_n-1]==1 & hemp~=hemp[_n-1] & hemp>0 & hemp ~=. & hemp[_n-1]>0 & hemp[_n-1] ~=.

	g wee=-1
	by i: replace wee=0 if we==1 & we[_n-1]==1 & wemp==wemp[_n-1] & wemp>0 & wemp ~=. & wemp[_n-1]>0 & wemp[_n-1] ~=.
	by i: replace wee=1 if we==1 & we[_n-1]==1 & wemp~=wemp[_n-1] & wemp>0 & wemp ~=. & wemp[_n-1]>0 & wemp[_n-1] ~=.

	* Evaluating ee' transitions
	g hleft1=-1
	by i: replace hleft1=hleft[_n-1] if he[_n-1]==1 

	g wleft1=-1
	by i: replace wleft1=wleft[_n-1] if we[_n-1]==1 

	****************************	
*	! Selecting samples
	****************************	
 
	keep i t he we hee wee hleft1 wleft1 holf wolf ylh ylw wealth age	
	outfile i t he we hee wee hleft1 wleft1 holf wolf ylh ylw wealth using "${finaloutput}\jsdatx_`j'`edu'c.out", wide replace	nol

	restore 
	} // j children
	} // i educacion


capture log close
