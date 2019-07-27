h21539
s 00315/00000/00000
d D 1.1 99/09/24 18:57:13 aalx 1 0
c date and time created 99/09/24 18:57:13 by aalx
e
u
U
f e 0
t
T
I 1
/* SCCS  %W%---%G%--%U% */
/* old kversion @(#)CrowleyFrame.mod	1.8 --- 08/05/99 -- 13:56:11 : jversion  @(#)CrowleyFrame.mod	1.2---04/23/99--18:32:18 */
verbatim_NSLJ;
import java.awt.*;
import java.awt.event.*;
import java.lang.*;
import nslj.src.nsls.struct.*;  // these are the script commands

class SaccadeParameterPlot extends java.awt.Panel {
  Rectangle r_border;
  int gap_time, sac_amp;
  int targ_duration;

  SaccadeParameterPlot() {
    setBackground(Color.white);
    gap_time = 0;
    sac_amp = 3;
    targ_duration = 100;
  }

  public void setDuration(int dur){
    targ_duration = dur;
  }

  public void setTime(int time) {
    gap_time = time;
  }

  public void setAmp(int amp) {
    sac_amp = amp;
  }

  public void paint(Graphics g) {
    int gx0, gx1, gy0, gy1;
    int x0, x1, y0, y1;
    int i;

    r_border = getBounds();
    // Draw grid
    gx0 = r_border.width / 10;
    gx1 = r_border.width - gx0;
    gy0 = r_border.height / 10;
    gy1 = r_border.height - gy0;
    g.setColor(Color.black);
    g.drawLine(gx0,gy1,gx1,gy1); // X-axis
    g.drawLine(gx0,gy0,gx0,gy1); // Y-axis
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
    // Y-ticks
    x0 = gx0 - 5;
    x1 = gx0 + 5;
    for(i=0;i<=7;i++){
      y0 = y1 = gy1 - ((gy1 - gy0) * i)/7;
      g.drawLine(x0,y0,x1,y1);
      g.drawString(Integer.toString(i),x0-10,y0+5);
    }
    // Start of saccade
    g.setColor(Color.blue);
    y0 = gy0;
    y1 = gy1;
    x0 = x1 = gx0 + 4*(gx1 - gx0)/12;
    g.drawLine(x0,y0,x1,y1);
    g.drawString("Saccade start",x0+5,y0+10);
    // target dissappearance
    g.setColor(Color.magenta);
    y0 = gy1;
    y1 = gy1 - (gy1 - gy0)/2;
    x0 = x1 = gx0 + (200+targ_duration) * (gx1 - gx0)/(12*50);
    g.drawLine(x0,y0,x1,y1);
    g.drawString("Target duration",x0+5,y0+(y1-y0)/2);
    g.drawString(Double.toString(targ_duration/1000.),x0+5,y0+(y1-y0)/2+8);
    // fixation point dissappearance
    g.setColor(Color.red);
    y0 = gy1;
    y1 = gy1 - (gy1 - gy0)/2;
    x0 = x1 = gx0 + gap_time * (gx1 - gx0)/(12*50);
    g.drawLine(x0,y0,x1,y1);
    g.drawString("Fixation off",x0+5,y0+(y1-y0)/2-18);
    g.drawString(Double.toString((gap_time - 200)/1000.),x0+5,y0+(y1-y0)/2-10);
    // Amplitude
    x0 = gx0 + (gx1 - gx0)/2;
    x1 = gx1;
    y0 = y1 = gy1 - sac_amp * (gy1 - gy0)/4;
    g.drawLine(x0,y0,x1,y1);
    g.drawString(Integer.toString(sac_amp),x0+(x1-x0)/2-5,y0-5);
  }
}

class GapSaccade extends ExperimentInterface implements ActionListener {
  Panel p_amp, p_time;
  Scrollbar sb_time, sb_amp, sb_dur;
  Button b_acc;
  SaccadeParameterPlot p_spp;
  VISINPUT visinput;

  GapSaccade(VISINPUT vis) {
    visinput = vis;
    sb_amp = new Scrollbar(Scrollbar.VERTICAL, 1, 1, 0, 4);
    sb_amp.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	p_spp.setAmp(4-sb_amp.getValue());
	b_acc.setEnabled(true);
	p_spp.repaint();
      }
    });

    sb_time = new Scrollbar(Scrollbar.HORIZONTAL, 0, 1, 0, 28);
    sb_time.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	p_spp.setTime(sb_time.getValue()*25);
	b_acc.setEnabled(true);
	p_spp.repaint();
      }
    });
    
    sb_dur = new Scrollbar(Scrollbar.HORIZONTAL, 4, 1, 0, 16);
    sb_dur.addAdjustmentListener(new AdjustmentListener() {
      public void adjustmentValueChanged(AdjustmentEvent e){
	p_spp.setDuration(sb_dur.getValue()*25);
	b_acc.setEnabled(true);
	p_spp.repaint();
      }
    });
    
    b_acc = new Button("Apply");
    b_acc.addActionListener(this);

    p_amp = new Panel();
    p_amp.setLayout(new FlowLayout());
    p_amp.add(sb_amp);
    p_amp.add(new Label("Amp"));
	
    p_time = new Panel();
    p_time.setLayout(new FlowLayout(FlowLayout.CENTER));
    p_time.add(sb_time);
    p_time.add(new Label("Gap time"));
    p_time.add(sb_dur);
    p_time.add(new Label("Target duration"));
    p_time.add(b_acc);

    p_spp = new SaccadeParameterPlot();

    setLayout(new BorderLayout());
    add("North", new Label("General Saccade Controls",Label.CENTER));
    add("Center",p_spp);
    add("East",p_amp);
    add("South",p_time);
  }

  public void Finalize(){
    int x,y;
    double ts, te;

    // Clear events
    visinput.resetIlluminations();
    // fixation
    x = 4;
    y = 4;
    ts = 0.;
    te = (double)(sb_time.getValue()*25./1000.);
    visinput.addIllumination(y,x,60.0,ts,te);
    System.out.println("Params: ts: "+ts+" te: "+te);
    // Target
    x = 4+4-sb_amp.getValue();
    y = 4;
    ts = 0.2;
    te = (double)(.2+sb_dur.getValue()*25./1000.);
    visinput.addIllumination(y,x,60.0,ts,te);
    System.out.println("Params: ts: "+ts+" te: "+te);
  }

  public void actionPerformed(ActionEvent e){

    String s = e.getActionCommand();
    if("Apply".equals(s)){
      Finalize();
      // Disable button
      b_acc.setEnabled(false);
    }
  }

  public Dimension getPreferredSize(){
    Dimension d = new Dimension(400,350);
    return d;
  }

}

