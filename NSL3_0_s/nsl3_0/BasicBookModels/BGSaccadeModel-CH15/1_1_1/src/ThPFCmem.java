/* This file is generated by  NSL3.0 preprocessor*/

/* SCCS  %W%---%G%--%U% */
/* old kversion @(#)ThPFCmem.mod	1.8 --- 08/05/99 -- 13:56:46 : jversion  @(#)ThPFCmem.mod	1.2---04/23/99--18:33:33 */

 import nslj.src.system.*; 
 import nslj.src.cmd.*; 
 import nslj.src.lang.*; 
 import nslj.src.math.*; 
 import nslj.src.display.*; 
/////////////////////////////////////////////
//Module: ThPFCmem - Part of the Thalamus
/////////////////////////////////////////////

//
//ThPFCmem
//
 public class ThPFCmem extends NslModule/*(int array_size)*/{
//input ports
    public NslDinDouble2 SNRmedburst_in ; /*(array_size,array_size)    */
    public NslDinDouble2 ThMEDlcn_in ; /*(array_size,array_size)     */
    public NslDinDouble2 PFCmem_in ; /*(array_size,array_size)     */
//output ports
    public NslDoutDouble2 ThPFCmem_out ; /*(array_size,array_size)  */

//private variables

  private  double Thpfcmemtm;
  private  double ThpfcmemK1;
  private  double ThpfcmemK2;
  private  double ThpfcmemK3;
  private  double ThPFCmemsigma1;
  private  double ThPFCmemsigma2;
  private  double ThPFCmemsigma3;
  private  double ThPFCmemsigma4;
  private  NslDouble2 Thpfcmem ; /*(array_size,array_size)   */

  private NslDouble2 THNewActivation ; /*(array_size,array_size)   */

public  void initModule()
  {
    THNewActivation.set((NslDouble2)nslGetValue("crowleyTop.thal1.THNewActivation")) /*rule 114 */;
  }

public  void initRun(){
    Thpfcmem.set(0);
    ThPFCmem_out.set(0);
    Thpfcmemtm=0.006;
    ThpfcmemK1=1.5;
    ThpfcmemK2=0.5;
    ThpfcmemK3=0.5;
    ThPFCmemsigma1=30;
    ThPFCmemsigma2=65;
    ThPFCmemsigma3=0;
    ThPFCmemsigma4=60;
}

public  void simRun(){
  /* <Q> PFCmem_in SNRmedburst_in ThMEDlcn_in THNewActivation */

  // System.err.println("@@@@ ThPFCmem_in simRun entered @@@@");
    Thpfcmem.set(system.nsldiff.eval(Thpfcmem,Thpfcmemtm,
 __nsltmp108=nslj.src.math.NslAdd.eval(__nsltmp108,
 __nsltmp107=nslj.src.math.NslSub.eval(__nsltmp107,
 __nsltmp105=nslj.src.math.NslSub.eval(__nsltmp105,
 __nsltmp103=nslj.src.math.NslAdd.eval(__nsltmp103,
 __nsltmp101=nslj.src.math.NslSub.eval(__nsltmp101,0,Thpfcmem.get()),
 __nsltmp102=nslj.src.math.NslElemMult.eval(__nsltmp102,ThpfcmemK1,PFCmem_in.get())),
 __nsltmp104=nslj.src.math.NslElemMult.eval(__nsltmp104,ThpfcmemK2,SNRmedburst_in.get())),
 __nsltmp106=nslj.src.math.NslElemMult.eval(__nsltmp106,ThpfcmemK3,ThMEDlcn_in.get())),THNewActivation.get()))) /* rule 108 */;
			   
    ThPFCmem_out.set(Nsl2Sigmoid.eval(Thpfcmem,ThPFCmemsigma1,ThPFCmemsigma2,ThPFCmemsigma3,ThPFCmemsigma4)) /* rule 108 */;
  }

	/* nslInitTempModule inserted by NPP */
public void nslInitTempModule() {
	/* Instantiation statements generated by NslPreProcessor */
	/* temporary variables */
	__nsltmp101 = new double[1][1];
	__nsltmp102 = new double[1][1];
	__nsltmp103 = new double[1][1];
	__nsltmp104 = new double[1][1];
	__nsltmp105 = new double[1][1];
	__nsltmp106 = new double[1][1];
	__nsltmp107 = new double[1][1];
	__nsltmp108 = new double[1][1];
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
	private  double[][] __nsltmp101;
	private  double[][] __nsltmp102;
	private  double[][] __nsltmp103;
	private  double[][] __nsltmp104;
	private  double[][] __nsltmp105;
	private  double[][] __nsltmp106;
	private  double[][] __nsltmp107;
	private  double[][] __nsltmp108;
	/* constructor and related methods */
	/* nsl declarations */
	int array_size;

	 /*GENERIC CONSTRUCTOR:   */
	 public ThPFCmem(String nslName, NslModule nslParent,int array_size) {
		super(nslName, nslParent);
		this.array_size = array_size;
		initSys();
		makeInst(nslName, nslParent,array_size);
	}
	public void makeInst(String nslName, NslModule nslParent,int array_size){ 
	 SNRmedburst_in=new NslDinDouble2 ("SNRmedburst_in",this,array_size,array_size); //NSLDECLS 
	 ThMEDlcn_in=new NslDinDouble2 ("ThMEDlcn_in",this,array_size,array_size); //NSLDECLS 
	 PFCmem_in=new NslDinDouble2 ("PFCmem_in",this,array_size,array_size); //NSLDECLS 
	 ThPFCmem_out=new NslDoutDouble2 ("ThPFCmem_out",this,array_size,array_size); //NSLDECLS 
	 Thpfcmem=new NslDouble2 ("Thpfcmem",this,array_size,array_size); //NSLDECLS 
	 THNewActivation=new NslDouble2 ("THNewActivation",this,array_size,array_size); //NSLDECLS 
	}
	/* end of automatic declaration statements */
} //end class