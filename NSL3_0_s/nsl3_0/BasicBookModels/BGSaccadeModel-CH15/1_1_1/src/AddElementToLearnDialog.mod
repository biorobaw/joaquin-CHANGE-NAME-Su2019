/* SCCS  @(#)AddElementToLearnDialog.mod	1.1---09/24/99--18:57:09 */
/* old  @(#)AddElementToLearnDialog.mod	1.8---08/05/99--13:56:05 */
/*
    A basic extension of the java.awt.Dialog class
 */
verbatim_NSLJ;
import java.awt.*;

public class AddElementToLearnDialog extends Dialog {
	void buttonADD_Clicked(Event event) {
		// to do: place event handler code here.

	  	  
		  try {
		    random_to_add = Integer.valueOf(random_num.getText()).intValue();
		    specific_to_add = Integer.valueOf(specific_num.getText()).intValue();
				
		    /*
		    med.addNewElementsToLearn(Integer.valueOf(random_num.getText()).intValue(),
					      Integer.valueOf(specific_num.getText()).intValue());
					      */
		  } catch (NumberFormatException e) {
		    System.err.println("Make sure all two arguments are integer type");
		    return;
		  }
		  if(random_to_add > 0) {
		    //System.out.println("Random to add"+random_to_add);
		    med.addNewRandomElementsToLearn(random_to_add);
		  }
	
		  if (specific_to_add >0) {
		    
		    lb_elem_num.setText(""+specific_to_add);
		    //    System.out.println("Specified to add"+specific_to_add);
		    panel_front.hide();
		    panel_back.show();
		  }
		  else {
		    disable();
		    dispose();  
		  }
		  return;
	}

	void buttonNEXT_Clicked(Event event) {
		// to do: place event handler code here.

	  int x_val;
	  int y_val;
	  int xo_val;
	  int yo_val;


	  if( specific_to_add>0) {	   
	    if (specific_to_add == 1) {
	      button_NEXT.setLabel("OK");
	    }
	    try {
	      x_val = Integer.valueOf(x.getText()).intValue();
	      y_val = Integer.valueOf(y.getText()).intValue();
	      xo_val = Integer.valueOf(xo.getText()).intValue();
	      yo_val = Integer.valueOf(yo.getText()).intValue();     
	      if ( ( x_val < 0 )  || ( x_val >  CorticalArraySize-1) ||
		   ( y_val < 0 )  || ( y_val >  CorticalArraySize-1) ||
		   ( xo_val < 0 ) || ( xo_val > CorticalArraySize-1) ||
		   ( yo_val < 0 ) || ( yo_val > CorticalArraySize-1) ) {
		return;
	      }
 
	      med.addNewSpecifiedElementsToLearn(x_val, y_val, xo_val, yo_val);
	    }catch (NumberFormatException e) {
		    System.err.println("Make sure all arguments are integer type");
		    return;
		  }
	    specific_to_add--;
	    lb_elem_num.setText(""+specific_to_add);
	    if (specific_to_add > 0) {
	      x.setText("0");
	      y.setText("0");
	      xo.setText("0");
	      yo.setText("0");
	      return;
	    }
	  }
	  disable();
	  dispose();  
  
	}
 	public AddElementToLearnDialog(Frame parent, boolean modal, Med med) {
	  this(parent, modal);
	  this.med = med;
	}


