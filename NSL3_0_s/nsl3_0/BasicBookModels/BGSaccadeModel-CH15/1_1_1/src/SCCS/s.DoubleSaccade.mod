h59908
s 00411/00000/00000
d D 1.1 99/09/24 18:57:15 aalx 1 0
c date and time created 99/09/24 18:57:15 by aalx
e
u
U
f e 0
t
T
I 1
/* SCCS  %W%---%G%--%U% */
/* old kversion @(#)DoubleSaccade.mod	1.8 --- 08/05/99 -- 13:56:15 */
verbatim_NSLJ;

import java.awt.*;
import java.awt.event.*;
import java.lang.*;

// panel that plots and records target locations
class SaccadeTargetLocations extends java.awt.Panel {
  // enums for reading parameter values
  public static final int FX = 0;
  public static final int FY = 1;
  public static final int X1 = 2;
  public static final int Y1 = 3;
  public static final int X2 = 4;
  public static final int Y2 = 5;
  // enums for setting mode
  public static final int M_F = 0;
  public static final int M_1 = 1;
  public static final int M_2 = 2;
  // internal variables
  private Rectangle r_border;
  private int fix_x, fix_y, t1_x, t1_y, t2_x, t2_y;
  private int mode;

  SaccadeTargetLocations() {
    setBackground(Color.white);
    fix_x = fix_y = 4;
    t1_y = t2_y = 1;
    t1_x = 5;
    t2_x = 1;
    mode = M_F;

    addMouseListener(new MouseAdapter(){
      public void mousePressed(MouseEvent e){
	int rx, ry;
	
	rx = e.getX()*9/r_border.width;
	ry = e.getY()*9/r_border.height;
	switch(mode){
	case M_F:
	  fix_x = rx;
	  fix_y = ry;
	  break;
	case M_1:
	  t1_x = rx;
	  t1_y = ry;
	  break;
	case M_2:
	  t2_x = rx;
	  t2_y = ry;
	  break;
	}
	repaint();
      }
    });

  }

  public int GetParam(int what){
    switch(what){
    case FX:
      return fix_x;
    case FY:
      return fix_y;
    case X1:
      return t1_x;
    case Y1:
      return t1_y;
    case X2:
      return t2_x;
    case Y2:
      return t2_y;
    default:
      return 0;
    }
  }
  
  public void SetMode(int new_mode){
    mode = new_mode;
  }

  public void paint(Graphics g) {
    float sx,sy;
    int i;
    int x0,y0,x1,y1;

    r_border = getBounds();
    // Compute scaling constants: dimx = dimy = 9
    sx = (float)(r_border.width/9.);
    sy = (float)(r_border.height/9.);
    // Draw box
    g.setColor(Color.black);
    g.drawRect(0, 0, r_border.width-1, r_border.height-1);
    // Draw Grid
    g.setColor(Color.lightGray);
    // Horiz lines
    x0 = 1;
    x1 = r_border.width-2;
    for(i=1;i<9;i++){
      y0 = y1 = r_border.height*i/9;
      g.drawLine(x0,y0,x1,y1);
    }
    // Vert lines
    y0 = 1;
    y1 = r_border.height-2;
    for(i=1;i<9;i++){
      x0 = x1 = r_border.width*i/9;
      g.drawLine(x0,y0,x1,y1);
    }
    // Draw targets and fixation point
    // Fixation
    g.setColor(Color.red);
    g.fillOval((int)(fix_x*sx + sx/2.) - 3, (int)(fix_y*sy + sy/2.) - 3, 7, 7);
    // First Target
    g.setColor(Color.green);
    g.fillRect((int)(t1_x*sx + sx/2.) - 3, (int)(t1_y*sy + sy/2.) - 3, 7, 7);
    // Second Target
    g.setColor(Color.blue);
    g.fillRect((int)(t2_x*sx + sx/2.) - 3, (int)(t2_y*sy + sy/2.) - 3, 7, 7);
  }

}

// Panel to show timing of targets
class SaccadeTargetDurations extends java.awt.Panel {
  public static final int FS = 0;
  public static final int FE = 1;
  public static final int T1S = 2;
  public static final int T1E = 3;
  public static final int T2S = 4;
  public static final int T2E = 5;
  
  private float fix_start, fix_end, t1_start, t1_end, t2_start, t2_end;

  SaccadeTargetDurations(){
    setBackground(Color.white);
    fix_start = (float) 0.;
    fix_end = (float) 0.2;
    t1_start = (float) 0.05;
    t1_end = (float) 0.1;
    t2_start = (float) 0.1;
    t2_end = (float) 0.15;
  }

