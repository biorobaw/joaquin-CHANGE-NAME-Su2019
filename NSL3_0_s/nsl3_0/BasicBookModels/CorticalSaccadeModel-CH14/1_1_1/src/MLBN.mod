/* SCCS  @(#)MLBN.mod	1.2 --- 09/22/99 -- 23:20:57 */

/*MLBN
* Medium lead burst neurons -  module
* @see  MLBN.nslm
* @version 98/6/18
* @author Dominey and Alexander
*/
nslImport nslAllImports;

nslModule MLBN (int stdsz)  {

// ports
public NslDinFloat2 stm(stdsz,stdsz);  //input - spatio temporal transformations
public NslDinFloat2 llbn(stdsz,stdsz);  //input
public NslDoutFloat2 mlbn (stdsz,stdsz); // output
// parameters 
private NslFloat0 mlbnPot_tm();
private NslFloat0 mlbn_kx1();
private NslFloat0 mlbn_kx2();
private NslFloat0 mlbn_ky1();
private NslFloat0 mlbn_ky2();
// vars
private NslFloat2 mlbnPot (stdsz,stdsz);	// medium lead burst neurons of the brainstem saccade generator


public void initRun() {
       mlbn=0;
       mlbnPot=0;

	mlbnPot_tm=0.008;
	mlbn_kx1=0;
	mlbn_kx2=1500;
	mlbn_ky1=0;
	mlbn_ky2=950;

}
public void simRun() {
	// leftSTM, rightSTM etc have weights that increase with distance from fovea
	// performing the SpatioTeMporal transformation.
	// ^ = pointwise multiplication
	// medium lead burst neurons - see Hepp and Henn (in refs) for details.

	mlbnPot=nslDiff(mlbnPot,mlbnPot_tm, -mlbnPot + (stm^llbn));
	mlbn = nslSaturation(mlbnPot,mlbn_kx1,mlbn_kx2,mlbn_ky1,mlbn_ky2);
	if (system.debug>=7) {
		nslPrintln("debug: MLBN");
		nslPrintln(mlbn);
	}
}
}





