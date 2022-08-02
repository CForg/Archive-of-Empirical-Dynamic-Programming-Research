/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bruteforce;

import constants.TeacherConstants;
import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.Serializable;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class Model_14_Task implements Serializable, Callable<Double> {

    private double beta;
    private double mu;
    private int numHolidays;
    private int daysInCurrentMonth;
    private Jama.Matrix history;
    private double yesterdayShifter;

    public Model_14_Task(double beta, double mu, int numHolidays, int daysInCurrentMonth, Jama.Matrix history, double yesterdayShifter) {
        this.beta = beta;
        this.mu = mu;
        this.numHolidays = numHolidays;
        this.daysInCurrentMonth = daysInCurrentMonth;
        this.history = history;
        this.yesterdayShifter = yesterdayShifter;
    }

    public Double call() throws Exception {
        StateSpaceIIDYesterday s = new StateSpaceIIDYesterday(beta, mu, daysInCurrentMonth, yesterdayShifter);
//        try {
//            BufferedWriter out = new BufferedWriter(new FileWriter("model14_stateSpace.txt"));
//            out.write(s.toString());
//            out.close();
//            // System.exit(0);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        int daysWorked = 0;
        double outerProb = 1;
        int workedYesterday = 0;
        if (history.get(0, 0) == 1) {
            workedYesterday = 1;
        }
        daysWorked += workedYesterday;

        boolean outputFirstGuy = false;

        try {
            BufferedWriter out = null;
            if (outputFirstGuy) {
                out = new BufferedWriter(new FileWriter("model14_firstGuy.csv"));
            }

            for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                double prob = s.getProbabilityWork(i + 1 + numHolidays, daysWorked + numHolidays, workedYesterday);
                boolean useProb = false;
                if (!TeacherConstants.USE_WINDOW) {
                    useProb = true;
                } else {
                    if (i < TeacherConstants.DAYS_WINDOW || i > (daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW - 1)) {
                        useProb = true;
                    }
                }
                if (history.get(i, 0) == 1) {
                    if (useProb) {
                        outerProb *= prob;
                    }
                    daysWorked++;
                    workedYesterday = 1;
                } else {
                    if (useProb) {
                        outerProb *= (1.0 - prob);
                    }
                    workedYesterday = 0;
                }
                if (outputFirstGuy) {
                    out.write(i + "," + prob + "," + outerProb + "," + daysWorked + "," + numHolidays + "," + workedYesterday + "\n");
                }
            }
            if (outputFirstGuy) {
                out.write("LLH: " + Math.log(outerProb) + "\n");
                out.close();
                System.exit(0);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Math.log(outerProb);
    }
}
