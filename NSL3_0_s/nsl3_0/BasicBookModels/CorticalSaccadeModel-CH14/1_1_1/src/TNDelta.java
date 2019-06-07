/* This file is generated by  NSL3.0 preprocessor*/

/* SCCS %W% --- %G% -- %U% */

/*TNDelta
* This module calculates the delay and delta for 
* the temporal remapping.
* @see  TNDelta.nslm
* @version 98/6/18
* @author Dominey and Alexander
*/
 import nslj.src.system.*; 
 import nslj.src.cmd.*; 
 import nslj.src.lang.*; 
 import nslj.src.math.*; 
 import nslj.src.display.*; 

 public class TNDelta extends NslModule /*(int stdsz)*/  {

// input ports
public NslDinFloat2 fefsac ; /* (stdsz,stdsz)*/
public NslDinFloat0 tn ; /*()*/

// output ports
public NslDoutFloat0 fefgate ; /*()*/
public NslDoutFloat0 tnDelta ; /*()*/

// parameters 
private NslFloat0 fefswitchPot_k1 ; /* ()*/
private NslFloat0 fefgatePot_tm ; /* ()*/
private NslFloat0 fefswitch_k1 ; /* ()*/
private NslFloat0 fefswitch_k2 ; /* ()*/
private NslFloat0 fefswitch_k3 ; /* ()*/
private NslFloat0 fefgate_k1 ; /* ()*/
private NslFloat0 fefgate_k2 ; /* ()*/
private NslFloat0 fefgate_k3 ; /* ()*/
/// vars
private NslFloat0 fefswitchPot ; /* ()*/
private NslFloat0 fefgatePot ; /* ()*/
public NslFloat0 fefswitch ; /* ()*/

private NslInt0 protocolNum ; /*()*/


// aa: shortened this list from the orignal
private NslFloat0 tnDelay2_tm ; /*()*/
private NslFloat0 tnDelay3_tm ; /*()*/
private NslFloat0 tnDelta_tm ; /*()*/
// vars
private NslFloat0 tnDelay2 ; /*()*/
private NslFloat0 tnDelay3 ; /*()*/

public  void initRun() {
	if (system.debug>=10) {
		System.out.println("TNDelta:initRun");
	}

// 	only need if doing collision experiments
//	protocolNum=(NslInt0)nslGetValue("domineyModel.protocolNum");
	
       fefgate.set(0);
       fefswitch.set(0);
       fefswitchPot.set(0);
       fefgatePot.set(0);

	fefswitchPot_k1.set(0.21);
	fefgatePot_tm.set(0.04);
	fefswitch_k1.set(89);
	fefswitch_k2.set(0);
	fefswitch_k3.set(90);
	fefgate_k1.set(40);  // aa: 2.1.7 also mentions 45
	fefgate_k2.set(0);

       //98/11/20 aa: fefgate_k3 = 1 for collisions experiments
	 // is what the 2.1.7 file had as the default
       fefgate_k3.set(0);  // for non-collision experiments
       // fefgate_k3=1;  // for collision experiments

       tnDelta.set(0);  //use to be TNCHANGE2 in NSL2.1.7
       tnDelay2.set(154);
       tnDelay3.set(154);

	tnDelay2_tm.set(0.02);
	tnDelay3_tm.set(0.04);  // aa: 2.1.7 had up direction as 0.02
	tnDelta_tm.set(0.006);
}
public  void simRun() {
	fefswitchPot.set((fefswitchPot_k1.get())*(NslMaxValue.eval(fefsac)));
	fefgatePot.set(system.nsldiff.eval(fefgatePot,fefgatePot_tm,
 nslj.src.math.NslAdd.eval(nslj.src.math.NslSub.eval(0,fefgatePot),fefswitch.get()))) /* rule 108 */;
	fefswitch.set(NslStep.eval(fefswitchPot,fefswitch_k1,fefswitch_k2,fefswitch_k3)) /* rule 108 */;
	fefgate.set(NslStep.eval(fefgatePot,fefgate_k1,fefgate_k2,fefgate_k3)) /* rule 108 */;

	tnDelay2.set(system.nsldiff.eval(tnDelay2,tnDelay2_tm,
 nslj.src.math.NslAdd.eval(nslj.src.math.NslSub.eval(0,tnDelay2),tn.get()))) /* rule 108 */;
	tnDelay3.set(system.nsldiff.eval(tnDelay3,tnDelay3_tm,
 nslj.src.math.NslAdd.eval(nslj.src.math.NslSub.eval(0,tnDelay3),tn.get()))) /* rule 108 */;
	tnDelta.set(system.nsldiff.eval(tnDelta,tnDelta_tm,
 nslj.src.math.NslSub.eval(
 nslj.src.math.NslAdd.eval(nslj.src.math.NslSub.eval(0,tnDelta),tnDelay2.get()),tnDelay3.get()))) /* rule 108 */;

	if (system.debug>=10) {
		System.out.println(("TNDelta:fefgate:")+(fefgate));
		System.out.println(("TNDelta:tnDelta:")+(tnDelta));
	}

}
	/* nslInitTempModule inserted by NPP */
public void nslInitTempModule() {
	/* Instantiation statements generated by NslPreProcessor */
	/* temporary variables */
	/* end of automatic instantiation statements */
	/* Intialisation statements generated by NslPreProcessor */
	/* temporary variables */
	/* end of automatic intialisation statements */
}

	/* nslInitTempRun inserted by NPP */
public void nslInitTempRun() {
	/* Intialisation statements generated by NslPreProcessor */
	/* temporary variables */
	/* end of automatic intialisation statements */
}

	/* nslInitTempTrain inserted by NPP */
public void nslInitTempTrain() {
	/* Initialisation statements generated by NslPreProcessor */
	/* temporary variables */
	/* end of automatic intialisation statements */
}

	/* Declaration statements generated by NslPreProcessor */
	/* makeinst() declared variables */
	/* temporary variables */
	/* constructor and related methods */
	/* nsl declarations */
	int stdsz;

	 /*GENERIC CONSTRUCTOR:   */
	 public TNDelta(String nslName, NslModule nslParent,int stdsz) {
		super(nslName, nslParent);
		this.stdsz = stdsz;
		initSys();
		makeInst(nslName, nslParent,stdsz);
	}
	public void makeInst(String nslName, NslModule nslParent,int stdsz){ 
	 fefsac=new NslDinFloat2 ("fefsac",this,stdsz,stdsz); //NSLDECLS 
	 tn=new NslDinFloat0 ("tn",this); //NSLDECLS 
	 fefgate=new NslDoutFloat0 ("fefgate",this); //NSLDECLS 
	 tnDelta=new NslDoutFloat0 ("tnDelta",this); //NSLDECLS 
	 fefswitchPot_k1=new NslFloat0 ("fefswitchPot_k1",this); //NSLDECLS 
	 fefgatePot_tm=new NslFloat0 ("fefgatePot_tm",this); //NSLDECLS 
	 fefswitch_k1=new NslFloat0 ("fefswitch_k1",this); //NSLDECLS 
	 fefswitch_k2=new NslFloat0 ("fefswitch_k2",this); //NSLDECLS 
	 fefswitch_k3=new NslFloat0 ("fefswitch_k3",this); //NSLDECLS 
	 fefgate_k1=new NslFloat0 ("fefgate_k1",this); //NSLDECLS 
	 fefgate_k2=new NslFloat0 ("fefgate_k2",this); //NSLDECLS 
	 fefgate_k3=new NslFloat0 ("fefgate_k3",this); //NSLDECLS 
	 fefswitchPot=new NslFloat0 ("fefswitchPot",this); //NSLDECLS 
	 fefgatePot=new NslFloat0 ("fefgatePot",this); //NSLDECLS 
	 fefswitch=new NslFloat0 ("fefswitch",this); //NSLDECLS 
	 protocolNum=new NslInt0 ("protocolNum",this); //NSLDECLS 
	 tnDelay2_tm=new NslFloat0 ("tnDelay2_tm",this); //NSLDECLS 
	 tnDelay3_tm=new NslFloat0 ("tnDelay3_tm",this); //NSLDECLS 
	 tnDelta_tm=new NslFloat0 ("tnDelta_tm",this); //NSLDECLS 
	 tnDelay2=new NslFloat0 ("tnDelay2",this); //NSLDECLS 
	 tnDelay3=new NslFloat0 ("tnDelay3",this); //NSLDECLS 
	}
	/* end of automatic declaration statements */
}