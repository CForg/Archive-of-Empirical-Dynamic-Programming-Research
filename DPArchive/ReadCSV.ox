#include "ReadCSV.h"

ReadCSV::Parse(H) {
	decl eos,token,delim;
	newrow = {};
	do {
		eos = sscan(&entry,"%T",&token);
		if (eos!=-1) {
			eos = sscan(&entry,"%c1",&delim);
			newrow |= entry;
			}
		} while (eos!=-1);
	return newrow;
	}
	
ReadCSV::ReadCSV(fn,HorL,delimiter) {
	decl f, rc;
	f = fopen(fn);
	if (!isfile(f))
		oxrunerror("Fail to open CSV file: "+fn);
	this.delimiter = delimiter;
	if (isarray(HorL)) {
		labels = HorL;
		}
	else {
		if (HorL) {
			rc = fscan(f,"%z",&entry);
			labels = Parse(TRUE);		//skip labels at top of file
			}
		else 
			labels = {};
		}
	K = sizeof(labels);
	N=0; 
	data = {};
	do {
		rc = fscan(f,"%z",&entry);
		if (rc>0) {
    		newrow = Parse();
			if (party < 0) party = Nparties-1;
//			println(N," ",rnum," ",party," ",votes," ",pct," ",party);
    		votemat[rnum-1][party] += pct;				// start riding numbers at 0
			++N;
			}
		} while(r>0);
	fclose(f);
	println("%c",plabels,votemat);
	savemat("Votes218",votemat);
}

	