public class CrowleyFrame extends java.awt.Frame implements ActionListener {
  Component cur_exp;
  Component cur_title;
  Panel p_action;
  CrowleyParams cp;
  VISINPUT visinput;
  Med med;


  CrowleyFrame(String name,VISINPUT vi, Med m){ this(vi,m);}
  CrowleyFrame(VISINPUT vi, Med m){
    Label l_tmp;
    MenuItem mi;
    Button b_tmp;

    visinput = vi;
    med = m;
    Menu m_file = new Menu("File");
    mi = m_file.add(new MenuItem("Load"));
    mi.addActionListener(this);
    mi = m_file.add(new MenuItem("Save"));
    mi.addActionListener(this);
    mi = m_file.add(new MenuItem("Exit"));
    mi.addActionListener(this);
    Menu m_exp = new Menu("Experiment");
    mi = m_exp.add(new MenuItem("Gap saccade"));
    mi.addActionListener(this);
    mi = m_exp.add(new MenuItem("Double saccade"));
    mi.addActionListener(this);
    Menu m_sim = new Menu("Simulation");
    mi = m_sim.add(new MenuItem("Start"));
    mi.addActionListener(this);
    mi = m_sim.add(new MenuItem("Stop"));
    mi.addActionListener(this);
    mi = m_sim.add(new MenuItem("Continue"));
    mi.addActionListener(this);
    mi = m_sim.add(new MenuItem("Parameters"));
    mi.addActionListener(this);
    MenuBar mbar = new MenuBar();
    mbar.add(m_file);
    mbar.add(m_exp);
    mbar.add(m_sim);
    setMenuBar(mbar);

    p_action = new Panel();
    b_tmp = new Button("Start");
    b_tmp.addActionListener(this);
    p_action.add(b_tmp);
    b_tmp = new Button("Stop");
    b_tmp.addActionListener(this);
    p_action.add(b_tmp);
    b_tmp = new Button("Continue");
    b_tmp.addActionListener(this);
    p_action.add(b_tmp);

    l_tmp = new Label("Choose experiment",Label.CENTER);
    cur_title = new Label("");
    cur_exp = l_tmp;
    add("Center",l_tmp);
    add("North",cur_title);

    cp = new CrowleyParams();

    pack();
    setSize(400,200);
  }

  public void actionPerformed(ActionEvent e){
    String s = e.getActionCommand();

    if("Parameters".equals(s)){
      cp.setVisible(true);
    }
    else if("Load".equals(s)){
      System.out.println("Sorry - not implemented yet!");
    }
    else if("Save".equals(s)){
      System.out.println("Sorry - not implemented yet!");
    }
    else if("Exit".equals(s)){
      System.exit(0);
    }
    else if("Start".equals(s)){
      System.out.println("Executing initrun");
      nslj.src.nsls.struct.Executive.interpreter.execute("init");
      System.out.println("Executing run");
      ((ExperimentInterface)cur_exp).Finalize();
      nslj.src.nsls.struct.Executive.interpreter.execute("step 1");
      nslj.src.nsls.struct.Executive.interpreter.execute("cont");
    }
    else if("Stop".equals(s)){
      System.out.println("Sorry! Can't stop this thing!");
    }
    else if("Continue".equals(s)){
      nslj.src.nsls.struct.Executive.interpreter.execute("cont");
    }
    else if("Gap saccade".equals(s)){
      remove(cur_exp);
      remove(cur_title);
      cur_title = new Label("Gap Saccade",Label.CENTER);
      cur_exp = new GapSaccade(visinput);
      add("North",cur_title);
      add("Center",cur_exp);
      add("South",p_action);
      pack();
    }
    else if("Double saccade".equals(s)){
      remove(cur_exp);
      remove(cur_title);
      cur_title = new Label("Double Saccade",Label.CENTER);
      cur_exp = new DoubleSaccade(visinput,med);
      add("North",cur_title);
      add("Center",cur_exp);
      add("South",p_action);
      pack();
    }
  }
}
verbatim_off;
E 1
