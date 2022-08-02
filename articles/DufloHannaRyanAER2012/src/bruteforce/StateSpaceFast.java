/*
 * StateSpaceFast.java
 *
 * Created on June 19, 2006, 10:50 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package bruteforce;

import Jama.Matrix;
import constants.TeacherConstants;
import JSci.maths.statistics.NormalDistribution;
import data.FullHistoryData;
import java.text.NumberFormat;
import javax.swing.table.AbstractTableModel;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class StateSpaceFast extends AbstractTableModel {

    private double[][][] v;
    private boolean[][][] p;
    private double rho;
    private double beta;
    private double mu;
    private EpsilonFactory epsFactory;
    private long randomSeed;
    private int numberWorkDaysInMonth;
    private double FINANCIAL_BONUS;
    private double FINANCIAL_CUTOFF;
    static NormalDistribution normal = new NormalDistribution();
    static NumberFormat nf = NumberFormat.getInstance();
    static String[] colName = {"Time", "PreviousDaysWorked", "Epsilon", "Value", "Work"};

    /** Creates a new instance of StateSpaceFast
     * @param beta The marginal utility of income parameter
     * @param mu Average outside option utility
     * @param rho Serial dependence parameter
     * @param randomSeed To keep draws of epsilons constant over function evaluations we use a starting seed in the RNG
     * @param numberWorkDaysInMonth Number of days in the month it is possible to work
     */
    public StateSpaceFast(double beta, double mu, double rho, long randomSeed, int numberWorkDaysInMonth) {
        this.rho = rho;
        this.beta = beta;
        this.mu = mu;
        this.randomSeed = randomSeed;
        this.numberWorkDaysInMonth = numberWorkDaysInMonth;
        FINANCIAL_BONUS = TeacherConstants.BONUS;
        FINANCIAL_CUTOFF = TeacherConstants.BONUS_CUTOFF;
        initializeStateSpace();
    }

    public StateSpaceFast(double beta, double mu, double rho, long randomSeed, int numberWorkDaysInMonth, double bonus, double cutoff) {
        this.rho = rho;
        this.beta = beta;
        this.mu = mu;
        this.randomSeed = randomSeed;
        this.numberWorkDaysInMonth = numberWorkDaysInMonth;
        FINANCIAL_BONUS = bonus;
        FINANCIAL_CUTOFF = cutoff;
        initializeStateSpace();
    }

    public String getCondensedView() {
        // here I want to integrate out over the error term to get a probability of working at every
        // state in the system, unconditional on the error term (so the econometrician's view of whether or not
        // the agent is going to work)
        String s = new String();
        for (int t = 1; t <= numberWorkDaysInMonth + 1; t++) {
            for (int d = 0; d < t; d++) {
                // here is where i need to integrate over the probability of working
                double probWork = 0;
                double value = 0;

                for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
                    double left = epsFactory.epsilon[eps1] - (epsFactory.INTERVAL / 2.0);
                    double right = epsFactory.epsilon[eps1] + (epsFactory.INTERVAL / 2.0);
                    if (eps1 == 0) {
                        left = -100000;
                    }
                    if (eps1 == epsFactory.NUM_SUPPORT_POINTS - 1) {
                        right = 100000;
                    }
                    if (p[t][d][eps1]) {
                        probWork += (normal.cumulative(right) - normal.cumulative(left)) * 1;
                    }
                    value += (normal.cumulative(right) - normal.cumulative(left)) * v[t][d][eps1];
                }

                s = s.concat("t: " + t + " d: " + d + " V: " + nf.format(value) + " work: " + (probWork) + "\n");
            }
        }
        return s;
    }

    public double[][] getUnconditionalValueFunction(int maxDays) {
        double[][] uv = new double[maxDays][maxDays];
        for (int t = 1; t <= maxDays; t++) {
            for (int d = 0; d < t; d++) {
                double value = 0;

                for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
                    double left = epsFactory.epsilon[eps1] - (epsFactory.INTERVAL / 2.0);
                    double right = epsFactory.epsilon[eps1] + (epsFactory.INTERVAL / 2.0);
                    if (eps1 == 0) {
                        left = -100000;
                    }
                    if (eps1 == epsFactory.NUM_SUPPORT_POINTS - 1) {
                        right = 100000;
                    }
                    value += (normal.cumulative(right) - normal.cumulative(left)) * v[t][d][eps1];
                }
                uv[t - 1][d] = value;
            }
        }
        return uv;
    }

    public double[][] getUnconditionalPolicyFunction(int maxDays) {
        double[][] up = new double[maxDays][maxDays];
        for (int t = 1; t <= maxDays; t++) {
            for (int d = 0; d < t; d++) {
                double probWork = 0;

                for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
                    double left = epsFactory.epsilon[eps1] - (epsFactory.INTERVAL / 2.0);
                    double right = epsFactory.epsilon[eps1] + (epsFactory.INTERVAL / 2.0);
                    if (eps1 == 0) {
                        left = -100000;
                    }
                    if (eps1 == epsFactory.NUM_SUPPORT_POINTS - 1) {
                        right = 100000;
                    }
                    if (p[t][d][eps1]) {
                        probWork += (normal.cumulative(right) - normal.cumulative(left)) * 1;
                    }
                }
                up[t - 1][d] = probWork;
            }
        }
        return up;
    }

    private Matrix generateBlockHistory(int numHolidays, int daysInThisMonth) {
        Jama.Matrix history = new Jama.Matrix(TeacherConstants.NUM_BLOCKS, 1);
        int numWorkDays = Math.min(TeacherConstants.NUM_BLOCKS * TeacherConstants.LENGTH_WORK_BLOCK, daysInThisMonth - numHolidays);

        int[] epsilons = epsFactory.drawEpsilonIndex(numWorkDays);

        int numDaysWorked = numHolidays;
        int differenceInDays = numberWorkDaysInMonth - daysInThisMonth;

        Jama.Matrix underlyingHistory = new Jama.Matrix(numWorkDays, 1);

        int counter = 0;
        int shift = differenceInDays + numHolidays;
        for (int t = 1; t <= numWorkDays; t++) {
            if (p[t + shift][numDaysWorked][epsilons[t - 1]]) {
                underlyingHistory.set(counter, 0, 1);
                numDaysWorked++;
            }
            counter++;
        }

        int numWorkedInBlock = 0;
        counter = 0;
        int blockCounter = 0;
        for (int t = 0; t < numWorkDays; t++) {
            numWorkedInBlock += underlyingHistory.get(t, 0);
            counter++;
            if (counter == TeacherConstants.LENGTH_WORK_BLOCK) {
                counter = 0;
                if (numWorkedInBlock >= TeacherConstants.WORK_BLOCK_THRESHOLD) {
                    history.set(blockCounter, 0, 1);
                }
                blockCounter++;
                numWorkedInBlock = 0;
            }
        }

        return history;
    }

    private void initializeStateSpace() {
        epsFactory = new EpsilonFactory(rho, randomSeed);
        // re-initialized epsilon factory
        // System.out.println("Initialized epsilon factory, randomseed = "+randomSeed);

        v = new double[numberWorkDaysInMonth + 2][numberWorkDaysInMonth + 1][epsFactory.NUM_SUPPORT_POINTS];
        p = new boolean[numberWorkDaysInMonth + 2][numberWorkDaysInMonth + 1][epsFactory.NUM_SUPPORT_POINTS];

        double[][] transitionProbability = new double[epsFactory.NUM_SUPPORT_POINTS][epsFactory.NUM_SUPPORT_POINTS];
        for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
            for (int eps2 = 0; eps2 < epsFactory.NUM_SUPPORT_POINTS; eps2++) {
                transitionProbability[eps1][eps2] = epsFactory.getProbability(epsFactory.epsilon[eps1], epsFactory.epsilon[eps2], rho);
            }
        }

        // have to generate the state space here
        for (int t = numberWorkDaysInMonth + 1; t >= 1; t--) {
            for (int d = 0; d < t; d++) {
                for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
                    if (t == numberWorkDaysInMonth + 1) {
                        v[t][d][eps1] = payoffFunction(d);
                    // System.out.println("t: "+t+" d: "+d+" eps: "+epsFactory.epsilon[eps1]+" v: "+v[t][d][eps1]+" p: "+p[t][d][eps1]);
                    } else {
                        double vwork = 0;
                        double vnotwork = mu + epsFactory.epsilon[eps1];
                        for (int eps2 = 0; eps2 < epsFactory.NUM_SUPPORT_POINTS; eps2++) {
                            // System.out.println("work eps1: "+eps1+" eps2: "+eps2+" prob: "+transitionProbability[eps1][eps2]+" v[t+1][d+1][eps2]: "+v[t+1][d+1][eps2]);
                            // System.out.println("wnot eps1: "+eps1+" eps2: "+eps2+" prob: "+transitionProbability[eps1][eps2]+" v[t+1][d+1][eps2]: "+v[t+1][d][eps2]);
                            vwork += transitionProbability[eps1][eps2] * v[t + 1][d + 1][eps2];
                            vnotwork += transitionProbability[eps1][eps2] * v[t + 1][d][eps2];
                        }
                        // System.out.println("vwork: "+vwork+" vnotwork: "+vnotwork);
                        if (vwork > vnotwork) {
                            p[t][d][eps1] = true;
                            v[t][d][eps1] = vwork;
                        } else {
                            p[t][d][eps1] = false;
                            v[t][d][eps1] = vnotwork;
                        }
                    // System.out.println("t: "+t+" d: "+d+" eps: "+epsFactory.epsilon[eps1]+" v: "+v[t][d][eps1]+" p: "+p[t][d][eps1]);
                    }
                }
            }
        }
    }

    double payoffFunction(int daysWorked) {
        double pi = beta * Math.max(TeacherConstants.MINIMUM_PAYMENT, TeacherConstants.MINIMUM_PAYMENT + FINANCIAL_BONUS * (-FINANCIAL_CUTOFF + daysWorked));
        return pi;
    }

    double monetaryPayoff(int daysWorked) {
        return Math.max(TeacherConstants.MINIMUM_PAYMENT, TeacherConstants.MINIMUM_PAYMENT + FINANCIAL_BONUS * (-FINANCIAL_CUTOFF + daysWorked));
    }

    @Override
    public String toString() {
        String s = new String();
        for (int t = numberWorkDaysInMonth + 1; t >= 1; t--) {
            for (int d = 0; d < t; d++) {
                for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
                    s = s.concat("t: " + t + " d: " + d + " e: " + nf.format(epsFactory.epsilon[eps1]) + " V: " + nf.format(v[t][d][eps1]) + " work: " + (p[t][d][eps1]) + "\n");
                }
            }
        }
        return s;
    }

    public int getRowCount() {
        int size = 0;
        for (int t = 1; t <= numberWorkDaysInMonth + 1; t++) {
            for (int d = 0; d < t; d++) {
                for (int eps1 = 0; eps1 < epsFactory.NUM_SUPPORT_POINTS; eps1++) {
                    size++;
                }
            }
        }
        return size;
    }

    public int getColumnCount() {
        return 5;
    }

    @Override
    public String getColumnName(int i) {
        return colName[i];
    }

    @Override
    public Class getColumnClass(int i) {
        return getValueAt(0, i).getClass();
    }

    public Object getValueAt(int i, int i0) {
        int counter = 0;
        for (int t = numberWorkDaysInMonth + 1; t >= 1; t--) {
            for (int d = t - 1; d >= 0; d--) {
                for (int eps1 = epsFactory.NUM_SUPPORT_POINTS - 1; eps1 >= 0; eps1--) {
                    if (counter == i) {
                        if (i0 == 0) {
                            return t;
                        }
                        if (i0 == 1) {
                            return d;
                        }
                        if (i0 == 2) {
                            return epsFactory.epsilon[eps1];
                        }
                        if (i0 == 3) {
                            return v[t][d][eps1];
                        }
                        if (p[t][d][eps1]) {
                            return true;
                        }
                        return false;
                    }
                    counter++;
                }
            }
        }
        // Should never return this
        return "Megadeth";
    }

    public FullHistoryData generateFullHistory(int numHolidays, int daysInThisMonth) {
        int numWorkDays = daysInThisMonth - numHolidays;
        Jama.Matrix history = new Jama.Matrix(numWorkDays, 1);

        int[] epsilons = epsFactory.drawEpsilonIndex(numWorkDays);

        int numDaysWorked = numHolidays;
        int differenceInDays = numberWorkDaysInMonth - daysInThisMonth;

        int counter = 0;
        int shift = differenceInDays + numHolidays;
        for (int t = 1; t <= numWorkDays; t++) {
            if (p[t + shift][numDaysWorked][epsilons[t - 1]]) {
                history.set(counter, 0, 1);
                numDaysWorked++;
            }
            counter++;
        }

        FullHistoryData data = new FullHistoryData();
        data.setFullHistory(history);
        data.setCost(monetaryPayoff(numDaysWorked));
        // System.out.println("d: "+numDaysWorked+" payoff: "+monetaryPayoff(numDaysWorked));
        data.setNumberDaysWorked(numDaysWorked - numHolidays);

        return data;
    }

    public int[] getNextEpsilonSeries() {
        return epsFactory.drawEpsilonIndex(TeacherConstants.NUM_PERIODS_MATCH);
    }

    public Jama.Matrix generateHistory(int numHolidays, int daysInThisMonth) {
        if (TeacherConstants.MODEL_17) {
            return generateBlockHistory(numHolidays, daysInThisMonth);
        }
        
        Jama.Matrix history = new Jama.Matrix(TeacherConstants.NUM_PERIODS_MATCH, 1);
        int[] epsilons = epsFactory.drawEpsilonIndex(TeacherConstants.NUM_PERIODS_MATCH);

        // System.out.println(epsilons[2]);

        int numDaysWorked = numHolidays;
        int differenceInDays = numberWorkDaysInMonth - daysInThisMonth;
        int counter = 0;

        try {
            int shift = differenceInDays + numHolidays;
            // System.out.println(differenceInDays+" "+numHolidays);
            for (int t = 1; t <= TeacherConstants.NUM_PERIODS_MATCH; t++) {
                if (p[t + shift][numDaysWorked][epsilons[t - 1]]) {
                    history.set(counter, 0, 1);
                    numDaysWorked++;
                }
                counter++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return history;
    }

    public Jama.Matrix generateHistory(int numHolidays, int daysInThisMonth, int[] epsilons) {
        Jama.Matrix history = new Jama.Matrix(TeacherConstants.NUM_PERIODS_MATCH, 1);

        int numDaysWorked = numHolidays;
        int differenceInDays = numberWorkDaysInMonth - daysInThisMonth;
        int counter = 0;

        try {
            int shift = differenceInDays + numHolidays;
            // System.out.println(differenceInDays+" "+numHolidays);
            for (int t = 1; t <= TeacherConstants.NUM_PERIODS_MATCH; t++) {
                if (p[t + shift][numDaysWorked][epsilons[t - 1]]) {
                    history.set(counter, 0, 1);
                    numDaysWorked++;
                }
                counter++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return history;
    }

    public double[][][] getV() {
        return v;
    }

    public boolean[][][] getP() {
        return p;
    }
}
