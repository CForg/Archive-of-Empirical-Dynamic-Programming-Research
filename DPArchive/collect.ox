#include "oxstd.oxh"

enum{cname,cparent,ccall,Natt}

const decl path = "..\\niqlow\\include\\";

collectclasses(hname,alist) {
	decl eof,line,f,parent,child,toke,sym,N=0;
	f = fopen(path+hname+".h");
	do {
		if (fscan(f,"%z",&line)==-1)
			break;
		sscan(&line," %t",&toke);  //assuming struct first token on line
		if (strlwr(toke)=="struct" || strlwr(toke)=="class") {
			println(line);
			sscan(&line," %t",&child);
			sscan(&line," %t",&sym);
			sscan(&line," %t",&parent);
			println("***",parent,"***",alist[0][cname]," ",find(alist[0][cname],parent));
			if (find(alist[0][cname],parent)>=0) {   //parent is on the chain
				alist[0][cname]  |= child;
				println(alist[0][cname]);
				alist[0][cparent]|= parent;
				++N;
				do {
					fscan(f,"%z",&line);
					sscan(&line," %t",&toke," %t",&sym);	//assuming first token
					if (toke==child && sym=="(") { 
						alist[0][ccall] |= "("+line[:strfind(line,")")];
						break;
						}
					} while(toke!="}");
				if (toke=="}") alist[0][ccall] |= "";
				}
			}
		} while(TRUE);
	fclose(f);
	return N;
	}

main() {
	decl clocks,bellmans;
	clocks = new array[Natt];
	clocks[cname] = {"Clock"};
	clocks[cparent]={""};
	clocks[ccall]={"(Nt,Ntprime)"};
	collectclasses("Clock",&clocks);

	bellmans= new array[Natt];
	bellmans[cname] = {"Bellman"};
	bellmans[cparent]={""};
	bellmans[ccall]={""};
	collectclasses("Bellman",&bellmans);
	println(clocks,bellmans);

/*
StateVariable.h 

TimeInvariant.h
*/
	}

