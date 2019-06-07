/* Generated By:JJTree: Do not edit this line. ASTFormalParameters.java */

/* SCCS  %W--- %G% -- %U% */

// Copyright: Copyright (c) 1997-2002 University of Southern California Brain Project.
// Copyright: This software may be freely copied provided the toplevel
// Copyright: COPYRIGHT file is included with each such copy.
// Copyright: Email nsl@java.usc.edu.

// Author: Salvador Marmol

public class ASTFormalParameters extends SimpleNode {
    public ASTFormalParameters(int id) {
        super(id);
    }

    public ASTFormalParameters(NslParser p, int id) {
        super(p, id);
    }


    /**
     * Accept the visitor.
     **/
    public Object jjtAccept(NslParserVisitor visitor, Object data) {
        return visitor.visit(this, data);
    }

    public String[] getTypes() {
        int numTypes = jjtGetNumChildren();
        String[] types = new String[numTypes];
        ASTFormalParameter formal;
        for (int i = 0; i < numTypes; i++) {
            formal = (ASTFormalParameter) jjtGetChild(i);
            types[i] = formal.getType();
        }
        return types;
    }

    public String[] getNames() {
        int numNames = jjtGetNumChildren();
        String[] names = new String[numNames];
        ASTFormalParameter formal;
        for (int i = 0; i < numNames; i++) {
            formal = (ASTFormalParameter) jjtGetChild(i);
            names[i] = formal.getName();
        }
        return names;
    }
}