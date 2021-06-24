#include "DPArchive.oxh"

/** Find intag in tags OR find first frag character.
    Otherwise return sizeof(tags) which should be associated with an undefined tag
**/
Entry::match(tags,intag,frag,strips) {
	decl rc = strifind(tags,intag), t;
	if (rc>=0) return rc;
	if (frag>=0)
		foreach(t in tags[rc])
			if (strifind(t[:frag],intag[:frag])==0) return rc;
	if (sizeof(strips)) {
		foreach (t in strips)
			intag = replace(intag,t+" ","","i*");
		rc = strifind(tags,intag);
		if (rc>=0) return rc;			
		}
	return  sizeof(tags);		
	}

/** Find { or \" then match from end of string.
Return string in between.**/
Entry::body(line) {
	decl lft, rght, rsym;
	lft = strfind(line,LC);
	if (lft==NOMATCH) {
		lft = strfind(line,QT);
		if (lft==NOMATCH) {
			lft = strfind(line,EQ);
			if (lft==NOMATCH) return "";
			rsym = CM;
			}
		else
			rsym = QT;
		}
	else rsym = RC;
	rght = strfindr(line,rsym);
	return line[lft+1 : max(lft+1,rght-1) ];
	}

Entry::scan(f,aL) {
 	return isfile(f) ? fscan(f,"%z",aL) : sscan(f,"%z",aL);
	}

Entry::Attribute(aIT) {
	aIT[0][TAG] = match(this.tlabels,aIT[0][FIELD]);
    }
	
Article::Attribute(aIT) {
    Entry::Attribute(aIT);
//	aIT[0][TAG] = match(tlabels,aIT[0][FIELD]);
	decl g;
	switch_single(aIT[0][TAG]) {
		case UR : ;
		case AU : ;
		case JO :	//Look for journal title match
					{aIT[0][CODE] = match(jlabels,aIT[0][VALUE],-1,{"THE"});}
		case AR :	//look for research area match
					{aIT[0][CODE] = match(alabels,aIT[0][VALUE],3);}
		case YR :
					{sscan(aIT[0][VALUE],"%i",&g); aIT[0][CODE]=g;}
		case LG :	// Look for coding language
					{aIT[0][CODE] = match(llabels,aIT[0][VALUE]+"  ",3);}
		default :
		}
	}

Entry::Process(f) {
	decl eos, line, newitem, fld, lc;
	N = 0;
 	do {
 		eos = scan(f,&line);
		if (eos>=0) {
			lc = sscan(&line," %t",&fld);	//find token skipping whitespace
			if (fld==RC)
				break;  //end of entry, } first token
			newitem = new array[NBib];
			newitem[FIELD] = fld;
			newitem[VALUE] = body(line);
			this->Attribute(&newitem);
			if (tokens[newitem[TAG]]==.Null)
				tokens[newitem[TAG]] = {newitem};
			else
				tokens[newitem[TAG]] |= {newitem};
			++N;
			}
	  	else
	  		oxwarning("closing bracket for entry not found");
 		} while (eos>=0);
	}

Entry::Entry(fldr,arkf,f) {
	entrytag = fldr;
	arkfile = arkf;
    tlabels = NOMATCH;
    }

Article::Article(fldr,arkf,f) {
    Entry(fldr,arkf,f);
	tlabels = clabels | plabels | alabels;
    tokens =  new array[NTokenTypes];	 //different types by item
	hascode = sizeof(getfolders("code"))>0;
	}
	
Package::Package(fldr,arkf,f) {
    Entry(fldr,arkf,f);
	if (isint(tlabels)) tlabels = clabels;
    tokens =  new array[NTokenTypes];
	}

Site::Site(fldr,arkf,f) {
    Entry(fldr,arkf,f);
	tlabels = clabels;
    tokens =  new array[NTokenTypes];
	}

Survey::Survey(fldr,arkf,f) {
    Entry(fldr,arkf,f);
	tlabels = clabels | plabels;
    tokens =  new array[NTokenTypes];		
	}

Entry::GetToke(toke) {
	return toke==.Null ? "." : toke[0][VALUE];
	}

Entry::Write(ifile) {
	fprint(ifile,"<tr class=\"item\" id=\"",entrytag,"\"><td>");
	if (tokens[UR]==.Null)
		fprint(ifile,entrytag);
	else
		fprint(ifile,"<a target=\"_blank\" href=\"",tokens[UR][0][VALUE],"\">",entrytag,"</a>");
    fprint(ifile,"</td>");
    }

