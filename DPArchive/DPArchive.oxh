#include "oxstd.h"
						enum{DOALL=-1,NOMATCH=-1}
						enum{ TI , AU , UR , AR , AB, LA, NCommon}
						enum{ DI=NCommon, JO , YR , NPubTokens}
						enum{ NRelatedTokens=NCommon}
static const decl clabels= {"title","author","url","area","abstract","language"},
				  plabels= {"doi","journal","year"},
                  stylesheets = "<link href=\"https://cdn.jsdelivr.net/npm/bootstrap@5.1.1/dist/css/bootstrap.min.css\" rel=\"stylesheet\"></link><link rel=\"stylesheet\" href=\"./screen.css\"/><link rel=\"stylesheet\" href=\"./doc.css\"/>",
				 EXT="ark", AT = '@', LC="{", RC="}",QT='"', EQ="=",CM=",",
				 SRC="source", INC="include", LAQ="«", RAQ="»",
                 uplevel="..",docdir="docs/"
                ;

static decl apath, numitems;
		
struct Entry {
 	enum{ FIELD, TAG, VALUE, CODE, NBib}

	const decl ind, tlabels, tokens, entrytag, folder, arkfile, hascode ;
	decl N;

	#include "AREAS.oxh"		
	#include "LANGUAGES.oxh"
	#include "JOURNALS.oxh"

	static GetToke(toke);
            Entry(fldr,arkf,f);
			Process(f);
			body(line);
			scan(f,aL);
			match(tags,intag,frag=-1,strips={});
	virtual Attribute(item);
	virtual Write(ifile);
	}

struct Publication : Entry {
				
    virtual Attribute(item);
 	virtual Write(ifile);

	}

	
struct Article : Publication {

        enum{ LG = NPubTokens, EO , BE , CL , AV , SV, FG, UT, MT , UD, NTokenTypes }	
	static const decl
		alabels =  {"language","parameter-selection","bellman","clock","action","state","group","utility","method"};

	static const decl
		phs = {"MyModel","BaseClass"},
		vars = {"CLK","AV","SV","RE","FE"},
		preargs = {"INIT","CS","CLK"},
		roots = {"CREATE","LIST"};

		
/*	#include "BELLMAN.oxh"
	#include "CLOCK.oxh"
	#include "STATEVARIABLE.oxh"
	#include "TIMEINVARIANT.oxh"
	#include "METHOD.oxh" */
	enum {OC,OL,ON,OPARS,NniqlowTags}
			Article(fldr,a,f);
    		Attribute(item);
			MakeStarterCode();
 	        Write(ifile);

	}

struct Related : Entry {
	}
	
struct Package : Related {
	enum{UD=NRelatedTokens,NTokenTypes};
	Package(fldr,a,f);
    //Attribute(item);
	}

struct Site : Entry {
	enum{UD=NRelatedTokens,NTokenTypes};
	Site(fldr,a,f);
    //Attribute(item);
	}

struct Survey : Publication {
	enum{UD=NPubTokens,NTokenTypes};
	Survey(fldr,a,f);
	//Attribute(item);
	}
	
struct DPArchive {

	enum {Item_art,Item_surv,Item_pack,Item_site,UD,NTokenTypes}

	static const decl tlabels =
				  {"article","survey","package","site"};

	static decl archive;
	static ReadJEL(fn="");
	static CreateArchive(rootdir,items=DOALL);
	static CheckType(f,t,atag);
	}
	