  public void SetParam(int what, float val){
    switch(what){
    case FS:
      fix_start = val;
      break;
    case FE:
      fix_end = val;
      break;
    case T1S:
      t1_start = val;
      break;
    case T1E:
      t1_end = val;
      break;
    case T2S:
      t2_start = val;
      break;
    case T2E:
      t2_end = val;
      break;
    }
  }
  
  public void paint(Graphics g){
    Rectangle r_border;
    int gx0, gx1, gy0, gy1;
    int x0, x1, y0, y1;
    int i;

    r_border = getBounds();
    // Draw grid
    gx0 = r_border.width / 10;
    gx1 = r_border.width - gx0;
    gy0 = r_border.height / 5;
    gy1 = r_border.height - gy0;
    g.setColor(Color.black);
    g.drawLine(gx0,gy1,gx1,gy1); // X-axis
    // X-ticks
    y0 = gy1 - 5;
    y1 = gy1 + 5;
    for(i=0;i<=12;i++){
      x0 = x1 = gx0 + ((gx1 - gx0) * i)/12;
      g.drawLine(x0,y0,x1,y1);
      if(i%2 == 0){
	g.drawString(Double.toString(i*5./100.),x0-5,y1+15);
      }
    }
    // Draw time bars
    y1 = gy0/2;
    // Fixation
    g.setColor(Color.red);
    y0 = gy0;
    x0 = gx0 + (int)((fix_start/.6)*(gx1-gx0));
    x1 = (int)(((fix_end-fix_start)/.6)*(gx1-gx0));
    if(x1<=0)
      x1 = 1;
    g.fillRect(x0,y0,x1,y1);
    // T1
    g.setColor(Color.green);
    y0 = gy0*2;
    x0 = gx0 + (int)((t1_start/.6)*(gx1-gx0));
    x1 = (int)(((t1_end-t1_start)/.6)*(gx1-gx0));
    if(x1<=0)
      x1 = 1;
    g.fillRect(x0,y0,x1,y1);
    // T2
    g.setColor(Color.blue);
    y0 = gy0*3;
    x0 = gx0 + (int)((t2_start/.6)*(gx1-gx0));
    x1 = (int)(((t2_end-t2_start)/.6)*(gx1-gx0));
    if(x1<=0)
      x1 = 1;
    g.fillRect(x0,y0,x1,y1);
  }
}

public class DoubleSaccade extends ExperimentInterface implements ActionListener {
  Scrollbar sb_fix_s, sb_fix_e, sb_t1_s, sb_t1_e, sb_t2_s, sb_t2_e;
  Checkbox cb_fix, cb_t1, cb_t2;
  Button b_acc;
  SaccadeTargetLocations stl;
  SaccadeTargetDurations std;
  VISINPUT visinput;
  Med med;

