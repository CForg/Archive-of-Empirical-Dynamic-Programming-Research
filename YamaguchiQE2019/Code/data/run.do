quietly do read.do
use ../dta/jpsc-raw.dta, clear

quietly do hhcomp.do
quietly do delivery.do
quietly do educ.do
quietly do work.do
quietly do income.do
quietly do location.do
quietly do asset.do
/* quietly do childcare.do */

use /tmp/hhcomp.dta, clear

merge 1:1 id panel using /tmp/delivery.dta
drop _merge

merge 1:1 id panel using /tmp/educ.dta
drop _merge

merge 1:1 id panel using /tmp/work.dta
drop _merge

merge 1:1 id panel using /tmp/income.dta
drop _merge

merge 1:1 id panel using /tmp/location.dta
drop _merge

merge 1:1 id panel using /tmp/asset.dta
drop _merge

/* merge 1:1 id panel using /tmp/childcare.dta */
/* drop _merge */

save /tmp/jpsc.dta, replace

do make-panel.do
