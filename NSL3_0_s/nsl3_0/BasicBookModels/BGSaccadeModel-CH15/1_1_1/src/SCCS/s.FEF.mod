h24917
s 00142/00000/00000
d D 1.1 99/09/24 18:57:17 aalx 1 0
c date and time created 99/09/24 18:57:17 by aalx
e
u
U
f e 0
t
T
I 1
/* SCCS  %W%---%G%--%U% */
/* old kversion @(#)FEF.mod	1.8 --- 08/05/99 -- 13:56:18 : jversion  @(#)FEF.mod	1.2---04/23/99--18:39:27 */


// ----------------------------FEF module ------------------------------------
nslImport nslAllImports;

/* 
* Here is the class representing the Frontal Eye Fields (FEF) module.
* FEF is modeled to have two type of cells: FEFvis, visual response cells and
* FEFmem, memory response cells. FEFvis only responds to visual stimuli that 
* are targets of impending saccades and do not fire before saccades made 
* without visual input, nor they project to the SC.
*/

nslModule FEF(int array_size) 
{
	// input ports  
     public NslDinDouble2 ThFEFmem_in(array_size,array_size)  ;
     public NslDinDouble2 LIPmem_in(array_size,array_size)  ;
     public NslDinDouble2 PFCgo_in(array_size,array_size)  ;
     public NslDinDouble2 PFCnovelty(array_size,array_size)  ;
     public NslDinDouble2 PFCmem_in(array_size,array_size)  ;

    // outputs
    public NslDoutDouble2 FEFmem_out(array_size,array_size)  ;
    public NslDoutDouble2 FEFsac_out(array_size,array_size)  ; 

    // privates
    private NslDouble2 fefmem(array_size,array_size)   ;
    private NslDouble2 fefsac(array_size,array_size)   ;

    // envs or hierarchy variables
    private NslInt0 FOVEAX();
    private NslInt0 FOVEAY();
  /* ERH: 
   NINE = CorticalArraySize = 9 ; -may be it is better to replace NINE's
   with the overall common arraysize: CorticalArraySize
   But if this is to be passed as a parameter in the future, this is ok.
   */
  private static int NINE = 9;
  /* ERH: 
     CorticalSlowdown is currently constant but there is some comment in
     LateralCaudate (RUN)module may be it can be useful in future:
     "Factor to slow down certain cortical areas due to cortical plasticity
     responding to slowdown already occurring in BG during PD and HD.
     Go with half to indicate slowdown lag between cortex and BG.
     
     CorticalSlowdown = NslSigma(SNCdopmax,SNCdopsigma3,SNCdopsigma4,
     cdburstsigma3,cdburstsigma4) / 2.0;
     "
     And CorticalSlowdown is also used by LateralCaudate (RUN)module.
  */
  private static double CorticalSlowdown = 1.0;  
  private static double basefefsactm = 0.008;     


  private double FEFmemsigma1;
  private double FEFmemsigma2;
  private double FEFmemsigma3;
  private double FEFmemsigma4;
  private double FEFsacsigma1;
  private double FEFsacsigma2;
  private double FEFsacsigma3;
  private double FEFsacsigma4;
  private double FEFSaccadeVector ;
  private double fefmemtm ;
  private double fefsactm ;
  private double fefmemK1 ;
  private double fefmemK2 ;
  private double fefmemK3;

  private double fefsacK1 ;
  private double fefsacK2 ;
  
 public void initModule() 
 {
  FOVEAX=(NslInt0)nslGetValue("crowleyTop.FOVEAX");
  FOVEAY=(NslInt0)nslGetValue("crowleyTop.FOVEAY");
 }

  public void initRun(){
    
    FEFmem_out = 0;
    FEFsac_out = 0;
    fefmem       = 0;
    fefsac       = 0;

    FEFmemsigma1 =   0;
    FEFmemsigma2 =  90;
    FEFmemsigma3 =   0;
    FEFmemsigma4 =  90;
    FEFsacsigma1 =  40;
    FEFsacsigma2 =  90;
    FEFsacsigma3 =   0;
    FEFsacsigma4 =  90;
    

    FEFSaccadeVector = 0;
    fefmemtm = 0.008;
    fefsactm = 0.006;
    fefmemK1 = 0.5;
    fefmemK2 = 1;
    fefmemK3 = 0.5;

    fefsacK1 = 0.3;
    fefsacK2 = 1;
  }
public void simRun(){

  // System.err.println("@@@@ FEF simRun entered @@@@");


    //LNK_FEF2
    /**
     * A memory loop is established between FEFmem and mediodorsal thalamus
     *(ThFEFmem_in) to maintain the saccadic target memory.
     */

    // 1-2-97 isaac:  fefmemK3 * PFCmem is missing from the original code.
    // redefine the inport interface.

    fefmem=nslDiff(fefmem,fefmemtm,-fefmem+(fefmemK1*ThFEFmem_in)+(fefmemK2*LIPmem_in)+(fefmemK3*PFCmem_in));
    
    //    fefsactm = basefefsactm * CorticalSlowdown;
    
    fefsac=nslDiff(fefsac,fefsactm,-fefsac + ( fefsacK1 * FEFmem_out )
		       + ( fefsacK2 * PFCgo_in ) + PFCnovelty);
    fefsac[FOVEAX][FOVEAY] = 0;
    FEFmem_out=Nsl2Sigmoid.eval(fefmem,FEFmemsigma1,FEFmemsigma2,FEFmemsigma3,FEFmemsigma4);
    FEFsac_out=Nsl2Sigmoid.eval(fefsac,FEFsacsigma1,FEFsacsigma2,FEFsacsigma3,FEFsacsigma4);
	//96/12/20 aa
    //System.out.println("FEFsac_out: " + FEFsac_out);
  }
  

  


} //end class


E 1