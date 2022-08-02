/*
 * GenerateActionList.java
 *
 * Created on June 20, 2006, 5:22 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package bruteforce;

import java.util.ArrayList;
import utility.pmUtility;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class GenerateActionList {
    
    static int numActions;
    static int timePeriods;
    ArrayList<Jama.Matrix> actionList;
    
    /** Creates a new instance of GenerateActionList */
    public GenerateActionList(int timePeriods, int numActions) {
        GenerateActionList.timePeriods = timePeriods;
        GenerateActionList.numActions = numActions;
        ArrayList<Jama.Matrix> list = new ArrayList<Jama.Matrix>();
        Jama.Matrix startMatrix = new Jama.Matrix(timePeriods, 1);
        GenerateActionList g = new GenerateActionList(startMatrix, 0, list);
        actionList = list;
    }
    
    public GenerateActionList(Jama.Matrix matrix, int level, ArrayList<Jama.Matrix> list) {
        if(level==timePeriods-1) {
            for(int i=0;i<numActions;i++) {
                matrix.set(level, 0, i);
                list.add(matrix.copy());
                // pmUtility.prettyPrintVector(matrix);
            }
        } else {
            for(int i=0;i<numActions;i++) {
                matrix.set(level, 0, i);
                GenerateActionList go = new GenerateActionList(matrix, level+1, list);
            }
        }
        
    }
    
    public static void main(String[] args) {
        GenerateActionList go = new GenerateActionList(3, 2);
        ArrayList<Jama.Matrix> list = go.getList();
        for(int i=0;i<list.size();i++) {
            pmUtility.prettyPrintVector(list.get(i));
        }
    }

    public ArrayList<Jama.Matrix> getList() {
        return actionList;
    }
    
    
}