Article::Write(ifile) {
	decl t, j, i, k, detailf;
    Entry::Write(ifile);
//	println(tokens);
	fprintln(ifile,"<td>",tokens[YR][0][VALUE],
				   "</td><td>",GetToke(tokens[AR]),
				   "</td><td>",jabb[tokens[JO][0][CODE]],
				   "</td><td>",GetToke(tokens[LG]),
				   "</td><td>",hascode ? "Y" : "N","</td>");
	fprintln(ifile,"<td><a href=\"",apath,".html\""," target=\"details\">&#8227;</a></td></tr>");
    detailf = fopen("../../"+docdir+apath+".html","w");      //current directory is no
	for(j=0;j<sizeof(tokens);++j) if (!ismissing(tokens[j])) {
		t = tokens[j];
		fprint(detailf,"<DT>",j<sizeof(tlabels) ? tlabels[j] : "Undefined</DT>" );
		foreach (i in t) if (!ismissing(i))	{
			if ( !(i[VALUE] == .Null) )
				fprint(detailf,"<DD>'",i[VALUE],"'</DD>");
			else
				fprint(detailf,"<DD>.</DD>");
			}
		}
    fclose(detailf);
	}
	
Article::MakeStarterCode() {
   //open .oxh for writing and MyModel.oxh for reading

    // replace meta values with actual
	
   //open .ox for writing	and MyModel.ox for reading

   //open main for writing and main.ox for reading

	}

DPArchive::CheckType(f,t,atag) {
	decl line,lc,type,rc;
 	do {  //look for @ in 1st column
		rc =fscan(f,"%z",&line);
 		if (rc==NOMATCH) {
			return FALSE; //not  found
			}
	  sscan(&line,"%c1",&lc);
	} while (lc!=AT);
 	sscan(&line," %t",&type);  //should check if type==item type OR make this determine the type
 	atag[0] = line[1:strfindr(line,CM)-1];
	return strifind(tlabels,type)==t ;
	}
	
DPArchive::CreateArchive(rootdir,todo)  {
 if (!isint(archive)) oxrunerror("Archive already created");
 decl root,t,a,tag,fldr,arks,f,n,folders,rootf,rfiles,item,tocf,numitems,artexists;

 archive = new array[sizeof(tlabels)];
 rfiles  = new array[sizeof(tlabels)];

 chdir(rootdir);
 rootf = fopen(docdir+"archive.html","w");
 tocf = fopen(docdir+"toc.html","w");
 fprintln(tocf,"<HTML><head>",stylesheets,"</head><body><div><UL class=\"rmenu\">");
 foreach(root in tlabels[t]) if (todo==DOALL || t==todo) {
 	archive[t] = {};  // intialize list of this type

	fldr = root+"s";

	//delete docs/fldr
	rfiles[t] = fopen(docdir+fldr+".html","w");
	fprintln(rfiles[t],"<HTML><head>",stylesheets,"</head><body><script src=\"https://www.kryogenix.org/code/browser/sorttable/sorttable.js\"></script><table class=\"niqsum sortable\" id=\"",fldr,"\">");
	fprintln(rfiles[t],"<tr><th>Tag</th><th>Year</th><th>Area</th><th>JO</th><th>Lang.</th><th>Code</th><th>Details</th></tr>");
 	chdir(fldr);
	folders = getfolders("*");
    numitems = 0;
	foreach (item in folders) {
		chdir(item);
/*        if (chdir("articles")) {                // articles subdirectory exists ...
            chdir("..");                        // go back up
            systemcall("erase /q /s articles");
            systemcall("rmdir /q /s articles");
            }*/
        apath = fldr+"/"+item;                  // name of detail file over in docs (used both relative and as anchor)
		arks = getfiles("*."+EXT);
		foreach (a in arks) {
			f = fopen(a);
			if (!isfile(f) || !CheckType(f,t,&tag)) {
				oxwarning("File not opened or Type Does Not Match: "+a);
                continue;
                }
			switch_single(t) {
				case Item_art : n = new Article(item,a,f);
				case Item_surv: n = new Survey(item,a,f);
				case Item_pack: n = new Package(item,a,f);
				case Item_site: n = new Site(item,a,f);
				}
            ++numitems;
			n -> Process(f);
			n.folder = fldr;
			n.arkfile = a;
			archive[t] |= n;
			fclose(f); f = 0;
			n->Write(rfiles[t]); //uplevel+"/docs/"+fldr+"/"+item+".html",
			}
		chdir(uplevel);
		}
	 chdir(uplevel);
     fprintln(tocf,"<li class=\"tooltip\"><a href=\"",fldr,".html\" target=\"content\">",fldr,"<br/>&nbsp;[",numitems,"]&nbsp;</li>");
     fprintln(rfiles[t],"</table></body></html>");
	 fclose(rfiles[t]); rfiles[t]=0;

 	}
  fclose(rootf);
  /* afiles = new array[AREACODES];
    for (a=0;a<AREACODES) afiles[a] = fopen("areas.html","w");
    fprintln(afiles[a],"<HTML><head>",stylesheets,"</head><body><script src=\"https://www.kryogenix.org/code/browser/sorttable/sorttable.js\"></script><table class=\"niqsum sortable\" id=\"",fldr,"\">");
    fprintln(afiles[a],"</table></body></html>");
  */
  fprintln(tocf,"</UL></div>");
  fclose(tocf);
  }	
	
