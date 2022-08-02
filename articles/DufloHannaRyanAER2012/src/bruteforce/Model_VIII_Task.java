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
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class Model_VIII_Task implements Serializable, Callable<StateSpaceIID> {

    private double[] x;
    private Random rng;
    private int daysInLongestMonth;
    static NormalDistribution stdNormal = new NormalDistribution();

    /** Creates a new instance of GenerateHistoryTask */
    public Model_VIII_Task(double[] x, long seed, int daysInLongestMonth) {
        this.x = x;
        this.daysInLongestMonth = daysInLongestMonth;
        rng = new Random(seed);
    }

    public StateSpaceIID call() throws Exception {
        double beta = x[1];
        double mu = 0;
        double probType2 = x[6]; // Math.exp(x[6]) / (1.0 + Math.exp(x[6]));
        // System.out.println(x[6]+" "+probType2);
        // double probType2 = x[6];
        // if (rng.nextDouble() < x[6]) {
        if (rng.nextDouble() < probType2) {
            // NormalDistribution muNormal2 = new NormalDistribution(x[4], x[5]*x[5]);
            // mu = muNormal2.inverse(rng.nextDouble());
            mu = x[4] + Math.sqrt(x[5]) * stdNormal.inverse(rng.nextDouble());
        } else {
            // NormalDistribution muNormal = new NormalDistribution(x[2], x[3]*x[3]);
            // mu = muNormal.inverse(rng.nextDouble());
            mu = x[2] + Math.sqrt(x[3]) * stdNormal.inverse(rng.nextDouble());
        }

        return new StateSpaceIID(beta, mu, daysInLongestMonth);
    }
}
