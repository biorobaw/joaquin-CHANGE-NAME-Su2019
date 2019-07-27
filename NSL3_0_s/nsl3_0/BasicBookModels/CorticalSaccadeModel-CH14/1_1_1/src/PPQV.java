/* This file is generated by  NSL3.0 preprocessor*/

/* SCCS  %W% --- %G% -- %U% */

/*PPQV
* Burst Neurons
* @see PPQV.nslm
* @version 98/6/18
* @author Dominey; coder Alexander
* Note: the index need to be size independent
*/

 import nslj.src.system.*; 
 import nslj.src.cmd.*; 
 import nslj.src.lang.*; 
 import nslj.src.math.*; 
 import nslj.src.display.*; 

 public class PPQV extends NslModule /*(int stdsz)*/  {

// input ports
public NslDinFloat0 horizontalVelocity ; /*()*/
public NslDinFloat0 verticalVelocity ; /* ()*/
public NslDinFloat2 scDelay ; /*(stdsz,stdsz)*/
public NslDinFloat2 erasure2 ; /*(stdsz,stdsz)*/
public NslDinFloat2 posteriorParietal ; /*(stdsz,stdsz)*/
public NslDinFloat2 fovElem ; /*(stdsz,stdsz)*/
//output ports
public NslDoutFloat2 ppqv ; /*(stdsz,stdsz)*/
// parameters 
private NslFloat0 qvCtr ; /*()*/
private NslFloat0 qvFactor ; /*()*/
private NslFloat0 oblique ; /* ()*/
private NslFloat0 qvMask_k1 ; /* ()*/
private NslFloat0 qvMask_k2 ; /* ()*/
private NslFloat0 ppqvPot_k1 ; /* ()*/
private NslFloat0 ppqvPot_k2 ; /* ()*/
private NslFloat0 ppqv_kx1 ; /*()*/
private NslFloat0 ppqv_kx2 ; /*()*/
private NslFloat0 ppqv_ky1 ; /*()*/
private NslFloat0 ppqv_ky2 ; /*()*/
//vars
private NslFloat2 qvMask ; /*(stdsz,stdsz)*/
private NslFloat2 qvmask1 ; /*(stdsz,stdsz)*/
// private NslFloat2 qvmask2(stdsz,stdsz); // 2.1.7 has commented out
private NslFloat0 inhSurr ; /*()*/
private NslFloat2 ppqvPot ; /*(stdsz,stdsz)*/
private NslFloat2 ppqva ; /*(stdsz,stdsz)*/
private NslFloat2 ppqvT ; /*(stdsz,stdsz)*/

private NslFloat0 protocolNum ; /*()*/ 
private  int center;

public  void initModule() {
	qvMask_k1.nslSetAccess('W');
}

public  void initRun() {
	protocolNum.set(-(1));
	protocolNum.set((NslInt0)nslGetValue("domineyModel.protocolNum")) /*rule 114 */;
	center = stdsz/2;

	ppqv.set(0);
        ppqva.set(0);
        ppqvT.set(0);
        qvMask.set(0);
        qvmask1.set(0);
        inhSurr.set(0);
        ppqvPot.set(0);

	qvCtr.set(1);       
 
	qvFactor.set(1600);
	oblique.set(1);

	qvMask_k1.set(1.23);
	//98/11/17 aa: qvMask_k1 =1.23 for non-memory protocolNums
       // and 0 for memory protocolNums
       if ((
 nslj.src.math.NslEqu.eval(protocolNum.get(),2))||(
 nslj.src.math.NslEqu.eval(protocolNum.get(),3))) {

               qvMask_k1.set(0);  //0 for memory protocolNums to disable
		// ppqv's intrinsic memory
       }
       // 99/7/27 these are memory saccades but require 
	// ppqv to save the second second until FON goes high
	// and the new location can be locked into fefmem and thmem.

       if ((
 nslj.src.math.NslEqu.eval(protocolNum.get(),8))||(
 nslj.src.math.NslEqu.eval(protocolNum.get(),15))) {
	  qvMask_k1.set(1.23);
	}

	qvMask_k2.set(0); 
	ppqvPot_k1.set(1);
	ppqvPot_k2.set(0);// for scDelay
	ppqv_kx1.set(0);


	ppqv_kx2.set(97.2); //aa: 96.5 or 97.4 in 2.1.7 but no description as 
	// too which protocolNum 

	ppqv_ky1.set(0);
	ppqv_ky2.set(90);
	inhSurr.set(0);  //aa: 98-7-20 no data to support this except comment below
}
public  void simRun() {

	qvmask1.set(DomineyLib.shift(horizontalVelocity,verticalVelocity,qvFactor,stdsz)) /* rule 108 */;

	// commented out in 2.1.7
	// qvmask2 =DomineyLib.shift(horizontalVelocity,verticalVelocity,
	// qvFactor, stdsz, qvCenter, Oblique);

	//qvMask = qvMask_k1*qvmask1 + qvMask_k2*qvmask2;
	// qvMask_k2 always 0 in 2.1.7
	qvMask.set(
 __nsltmp101=nslj.src.math.NslElemMult.eval(__nsltmp101,qvMask_k1.get(),qvmask1.get()));

	// This draws a square -5 elements on a side- around the fovea area
	(qvMask).set(2,2,inhSurr);
	(qvMask).set(2,3,inhSurr);
	(qvMask).set(2,4,inhSurr); 
	(qvMask).set(2,5,inhSurr);
	(qvMask).set(2,6,inhSurr);
	(qvMask).set(3,6,inhSurr);
	(qvMask).set(4,6,inhSurr);
 	(qvMask).set(5,6,inhSurr);
	(qvMask).set(6,2,inhSurr);
	(qvMask).set(6,3,inhSurr);
	(qvMask).set(6,4,inhSurr);
	(qvMask).set(6,5,inhSurr);
	(qvMask).set(6,6,inhSurr);
	(qvMask).set(3,2,inhSurr);
	(qvMask).set(4,2,inhSurr); 
	(qvMask).set(5,2,inhSurr);


	ppqvPot.set(
 __nsltmp108=nslj.src.math.NslSub.eval(__nsltmp108,
 __nsltmp105=nslj.src.math.NslSub.eval(__nsltmp105,
 __nsltmp103=nslj.src.math.NslAdd.eval(__nsltmp103,posteriorParietal.get(),
 __nsltmp102=nslj.src.math.NslConvZero.eval(__nsltmp102,qvMask.get(),ppqva.get())),
 __nsltmp104=nslj.src.math.NslElemMult.eval(__nsltmp104,ppqvPot_k1.get(),fovElem.get())),
 __nsltmp107=nslj.src.math.NslElemMult.eval(__nsltmp107,ppqvPot_k2.get(),
 __nsltmp106=nslj.src.math.NslConvZero.eval(__nsltmp106,erasure2.get(),scDelay.get()))));
	ppqvPot.set(
 __nsltmp109=nslj.src.math.NslElemMult.eval(__nsltmp109,erasure2.get(),ppqvPot.get())); 
	ppqva.set(NslSigmoid.eval(ppqvPot,ppqv_kx1,ppqv_kx2,ppqv_ky1,ppqv_ky2)) /* rule 108 */;
	ppqv.set(ppqva);
	(ppqv).set(center,center,0); 	// center of fovea is zero

       //98/11/9 aa: added until 3d plot gets fixed
       // using this matrix instead of ppqv for 3d display
       ppqvT.set(NslTrans.eval(ppqv)) /* rule 108 */;

	if (system.debug>=17) {
		System.out.println("PPQV: ppqv: ");
		System.out.println(ppqv);
	}

}

	/* nslInitTempModule inserted by NPP */
public void nslInitTempModule() {
	/* Instantiation statements generated by NslPreProcessor */
	/* temporary variables */
	__nsltmp101 = new float[1][1];
	__nsltmp102 = new float[1][1];
	__nsltmp103 = new float[1][1];
	__nsltmp104 = new float[1][1];
	__nsltmp105 = new float[1][1];
	__nsltmp106 = new float[1][1];
	__nsltmp107 = new float[1][1];
	__nsltmp108 = new float[1][1];
	__nsltmp109 = new float[1][1];
	/* end of automatic instantiation statements */
	/* Intialisation statements generated by NslPreProcessor */
	/* temporary variables */
	/* end of automatic intialisation statements */
}

	/* nslInitTempRun inserted by NPP */
public void nslInitTempRun() {
	/* Intialisation statements generated by NslPreProcessor */
	/* temporary variables */
	for (int i = 0; i < __nsltmp101.length; i++) {
		for (int j = 0; j < __nsltmp101[0].length; j++) {
			__nsltmp101[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp102.length; i++) {
		for (int j = 0; j < __nsltmp102[0].length; j++) {
			__nsltmp102[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp103.length; i++) {
		for (int j = 0; j < __nsltmp103[0].length; j++) {
			__nsltmp103[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp104.length; i++) {
		for (int j = 0; j < __nsltmp104[0].length; j++) {
			__nsltmp104[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp105.length; i++) {
		for (int j = 0; j < __nsltmp105[0].length; j++) {
			__nsltmp105[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp106.length; i++) {
		for (int j = 0; j < __nsltmp106[0].length; j++) {
			__nsltmp106[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp107.length; i++) {
		for (int j = 0; j < __nsltmp107[0].length; j++) {
			__nsltmp107[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp108.length; i++) {
		for (int j = 0; j < __nsltmp108[0].length; j++) {
			__nsltmp108[i][j] = 0;
		}
	}
	for (int i = 0; i < __nsltmp109.length; i++) {
		for (int j = 0; j < __nsltmp109[0].length; j++) {
			__nsltmp109[i][j] = 0;
		}
	}
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
	private  float[][] __nsltmp101;
	private  float[][] __nsltmp102;
	private  float[][] __nsltmp103;
	private  float[][] __nsltmp104;
	private  float[][] __nsltmp105;
	private  float[][] __nsltmp106;
	private  float[][] __nsltmp107;
	private  float[][] __nsltmp108;
	private  float[][] __nsltmp109;
	/* constructor and related methods */
	/* nsl declarations */
	int stdsz;

	 /*GENERIC CONSTRUCTOR:   */
	 public PPQV(String nslName, NslModule nslParent,int stdsz) {
		super(nslName, nslParent);
		this.stdsz = stdsz;
		initSys();
		makeInst(nslName, nslParent,stdsz);
	}
	public void makeInst(String nslName, NslModule nslParent,int stdsz){ 
	 horizontalVelocity=new NslDinFloat0 ("horizontalVelocity",this); //NSLDECLS 
	 verticalVelocity=new NslDinFloat0 ("verticalVelocity",this); //NSLDECLS 
	 scDelay=new NslDinFloat2 ("scDelay",this,stdsz,stdsz); //NSLDECLS 
	 erasure2=new NslDinFloat2 ("erasure2",this,stdsz,stdsz); //NSLDECLS 
	 posteriorParietal=new NslDinFloat2 ("posteriorParietal",this,stdsz,stdsz); //NSLDECLS 
	 fovElem=new NslDinFloat2 ("fovElem",this,stdsz,stdsz); //NSLDECLS 
	 ppqv=new NslDoutFloat2 ("ppqv",this,stdsz,stdsz); //NSLDECLS 
	 qvCtr=new NslFloat0 ("qvCtr",this); //NSLDECLS 
	 qvFactor=new NslFloat0 ("qvFactor",this); //NSLDECLS 
	 oblique=new NslFloat0 ("oblique",this); //NSLDECLS 
	 qvMask_k1=new NslFloat0 ("qvMask_k1",this); //NSLDECLS 
	 qvMask_k2=new NslFloat0 ("qvMask_k2",this); //NSLDECLS 
	 ppqvPot_k1=new NslFloat0 ("ppqvPot_k1",this); //NSLDECLS 
	 ppqvPot_k2=new NslFloat0 ("ppqvPot_k2",this); //NSLDECLS 
	 ppqv_kx1=new NslFloat0 ("ppqv_kx1",this); //NSLDECLS 
	 ppqv_kx2=new NslFloat0 ("ppqv_kx2",this); //NSLDECLS 
	 ppqv_ky1=new NslFloat0 ("ppqv_ky1",this); //NSLDECLS 
	 ppqv_ky2=new NslFloat0 ("ppqv_ky2",this); //NSLDECLS 
	 qvMask=new NslFloat2 ("qvMask",this,stdsz,stdsz); //NSLDECLS 
	 qvmask1=new NslFloat2 ("qvmask1",this,stdsz,stdsz); //NSLDECLS 
	 inhSurr=new NslFloat0 ("inhSurr",this); //NSLDECLS 
	 ppqvPot=new NslFloat2 ("ppqvPot",this,stdsz,stdsz); //NSLDECLS 
	 ppqva=new NslFloat2 ("ppqva",this,stdsz,stdsz); //NSLDECLS 
	 ppqvT=new NslFloat2 ("ppqvT",this,stdsz,stdsz); //NSLDECLS 
	 protocolNum=new NslFloat0 ("protocolNum",this); //NSLDECLS 
	}
	/* end of automatic declaration statements */
}//end class
