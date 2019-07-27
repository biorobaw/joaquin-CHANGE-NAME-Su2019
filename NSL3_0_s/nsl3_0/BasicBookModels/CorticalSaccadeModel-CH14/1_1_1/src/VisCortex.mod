/* SCCS  @(#)VisCortex.mod	1.2 --- 09/22/99 -- 23:21:01 */

/*VisCortex
* Burst Neurons
* @see VisCortex.nslm
* @version 98/6/18
* @author Dominey and Alexander
*
*/
nslImport nslAllImports;

nslModule VisCortex(int stdsz){

// ports
public NslDinFloat2 retina (stdsz,stdsz);
public NslDoutFloat2 posteriorParietal(stdsz,stdsz);

//parameters
private NslFloat0 posteriorParietal_tm();  
private NslFloat0 arrMT_tm();  
private NslFloat0 arrV4_tm();  
private NslFloat0 arrV2_tm();  
private NslFloat0 arrV1_tm();  
private NslFloat0 arrLGN_tm();  

//vars
private NslFloat2 arrMT(stdsz,stdsz);  
private NslFloat2 arrV4(stdsz,stdsz);  
private NslFloat2 arrV2(stdsz,stdsz);  
private NslFloat2 arrV1(stdsz,stdsz);  
private NslFloat2 arrLGN(stdsz,stdsz);  


public void initModule() {	
}

public void initRun() {       
       posteriorParietal=0;
       arrMT=0;
       arrV4=0;
       arrV2=0;
       arrV1=0;
       arrLGN=0;

	 posteriorParietal_tm= 0.006;  
	 arrMT_tm= 0.006;  
	 arrV4_tm= 0.006;
	 arrV2_tm= 0.006;  
	 arrV1_tm= 0.006;  
	 arrLGN_tm= 0.006;  
}
public void simRun() {
	if (system.debug>=16) {
	nslPrintln("debug: VisCortex: retina "+retina);
	}

	posteriorParietal=nslDiff(posteriorParietal,posteriorParietal_tm,- posteriorParietal + arrMT);
	arrMT=nslDiff(arrMT,arrMT_tm, - arrMT + arrV4);
	arrV4=nslDiff(arrV4,arrV4_tm, - arrV4 + arrV2);
	arrV2=nslDiff(arrV2,arrV2_tm, - arrV2 + arrV1);
	arrV1=nslDiff(arrV1,arrV1_tm, - arrV1 + arrLGN);
	arrLGN=nslDiff(arrLGN,arrLGN_tm, - arrLGN + retina);

	if (system.debug>=16) {
	nslPrintln("VisCortex: simRun: posteriorParietal ");
	nslPrintln(posteriorParietal);
	}


}
}



