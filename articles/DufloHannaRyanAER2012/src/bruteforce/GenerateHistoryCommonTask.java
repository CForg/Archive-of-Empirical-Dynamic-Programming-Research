/*
 * GenerateHistoryTask.java
 *
 * Created on August 18, 2006, 4:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package bruteforce;

import constants.TeacherConstants;
import Jama.Matrix;
import data.FullHistoryData;
import java.util.ArrayList;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class GenerateHistoryCommonTask implements Callable<Jama.Matrix> {
    
    private int numHolidays;
    private int numberWorkDaysInMonth;
    private StateSpaceFast s;
    private boolean fullHistory;
    private double frequency;
    private int[] epsilons;
    
    private ArrayList<Jama.Matrix> actionList;
    private Matrix binaryConverter;
    
    /** Creates a new instance of GenerateHistoryTask
     * @param s StateSpaceFast used to generate work sequences
     * @param numHolidays Number of paid holidays
     * @param numberWorkDaysInMonth Length of month in terms of maximum number of days they could work
     * @param randomSeed Seed for the random number generator so that the same parameter gives the same answer each time
     */
    public GenerateHistoryCommonTask(StateSpaceFast s, int numHolidays, int numberWorkDaysInMonth, boolean fullHistory, double frequency, int[] epsilons, ArrayList<Jama.Matrix> actionList) {
        this.numHolidays = numHolidays;
        this.actionList = actionList;
        this.numberWorkDaysInMonth = numberWorkDaysInMonth;
        this.s = s;
        this.fullHistory = fullHistory;
        this.epsilons = epsilons;
        this.frequency = frequency;
        
        binaryConverter = new Jama.Matrix(1, TeacherConstants.NUM_PERIODS_MATCH);
        for (int j = TeacherConstants.NUM_PERIODS_MATCH - 1; j >= 0; j--) {
            binaryConverter.set(0, j, Math.pow(2, TeacherConstants.NUM_PERIODS_MATCH - 1 - j));
        }
    }
    
    public Matrix call() throws Exception {
        Jama.Matrix expectedProbs = new Jama.Matrix(actionList.size() - 1, 1);
        if (fullHistory) {
            FullHistoryData fhd = s.generateFullHistory(numHolidays, numberWorkDaysInMonth);
            int index = (int) binaryConverter.times(fhd.getFullHistory()).get(0,0);
            if (index < actionList.size() - 1) {
                expectedProbs.set(index, 0, expectedProbs.get(index, 0) + 1);
            }
        } else {
            int index = (int) binaryConverter.times(s.generateHistory(numHolidays, numberWorkDaysInMonth, epsilons)).get(0,0);
            if (index < actionList.size() - 1) {
                expectedProbs.set(index, 0, expectedProbs.get(index, 0) + 1);
            }
        }
        return expectedProbs.times(frequency);
    }
}
