/* This file is generated by  NSL3.0 preprocessor*/

/* SCCS  %W%---%G%--%U% */
/* old kversion @(#)SubData.mod	1.8 --- 08/05/99 -- 13:56:42 : jversion  @(#)SubData.mod	1.2---04/23/99--18:39:51 */
// SubData 
 import nslj.src.system.*; 
 import nslj.src.cmd.*; 
 import nslj.src.lang.*; 
 import nslj.src.math.*; 
 import nslj.src.display.*; 

/* verbatim NSLJ */
import java.io.*;
import java.util.StringTokenizer;
 /* verbatim off */

 public class SubData extends NslModule /*()*/{
   NslDoutDouble2 SNRmedburst_out ; /*(9,9)   */

/* verbatim NSLJ */
   private StringTokenizer st;
 /* verbatim off */

public  void initRun() {
/* verbatim NSLJ */
    byte[] bytebuf = new byte[80000];
    FileInputStream fis ;


    String strbuf = "";

      try {
      fis=new FileInputStream ("sub.dat")  ;


      for(int i=0; i<10; i++) {
      //     while(true) {
	int ret = fis.read(bytebuf);
	strbuf += new String(bytebuf, 0);
	if (ret==-1)
	  break;
      }
    } catch (java.io.IOException e) {
      System.err.println("Error in opening file 'sub.dat'");

      return;
    }

    st= new StringTokenizer(strbuf)  ;
 /* verbatim off */  

    readData();
   
}

public  void simRun() {
  /* @@@ */ System.err.println("@@@@  SubData entered @@@@");
    if(!st.hasMoreTokens()) {System.out.println("End of sub data");return;}
    readData();
  }

public  void readData() {
     int i, j;
      for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  (SNRmedburst_out).set(i,j,(0)+(Double.valueOf(st.nextToken()).doubleValue()));
	}
}
//=================
// the following was in readData
    /*
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  visinput_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  ThLIPmem_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}


    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  PFCmem_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}

      for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  FEFmem_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
      for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  LIPmem_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
	*/
      /*
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  SNCdop_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  PFCgo_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  FEFsac_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  PFCfovea_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  LIPvis_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  ThPFCmem_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}

    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  SNRlatburst_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}

    BSGsaccade_out= Double.valueOf(st.nextToken()).doubleValue();

    for(i=0; i<2; i++) 
	  BSGEyeMovement_out[i] = Double.valueOf(st.nextToken()).doubleValue();

    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  ThFEFmem_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}

    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  SCbu_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  SCsac_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}

    for(i=0; i<9; i++) 
	for(j=0; j<9; j++){
	  LimbicCortex_out[i][j] = Double.valueOf(st.nextToken()).doubleValue();
	}
	*/


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

	 /*GENERIC CONSTRUCTOR:   */
	 public SubData(String nslName, NslModule nslParent) {
		super(nslName, nslParent);
		initSys();
		makeInst(nslName, nslParent);
	}
	public void makeInst(String nslName, NslModule nslParent){ 
	 SNRmedburst_out=new NslDoutDouble2 ("SNRmedburst_out",this,9,9); //NSLDECLS 
	}
	/* end of automatic declaration statements */
} // end class