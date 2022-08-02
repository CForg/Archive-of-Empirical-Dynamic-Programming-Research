/*
 * MainOptimalPolicy.java
 *
 * Created on April 11, 2007, 12:17 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package optimalpolicy;

import JSci.maths.statistics.NormalDistribution;
import Jama.Matrix;
import bruteforce.GenerateActionList;
import bruteforce.Model_14_DaysWorkedTask;
import bruteforce.Model_15_DaysWorkedTask;
import bruteforce.Model_16_DaysWorkedTask;
import bruteforce.Model_20_DistributionTask;
import bruteforce.Model_XI_DaysWorkedTask;
import bruteforce.MonthHolidayType;
import bruteforce.StateSpaceIID;
import bruteforce.StateSpaceIIDYesterday;
import data.SimulatedHistoryData;
import constants.TeacherConstants;
import data.FullHistoryData;
import data.ProcessTeacherData;
import java.awt.BorderLayout;
import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.ObjectInputStream;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Random;
import java.util.TreeSet;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import javax.swing.JFrame;
import javax.swing.JProgressBar;
import javax.swing.JScrollPane;
import javax.swing.UIManager;
import utility.JTextAreaAutoscroll;
import utility.pmUtility;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class MainOptimalPolicy {

    NormalDistribution normal = new NormalDistribution();
    Random rng;
    private ArrayList<Matrix> workHistories;
    private ArrayList<Integer> daysInMonth;
    private ArrayList<Integer> teacherIDList;
    private ArrayList<Integer> holidayList;
    private ArrayList<Integer> teacherIDIndex;
    private ArrayList<Double> workedLastMonthList;
    JProgressBar bar = new JProgressBar();
    private JTextAreaAutoscroll jt = new JTextAreaAutoscroll();
    private int daysInLongestMonth;
    private ArrayList<Double> controlOpenList;
    private ArrayList<Double> testScoreList;
    private ExecutorService tpes;

    private double[] drawGuess(double[] means, double[] variances) {
        double[] guess = new double[means.length];
        for (int i = 1; i < means.length; i++) {
            guess[i] = means[i] + Math.sqrt(variances[i]) * normal.inverse(Math.random());
        }
        return guess;
    }

    public void initializeGUI() {
        JFrame f = new JFrame("Optimal Policy Counterfactual");
        f.setBounds(150, 150, 1000, 600);
        f.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        f.getContentPane().setLayout(new BorderLayout());
        f.getContentPane().add(new JScrollPane(jt), BorderLayout.CENTER);
        f.getContentPane().add(bar, BorderLayout.SOUTH);
        f.setVisible(true);
    }

    /** Creates a new instance of MainOptimalPolicy */
    public MainOptimalPolicy(ExecutorService tpes) {
        this.tpes = tpes;
    }

    public void execute() {
        int numberHeterogeneitySamples = TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE;
        TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE = 1;
        NumberFormat nf = NumberFormat.getInstance();

        // load data
        ArrayList<Jama.Matrix> actionList;
        Jama.Matrix outcomes;

        GenerateActionList listGen = new GenerateActionList(TeacherConstants.NUM_PERIODS_MATCH, 2);
        actionList = listGen.getList();

        ProcessTeacherData ptd = new ProcessTeacherData(actionList, bar);
        int numObs = ptd.getNumObs();
        outcomes = ptd.getOutcomes();
        ArrayList<MonthHolidayType> monthHolidayPermutations = ptd.getMonthHolidayPermutations();
        workHistories = ptd.getWorkHistories();
        daysInMonth = ptd.getDaysInMonth();
        holidayList = ptd.getHolidayList();
        teacherIDList = ptd.getTeacherIDList();
        daysInLongestMonth = ptd.getMaxDaysWorked();
        testScoreList = ptd.getTestScoreList();
        controlOpenList = ptd.getControlOpenList();
        workedLastMonthList = ptd.getWorkedLastMonthList();

        TreeSet<Integer> teacherTree = new TreeSet<Integer>(teacherIDList);
        teacherIDIndex = new ArrayList<Integer>(teacherTree);

        System.out.println("Number of observations: " + numObs);
        outcomes.timesEquals(1.0 / numObs);

        jt.append("TeacherConstants.NUM_SIMS = " + TeacherConstants.NUM_SIMS + "\n");
        jt.append("TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE = " + TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE + "\n");
        jt.append("TeacherConstants.NUM_PERIODS_MATCHED = " + TeacherConstants.NUM_PERIODS_MATCH + "\n");

        System.out.print("TeacherConstants.NUM_SIMS = " + TeacherConstants.NUM_SIMS + "\n");
        System.out.print("TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE = " + TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE + "\n");
        System.out.print("TeacherConstants.NUM_PERIODS_MATCHED = " + TeacherConstants.NUM_PERIODS_MATCH + "\n");

        int simsPerMonth = TeacherConstants.NUM_SIMS;

        double[] means = new double[2];
        double[] variances = new double[2];

        String model = "I";
        if (TeacherConstants.MODEL_IV) {
            model = "IV";
        }
        if (TeacherConstants.MODEL_V) {
            model = "V";
        }
        if (TeacherConstants.MODEL_VI) {
            model = "VI";
        }
        if (TeacherConstants.MODEL_VII) {
            model = "VII";
        }
        if (TeacherConstants.MODEL_VIII) {
            model = "VIII";
        }
        if (TeacherConstants.MODEL_IX) {
            model = "IX";
            // beta, mu, rho, and a mu shifter for worked yesterday
        }
        if (TeacherConstants.MODEL_X) {
            model = "X";
            // beta, mu, rho, and a mu shifter for worked yesterday
        }
        if (TeacherConstants.MODEL_XI) {
            model = "XI";
            // beta, mu, rho, and a mu shifter for worked yesterday + one normal of heterogeneity on mu
        }
        if (TeacherConstants.MODEL_XII) {
            model = "XII";
            // beta, mu, rho, and a mu shifter for worked yesterday + one normal of heterogeneity on mu
        }
        if (TeacherConstants.MODEL_13) {
            model = "13";
            // beta, mu shared by all; monthly shifter by control group and teacher score
        }
        if (TeacherConstants.MODEL_14) {
            model = "14";
            // beta, mu shared by all; monthly shifter by control group and teacher score, yesterday
        }
        if (TeacherConstants.MODEL_15) {
            model = "15";
            // beta shared by all; one dimension heterogeneity on mu; monthly shifter by control group and teacher score, yesterday
        }
        if (TeacherConstants.MODEL_16) {
            model = "16";
        }
        if (TeacherConstants.MODEL_18) {
            model = "18";
        }
        if (TeacherConstants.MODEL_20) {
            model = "20";
        }

        String windowAppend = "";
        if (TeacherConstants.USE_WINDOW) {
            windowAppend = "Window" + TeacherConstants.DAYS_WINDOW;
        }

        try {
            System.out.println("Trying to read in guess" + model + windowAppend + ".dat");
            ObjectInputStream in = new ObjectInputStream(new FileInputStream("data/guess" + model + windowAppend + ".dat"));
            means = (double[]) in.readObject();
            variances = (double[]) in.readObject();
            in.close();
            System.out.println("Successfully read in starting values.");
        } catch (Exception e) {
            System.out.println("That failed");
            if (TeacherConstants.USE_WINDOW) {
                System.out.println("\tTrying to use non-window results as a starting value");
                try {
                    ObjectInputStream in = new ObjectInputStream(new FileInputStream("data/guess" + model + ".dat"));
                    means = (double[]) in.readObject();
                    variances = (double[]) in.readObject();
                    in.close();
                    System.out.println("Successful in using non-window results.");
                } catch (Exception e2) {
                    System.out.println("That didn't work either, going with zero values as starting values.");
                    e2.printStackTrace();
                }
            }
            e.printStackTrace();
        }

        jt.append("Model = " + model + "\n");

        // testing values
        double[] guessModel_I = {0, 0.013, -0.428, 0.449, 0.007, 1.781, 0.050, 0.024};
        double[] varianceModel_I = {0, 0.001, 0.045, 0.043, 0.019, 0.345, 0.545, 0.007};
        if (TeacherConstants.MODEL_I) {
            means = guessModel_I;
            for (int i = 0; i < variances.length; i++) {
                variances[i] = Math.pow(varianceModel_I[i], 2);
            }
        }

        jt.append("Means loaded: ");
        jt.append(pmUtility.stringPrettyPrint(new Jama.Matrix(means, 1)) + "\n");
        jt.append("Variances loaded: ");
        jt.append(pmUtility.stringPrettyPrint(new Jama.Matrix(variances, 1)) + "\n");

        int numSamplesVariance = 500;

        // this calculates the cost of a matrix of possible policies; only run on MODEL_I
        boolean fullCounterfactuals = false;
        if (fullCounterfactuals && TeacherConstants.MODEL_I) {
            long t1 = System.currentTimeMillis();
            for (TeacherConstants.BONUS_CUTOFF = 0; TeacherConstants.BONUS_CUTOFF <= 27; TeacherConstants.BONUS_CUTOFF++) {
                for (TeacherConstants.BONUS = 0; TeacherConstants.BONUS <= 300; TeacherConstants.BONUS += 25) {
                    long ti1 = System.currentTimeMillis();
                    Jama.Matrix results = new Jama.Matrix(numSamplesVariance, 2);
                    bar.setMaximum(numSamplesVariance);
                    for (int ir = 0; ir < numSamplesVariance; ir++) {
                        double[] guess = drawGuess(means, variances);
                        SimulatedHistoryData shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                        results.set(ir, 0, shd.getExpectedNumberDaysWorked());
                        results.set(ir, 1, shd.getExpectedCost());
                        bar.setValue(ir + 1);
                    }
                    System.out.println("Cutoff: " + TeacherConstants.BONUS_CUTOFF + "\t Bonus: " + TeacherConstants.BONUS + "\t Expected Days Worked: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")" + "\t Expected Cost: " + nf.format(pmUtility.mean(results, 1)) + " (" + nf.format(pmUtility.standardDeviation(results, 1)) + ")");
                    jt.append("Cutoff: " + TeacherConstants.BONUS_CUTOFF + "\t Bonus: " + TeacherConstants.BONUS + "\t Expected Days Worked: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")" + "\t Expected Cost: " + nf.format(pmUtility.mean(results, 1)) + " (" + nf.format(pmUtility.standardDeviation(results, 1)) + ")\n");
                    long ti2 = System.currentTimeMillis();
                    System.out.println("Elapsed: " + (ti2 - ti1));
                }
            }
            TeacherConstants.BONUS = 50;
            TeacherConstants.BONUS_CUTOFF = 10;
            long t2 = System.currentTimeMillis();
            System.out.println("Elapsed time: " + (t2 - t1) / 1000.0 + " s.");
            jt.append("Elapsed time: " + (t2 - t1) / 1000.0 + " s.\n");
        }

        boolean outputGraphFits = false;
        if (outputGraphFits) {
            Jama.Matrix results = new Jama.Matrix(numSamplesVariance, 28);
            bar.setMaximum(numSamplesVariance);
            for (int ir = 0; ir < numSamplesVariance; ir++) {
                double[] guess = drawGuess(means, variances);
                SimulatedHistoryData shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                Jama.Matrix distributionDaysWorked = shd.getDistributionDaysWorked();
                for (int i = 0; i < 28; i++) {
                    results.set(ir, i, distributionDaysWorked.get(i, 0));
                }
                bar.setValue(ir + 1);
            }
            // pmUtility.prettyPrint(results);
            try {
                BufferedWriter out = new BufferedWriter(new FileWriter("data/fits" + model + ".csv"));
                Jama.Matrix edf = ptd.getEmpiricalDistribution();
                out.write("Days Worked,Empirical,Mean,Median,alpha=0.025,alpha=0.975\n");
                for (int t = 0; t < 28; t++) {
                    out.write(t + "," + edf.get(t, 0) + "," + pmUtility.mean(results, t) + "," + pmUtility.median(results, t) + "," + pmUtility.percentile(results, t, 0.025) + "," + pmUtility.percentile(results, t, 0.975) + "\n");
                    System.out.print(t + "," + edf.get(t, 0) + "," + pmUtility.mean(results, t) + "," + pmUtility.median(results, t) + "," + pmUtility.percentile(results, t, 0.025) + "," + pmUtility.percentile(results, t, 0.975) + "\n");
                }
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        boolean calculateThreeImportantNumbers = false;
        if (calculateThreeImportantNumbers && !fullCounterfactuals) {
            double[] bonusList = {0, 50, 70};
            int[] cutoffList = {10, 10, 12};

            for (int i = 0; i < bonusList.length; i++) {
                long t1 = System.currentTimeMillis();
                TeacherConstants.BONUS = bonusList[i];
                TeacherConstants.BONUS_CUTOFF = cutoffList[i];
                // System.out.println("Bonus: " + b + " Cutoff: " + c);
                Jama.Matrix results = new Jama.Matrix(numSamplesVariance, 2);
                bar.setMaximum(numSamplesVariance);
                for (int ir = 0; ir < numSamplesVariance; ir++) {
                    double[] guess = drawGuess(means, variances);
                    SimulatedHistoryData shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                    results.set(ir, 0, shd.getExpectedNumberDaysWorked());
                    results.set(ir, 1, shd.getExpectedCost());
                    bar.setValue(ir + 1);
                }
                System.out.println("Cutoff: " + TeacherConstants.BONUS_CUTOFF + "\t Bonus: " + TeacherConstants.BONUS + "\t Expected Days Worked: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")" + "\t Expected Cost: " + nf.format(pmUtility.mean(results, 1)) + " (" + nf.format(pmUtility.standardDeviation(results, 1)) + ")");
                jt.append("Cutoff: " + TeacherConstants.BONUS_CUTOFF + "\t Bonus: " + TeacherConstants.BONUS + "\t Expected Days Worked: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")" + "\t Expected Cost: " + nf.format(pmUtility.mean(results, 1)) + " (" + nf.format(pmUtility.standardDeviation(results, 1)) + ")\n");
                long t2 = System.currentTimeMillis();
                System.out.println("Elapsed time: " + nf.format((t2 - t1) / 1000.0) + " seconds.");
            }
            TeacherConstants.BONUS = 50;
            TeacherConstants.BONUS_CUTOFF = 10;
        }

        // so just need to implement the elasticity calculations
        boolean calculateBonusElasticity = false;
        if (calculateBonusElasticity) {
            double change = 0.1;
            Jama.Matrix results = new Jama.Matrix(numSamplesVariance, 1);
            bar.setMaximum(numSamplesVariance);
            for (int ir = 0; ir < numSamplesVariance; ir++) {
                double[] guess = drawGuess(means, variances);
                TeacherConstants.BONUS = 50;
                SimulatedHistoryData shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                double before = shd.getExpectedNumberDaysWorked();
                TeacherConstants.BONUS = 50 * (1.0 + change);
                shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                double after = shd.getExpectedNumberDaysWorked();
                results.set(ir, 0, (after - before) / (change * before));
                bar.setValue(ir + 1);
            }
            System.out.println("Bonus Elasticity: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")");
            jt.append("Bonus Elasticity: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")\n");
            TeacherConstants.BONUS = 50;
            TeacherConstants.BONUS_CUTOFF = 10;
        }


        boolean calculateCutoffElasticity = true;
        if (calculateCutoffElasticity) {
            Jama.Matrix results = new Jama.Matrix(numSamplesVariance, 1);
            bar.setMaximum(numSamplesVariance);
            for (int ir = 0; ir < numSamplesVariance; ir++) {
                double[] guess = drawGuess(means, variances);
                TeacherConstants.BONUS_CUTOFF = 10;
                SimulatedHistoryData shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                double before = shd.getExpectedNumberDaysWorked();
                TeacherConstants.BONUS_CUTOFF = 11;
                shd = calculateExpectedNumberDaysWorked(monthHolidayPermutations, tpes, guess, simsPerMonth);
                double after = shd.getExpectedNumberDaysWorked();
                results.set(ir, 0, 100 * (after - before) / before);
                bar.setValue(ir + 1);
            }
            System.out.println("Cutoff Semi-Elasticity: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")");
            jt.append("Cutoff Semi-Elasticity: " + nf.format(pmUtility.mean(results, 0)) + " (" + nf.format(pmUtility.standardDeviation(results, 0)) + ")\n");
            TeacherConstants.BONUS = 50;
            TeacherConstants.BONUS_CUTOFF = 10;
        }

        System.out.println("Execution finished.");
        jt.append("\n");
        TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE = numberHeterogeneitySamples;
    }

    public SimulatedHistoryData calculateExpectedNumberDaysWorked(ArrayList<MonthHolidayType> monthHolidayPermutations, ExecutorService tpes, double[] guess, int simsPerMonth) {
        SimulatedHistoryData historyData = new SimulatedHistoryData();
        double expectedNumberDaysWorked = 0;
        double expectedCost = 0;
        Jama.Matrix distributionDaysWorked = new Jama.Matrix(28, 1, 0);

        rng = new Random(888);

        ArrayList<Future<SimulatedHistoryData>> futureList = new ArrayList<Future<SimulatedHistoryData>>();

        double numMonthsUse = monthHolidayPermutations.size();
        double adjustment = 0;
        for (int k = 0; k < numMonthsUse; k++) {
            MonthHolidayType t = monthHolidayPermutations.get(k);
            adjustment += t.getFrequencyInPopulation();
        }
        adjustment = 1.0 / adjustment;

        if (TeacherConstants.MODEL_V) {
            // iid model, don't need to compute a bunch of statespaces a huge number of times
            StateSpaceIID space = new StateSpaceIID(guess[1], guess[2], 28);
            for (int k = 0; k < numMonthsUse; k++) {
                MonthHolidayType t = monthHolidayPermutations.get(k);
                int numHolidays = t.getNumHolidays();
                int numWorkDaysInMonth = t.getNumDaysInMonth();
                for (int i = 0; i < simsPerMonth; i++) {
                    FullHistoryData fhd = space.generateFullHistory(numHolidays, numWorkDaysInMonth);
                    expectedCost += fhd.getCost() * t.getFrequencyInPopulation() * adjustment;
                    expectedNumberDaysWorked += fhd.getNumberDaysWorked() * t.getFrequencyInPopulation() * adjustment;
                }
            }
            expectedCost /= simsPerMonth;
            expectedNumberDaysWorked /= simsPerMonth;
        }
        if (TeacherConstants.MODEL_IX) {
            // iid model, don't need to compute a bunch of statespaces a huge number of times
            StateSpaceIIDYesterday space = new StateSpaceIIDYesterday(guess[1], guess[2], 28, guess[3]);
            for (int k = 0; k < numMonthsUse; k++) {
                MonthHolidayType t = monthHolidayPermutations.get(k);
                int numHolidays = t.getNumHolidays();
                int numWorkDaysInMonth = t.getNumDaysInMonth();
                for (int i = 0; i < simsPerMonth; i++) {
                    FullHistoryData fhd = space.generateFullHistory(numHolidays, numWorkDaysInMonth, rng.nextLong());
                    expectedCost += fhd.getCost() * t.getFrequencyInPopulation() * adjustment;
                    expectedNumberDaysWorked += fhd.getNumberDaysWorked() * t.getFrequencyInPopulation() * adjustment;
                }
            }
            expectedCost /= simsPerMonth;
            expectedNumberDaysWorked /= simsPerMonth;
        }
        if (TeacherConstants.MODEL_XI) {
//            for (int i = 0; i < guess.length; i++) {
//                guess[i] = 0;
//            }
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);

                futureList.add(tpes.submit(new Model_XI_DaysWorkedTask(guess, controlOpen, teacherScore, daysInMonth.get(ij), holidayList.get(ij), rng.nextLong())));
            }
            try {
                for (int k = 0; k < futureList.size(); k++) {
                    SimulatedHistoryData data = futureList.get(k).get();
                    expectedNumberDaysWorked += data.getExpectedNumberDaysWorked();
                    expectedCost += data.getExpectedCost();
                    // System.out.println("Cost: "+data.getExpectedCost()+" "+data.getExpectedNumberDaysWorked());
                }
                expectedNumberDaysWorked /= futureList.size();
                expectedCost /= futureList.size();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (TeacherConstants.MODEL_14) {
//            for (int i = 0; i < guess.length; i++) {
//                guess[i] = 0;
//            }
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);

                futureList.add(tpes.submit(new Model_14_DaysWorkedTask(guess, controlOpen, teacherScore, daysInMonth.get(ij), holidayList.get(ij), rng.nextLong())));
            }
            try {
                for (int k = 0; k < futureList.size(); k++) {
                    SimulatedHistoryData data = futureList.get(k).get();
                    expectedNumberDaysWorked += data.getExpectedNumberDaysWorked();
                    expectedCost += data.getExpectedCost();
                    // System.out.println("Cost: "+data.getExpectedCost()+" "+data.getExpectedNumberDaysWorked());
                }
                expectedNumberDaysWorked /= futureList.size();
                expectedCost /= futureList.size();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (TeacherConstants.MODEL_15) {
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);

                futureList.add(tpes.submit(new Model_15_DaysWorkedTask(guess, controlOpen, teacherScore, daysInMonth.get(ij), holidayList.get(ij), rng.nextLong())));
            }
            try {
                for (int k = 0; k < futureList.size(); k++) {
                    SimulatedHistoryData data = futureList.get(k).get();
                    expectedNumberDaysWorked += data.getExpectedNumberDaysWorked();
                    expectedCost += data.getExpectedCost();
                    // System.out.println("Cost: "+data.getExpectedCost()+" "+data.getExpectedNumberDaysWorked());
                }
                expectedNumberDaysWorked /= futureList.size();
                expectedCost /= futureList.size();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (TeacherConstants.MODEL_20) {
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                double workedLastMonth = workedLastMonthList.get(ij);

                /**
                 * Number of simulations per agent when generating the distribution of days worked.
                 */
                int numSims = 10;
                futureList.add(tpes.submit(new Model_20_DistributionTask(guess, controlOpen, teacherScore, workedLastMonth, daysInMonth.get(ij), holidayList.get(ij), rng.nextLong(), numSims)));
            }
            try {
                for (int k = 0; k < futureList.size(); k++) {
                    SimulatedHistoryData data = futureList.get(k).get();
                    expectedNumberDaysWorked += data.getExpectedNumberDaysWorked();
                    expectedCost += data.getExpectedCost();
                    distributionDaysWorked.plusEquals(data.getDistributionDaysWorked());
                    // System.out.println("Cost: "+data.getExpectedCost()+" "+data.getExpectedNumberDaysWorked());
                }
                expectedNumberDaysWorked /= futureList.size();
                expectedCost /= futureList.size();
                distributionDaysWorked.timesEquals(1.0 / futureList.size());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (TeacherConstants.MODEL_16) {
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);

                futureList.add(tpes.submit(new Model_16_DaysWorkedTask(guess, controlOpen, teacherScore, daysInMonth.get(ij), holidayList.get(ij), rng.nextLong())));
            }
            try {
                for (int k = 0; k < futureList.size(); k++) {
                    SimulatedHistoryData data = futureList.get(k).get();
                    expectedNumberDaysWorked += data.getExpectedNumberDaysWorked();
                    expectedCost += data.getExpectedCost();
                    // System.out.println("Cost: "+data.getExpectedCost()+" "+data.getExpectedNumberDaysWorked());
                }
                expectedNumberDaysWorked /= futureList.size();
                expectedCost /= futureList.size();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        if (TeacherConstants.MODEL_I || TeacherConstants.MODEL_IV || TeacherConstants.MODEL_VII || TeacherConstants.MODEL_VIII) {
            for (int k = 0; k < numMonthsUse; k++) {
                MonthHolidayType t = monthHolidayPermutations.get(k);
                int numHolidays = t.getNumHolidays();
                int numWorkDaysInMonth = t.getNumDaysInMonth();
                futureList.add(tpes.submit(new GenerateDaysWorkedTask(guess, rng.nextLong(), numHolidays, numWorkDaysInMonth, true, simsPerMonth, adjustment * t.getFrequencyInPopulation())));
            }

            try {
                for (int k = 0; k < numMonthsUse; k++) {
                    SimulatedHistoryData data = futureList.get(k).get();
                    expectedNumberDaysWorked += data.getExpectedNumberDaysWorked();
                    expectedCost += data.getExpectedCost();
                    // System.out.println("Cost: "+data.getExpectedCost()+" "+data.getExpectedNumberDaysWorked());
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // okay, i forgot model VI here so far
        if (TeacherConstants.MODEL_VI) {
            double counter = 0;
            for (int ij = 0; ij < workHistories.size(); ij++) {
                int daysInCurrentMonth = daysInMonth.get(ij);
                int teacherID = teacherIDList.get(ij);
                int numHolidays = holidayList.get(ij);
                int teacherIndex = teacherIDIndex.indexOf(new Integer(teacherID));
                StateSpaceIID s = new StateSpaceIID(guess[1], guess[2 + teacherIndex], daysInLongestMonth);
                FullHistoryData fhd = s.generateFullHistory(numHolidays, daysInCurrentMonth);
                expectedCost += fhd.getCost();
                expectedNumberDaysWorked += fhd.getNumberDaysWorked();
                counter++;
            }
            expectedCost /= counter;
            expectedNumberDaysWorked /= counter;
        }

        historyData.setExpectedCost(expectedCost);
        historyData.setExpectedNumberDaysWorked(expectedNumberDaysWorked);
        historyData.setDistributionDaysWorked(distributionDaysWorked);
        return historyData;
    }

    /**
     * @return the jt
     */
    public JTextAreaAutoscroll getJt() {
        return jt;
    }
}
