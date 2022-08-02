/*
 * StateSpace.java
 *
 * Created on June 19, 2006, 10:50 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package bruteforce;

import constants.TeacherConstants;
import JSci.maths.statistics.NormalDistribution;
import data.FullHistoryData;
import java.text.NumberFormat;
import java.util.Random;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class StateSpaceIID implements StateSpaceInterface {

    static private Random rng = new Random();    
    // index by T and d
    // going one step further than that;
    // make the value function a double[time][daysworked]
    // and have a policy function which is probability of working[time][daysworked]
    private double[][] v;
    private double[][] p;    // private ArrayList<StateIID> stateList = new ArrayList<StateIID>();
    private double beta;
    private int maxDaysMonth;
    NormalDistribution normal = new NormalDistribution();
    static NumberFormat nf = NumberFormat.getInstance();

    /** Creates a new instance of StateSpace
     * @param beta The marginal utility of income parameter
     * @param mu Average outside option utility
     * @param maxDaysMonth Number of days it is possible to work in this month
     */
    public StateSpaceIID(double beta, double mu, int maxDaysMonth) {
        this.beta = beta;
        this.maxDaysMonth = maxDaysMonth;
        // need to have v be defined over T and T-1
        v = new double[maxDaysMonth + 2][maxDaysMonth + 1];
        p = new double[maxDaysMonth + 2][maxDaysMonth + 1];
        double A;
        double phi1;
        double censoringPoint;

        for (int time = maxDaysMonth + 1; time >= 1; time--) {
            for (int daysWorked = 0; daysWorked < time; daysWorked++) {
                if (time == maxDaysMonth + 1) {
                    v[time][daysWorked] = payoffFunction(daysWorked);
                    // System.out.println("t: "+time+" d: "+daysWorked+" value: "+v[time][daysWorked]);
                } else {
                    A = v[time + 1][daysWorked + 1] - v[time + 1][daysWorked];
                    censoringPoint = A - mu;
                    phi1 = normal.probability(censoringPoint);
                    double et = phi1;

                    // System.out.println("expectedEpsilon: "+expectedEpsilon);
                    // work if \epsilon + \mu + ev(t+1,d) < ev(t+1,d+1) -> \epsilon < ev(t+1,d+1)-ev(t+1,d)-\mu -> cdf(A - \mu)
                    // expected epsilon is epsilon conditional on being greater than A-\mu; 
                    p[time][daysWorked] = normal.cumulative(censoringPoint);
                    double term1 = et + (1.0 - p[time][daysWorked]) * (mu + v[time + 1][daysWorked]);
                    if (1.0 - p[time][daysWorked] <= 1E-10) {
                        term1 = 0;
                    }
                    double term2 = p[time][daysWorked] * (v[time + 1][daysWorked + 1]);
                    v[time][daysWorked] = term1 + term2;
                    // System.out.println("t: "+time+" d: "+daysWorked+" vwork: "+(v[time+1][daysWorked+1])+" vnot: "+(v[time+1][daysWorked])+" diff: "+(A)+" eps: "+(et)+" prwork: "+(p[time][daysWorked])+" value: "+(v[time][daysWorked]));
                }
            }
        }
    }

    double payoffFunction(int daysWorked) {
        double pi = beta * Math.max(TeacherConstants.MINIMUM_PAYMENT, TeacherConstants.MINIMUM_PAYMENT + TeacherConstants.BONUS * (daysWorked - TeacherConstants.BONUS_CUTOFF));
        return pi;
    }

    double monetaryPayout(int daysWorked) {
        return Math.max(TeacherConstants.MINIMUM_PAYMENT, TeacherConstants.MINIMUM_PAYMENT + TeacherConstants.BONUS * (-TeacherConstants.BONUS_CUTOFF + daysWorked));
    }

    public FullHistoryData generateFullHistory(int numHolidays, int numDaysInMonth) {
        int numWorkingDays = numDaysInMonth - numHolidays;
        FullHistoryData fhd = new FullHistoryData();
        Jama.Matrix outcome = new Jama.Matrix(numWorkingDays, 1);
        int daysWorked = numHolidays;
        int startTime = 1 + maxDaysMonth - numWorkingDays;
        for (int i = 0; i < numWorkingDays; i++) {
            if (rng.nextDouble() < p[startTime + i][daysWorked]) {
                daysWorked++;
                outcome.set(i, 0, 1);
            }
        }
        fhd.setFullHistory(outcome);
        fhd.setNumberDaysWorked(daysWorked - numHolidays);
        fhd.setCost(monetaryPayout(daysWorked));
        return fhd;
    }

    @Override
    public String toString() {
        String s = new String();
        for (int t = 1; t <= maxDaysMonth + 1; t++) {
            for (int d = 0; d < t; d++) {
                s = s.concat("t: " + t + " d: " + d + " V: " + nf.format(v[t][d]) + " work: " + (p[t][d]) + "\n");
            }
        }

        return s;
    }

    public double getProbabilityWork(int time, int daysWorked) {
        if (v[time][daysWorked] == -1) {
            System.out.println("This region not defined! t = " + time + " daysWorked = " + daysWorked);
        }
        return p[time][daysWorked];
    }
}
