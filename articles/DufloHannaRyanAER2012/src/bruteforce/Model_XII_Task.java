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
import java.util.Random;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class Model_XII_Task implements Serializable, Callable<StateSpaceIID> {

    private double[] x;
    private Random rng;
    private int daysInLongestMonth;
    static NormalDistribution stdNormal = new NormalDistribution();

    /** Creates a new instance of GenerateHistoryTask */
    public Model_XII_Task(double[] x, long seed, int daysInLongestMonth) {
        this.x = x;
        this.daysInLongestMonth = daysInLongestMonth;
        rng = new Random(seed);
    }

    public StateSpaceIID call() throws Exception {
        double beta = x[1];
        double mu = x[2] + x[3] * stdNormal.inverse(rng.nextDouble());

        return new StateSpaceIID(beta, mu, daysInLongestMonth);
    }
}
