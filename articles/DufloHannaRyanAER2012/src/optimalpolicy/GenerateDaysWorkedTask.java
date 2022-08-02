/*
 * GenerateDaysWorkedTask.java
 *
 * Created on August 18, 2006, 4:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package optimalpolicy;

import data.SimulatedHistoryData;
import bruteforce.*;
import constants.TeacherConstants;
import JSci.maths.statistics.NormalDistribution;
import data.FullHistoryData;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class GenerateDaysWorkedTask implements Serializable, Callable<SimulatedHistoryData> {

    private double[] x;
    private int numHolidays;
    private int numberWorkDaysInMonth;
    private long seed;
    public ArrayList<Jama.Matrix> actionList; // everyone can share the same one
    private double frequency;
    private double numSims;

    /** Creates a new instance of GenerateHistoryTask */
    public GenerateDaysWorkedTask(double[] xPassed, long seed, int numHolidays, int numberWorkDaysInMonth, boolean fullHistory, double numSims, double frequency) {
        x = new double[xPassed.length];
        for (int i = 0; i < xPassed.length; i++) {
            x[i] = xPassed[i];
        }
        this.numHolidays = numHolidays;
        this.numberWorkDaysInMonth = numberWorkDaysInMonth;
        this.seed = seed;
        this.frequency = frequency;
        this.numSims = numSims;
    }

    /* IDEA: Instead of generating lots of the state spaces, many of which are almost exactly the same
     * Why don't I instead generate lots of histories for each state space that I generate?
     */
    public SimulatedHistoryData call() throws Exception {
        // outputCallMessage();
        SimulatedHistoryData data = new SimulatedHistoryData();
        Random rng = new Random(seed);
        rng = new Random(rng.nextLong()); // this should decouple the errors in the simulation from the draws on heterogeneity while preserving the same answer for
        // each guess
        double numDaysWorked = 0;
        double expectedCost = 0;
        double counter = 0;

        for (int ij = 0; ij < TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE; ij++) {
            double beta = x[1];
            double mudraw = x[2];
            double rho = 0;
            if (TeacherConstants.MODEL_VIII) {
                // model VIII is type types without rho
                x[3] = Math.max(1E-100, x[3]);
                NormalDistribution muNormal = new NormalDistribution(x[2], x[3]);
                mudraw = muNormal.inverse(rng.nextDouble());

                x[4] = Math.max(x[2] + (1.0E-15), x[4]); // this assure it is always to the right of x[2]
                x[5] = Math.max(1.0E-100, x[5]);
                NormalDistribution muNormal2 = new NormalDistribution(x[4], x[5]);

                x[6] = Math.max(0, x[6]);
                x[6] = Math.min(1, x[6]); // bound that probability
                if (rng.nextDouble() < x[6]) {
                    mudraw = muNormal2.inverse(rng.nextDouble());
                }
                StateSpaceIID space = new StateSpaceIID(beta, mudraw, numberWorkDaysInMonth);
                for (int i = 0; i < numSims; i++) {
                    FullHistoryData fh = space.generateFullHistory(numHolidays, numberWorkDaysInMonth);
                    expectedCost += fh.getCost();
                    numDaysWorked += fh.getNumberDaysWorked();
                    counter++;
                }
            } else {
                if (TeacherConstants.MODEL_VII) {
                    x[3] = Math.max(x[3], -0.9);
                    x[3] = Math.min(x[3], 0.9);
                    rho = x[3];
                } else {
                    if (x.length > 3) {
                        x[3] = Math.max(x[3], -0.9);
                        x[3] = Math.min(x[3], 0.9);
                        rho = x[3];
                    }
                    if (x.length > 4) {
                        x[4] = Math.max(1.0E-100, x[4]);
                        NormalDistribution muNormal = new NormalDistribution(x[2], x[4]);
                        mudraw = muNormal.inverse(rng.nextDouble());
                    }
                    if (x.length > 5) {
                        x[5] = Math.max(x[2] + (1.0E-15), x[5]); // this assure it is always to the right of x[2]
                        x[6] = Math.max(1.0E-100, x[6]);
                        NormalDistribution muNormal2 = new NormalDistribution(x[5], x[6]);

                        x[7] = Math.max(0, x[7]);
                        x[7] = Math.min(1, x[7]); // bound that probability
                        if (rng.nextDouble() < x[7]) {
                            mudraw = muNormal2.inverse(rng.nextDouble());
                        }
                    }
                }
                StateSpaceFast space = new StateSpaceFast(beta, mudraw, rho, seed, numberWorkDaysInMonth);

                for (int i = 0; i < numSims; i++) {
                    FullHistoryData fh = space.generateFullHistory(numHolidays, numberWorkDaysInMonth);
                    expectedCost += fh.getCost();
                    numDaysWorked += fh.getNumberDaysWorked();
                    counter++;
                }
            }
        }
        if (numDaysWorked > 0) {
            numDaysWorked /= counter;
        }
        if (expectedCost > 0) {
            expectedCost /= counter;
        }
        numDaysWorked *= frequency;
        expectedCost *= frequency;
        data.setExpectedNumberDaysWorked(numDaysWorked);
        data.setExpectedCost(expectedCost);
        // outputReturnMessage();
        return data;
    }
}
