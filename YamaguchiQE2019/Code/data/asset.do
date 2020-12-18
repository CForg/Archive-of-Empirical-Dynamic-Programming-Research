use ../dta/jpsc-raw.dta, clear

/*** savings ***/
rename q331 whether_savings
rename q332 savings
rename q333 whether_securities
rename q334 securities

replace savings = 0 if whether_savings == 2
replace securities = 0 if whether_securities == 2

gen asset = savings + securities

/*** save outcomes ***/
keep  id panel asset savings securities
order id panel asset savings securities
sort  id panel
save /tmp/asset.dta, replace


