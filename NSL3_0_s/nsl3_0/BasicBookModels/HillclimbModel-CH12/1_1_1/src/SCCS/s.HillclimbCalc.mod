h07644
s 00261/00000/00000
d D 1.1 99/09/24 16:05:43 aalx 1 0
c date and time created 99/09/24 16:05:43 by aalx
e
u
U
f e 0
t
T
I 1
/* SCCS %W% --- %G% -- %U% */
/* Copyright 1999 University of Southern California Brain Lab */
/* Author: Mihai Bota */
/* Coder: Amanda Alexander and Salvador Marmol */
/* email nsl@java.usc.edu */

nslImport nslAllImports;


nslModule HillclimbCalc(int weightSize, int areaSize) {

//         int weightSize=4;
//        int areaSize=40;
        int hold_x_y_size=2;

// output ports
public 	NslDoutDouble0 x();
public 	NslDoutDouble0 y();
public 	NslDoutDouble0 distance();
public 	NslDoutDouble2 Weight(weightSize,weightSize);
public 	NslDoutDouble2 areaTrain(areaSize,areaSize);
public 	NslDoutDouble2 areaRun(areaSize,areaSize);

//variables
 	private double bound;
	private double smell;
	private double tree;
	private int countk;
	private int countj; 
	private double nvar; 
	private double z;
	private double z1;
	private double Dtree; 
	private double Dtree1; 
	private double dtree_ratio;
	private double tmp;
	private double tmp1; 
	private double idouble;
	private double jdouble;
	private int i_index;
	private int j_index;
	private NslDouble0	rr1() ;
	private NslDouble0	rr2() ;
//	private NslDouble0	k() ;
	private NslDouble1      Tree(hold_x_y_size) ; 
	private NslDouble1      north(hold_x_y_size);
	private NslDouble1 	south	(hold_x_y_size);
	private NslDouble1      west	(hold_x_y_size);
	private NslDouble1	east	(hold_x_y_size);
	private NslDouble2 	weight(weightSize,weightSize);

	private NslDouble2 	weightTrans(weightSize,weightSize);
	private NslDouble2	w  (weightSize,weightSize);
	private NslDouble1	w0(weightSize);
	private NslDouble0	kx1();
	private NslDouble0	kx2();
	private NslDouble1	dist	(weightSize);
	private NslDouble1	X	(hold_x_y_size);
	private NslDouble1	X0	(hold_x_y_size);
	
	private NslDouble1	Xinit	(hold_x_y_size);
	private NslDouble1	Y	(weightSize);
	private NslDouble1	state   (weightSize);
	private NslDouble2	stateTemp   (weightSize,1);
	private NslDouble1	stateTemp2   (weightSize);
	private NslDouble1	XX	(weightSize);
	private NslDouble2	XXTrans	(weightSize,1);

	private NslDouble1	randomVector(weightSize);
	private NslDouble1	diffT	(hold_x_y_size);
	private NslDouble1	diffT1	(hold_x_y_size);
	private NslDouble1	diff0	(hold_x_y_size);
	private NslDouble1	diff1	(hold_x_y_size);
	private NslDouble1	diff2	(hold_x_y_size);
	private NslDouble1	diff3	(hold_x_y_size);

	private int halfAreaSize;
	private int areaSizeMinus1;
	private int oneEigthAreaSize;
	
// initialize all needed parameters
public void initTrain() { 
	halfAreaSize=(int)areaSize/2;
	oneEigthAreaSize=(int)areaSize/8;
	areaSizeMinus1=areaSize-1;
	X[0]=3;
	X[1]=3;
	x=0;
	y=0;
	X0[0]=3;
	X0[1]=3;
	Xinit[0]=-3;
        Xinit[1]=-3;
	smell=7;
	tree=10;
	bound=0.005;
	Tree[0]=0;
	Tree[1]=0;
	north[0]=0;
	north[1]=oneEigthAreaSize;
	south[0]=0;
	south[1]=-oneEigthAreaSize;
	west[0]=-oneEigthAreaSize;
	west[1]=0;
	east [0]=oneEigthAreaSize;
	east[1]=0;
	nvar=0.01;
        areaTrain=0;
	areaTrain[19][0]=1;
	areaTrain[halfAreaSize][0]=1;
	areaTrain[21][0]=1;
	areaTrain[0][19]=1;
	areaTrain[0][halfAreaSize]=1;
	areaTrain[0][21]=1;
	areaTrain[39][19]=1;
	areaTrain[39][21]=1;
	areaTrain[39][halfAreaSize]=1;
	areaTrain[19][39]=1;
	areaTrain[halfAreaSize][39]=1;
	areaTrain[21][39]=1;
	areaTrain[halfAreaSize][halfAreaSize]=1;
	areaRun=areaTrain;
	weight=nslRandom(weight);
	weight=(weight*0.1)-0.05;	
	w0=0;
	state=w0;
} //end initTrain

public void simTrain() {
	makeCalculations(X,areaTrain);
} //end simTrain

public void simRun() {
	makeCalculations(Xinit,areaRun);
} //end simRun

public void makeCalculations(NslDouble1 X, NslDouble2 area) {
	diffT=(Tree-X);
	Dtree=nslDistance(diffT.get(0),diffT.get(1));

	diff0=(north-X);
	dist[0]=nslDistance(diff0.get(0),diff0.get(1));

	diff1=(south-X);
	dist[1]=nslDistance(diff1.get(0),diff1.get(1));

	diff2=(east-X);
	dist[2]=nslDistance(diff2.get(0),diff2.get(1));

	diff3=(west-X);
	dist[3]=nslDistance(diff3.get(0),diff3.get(1));

	state=w0;

	XX=(1-(dist/smell));
	XX=0.5*nslRamp(XX);

	dtree_ratio=(1-Dtree/tree);
	z=0.5*nslRamp(dtree_ratio);

        weightTrans=nslTrans(weight);
        XXTrans=nslTrans(XX);
//	state=state+nslGetColumn((weightTrans*XXTrans),0);
	//99/9/4 aa: change in future
	stateTemp=NslProd.eval(weightTrans,XXTrans);  //The * calculates product with matrix and vector.
 	stateTemp2=nslGetColumn(stateTemp,0);  // but product leaves you with a matrix n by 1.
	state=state+stateTemp2;  //vector plus vector

	randomVector=state+((nslRandom(randomVector)*0.1)-0.05);	

	// Y is a random one dimensional array of 1's and 0's
	Y=nslStep(randomVector,0,0,1); 

	if (Y[0]==1)
		X[1]=X[1]+0.25;
	if (Y[1]==1)
		X[1]=X[1]-0.25;
	if (Y[2]==1)
		X[0]=X[0]+0.25;
	if (Y[3]==1)
		X[0]=X[0]-0.25;

	// aa:changed orig since x maps to j, and y maps to i
	y=-X[0];  //X[0]=delta_i
	x=X[1];  //X[1]=delta_j
	if (X[0]>oneEigthAreaSize) {
	  nslPrintln("HillclimbCalc: Error: X[0] index out of range :" +X.get(0));
	  X[0]=oneEigthAreaSize;
	}
	if (X[0]<-oneEigthAreaSize) {
	  nslPrintln("HillclimbCalc: Error: X[0] index out of range :" +X.get(0));
	  X[0]=-oneEigthAreaSize;
	}
	if (X[1]>oneEigthAreaSize) {
	  nslPrintln("HillclimbCalc: Error: X[1] index out of range :" +X.get(1));
	  X[1]=oneEigthAreaSize;
	}
	if (X[1]<-oneEigthAreaSize) {
	  nslPrintln("HillclimbCalc: Error: X[1] index out of range :" +X.get(1));
	  X[1]=-oneEigthAreaSize;
	}
	if (X[0]<=0) {
	  idouble=halfAreaSize+(weightSize*X[0]);//i must be between 0 and 39
	} else {
	  idouble=halfAreaSize+(weightSize*X[0])-1;//i must be between 0 and 39
	}
	if (X[1]<=0) {
	  jdouble=halfAreaSize+(weightSize*X[1]);//j must be between 0 and 39
	} else {
	  jdouble=halfAreaSize+(weightSize*X[1])-1;//j must be between 0 and 39
        }

	// use to be just a cast to int
	i_index=(int)nslRint(idouble);	  
	j_index=(int)nslRint(jdouble);

	i_index=nslBound(i_index,0,areaSizeMinus1,0,areaSizeMinus1);
	j_index=nslBound(j_index,0,areaSizeMinus1,0,areaSizeMinus1);

	area[i_index][j_index]=area[i_index][j_index]+0.15;

	diffT1=(Tree-X);
	Dtree1=nslDistance(diffT1.get(0),diffT1.get(1));

	distance=Dtree1;

	dtree_ratio=(1-Dtree1/tree);
	z1=0.5*nslRamp(dtree_ratio);

	tmp=0.25*(z1-z);

	w=weight;
	w=w+tmp*Y*XX;
	kx2=10*bound;
	kx1=-kx2;
	w=nslBound(w,kx1,kx2,kx1,kx2);

	weight=w;
	Weight=10*w;
	tmp1=0.5*(z1-z);

	w0=w0+tmp1*Y;
	w0=nslBound(w0,0,bound,0,bound);

} //end makeCalculations

} //end class














E 1
