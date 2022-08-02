/*
 * GenerateHistoryTask.java
 *
 * Created on August 18, 2006, 4:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package bruteforce;

import JSci.maths.statistics.NormalDistribution;
import java.io.Serializable;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class Model_15_Task implements Serializable, Callable<StateSpaceIIDYesterday> {

    private int daysInLongestMonth;
    static NormalDistribution stdNormal = new NormalDistribution();
    private double beta;
    private double mu;
    private double yesterdayShifter;

    /** Creates a new instance of GenerateHistoryTask */
    public Model_15_Task(double beta, double mu, double yesterdayShifter, int daysInLongestMonth) {
        this.beta = beta;
        this.mu = mu;
        this.yesterdayShifter = yesterdayShifter;
        this.daysInLongestMonth = daysInLongestMonth;
    }

    public StateSpaceIIDYesterday call() throws Exception {
        return new StateSpaceIIDYesterday(beta, mu, daysInLongestMonth, yesterdayShifter);
    }
}
