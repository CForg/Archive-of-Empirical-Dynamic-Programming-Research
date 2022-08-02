/*
 * EpsilonFactory.java
 *
 * Created on June 19, 2006, 11:18 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package bruteforce;

import constants.TeacherConstants;
import JSci.maths.statistics.NormalDistribution;
import java.util.Random;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class EpsilonFactory {

    int NUM_SUPPORT_POINTS = TeacherConstants.NUM_ERRORS;
    double[] epsilon = new double[NUM_SUPPORT_POINTS];
    double INTERVAL;

    // static double[][] transitionMatrix = new double[NUM_SUPPORT_POINTS][NUM_SUPPORT_POINTS];

    public double[] getEpsilon() {
        return epsilon;
    }

    public double getINTERVAL() {
        return INTERVAL;
    }

    double RANGE;
    NormalDistribution normal = new NormalDistribution();
    private double rho;
    Random rng;

    // want the range of the approximation to grow as the number of support points grows, as well
    // range -> infinity
    // interval -> zero
    // want the range to grow slower than the interval decreases
    /** Creates a new instance of EpsilonFactory */
    public EpsilonFactory(double rho, long randomSeed) {
        this.rho = rho;
        RANGE = 2 * Math.log(NUM_SUPPORT_POINTS) + (1.0 / (1.0 - rho * rho));
        INTERVAL = RANGE / (NUM_SUPPORT_POINTS - 1);
        for (int i = 0; i < NUM_SUPPORT_POINTS; i++) {
            epsilon[i] = -(RANGE / 2.0) + INTERVAL * i;
        }
        rng = new Random(randomSeed);
        // System.out.println("EpsilonFactory.(init).randomSeed: "+randomSeed);
    }

    public synchronized int[] drawEpsilonIndex(int numEpsilonsToDraw) {
        double[] e = new double[numEpsilonsToDraw];
        double eps = Math.sqrt(1.0 / (1.0 - rho * rho)) * normal.inverse(rng.nextDouble());
        e[0] = eps;
        for (int i = 1; i < numEpsilonsToDraw; i++) {
            e[i] = rho * e[i - 1] + normal.inverse(rng.nextDouble());
        }
        int[] epsilonIndex = new int[numEpsilonsToDraw];
        // now want to round those off to the closest support
        for (int i = 0; i < numEpsilonsToDraw; i++) {
            double lowest = Math.abs(e[i] - epsilon[0]);
            int index = 0;
            for (int j = 1; j < NUM_SUPPORT_POINTS; j++) {
                if (Math.abs(e[i] - epsilon[j]) < lowest) {
                    lowest = Math.abs(e[i] - epsilon[j]);
                    index = j;
                }
            }
            e[i] = epsilon[index];
            epsilonIndex[i] = index;
        }
        return epsilonIndex;
    }

    double getProbability(double epsilon0, double epsilon1, double rhoHat) {
        double c1 = epsilon1 - INTERVAL / 2.0;
        double c2 = epsilon1 + INTERVAL / 2.0;
        double cdf1 = normal.cumulative(c1 - rhoHat * epsilon0);
        double cdf2 = normal.cumulative(c2 - rhoHat * epsilon0);
        if (epsilon1 == epsilon[0]) {
            // left endpoint case
            return cdf2;
        }
        if (epsilon1 == epsilon[NUM_SUPPORT_POINTS - 1]) {
            // right endpoint case
            return 1.0 - cdf1;
        }
        // interior cases
        return cdf2 - cdf1;
    }
    
}