	public AddElementToLearnDialog(Frame parent, boolean modal) {

	    super(parent, modal);

		//{{INIT_CONTROLS
		setLayout(new CardLayout(0,0));
		addNotify();
		resize(insets().left + insets().right + 377,insets().top + insets().bottom + 300);
		panel_front = new java.awt.Panel();
		panel_front.setLayout(null);
		panel_front.reshape(insets().left,insets().top,280,265);
		//		add(panel_front);
		lb_random = new java.awt.Label("Random",Label.RIGHT);
		lb_random.reshape(28,97,100,30);
		lb_random.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_front.add(lb_random);
		lb_specific = new java.awt.Label("Specific",Label.RIGHT);
		lb_specific.reshape(28,135,100,30);
		lb_specific.setFont(new Font("Dialog", Font.PLAIN, 14));
		lb_specific.setBackground(new Color(12632256));
		panel_front.add(lb_specific);
		random_num = new java.awt.TextField();
		random_num.setText("0");
		random_num.reshape(147,97,79,30);
		random_num.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_front.add(random_num);
		specific_num = new java.awt.TextField();
		specific_num.setText("0");
		specific_num.reshape(147,135,79,30);
		specific_num.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_front.add(specific_num);
		button_ADD = new java.awt.Button("ADD");
		button_ADD.reshape(112,210,60,40);
		button_ADD.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_front.add(button_ADD);
		title = new java.awt.Label("Add Elements to Learn",Label.CENTER);
		title.reshape(14,22,252,40);
		title.setFont(new Font("Dialog", Font.PLAIN, 16));
		title.setForeground(new Color(255));
		panel_front.add(title);
		panel_front.show();

		panel_back = new java.awt.Panel();
		panel_back.setLayout(null);
		panel_back.reshape(insets().left,insets().top,280,265);
		add(panel_back);add(panel_front);
		label1 = new java.awt.Label("First Target",Label.RIGHT);
		label1.reshape(21,120,112,30);
		label1.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label1);
		x = new java.awt.TextField();
		x.setText("0");
		x.reshape(168,120,28,30);
		x.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(x);
		button_NEXT = new java.awt.Button("NEXT");
		button_NEXT.reshape(112,210,60,40);
		button_NEXT.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(button_NEXT);
		label3 = new java.awt.Label("Add Specific Elements to Learn",Label.CENTER);
		label3.reshape(14,15,252,40);
		label3.setFont(new Font("Dialog", Font.PLAIN, 16));
		label3.setForeground(new Color(255));
		panel_back.add(label3);
		y = new java.awt.TextField();
		y.setText("0");
		y.reshape(238,120,28,30);
		y.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(y);
		label4 = new java.awt.Label("x",Label.RIGHT);
		label4.reshape(147,120,21,30);
		label4.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label4);
		label5 = new java.awt.Label("y",Label.RIGHT);
		label5.reshape(217,120,21,30);
		label5.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label5);
		label2 = new java.awt.Label("Second Target",Label.RIGHT);
		label2.reshape(21,158,119,30);
		label2.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label2);
		xo = new java.awt.TextField();
		xo.setText("0");
		xo.reshape(168,158,28,30);
		xo.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(xo);
		yo = new java.awt.TextField();
		yo.setText("0");
		yo.reshape(238,158,28,30);
		yo.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(yo);
		label6 = new java.awt.Label("x",Label.RIGHT);
		label6.reshape(147,158,21,30);
		label6.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label6);
		label7 = new java.awt.Label("y",Label.RIGHT);
		label7.reshape(217,158,21,30);
		label7.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label7);
		label8 = new java.awt.Label("# of Elements to add",Label.RIGHT);
		label8.reshape(42,68,154,30);
		label8.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(label8);
		lb_elem_num = new java.awt.Label("1",Label.RIGHT);
		lb_elem_num.reshape(200,68,35,30);
		lb_elem_num.setFont(new Font("Dialog", Font.PLAIN, 14));
		panel_back.add(lb_elem_num);

		setTitle("Add Element To Learn");
		//}}
	}

	public AddElementToLearnDialog(Frame parent, String title, boolean modal) {
	    this(parent, modal);
	    setTitle(title);
	}

    public synchronized void show() {
    	Rectangle bounds = getParent().bounds();
    	Rectangle abounds = bounds();

    	move(bounds.x + (bounds.width - abounds.width)/ 2,
    	     bounds.y + (bounds.height - abounds.height)/2);

    	super.show();
    }

	public boolean handleEvent(Event event) {
	    if(event.id == Event.WINDOW_DESTROY) {
	        hide();
	        return true;
	    }
		if (event.target == button_NEXT && event.id == Event.ACTION_EVENT) {
			buttonNEXT_Clicked(event);
		}
		if (event.target == button_ADD && event.id == Event.ACTION_EVENT) {
			buttonADD_Clicked(event);
		}
		return super.handleEvent(event);
	}

	//{{DECLARE_CONTROLS
	java.awt.Panel panel_back;
	java.awt.Label label1;
	java.awt.TextField x;
	java.awt.Button button_NEXT;
	java.awt.Label label3;
	java.awt.TextField y;
	java.awt.Label label4;
	java.awt.Label label5;
	java.awt.Label label2;
	java.awt.TextField xo;
	java.awt.TextField yo;
	java.awt.Label label6;
	java.awt.Label label7;
	java.awt.Label label8;
	java.awt.Label lb_elem_num;
	java.awt.Panel panel_front;
	java.awt.Label lb_random;
	java.awt.Label lb_specific;
	java.awt.TextField specific_num;
	java.awt.TextField random_num;
	java.awt.Button button_ADD;
	java.awt.Label title;
	//}}

  int random_to_add;
  int specific_to_add;  
  Med med;
static final int CorticalArraySize = 9;
}
verbatim_off;