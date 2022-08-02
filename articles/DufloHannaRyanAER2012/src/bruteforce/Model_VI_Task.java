/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bruteforce;

import constants.TeacherConstants;
import java.io.Serializable;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class Model_VI_Task implements Serializable, Callable<Double> {

    private double beta;
    private double mu;
    private int daysInLongestMonth;
    private int numHolidays;
    private int daysInCurrentMonth;
    private Jama.Matrix history;

    public Model_VI_Task(double beta, double mu, int daysInLongestMonth, int numHolidays, int daysInCurrentMonth, Jama.Matrix history) {
        this.beta = beta;
        this.mu = mu;
        this.daysInLongestMonth = daysInLongestMonth;
        this.numHolidays = numHolidays;
        this.daysInCurrentMonth = daysInCurrentMonth;
        this.history = history;
    }

    public Double call() throws Exception {
        double value = 0;
        StateSpaceInterface s = new StateSpaceIID(beta, mu, daysInLongestMonth);
//        try {
//            BufferedWriter out = new BufferedWriter(new FileWriter("model13_stateSpace.txt"));
//            out.write(s.toString());
//            out.close();
//            // System.exit(0);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        int daysWorked = 0;
        daysWorked += history.get(0, 0);
        int diff = daysInLongestMonth - daysInCurrentMonth;
        double outerProb = 1;
//        try {
//            BufferedWriter out = new BufferedWriter(new FileWriter("model13_firstGuy.csv"));

        // NOTE: should start this at t=1 so that we can compare the LLH across specifications!

        for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
            double prob = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays);
            boolean useProb = false;
            if (!TeacherConstants.USE_WINDOW) {
                useProb = true;
            } else {
                if (i < TeacherConstants.DAYS_WINDOW || i > (daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW - 1)) {
                    useProb = true;
                }
            }
            if (history.get(i, 0) == 1) {
                // value += Math.log(prob);
                if (useProb) {
                    outerProb *= prob;
                }
                daysWorked++;
            } else {
                // value += Math.log(1.0 - prob);
                if (useProb) {
                    outerProb *= (1.0 - prob);
                }
            }
//                out.write(i + "," + prob + "," + daysWorked + "\n");
            }
//            out.close();
//            System.exit(0);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }

        value = Math.log(outerProb);
        return value;
    }
}
