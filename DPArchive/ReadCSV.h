#include "oxstd.h"

struct ReadCSV {
	enum{DOUBLE,INTEGER,STRING,Ntypes}	 
	const decl delimiter, N, K, labels, types, data;
	ReadCSV(fn,HorL=TRUE,delimiter=",");
	Get(vCorL);
	Print(vCorL);
	Parse(entry,H=FALSE);
	}