  // Constructor
  DoubleSaccade(VISINPUT vi, Med m){
    Panel p1,p2,p3;
    CheckboxGroup cbg;

    System.err.println("vi:"+vi+"   med:"+m);
    visinput = vi;
    med = m;

    // Panel for selecting targets
    cbg = new CheckboxGroup();
    cb_fix = new Checkbox("Fixation",cbg,true);
    cb_fix.addItemListener(new ItemListener(){
      public void itemStateChanged(ItemEvent e){
	stl.SetMode(SaccadeTargetLocations.M_F);
	b_acc.setEnabled(true);
      }
    });
    cb_t1 = new Checkbox("Target 1",cbg,false);
    cb_t1.addItemListener(new ItemListener(){
      public void itemStateChanged(ItemEvent e){
	stl.SetMode(SaccadeTargetLocations.M_1);
	b_acc.setEnabled(true);
      }
    });
    cb_t2 = new Checkbox("Target 2",cbg,false);
    cb_t2.addItemListener(new ItemListener(){
      public void itemStateChanged(ItemEvent e){
	stl.SetMode(SaccadeTargetLocations.M_2);
	b_acc.setEnabled(true);
      }
    });
    p1 = new Panel();
    p1.setLayout(new GridLayout(0,1));
    p1.add(cb_fix);
    p1.add(cb_t1);
    p1.add(cb_t2);
    // Composite target panel
    stl = new SaccadeTargetLocations();
    p2 = new Panel();
    p2.setLayout(new BorderLayout());
    p2.add("North", new Label("Target Locations",Label.CENTER));
    p2.add("Center", stl);
    p2.add("West", p1);
    // Panel for setting times
    sb_fix_s = new Scrollbar(Scrollbar.HORIZONTAL, 0, 1, 0, 60);
    sb_fix_s.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	std.SetParam(SaccadeTargetDurations.FS, 
		     (float)(sb_fix_s.getValue()/100.));
	b_acc.setEnabled(true);
	std.repaint();
      }
    });
    sb_fix_e = new Scrollbar(Scrollbar.HORIZONTAL, 20, 1, 0, 60);
    sb_fix_e.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	std.SetParam(SaccadeTargetDurations.FE, 
		     (float)(sb_fix_e.getValue()/100.));
	std.repaint();
      }
    });
    sb_t1_s = new Scrollbar(Scrollbar.HORIZONTAL, 5, 1, 0, 60);
    sb_t1_s.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	std.SetParam(SaccadeTargetDurations.T1S, 
		     (float)(sb_t1_s.getValue()/100.));
	b_acc.setEnabled(true);
	std.repaint();
      }
    });
    sb_t1_e = new Scrollbar(Scrollbar.HORIZONTAL, 10, 1, 0, 60);
    sb_t1_e.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	std.SetParam(SaccadeTargetDurations.T1E, 
		     (float)(sb_t1_e.getValue()/100.));
	b_acc.setEnabled(true);
	std.repaint();
      }
    });
    sb_t2_s = new Scrollbar(Scrollbar.HORIZONTAL, 10, 1, 0, 60);
    sb_t2_s.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	std.SetParam(SaccadeTargetDurations.T2S, 
		     (float)(sb_t2_s.getValue()/100.));
	b_acc.setEnabled(true);
	std.repaint();
      }
    });
    sb_t2_e = new Scrollbar(Scrollbar.HORIZONTAL, 15, 1, 0, 60);
    sb_t2_e.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	std.SetParam(SaccadeTargetDurations.T2E, 
		     (float)(sb_t2_e.getValue()/100.));
	b_acc.setEnabled(true);
	std.repaint();
      }
    });
    p1 = new Panel();
    p1.setLayout(new GridLayout(0,1));
    p1.add(new Label("Fixation", Label.CENTER));
    p1.add(sb_fix_s);
    p1.add(sb_fix_e);
    p1.add(new Label("Target 1", Label.CENTER));
    p1.add(sb_t1_s);
    p1.add(sb_t1_e);
    p1.add(new Label("Target 2", Label.CENTER));
    p1.add(sb_t2_s);
    p1.add(sb_t2_e);
    // Apply button
    p1.add(b_acc = new Button("Apply"));
    b_acc.addActionListener(this);
    // Composite duration + scrollbar panel
    std = new SaccadeTargetDurations();
    p3 = new Panel();
    p3.setLayout(new BorderLayout());
    p3.add("North", new Label("Target Durations",Label.CENTER));
    p3.add("Center", std);
    // Whole shebang
    setLayout(new GridLayout(0,1));
    add(p2);
    add(p3);
    add(p1);
  }

  public void Finalize(){
    int xf,yf,x1,y1,x2,y2;
    double ts, te;

    // Clear events
    visinput.resetIlluminations();
    // fixation
    xf = stl.GetParam(SaccadeTargetLocations.FX);
    yf = stl.GetParam(SaccadeTargetLocations.FY);
    ts = (double)(sb_fix_s.getValue()/100.);
    te = (double)(sb_fix_e.getValue()/100.);
    visinput.addIllumination(yf,xf,60.0,ts,te);
    // target 1
    x1 = stl.GetParam(SaccadeTargetLocations.X1);
    y1 = stl.GetParam(SaccadeTargetLocations.Y1);
    ts = (double)(sb_t1_s.getValue()/100.);
    te = (double)(sb_t1_e.getValue()/100.);
    visinput.addIllumination(y1,x1,60.0,ts,te);
    // target 2
    x2 = stl.GetParam(SaccadeTargetLocations.X2);
    y2 = stl.GetParam(SaccadeTargetLocations.Y2);
    ts = (double)(sb_t2_s.getValue()/100.);
    te = (double)(sb_t2_e.getValue()/100.);
    visinput.addIllumination(y2,x2,60.0,ts,te);
    
    // Learn saccade
    System.out.println("Learning new double saccade");
    med.startNewElementList();
    //System.out.println("double saccade -1 ");

    // med.addNewRandomElementsToLearn(2);
    med.addNewSpecifiedElementsToLearn(y1,x1,y2,x2);
    //System.out.println("double saccade -2 ");
    med.learnNewElements();
    // med.testAllLearnedElements();
    System.out.println("Done");
  }

  public void actionPerformed(ActionEvent e){

    String s = e.getActionCommand();
    if("Apply".equals(s)){
      Finalize();
      // Set button
      b_acc.setEnabled(false);
    }
  }

  public Dimension getPreferredSize(){
    Dimension d = new Dimension(400,550);
    return d;
  }

}
verbatim_off;
E 1