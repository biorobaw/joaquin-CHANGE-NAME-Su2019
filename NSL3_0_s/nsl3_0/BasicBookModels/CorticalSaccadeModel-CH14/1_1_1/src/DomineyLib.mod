/* SCCS  @(#)DomineyLib.mod	1.2---09/22/99--23:20:54 */
/* DomineyLib
* This library was previously called Lib.C
* @see  DomineyLib.nslm
* @version 98/6/25
* @author Dominey; code: Alexander
* This class contains:
* max: max of two floats
* eyePostion: calculates new eye postion
* winnerTakeAll: zero all but the maximum value element in an array
* shift:create the convolution nmask that will generate a berthoz-like
*	shift of activitny across the QV (quasi visual) cell layer.
*/

nslImport nslAllImports;

nslClass DomineyLib () {

//--------------------------------------------------------------------
/*  The nslAddToAllProtocols made this obsolete
public static void nslAddAllProtocols(NslModule joemodule) {
	joemodule.nslAddToProtocol("single");  //1
	joemodule.nslAddToProtocol("memorySingle1");//fixation on until after targets
	joemodule.nslAddToProtocol("memorySingle2");//fixation on until after targets
	joemodule.nslAddToProtocol("double1");  //4
	joemodule.nslAddToProtocol("double2");  //5
	joemodule.nslAddToProtocol("lesionsc"); //6
	joemodule.nslAddToProtocol("lesionfef"); //7
	joemodule.nslAddToProtocol("memoryDouble"); //8
	joemodule.nslAddToProtocol("stimulatedsc1"); //9
	joemodule.nslAddToProtocol("stimulatedsc2"); //10
	joemodule.nslAddToProtocol("stimulatedfef1"); //11
	joemodule.nslAddToProtocol("stimulatedfef2"); //12
	joemodule.nslAddToProtocol("stimulatedfef_lesionsc"); //13
	joemodule.nslAddToProtocol("stimulatedsc_lesionfef"); //14

}
*/
//--------------------------------------------------------------------
// this would be NslMaxMerge in nslm

public static float max(float x, float y) {
// java Math class should have this as well as C++ math?
// use: f=domineylib.max(x,y);
 
	if (x >= y) 
		return(x); 
	else 	return(y);
}

//--------------------------------------------------------------------
public static NslFloat2 eyeMove(NslFloat2 nmyinput, NslFloat0 nxxx, NslFloat0 nyyy,int stdsz,int bigsz)
/* 
* use: nretina = domineylib.eyeMove(nmyinput,nxxx,nyyy,stdsz,bigsz) 
* note: eyeMove remaps the std array nretina as a submatrix of the 
* big array nmyinput centered around horizontalTheta and verticalTheta. 
* Thus, nxxx and nyyy can be negative.
*/
{ 
/*	 
	nslPrintln("lib:mnyinput :"+nmyinput);
	nslPrintln("lib:nxxx :"+nxxx);
	nslPrintln("lib:nyyy :"+nyyy);
*/
	 float[][] myinput; //large array 3 x stdsz

	 int retinax=0;
	 int retinay=0;
	 int retinaDim=0;
	 int x=0;
	 int y=0;
	 int i=0;
	 int j=0;
	 int myinputDim=0;
	 int bigszMinus1=0;
	 int stdszMinus1=0;
	 int iMinusYPlusStdsz=0;
	 int jPlusXPlusStdsz=0;
	// int xPlusStdsz=0;
	// int yPlusStdsz=0;
	 //int iPlusXPlusStdsz=0;
	 //int jPlusYPlusStdsz=0;
	 float[][] retina;  //stdsz
	 NslFloat2 nretina(stdsz,stdsz);
verbatim_NSLJ;
	myinput = nmyinput.get();  // get native array of size large
	retina = nretina.get();  // get native array of size stdsz
	bigszMinus1=bigsz-1;
	stdszMinus1=stdsz-1;
	x = (int) nxxx.getint();
	y = (int) nyyy.getint();
	retinax = stdszMinus1;
	retinay = stdszMinus1;
// aa:99/7/18: i maps to y, and j maps to x except y=0, x=0 is in the center.
// and i=0, j=0 is in the upper lefthand corner.
	for (i = 0; i <= retinay; i++) {
		for (j = 0; j <= retinax; j++) {
			iMinusYPlusStdsz = i- y + stdsz; // cannot use YPlusStdsz
	                jPlusXPlusStdsz =  j+ x + stdsz;
		//aa: 99/7/18 changed bounds check from 2.1.7 version
		   	if  ( (iMinusYPlusStdsz <= bigszMinus1) && (iMinusYPlusStdsz >= 0) &&
				(jPlusXPlusStdsz <= bigszMinus1) && (jPlusXPlusStdsz >= 0)){
				retina[i][j]  = myinput[iMinusYPlusStdsz][jPlusXPlusStdsz];
		   } else {
			System.err.println("domineyLib:eyeMove:Error cannot move to that part of visual input matrix");
			System.err.println("It is too close too the edge: i  visinput:"+iMinusYPlusStdsz+" j visinput:"+jPlusXPlusStdsz+" i retina:" +i+ " j retina:" +j+ " y delta:" +y+ " x delta:" +x);
			retina[i][j] = 0;
		   }
		} //end j
	} // end i
	// aa: I think that since retina is a reference to nretina's data that
	// when retina changes so does nretina, so I don't have to do a set???
	return nretina;

verbatim_off;
}

//--------------------------------------------------------------------

public static  NslFloat2 winnerTakeAll(NslFloat2 ninput,float threshold,int stdsz)
/* Was called NSLwinnerTakeAll in Lib.C */
/* use: nwinner =winnerTakeAll(ninput,threshold,stdsz); */
{
	NslFloat2 nwinner("nwinner",stdsz,stdsz);
	float  thresh=0;
	int inputx, inputy, inputDim,i,j,threshi, threshj=0;
	int stdszMinus1=0;

	/* initialization */
	thresh = threshold;
	threshi = 0;
	threshj = 0;
	nwinner=0;

	stdszMinus1=stdsz-1;
	/* lanyer boundaries */
	inputx = stdszMinus1;
	inputy = stdszMinus1;
	inputDim = stdszMinus1;

	/* find the maximum cell in input */

	for (i = 0; i <= inputx; i++)
		for (j = 0; j <= inputy; j++)
			if (ninput[i][j] > thresh)
			{
				thresh = ninput[i][j];
				 threshi = i;
				 threshj = j;
			}
	if (thresh > threshold)
		nwinner[threshi][threshj] = thresh;
	return nwinner;
}
//--------------------------------------------------------------------
public static NslFloat2 shift(NslFloat0 nxxx, NslFloat0 nyyy,NslFloat0 nkkk,int stdsz)
{
	int iii=0;
	int jjj=0;
	int stdszMinus1=0;

	NslFloat2 nmask("nmask",stdsz,stdsz);
	float[][] mask;
        float k=0;
	float xxxnorm=0;
	float yyynorm=0;
        float xxxdata=0;
	float yyydata=0;
        float xkdata=0;
	float ykdata=0;

	stdszMinus1=stdsz-1;

	iii = (int)(stdszMinus1/2);
	jjj = (int)(stdszMinus1/2);
	k = nkkk.get();
	xxxdata = nxxx.get();
	yyydata = nyyy.get();
	xkdata = xxxdata/k;
	ykdata = yyydata/k;
	xxxnorm = nxxx.get()/1000;
	yyynorm = nyyy.get()/1000;

	mask=nmask.get();  // set mask = to nmask data
	mask[jjj][iii] = 1;

	if ( yyynorm > .0005) 
		{mask[jjj][iii] =  1- yyynorm;
		 mask[jjj-1][iii] =   yyynorm;
		 mask[jjj+1][iii] =  - yyynorm;	
		}
	
	if ( yyynorm < -0.0005) 
		{mask[jjj][iii] =  1+ yyynorm;
		 mask[jjj-1][iii] =   yyynorm;
		 mask[jjj+1][iii] =  - yyynorm;
		}

	if ( xxxnorm > 0.0005) 
		{mask[jjj][iii] =  1- xxxnorm;
		 mask[jjj][iii+1] =   xxxnorm;
		 mask[jjj][iii-1] =  - xxxnorm;
		}
	
	if ( xxxnorm < -0.0005) 
	{	
		mask[jjj][iii] =  1+ xxxnorm;
		 mask[jjj][iii+1] =   xxxnorm;
		 mask[jjj][iii-1] =  - xxxnorm;
	}
	
	if ( yyynorm < -.005 &&  xxxnorm < -.005)
	{
		 mask[jjj+1][iii-1] =  -ykdata -xkdata;
		 mask[jjj-1][iii+1] =  ykdata + xkdata;
	}


	if ( yyynorm > 0.005 &&  xxxnorm > .005)
	{
		 mask[jjj-1][iii+1] =  ykdata + xkdata;
		 mask[jjj+1][iii-1] =  -ykdata - xkdata;
	}


	if ( yyynorm > .005 && xxxnorm < -.005)
	{
		 mask[jjj-1][iii-1] =  ykdata -xkdata;
		 mask[jjj+1][iii+1] =  -ykdata +xkdata;
	}


	if ( yyynorm < -.005 &&  xxxnorm > .005)
	{
		 mask[jjj+1][iii+1] =  -ykdata + xkdata;
		 mask[jjj-1][iii-1] =  ykdata - xkdata;
	}
	// since mask points at nmasks data, nmask should be modified.
	return nmask ;
}
}






