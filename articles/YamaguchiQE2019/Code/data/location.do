use ../dta/jpsc-raw.dta, clear

/*** metropolitan status ***/
rename q3 place
gen metro = place == 1

/*** save outcomes ***/
order id panel place metro
keep  id panel place metro
sort  id panel
save /tmp/location.dta, replace
