/* SCCS  %W%---%G%--%U% */
/* old @(#)CrowleyOut.mod	1.5 -- 08/05/99 -- 13:56:13 */
// DomOutDisplay
// This is the module that displays all of the output graphs in a NslFrame

nslImport nslAllImports;

nslModule CrowleyOut(int CorticalArraySize, int StriatalArraySize) extends NslOutModule () {


//input ports
/*
public 	NslDinFloat2 visinput(CorticalArraySize,CorticalArraySize);
public 	NslDinFloat2 pfcGo(CorticalArraySize,CorticalArraySize);
public 	NslDinFloat2 lipMem(CorticalArraySize,CorticalArraySize);
public 	NslDinFloat2 thna(CorticalArraySize,CorticalArraySize);
public 	NslDinFloat2 fefsac(CorticalArraySize,CorticalArraySize);
public 	NslDinFloat2 scsac(CorticalArraySize,CorticalArraySize);
public 	NslDinFloat2 scbu(CorticalArraySize,CorticalArraySize);
*/

//privates
private	boolean goodstatus=false; //false=fail; true=success


// The following is used only if you are not using ports
// for communication with this module.
// Was used in debug phase.
private 	NslFloat2 visinput(CorticalArraySize,CorticalArraySize);
private 	NslFloat2 pfcGo(CorticalArraySize,CorticalArraySize);
private 	NslFloat2 lipMem(CorticalArraySize,CorticalArraySize);
private 	NslFloat2 thna(CorticalArraySize,CorticalArraySize);
private 	NslFloat2 fefsac(CorticalArraySize,CorticalArraySize);
private 	NslFloat2 scsac(CorticalArraySize,CorticalArraySize);
private 	NslFloat2 scbu(CorticalArraySize,CorticalArraySize);

public void initModule() {

	// the following is only if you are using
	// nslSetValue(var, charString);
	visinput.nslSetAccess('W');
	pfcGo.nslSetAccess('W');
	lipMem.nslSetAccess('W');
	thna.nslSetAccess('W');
	fefsac.nslSetAccess('W');
	scsac.nslSetAccess('W');
	scbu.nslSetAccess('W');

      if (!(system.getNoDisplay())) {		
	nslAddAreaCanvas(visinput,0,100);
	nslAddAreaCanvas(pfcGo,0,100);
	nslAddAreaCanvas(lipMem,0,100);
	nslAddAreaCanvas(thna,0,100);
	nslAddAreaCanvas(fefsac,0,100);
	nslAddAreaCanvas(scsac,0,100);
	nslAddAreaCanvas(scbu,0,100);
      }  //if not noDisplay
}

public void initRun(){

	if (system.debug>27) {
		nslPrintln("crowleyOut:initRun");
	}
	getValues();
}
public void simRun(){
	getValues();	           
}
public void getValues(){	

	// 99/7/28 aa: the following is commented out because
	// it was only used for debugging and it runs
	// slower than using ports.

         goodstatus=nslSetValue(visinput,"crowleyTop.visinput.visinput_out");
	  if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get visinput"); 
        }
	 goodstatus=nslSetValue(pfcGo,"crowleyTop.pfc.pfcGo");
		 if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get pfcGo"); 
        }
	 goodstatus=nslSetValue(lipMem,"crowleyTop.lip.LIPmem_out");
		 if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get lipMem"); 
        }

	goodstatus=nslSetValue(thna,"crowleyTop.thal1.thlip.THNA_out");
 	if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get thna"); 
        }

	goodstatus=nslSetValue(fefsac,"crowleyTop.fef.FEFsac_out");
 	if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get fefsac"); 
        }

	goodstatus=nslSetValue(scsac,"crowleyTop.sc.SCsac_out");
 	if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get scsac"); 
        }
	goodstatus=nslSetValue(scbu,"crowleyTop.sc.SCbu_out");
 	if (!goodstatus) {
		nslPrintln("crowleyOut: bad status in get scbu"); 
        }
}

} //end class



