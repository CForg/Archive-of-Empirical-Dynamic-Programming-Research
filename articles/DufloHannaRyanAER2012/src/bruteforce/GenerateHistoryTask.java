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
public class GenerateHistoryTask implements Serializable, Callable<Jama.Matrix> {

    private double[] x;
    private int numHolidays;
    private int numberWorkDaysInMonth;
    private long seed;
    private ArrayList<Jama.Matrix> actionList; // everyone can share the same one
    private double frequency;
    private int additionalSimulations;
    private boolean fullHistory;
    private Jama.Matrix binaryConverter;

    /** Creates a new instance of GenerateHistoryTask
     * @param xPassed Vector of unknown parameters.
     * @param seed Seed for random number generator.  Used to keep outcomes the same across replications.
     * @param numHolidays Number of holidays in month.
     * @param numberWorkDaysInMonth Number of work days in month.
     * @param fullHistory Switch to generate a full work history versus a work sequence of given length.
     * @param numSims Number of simulation draws to take in forming result.
     * @param frequency Empirical frequency of this combination of days worked and holidays.  Used for weighting outcomes.
     * @param actionList List of potential sequences.
     */
    public GenerateHistoryTask(double[] xPassed, long seed, int numHolidays, int numberWorkDaysInMonth, boolean fullHistory, int numSims, double frequency, ArrayList<Jama.Matrix> actionList) {
        x = new double[xPassed.length];
        for (int i = 0; i < xPassed.length; i++) {
            x[i] = xPassed[i];
        }
        this.numHolidays = numHolidays;
        this.numberWorkDaysInMonth = numberWorkDaysInMonth;
        this.fullHistory = fullHistory;
        this.seed = seed;
        this.frequency = frequency;
        this.actionList = actionList;
        this.additionalSimulations = numSims;

        binaryConverter = new Jama.Matrix(1, TeacherConstants.NUM_PERIODS_MATCH);
        for (int j = TeacherConstants.NUM_PERIODS_MATCH - 1; j >= 0; j--) {
            binaryConverter.set(0, j, Math.pow(2, TeacherConstants.NUM_PERIODS_MATCH - 1 - j));
        }
    }

    /* IDEA: Instead of generating lots of the state spaces, many of which are almost exactly the same
     * Why don't I instead generate lots of histories for each state space that I generate?
     */
    public Jama.Matrix call() throws Exception {
        Random rng = new Random(seed);
        rng = new Random(rng.nextLong()); // this should decouple the errors in the simulation from the draws on heterogeneity while preserving the same answer for

        Jama.Matrix expectedProbs = new Jama.Matrix(actionList.size() - 1, 1, 0);
        int counter = 0;

        for (int ij = 0; ij < TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE; ij++) {
            // each guess
            double beta = x[1];
            double mudraw = x[2];
            double rho = 0;
            if (TeacherConstants.MODEL_VII || TeacherConstants.MODEL_17) {
                x[3] = Math.max(x[3], -0.9);
                x[3] = Math.min(x[3], 0.9);
                rho = x[3];
            } else {
                if (TeacherConstants.MODEL_VIII) {
                    // model VIII is type types without rho (what the hell is going on with these parameters that i put in here?!?
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
                } else {
                    x[3] = Math.max(x[3], -0.9);
                    x[3] = Math.min(x[3], 0.9);
                    rho = x[3];
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
            }

            // System.out.println("beta: "+beta+" mu: "+mudraw+" rho: "+rho);

            StateSpaceFast space = new StateSpaceFast(beta, mudraw, rho, seed, numberWorkDaysInMonth);

            if (fullHistory) {
                expectedProbs = new Jama.Matrix(numberWorkDaysInMonth - numHolidays, 1);
                for (int i = 0; i < additionalSimulations; i++) {
                    FullHistoryData fh = space.generateFullHistory(numHolidays, numberWorkDaysInMonth);
                    // System.out.println((numberWorkDaysInMonth-numHolidays)+" "+fh.getRowDimension()+" x "+fh.getColumnDimension());
                    expectedProbs.plusEquals(fh.getFullHistory());
                }
            } else {
                for (int i = 0; i < additionalSimulations; i++) {
                    // really want to generate the expected distribution of sequences given these parameters and holidays/num work days
                    Jama.Matrix h = space.generateHistory(numHolidays, numberWorkDaysInMonth);
                    // pmUtility.prettyPrintVector(h);
                    int index = (int) binaryConverter.times(h).get(0, 0);
                    if (index < actionList.size() - 1) {
                        expectedProbs.set(index, 0, expectedProbs.get(index, 0) + 1);
                    }
                    counter++;
                }
            }
        }
        // System.out.println("------------ " + counter);
        // pmUtility.prettyPrintVector(expectedProbs);
        expectedProbs.timesEquals(1.0 / counter);
        // System.out.println("Divisor: " + TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE * additionalSimulations);
        // pmUtility.prettyPrintVector(expectedProbs);
        return expectedProbs.times(frequency);
    }
}
