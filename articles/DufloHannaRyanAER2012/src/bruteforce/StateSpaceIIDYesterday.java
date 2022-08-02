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
import java.io.Serializable;
import java.text.NumberFormat;
import java.util.Random;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class StateSpaceIIDYesterday implements Serializable {
    // this just holds together all the states in a month
    
    // index by T and d
    // going one step further than that;
    // make the value function a double[time][daysworked]
    // and have a policy function which is probability of working[time][daysworked]
    private double[][][] v;
    private double[][][] p;
    private double beta;
    private double mu;
    private int maxDaysMonth;
    NormalDistribution normal = new NormalDistribution();
    static NumberFormat nf = NumberFormat.getInstance();
    private double yesterdayShifter;

    /** Creates a new instance of StateSpace
     * @param beta The marginal utility of income parameter
     * @param mu Average outside option utility
     * @param maxDaysMonth Number of days it is possible to work in this month
     */
    public StateSpaceIIDYesterday(double beta, double mu, int maxDaysMonth, double yesterdayShifter) {
        this.beta = beta;
        this.mu = mu;
        this.maxDaysMonth = maxDaysMonth;
        this.yesterdayShifter = yesterdayShifter;

        // need to have v be defined over T and T-1
        // the third dimension is for an indicator function of whether we worked yesterday or not
        v = new double[maxDaysMonth + 2][maxDaysMonth + 1][2];
        p = new double[maxDaysMonth + 2][maxDaysMonth + 1][2];

        for (int time = maxDaysMonth + 1; time >= 1; time--) {
            for (int daysWorked = 0; daysWorked < time; daysWorked++) {
                for (int workedYesterday = 0; workedYesterday <= 1; workedYesterday++) {
                    if (time == maxDaysMonth + 1) {
                        v[time][daysWorked][workedYesterday] = payoffFunction(daysWorked);
                        // System.out.println("t: "+time+" d: "+daysWorked+" value: "+v[time][daysWorked][workedYesterday]);
                    } else {
                        double A;
                        double phi1;
                        // double expectedEpsilon;
                        double censoringPoint;
                        // the way to put in the dependence is here, no?
                        double muToday = mu;
                        if (workedYesterday == 0) {
                            muToday += yesterdayShifter;
                        }
                        A = v[time + 1][daysWorked + 1][1] - v[time + 1][daysWorked][0];
                        censoringPoint = A - muToday;

                        phi1 = normal.probability(censoringPoint);
                        // T = 1.0 - normal.cumulative(censoringPoint);
                        // expectedEpsilon = phi1 / T;
                        double expectedEpsilonTimesT = phi1;
                        // this should fix the problem

                        // System.out.println("expectedEpsilon: "+expectedEpsilon);
                        // work if \epsilon + \mu + ev(t+1,d) < ev(t+1,d+1) -> \epsilon < ev(t+1,d+1)-ev(t+1,d)-\mu -> cdf(A - \mu)
                        // expected epsilon is epsilon conditional on being greater than A-\mu;
                        p[time][daysWorked][workedYesterday] = normal.cumulative(censoringPoint);
                        double term1 = expectedEpsilonTimesT + (1.0 - p[time][daysWorked][workedYesterday]) * (mu + (1.0 - workedYesterday) * yesterdayShifter + v[time + 1][daysWorked][workedYesterday]);
                        if (1.0 - p[time][daysWorked][workedYesterday] <= 1E-10) {
                            term1 = 0;
                        }
                        double term2 = p[time][daysWorked][workedYesterday] * (v[time + 1][daysWorked + 1][workedYesterday]);
                        if (Double.isNaN(term1)) {
                            System.out.println("term1: " + term1);
                            System.out.println("t: " + time + " d: " + daysWorked + " y: " + workedYesterday + " vwork: " + nf.format(v[time + 1][daysWorked + 1][workedYesterday]) + " vnot: " + nf.format(v[time + 1][daysWorked][workedYesterday]) + " diff: " + nf.format(A) + " epsT: " + (expectedEpsilonTimesT) + " prwork: " + nf.format(p[time][daysWorked][workedYesterday]) + " value: " + nf.format(v[time][daysWorked][workedYesterday]));
                            System.out.println("Censoring point: " + censoringPoint);
                            System.exit(0);
                        }
                        if (Double.isNaN(term2)) {
                            System.out.println("term2: " + term2);
                            System.out.println("t: " + time + " d: " + daysWorked + " y: " + workedYesterday + " vwork: " + nf.format(v[time + 1][daysWorked + 1][workedYesterday]) + " vnot: " + nf.format(v[time + 1][daysWorked][workedYesterday]) + " diff: " + nf.format(A) + " epsT: " + (expectedEpsilonTimesT) + " prwork: " + nf.format(p[time][daysWorked][workedYesterday]) + " value: " + nf.format(v[time][daysWorked][workedYesterday]));
                        }
                        v[time][daysWorked][workedYesterday] = term1 + term2;
                        // System.out.println("t: "+time+" d: "+daysWorked+" vwork: "+(v[time+1][daysWorked+1][workedYesterday])+" vnot: "+(v[time+1][daysWorked][workedYesterday])+" diff: "+(A)+" eps: "+(expectedEpsilonTimesT)+" prwork: "+(p[time][daysWorked][workedYesterday])+" value: "+nf.format(v[time][daysWorked][workedYesterday]));
                    }
                }
            }
        }
        // System.out.println(this);
        // System.exit(0);
    }

    double payoffFunction(int daysWorked) {
        double pi = beta * Math.max(TeacherConstants.MINIMUM_PAYMENT, TeacherConstants.MINIMUM_PAYMENT + TeacherConstants.BONUS * (daysWorked - TeacherConstants.BONUS_CUTOFF));
        return pi;
    }

    double monetaryPayout(int daysWorked) {
        return Math.max(TeacherConstants.MINIMUM_PAYMENT, TeacherConstants.MINIMUM_PAYMENT + TeacherConstants.BONUS * (-TeacherConstants.BONUS_CUTOFF + daysWorked));
    }

    public FullHistoryData generateFullHistory(int numHolidays, int numDaysInMonth, long rngSeed) {
        Random rng = new Random(rngSeed);
        int numWorkingDays = numDaysInMonth - numHolidays;
        FullHistoryData fhd = new FullHistoryData();
        Jama.Matrix outcome = new Jama.Matrix(numWorkingDays, 1);
        int daysWorked = numHolidays;
        int startTime = 1 + maxDaysMonth - numWorkingDays;
        // what to do about the first day in the month?
        int workedYesterday = 0;
        for (int i = 0; i < numWorkingDays; i++) {
            if (rng.nextDouble() < p[startTime + i][daysWorked][workedYesterday]) {
                daysWorked++;
                outcome.set(i, 0, 1);
                workedYesterday = 1;
            } else {
                workedYesterday = 0;
            }
        }
        fhd.setFullHistory(outcome);
        fhd.setNumberDaysWorked(daysWorked - numHolidays);
        fhd.setCost(monetaryPayout(daysWorked));
        return fhd;
    }

    @Override
    public String toString() {
        System.out.println("Beta: " + beta + " Mu: " + mu + " MaxDays: " + maxDaysMonth + " YesterdayShifter: " + yesterdayShifter);
        String s = new String();
        for (int t = 1; t <= maxDaysMonth + 1; t++) {
            for (int d = 0; d < t; d++) {
                for (int y = 0; y <= 1; y++) {
                    s = s.concat("t: " + t + " d: " + d + " y: " + y + " V: " + nf.format(v[t][d][y]) + " work: " + (p[t][d][y]) + "\n");
                }
            }
        }

        return s;
    }

    public double getProbabilityWork(int time, int daysWorked, int workedYesterday) {
        if (v[time][daysWorked][workedYesterday] == -1) {
            System.out.println("This region not defined! t = " + time + " daysWorked = " + daysWorked);
        }
        double value = p[time][daysWorked][workedYesterday];
        if (Double.isNaN(value)) {
            System.out.println("In ssiidy: " + p[time][daysWorked][workedYesterday] + " beta: " + beta + " mu: " + mu + " shifter: " + yesterdayShifter + " t: " + time + " d: " + daysWorked + " y: " + workedYesterday);
            System.out.println(this);
            System.exit(0);
        }
        return p[time][daysWorked][workedYesterday];
    }
}