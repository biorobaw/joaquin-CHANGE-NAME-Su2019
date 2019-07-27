h60521
s 00004/00004/00267
d D 1.2 99/09/22 23:20:55 aalx 2 1
c updated for NSL3_0_m and made manual the same as simple
e
s 00271/00000/00000
d D 1.1 99/09/22 22:42:46 aalx 1 0
c date and time created 99/09/22 22:42:46 by aalx
e
u
U
f e 0
t
T
I 1
/* SCCS  %W% --- %G% -- %U% */
/*DomineyModel
* DomineyModel - the model top
* @see  DomineyModel.nslm
* @version 98/6/18
* @author Dominey; code by Alexander
*/
nslImport nslAllImports;

nslModel DomineyModel(){
// ports - none this is the top level
// vars - instances of modules
private int stdsz =9;
private int bigsz =27;
private NslFloat0 nWTAThreshold(70);  //used in DomineyLib.winnerTakeAll

private NslInt0 protocolNum(); // 15 protocolNums

// 15 protocolStrings
private charString protocolString; 

static int numOfDirections=4; // 4 directions, left, right, up, down

// Note these are order dependent:
private VisualInput visualinput1(stdsz,bigsz); 
private StimFEF stimfef1(stdsz);
private StimSC stimsc1(stdsz);

private BrainStem brainStem1(stdsz, numOfDirections, nWTAThreshold);
private Retina retina1(stdsz,bigsz);
private VisCortex viscortex1(stdsz);
private Erasure2 erasure2_1(stdsz);
private PPQV ppqv1(stdsz);
private FEF fef1(stdsz); 
private FON fon1(stdsz); //and FovElem
private BasalGanglia bg1(stdsz); //Caudate and SNR
private SC supcol1(stdsz);
private Thalamus thal1(stdsz);


private DomOutDisplay out1(stdsz,bigsz);

private int curcycle=0;
private double curtime=0;
private double stepsize=0;

public void initSys(){
	system.setRunEndTime(0.7); // most protocols do not need this long
	system.nslSetRunDelta(0.005); // from NSL2.1.7 compensatory_new.nsl
	system.nslSetBuffering(false); // NSL2.1.7 way
}
public void callFromConstructorTop() {
	if (system.debug>=1) {
D 2
	nslPrintln("DomineyModel:callFromConstructorTop");
E 2
I 2
	nslPrintln("domineyModel:callFromConstructorTop");
E 2
	}
}
public void callFromConstructorBottom() {
	if (system.debug>=1) {
D 2
	nslPrintln("DomineyModel:callFromConstructorBottom");
E 2
I 2
	nslPrintln("domineyModel:callFromConstructorBottom");
E 2
	}
}

public void initModule(){
	if (system.debug>=1) {
D 2
	  nslPrintln("DomineyModel:initModule: current time: "+curtime+" step "+stepsize);	
E 2
I 2
	  nslPrintln("domineyModel:initModule: current time: "+curtime+" step "+stepsize);	
E 2
	}

	nWTAThreshold=70; //From Dominey Lib.C file
	nslSetRunDelta(0.005); //98/8/4 aa

       // 98/10/27 aa: This should be selectable from the executive interface
	 // See initRun code below.
       protocolNum=0;//"manual";

	nslDeclareProtocol("single","single");  //1
	nslDeclareProtocol("memorySingle1","memorySingle1");//fixation on until after targets
	nslDeclareProtocol("memorySingle2","memorySingle2");//fixation on until after targets
	nslDeclareProtocol("double1","double1");  //4
	nslDeclareProtocol("double2","double2");  //5
	nslDeclareProtocol("lesionsc","lesionsc"); //6
	nslDeclareProtocol("lesionfef","lesionfef"); //7
	nslDeclareProtocol("memoryDouble","memoryDouble"); //8
	nslDeclareProtocol("stimulatedsc1","stimulatedsc1"); //9
	nslDeclareProtocol("stimulatedsc2","stimulatedsc2"); //10
	nslDeclareProtocol("stimulatedfef1","stimulatedfef1"); //11
	nslDeclareProtocol("stimulatedfef2","stimulatedfef2"); //12
	nslDeclareProtocol("stimulatedfef_lesionsc","stimulatedfef_lesionsc"); //13
	nslDeclareProtocol("stimulatedsc_lesionfef","stimulatedsc_lesionfef"); //14
	nslDeclareProtocol("memoryDouble2","memoryDouble2"); //15

	system.addProtocolToAll("single");  //1
	system.addProtocolToAll("memorySingle1");//fixation on until after targets
	system.addProtocolToAll("memorySingle2");//fixation on until after targets
	system.addProtocolToAll("double1");  //4
	system.addProtocolToAll("double2");  //5
	system.addProtocolToAll("lesionsc"); //6
	system.addProtocolToAll("lesionfef"); //7
	system.addProtocolToAll("memoryDouble"); //8
	system.addProtocolToAll("stimulatedsc1"); //9
	system.addProtocolToAll("stimulatedsc2"); //10
	system.addProtocolToAll("stimulatedfef1"); //11
	system.addProtocolToAll("stimulatedfef2"); //12
	system.addProtocolToAll("stimulatedfef_lesionsc"); //13
	system.addProtocolToAll("stimulatedsc_lesionfef"); //14
	system.addProtocolToAll("memoryDouble2"); //15

}

public void initRun() {

	curtime=system.getCurrentTime();

	stepsize=system.nslGetRunDelta();


	if (system.debug>=1) {
	  nslPrintln("debug DomineyModel: initRun: current time: "+curtime+" step "+stepsize);	
	}
}
public void makeConn() {
	// AA: all nslConnections should be made if we consider all the output ports on each of the module instances.
	
	// stimulation outputs
	nslConnect(stimfef1.stimFEF,fef1.stimulation);
	nslConnect(stimsc1.stimSC,supcol1.stimulation);

	// visualinput outputs
	nslConnect(visualinput1.visualinput,retina1.visualinput);
	// retina outputs
	nslConnect(retina1.retina,viscortex1.retina);
	nslConnect(retina1.retina,supcol1.retina);
 	// viscortex outputs
	nslConnect(viscortex1.posteriorParietal,fon1.posteriorParietal);
	nslConnect(viscortex1.posteriorParietal,ppqv1.posteriorParietal);
	// fef outputs
	nslConnect(fef1.fefmem,thal1.fefmem);	
	nslConnect(fef1.fefmem,bg1.fefmem);	
	nslConnect(fef1.fefsac,bg1.fefsac);
	nslConnect(fef1.fefsac,supcol1.fefsac);
	nslConnect(fef1.fefsac,brainStem1.fefsac);
	// fon outputs
	nslConnect(fon1.fon,fef1.fon);
	nslConnect(fon1.fon,supcol1.fon);
	nslConnect(fon1.fovElem,ppqv1.fovElem);
	// ppqv outputs
	nslConnect(ppqv1.ppqv,fef1.ppqv);
	nslConnect(ppqv1.ppqv,supcol1.ppqv);
	// thal outputs
	nslConnect(thal1.thmem,fef1.thmem);
	// bg
	nslConnect(bg1.snrmem,thal1.snrmem);
	nslConnect(bg1.snrsac,supcol1.snrsac);
	// supcol outputs
	nslConnect(supcol1.scDelay,thal1.scDelay);
	nslConnect(supcol1.scDelay,ppqv1.scDelay);
	nslConnect(supcol1.supcol,brainStem1.supcol);
	// erasure2
	nslConnect(erasure2_1.erasure2,thal1.erasure2);
	nslConnect(erasure2_1.erasure2,ppqv1.erasure2);
	// brainStem outputs
	nslConnect(brainStem1.horizontalVelocity,ppqv1.horizontalVelocity);
	nslConnect(brainStem1.verticalVelocity,ppqv1.verticalVelocity);
	nslConnect(brainStem1.horizontalTheta,retina1.horizontalTheta);
	nslConnect(brainStem1.verticalTheta,retina1.verticalTheta);
	nslConnect(brainStem1.saccademask,retina1.saccademask);
	nslConnect(brainStem1.saccademask,supcol1.saccademask);

	//inputs to the output display module
	nslConnect(visualinput1.visualinputSub,out1.visualinputSub);
	nslConnect(stimsc1.stimSC,out1.stimSC);
	nslConnect(stimfef1.stimFEF,out1.stimFEF);
	nslConnect(fon1.fonCenter,out1.posteriorParietalCenter);
	nslConnect(ppqv1.ppqv,out1.ppqv);
	nslConnect(supcol1.scqv,out1.scqv);
	nslConnect(supcol1.supcol,out1.supcol);
	nslConnect(supcol1.scsac,out1.scsac);
	nslConnect(fef1.fefvis,out1.fefvis);
	nslConnect(fef1.fefsac,out1.fefsac);	
	nslConnect(fef1.fefmem,out1.fefmem);
	nslConnect(thal1.thmem,out1.thmem);
	nslConnect(brainStem1.horizontalTheta,out1.horizontalTheta);
	nslConnect(brainStem1.verticalTheta,out1.verticalTheta);
}
public void simRun() {
	curtime=system.getCurTime();
	curcycle=system.getCurrentCycle();
	stepsize=system.nslGetRunDelta();
	if (system.debug>=1) {
D 2
	  nslPrintln("DomineyModel:simRun:current time: "+curtime+" cycle "+curcycle);	
E 2
I 2
	  nslPrintln("domineyModel:simRun:current time: "+curtime+" cycle "+curcycle);	
E 2
        }
}


// 98/10/27 aa: When the user selects a protocol from the interface or via a set call
// one of these methods will be called.
// These methods are not really necessary since we could do a system.getCurrentProtocol
// everywhere, but the old system had numbers and we just left them.  Numbers
// also are faster to compare than strings.

public void manualProtocol(){
	protocolString=system.nslGetProtocol();
       	protocolNum.set(0);//"manual";
}

public void singleProtocol(){
	protocolString=system.nslGetProtocol();
        	protocolNum.set(1);//"single";

}
public void memorySingle1Protocol(){
	protocolString=system.nslGetProtocol();
	  	protocolNum.set(2);//"memorySingle1";  //fixation on until after targets
}
public void memorySingle2Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(3);//"memorySingle2";  //fixation on until after targets
}
public void double1Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(4);//"double1";
}
public void double2Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(5);//"double2";
}
public void lesionscProtocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(6);//"lesionsc";
}
public void lesionfefProtocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(7);//"lesionfef";
}
public void memoryDoubleProtocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(8);//"memoryDouble"
}
public void stimulatedsc1Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(9);//"stimulatedsc1";
}
public void stimulatedsc2Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(10);//"stimulatedsc2";
}
public void stimulatedfef1Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(11);//"stimulatedfef1";
}
public void stimulatedfef2Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(12);//"stimulatedfef2";
}
public void stimulatedfef_lesionscProtocol(){
	protocolString=system.nslGetProtocol();
	protocolNum.set(13);//"stimulatedfef_lesionsc;
}
public void stimulatedsc_lesionfefProtocol(){
	protocolString=system.nslGetProtocol();
	protocolNum.set(14);//"stimulatedsc_lesionfef;
}
public void memoryDouble2Protocol(){
	protocolString=system.nslGetProtocol();
		protocolNum.set(15);//"memoryDouble2"
}

}  //end DomineyModel




E 1
