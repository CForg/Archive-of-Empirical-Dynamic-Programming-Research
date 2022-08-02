/*
 * BruteForceEstimation.java
 *
 * Created on August 18, 2006, 2:21 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package bruteforce;

// import com.ziena.knitro.KnitroJava;
import constants.TeacherConstants;
import data.ProcessTeacherData;
import java.awt.BorderLayout;
import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.ObjectOutputStream;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Random;
import java.util.TreeSet;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JProgressBar;
import mcmc.gibbsLTEGeneralized;
import mcmc.mcmcFunction;
import optimization.Uncmin_methods;
import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartPanel; 
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.xy.XYSeries;
import org.jfree.data.xy.XYSeriesCollection;
import utility.pmUtility;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class BruteForceEstimation implements Callable<double[]>, Uncmin_methods, mcmcFunction {

    boolean verbose = false;
    JProgressBar bar;
    JLabel statusLabel;
    // MomentMatchDialog momentMatched;
    boolean useOptimalWeights;
    double[] guess;
    // static int numParams = TeacherConstants.NUM_PARAMS;
    boolean parallelProcess = true;
    ExecutorService tpes;
    ArrayList<Jama.Matrix> actionList;
    // this is the actual empirical distribution of the moments!!!
    private Jama.Matrix outcomes;
    Jama.Matrix W;
    ArrayList<Jama.Matrix> workHistories = null;
    ArrayList<Integer> daysInMonth = null;
    ArrayList<Integer> holidayList = null;
    TreeSet<Integer> distributionDays = null;
    ArrayList<Integer> teacherIDList = null;
    ArrayList<Integer> teacherIDIndex = null;
    ArrayList<Jama.Matrix> completeHistories = null;
    ArrayList<MonthHolidayType> monthHolidayPermutations = null;
    NumberFormat nf = NumberFormat.getInstance();
    private boolean outputFittedMoments = false;

    /** Creates a new instance of BruteForceMC
     * @param bar JProgressBar to keep the GUI updated on long tasks
     * @param statusLabel GUI label to keep track of status
     * @param useOptimalWeights Switch to calculate optimal weighting matrix
     * @param tpes ExecutorService to be used in distributing parallel tasks
     */
    public BruteForceEstimation(JProgressBar bar, JLabel statusLabel, boolean useOptimalWeights, ExecutorService tpes) {
        this.tpes = tpes;
        this.useOptimalWeights = useOptimalWeights;
        this.bar = bar;
        this.statusLabel = statusLabel;

        if (TeacherConstants.MODEL_17) {
            // this is necessary to keep everything held together in ProcessTeacherData
            TeacherConstants.NUM_PERIODS_MATCH = TeacherConstants.NUM_BLOCKS;
        }
        GenerateActionList listGen = new GenerateActionList(TeacherConstants.NUM_PERIODS_MATCH, 2);
        actionList = listGen.getList();

        W = Jama.Matrix.identity(actionList.size() - 1, actionList.size() - 1);

        ProcessTeacherData ptd = new ProcessTeacherData(actionList, bar);
        completeHistories = ptd.getCompleteHistories();
        monthHolidayPermutations = ptd.getMonthHolidayPermutations();
        daysInMonth = ptd.getDaysInMonth();
        distributionDays = ptd.getDistributionDays();
        holidayList = ptd.getHolidayList();
        teacherIDList = ptd.getTeacherIDList();
        workHistories = ptd.getWorkHistories();
        outcomes = ptd.getOutcomes();

        // System.out.println(daysInMonth.size()+" "+workHistories.size()+" "+holidayList.size());
        // System.exit(0);

        // this would be the place to figure out the table of people who work conditional on in/out/maybe and the day of the month
        Jama.Matrix tableMoney = new Jama.Matrix(27 + 1, 3);  // in, out, maybe
        Jama.Matrix tableMoneyWeights = new Jama.Matrix(27 + 1, 3);
        Jama.Matrix table = new Jama.Matrix(27 + 1, 27 + 1, 0);  // days left in the month (up to 27) X days worked already
        Jama.Matrix tableWeights = new Jama.Matrix(27 + 1, 27 + 1, 0);  // need to keep track of who could have worked in this cell

        for (int i = 0; i < completeHistories.size(); i++) {
            Jama.Matrix completeHistory = completeHistories.get(i);
            int numHolidays = holidayList.get(i);
            int monthLength = daysInMonth.get(i);
            // so you are out of the money at time left+days worked already < 10?
            int daysWorked = numHolidays;
            for (int t = 0; t < monthLength - numHolidays; t++) {
                int daysLeftToWork = monthLength - t - numHolidays;
                boolean worked = false;
                if (completeHistory.get(t, 0) == 1) {
                    worked = true;
                }
                tableWeights.set(daysLeftToWork, daysWorked, tableWeights.get(daysLeftToWork, daysWorked) + 1);
                if (daysWorked >= 10) {
                    // in money
                    tableMoneyWeights.set(daysLeftToWork, 0, tableMoneyWeights.get(daysLeftToWork, 0) + 1);
                    if (worked) {
                        tableMoney.set(daysLeftToWork, 0, tableMoney.get(daysLeftToWork, 0) + 1);
                    }
                } else {
                    if (daysLeftToWork + daysWorked < 10) {
                        // out of money
                        tableMoneyWeights.set(daysLeftToWork, 1, tableMoneyWeights.get(daysLeftToWork, 1) + 1);
                        if (worked) {
                            tableMoney.set(daysLeftToWork, 1, tableMoney.get(daysLeftToWork, 1) + 1);
                        }
                    } else {
                        // maybe in money
                        tableMoneyWeights.set(daysLeftToWork, 2, tableMoneyWeights.get(daysLeftToWork, 2) + 1);
                        if (worked) {
                            tableMoney.set(daysLeftToWork, 2, tableMoney.get(daysLeftToWork, 2) + 1);
                        }
                    }
                }
                if (worked) {
                    // worked first possible time
                    // need to adjust this to make everyone's dynamic problem look the same
                    table.set(daysLeftToWork, daysWorked, table.get(daysLeftToWork, daysWorked) + 1);
                    daysWorked++;
                }
            }
        }
        for (int i = 0; i < table.getRowDimension(); i++) {
            for (int j = 0; j < table.getColumnDimension(); j++) {
                if (table.get(i, j) > 0) {
                    table.set(i, j, table.get(i, j) / tableWeights.get(i, j));
                }
            }
        }
        for (int i = 0; i < tableMoney.getRowDimension(); i++) {
            for (int j = 0; j < tableMoney.getColumnDimension(); j++) {
                if (tableMoney.get(i, j) > 0) {
                    tableMoney.set(i, j, tableMoney.get(i, j) / tableMoneyWeights.get(i, j));
                }
            }
        }

        // pmUtility.prettyPrint(tableWeights);

//        System.out.println("Days Worked Table");
//        printTable(table);
//
//        System.out.println("Condensed Version");
//        printTable(tableMoney);
    }

    private void printTable(Jama.Matrix table) {
        for (int j = 0; j < table.getColumnDimension(); j++) {
            System.out.print(" &\t" + j);
        }
        System.out.println("\\\\");

        nf.setMaximumFractionDigits(4);

        for (int i = 0; i < table.getRowDimension(); i++) {
            System.out.print(i + " & \t");
            for (int j = 0; j < table.getColumnDimension(); j++) {
                System.out.print(nf.format(table.get(i, j)) + "\t");
                if (j < table.getColumnDimension() - 1) {
                    System.out.print("& ");
                }
            }
            System.out.println("\\\\");
        }
    }

    public double[] getGuess() {
        return guess;
    }

    public void gradient(double[] x, double[] g) {
    }

    public void hessian(double[] x, double[][] h) {
    }

    public double objectiveFunction(double[] x) {
        return -f_to_minimize(x);
    }

    public double pi(double[] x) {
        return 1;
    }

    public void setGuess(double[] guess) {
        this.guess = guess;
        // System.out.print("Starting values: ");
        // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
    }

    public double[] call() throws Exception {
        // load parameters
        String model = "I";
        if (TeacherConstants.MODEL_IV) {
            model = "IV";
        }
        if (TeacherConstants.MODEL_VII) {
            model = "VII";
        }
        if (TeacherConstants.MODEL_VIII) {
            model = "VIII";
        }
        if (TeacherConstants.MODEL_17) {
            model = "17";
        }

        W = Jama.Matrix.identity(actionList.size() - 1, actionList.size() - 1);


        /**
         * Here is where we can change the starting values for timing reasons
         */
        boolean startZeroVector = false;
        if(startZeroVector) {
            for(int i=0;i<guess.length;i++) {
                guess[i] = 0;
            }
        }
        boolean startIIDVector = false;
        if(startIIDVector) {
            guess[1] = 0.05;
            guess[2] = 1.53;
            guess[3] = 0.4;
            guess[4] = 1.0;
        }
        boolean startTruth = true;
        if(startTruth) {
            guess[1] = 0.056698;
            guess[2] = 1.778442;
            guess[3] = 0.412076;
            guess[4] = 0.043014;
        }


        System.out.print("Starting values: ");
        pmUtility.prettyPrint(new Jama.Matrix(guess, 1));

        int numParams = guess.length - 1;
        double[] xpls = new double[numParams + 1];
        double[] fpls = new double[2];
        double[] gpls = new double[numParams + 1];
        int[] itrmcd = new int[2];
        double[][] a = new double[numParams + 1][numParams + 1];
        double[] udiag = new double[numParams + 1];
        double[] typsiz = new double[numParams + 1];
        double[] fscale = {0, 1E-8};
        int[] method = {0, 3}; // 1 line search 2 double dogleg 3 more-hebdon
        int[] iexp = {0, 1}; // 1 if expensive to evaluate
        int[] msg = {0, 0};
        int[] ndigit = {0, 5}; // number of good digits in minimand
        int[] itnlim = {0, 15};
        int[] iagflg = {0, 0};
        int[] iahflg = {0, 0};
        double[] dlt = {0, 1};
        double[] gradtl = {0, 1E-8};
        double[] stepmx = {0, 1E3};
        double[] steptl = {0, 1E-8};

        // guess = new double[numParams+1];
        // long t1 = System.currentTimeMillis();
        optimization.Uncmin_f77 minimizer = new optimization.Uncmin_f77(true);

        boolean plotFunction = false;
        if (plotFunction) {
            double trueRho = guess[3];
            double trueP = guess[9];
            // calculateWeightingMatrix(guess);
            statusLabel.setText("Plotting objective...");
            JFrame plotFrame = new JFrame("Plot objective function");
            plotFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            plotFrame.setBounds(20, 20, 1600, 1000); // big!

            XYSeriesCollection dataset = new XYSeriesCollection();
            XYSeries xy = new XYSeries("GMM");
            bar.setMaximum(16);
            int counter = 1;
            dataset.addSeries(xy);
            ChartPanel panel = new ChartPanel(ChartFactory.createXYLineChart("GMM - Model " + model, "rho", "Q_n", dataset, PlotOrientation.VERTICAL, false, false, false));
            plotFrame.getContentPane().add(panel, BorderLayout.CENTER);
            plotFrame.setVisible(true);
            // for (double rho = -0.8; rho <= 0.8; rho += 0.1) {
            for (double p = 0; p <= 1; p += 0.02) {
                bar.setValue(counter);
                guess[9] = p;
                xy.add(p, -objectiveFunction(guess));
                counter++;
            }
            guess[9] = trueP;
        }

        int numTests = 40;
        bar.setMaximum(numTests);
//        Jama.Matrix test = new Jama.Matrix(numTests, 1);
        /*
        for(TeacherConstants.NUM_SIMS=200;TeacherConstants.NUM_SIMS<=2000000;TeacherConstants.NUM_SIMS*=4) {
        for(int i=0;i<numTests;i++) {
        // System.out.print("Best point: " + (-objectiveFunction(guess)) + " ");
        // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
        resetRandomNumbers();
        test.set(i, 0, -objectiveFunction(guess));
        bar.setValue(i+1);
        }
        System.out.println("Num Sims: "+TeacherConstants.NUM_SIMS+" Mean: "+pmUtility.mean(test, 0)+" Std. Dev.: "+pmUtility.standardDeviation(test));
        }
         */


        boolean estimateModel = true;

        // System.out.print("f_to_min: "+(-objectiveFunction(guess))+" ");
        // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));

        // what is g_i here?  1(predicted)-1(actually happened)
        if (estimateModel) {
            if (useOptimalWeights) {
                System.out.print("Calculating optimal weighting matrix...");
                calculateWeightingMatrix(guess);
                System.out.println("done.");
            }
            // momentMatched.setup(actionList, outcomes);
            // momentMatched.setVisible(true);

            double[] variance = new double[guess.length];

            statusLabel.setText("Executing minimizer...");

            boolean useLTE = false;
            boolean useKNitro = false;
            boolean useUncmin = true;

            if (useUncmin) {
                minimizer.optif9_f77(numParams, guess, this, typsiz, fscale, method, iexp, msg, ndigit, itnlim, iagflg, iahflg, dlt, gradtl, stepmx, steptl, xpls, fpls, gpls, itrmcd, a, udiag);
            }
//            if (useKNitro) {
//                System.out.print("Before KNITRO: " + pmUtility.stringPrettyPrint(new Jama.Matrix(guess, 1)));
//                solveUsingKNitro(guess);
//                System.out.print("After KNITRO: " + pmUtility.stringPrettyPrint(new Jama.Matrix(guess, 1)));
//            }
            if (useLTE) {
                // minimizer.optif9_f77(numParams, guess, this, typsiz, fscale, method, iexp, msg, ndigit, itnlim, iagflg, iahflg, dlt, gradtl, stepmx, steptl, xpls, fpls, gpls, itrmcd, a, udiag);                
                // it is clear that gradient methods are useless in this context
                String[] name = {"Beta", "Mu", "Rho", "Mu_Variance", "Mu2", "Mu2Variance", "ProbMu2", "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "BetaPast20"};
                if (TeacherConstants.MODEL_VIII) {
                    String[] name2 = {"Beta", "Mu", "Mu_Variance", "Mu2", "Mu2_Variance", "ProbMu2"};
                    name = name2;
                }
                if (TeacherConstants.MODEL_17) {
                    String[] names2 = {"Beta", "Mu", "Rho"};
                    name = names2;
                }
                // gibbsLTEGeneralized lte = new gibbsLTEGeneralized(this, 200, 100, guess, "bruteVar_" + model, name);
                gibbsLTEGeneralized lte = new gibbsLTEGeneralized(this, 200, 100, guess, name);
                Jama.Matrix results = lte.getChain();

                guess = lte.getLowestPoint();

                try {
                    BufferedWriter out = new BufferedWriter(new FileWriter("data/results.txt"));

                    for (int i = 0; i < numParams; i++) {
                        // guess[i + 1] = pmUtility.mean(results, i + 1);
                        variance[i + 1] = Math.pow(pmUtility.standardDeviation(results, i + 1), 2);
                        System.out.println(name[i] + ": mean: " + nf.format(guess[i + 1]) + " median: " + nf.format(pmUtility.median(results, i + 1)) + " stddev: " + nf.format(pmUtility.standardDeviation(results, i + 1)));
                        out.write(name[i] + ": mean: " + nf.format(pmUtility.mean(results, i + 1)) + " median: " + nf.format(pmUtility.median(results, i + 1)) + " stddev: " + nf.format(pmUtility.standardDeviation(results, i + 1)) + "\n");
                    }
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
            System.out.print("Best point: " + (-objectiveFunction(guess)) + " ");
            pmUtility.prettyPrint(new Jama.Matrix(guess, 1));


            // save the parameters here for future use
            try {
                ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("data/guess" + model + ".dat"));
                out.writeObject(guess);
                out.writeObject(variance);
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        outputFittedMoments = false;
        if(outputFittedMoments) {
            f_to_minimize(guess);
        }
        outputFittedMoments = false;

        // momentMatched.dispose();
        return guess;
    }

    private void calculateWeightingMatrix(double[] x) {
        Random rng = new Random(888);
        // need to put in a method here for calculating the optimal weighting matrix in GMM
        // need E(gg') where g is the vector of moments
        statusLabel.setText("Computing optimal weighting matrix");
        Jama.Matrix omega = new Jama.Matrix(actionList.size() - 1, actionList.size() - 1, 0); // actionlist.size-1 moments

        int numObs = workHistories.size();
        bar.setMaximum(numObs);
        bar.setStringPainted(true);
        bar.setString("0 / " + numObs);

        ArrayList<Future<Jama.Matrix>> futureList = new ArrayList<Future<Jama.Matrix>>();

        for (int i = 0; i < numObs; i++) {
            int numHolidays = holidayList.get(i);
            int numWorkDaysInMonth = daysInMonth.get(i);

            int numSims = TeacherConstants.NUM_SIMS;
            futureList.add(tpes.submit(new GenerateHistoryTask(x, rng.nextLong(), numHolidays, numWorkDaysInMonth, false, numSims, 1, actionList)));
        }

        for (int i = 0; i < numObs; i++) {
            Jama.Matrix expectedProbs = new Jama.Matrix(actionList.size() - 1, 1);
            try {
                Future<Jama.Matrix> f = futureList.get(i);
                Jama.Matrix p = f.get();
                expectedProbs.plusEquals(p);
            } catch (Exception e) {
                e.printStackTrace();
            }
            // pmUtility.prettyPrintVector(expectedProbs);
            // so now we have the moment vector for guy _i_
            Jama.Matrix history = workHistories.get(i);
            Jama.Matrix actual = new Jama.Matrix(actionList.size() - 1, 1);
            for (int j = 0; j < actionList.size() - 1; j++) {
                Jama.Matrix action = actionList.get(j);
                if ((history.minus(action)).normF() == 0) {
                    actual.set(j, 0, 1);
                    j = actionList.size(); // no need to keep searching over the rest of the list
                }
            }
            Jama.Matrix g = actual.minus(expectedProbs);
            Jama.Matrix ggprime = g.times(g.transpose());
            // System.out.println("---------");
            // pmUtility.prettyPrint(ggprime);
            omega.plusEquals(ggprime);
            bar.setValue(i + 1);
            bar.setString((i + 1) + " / " + numObs);
        }
        omega.timesEquals(1.0 / numObs);
        System.out.println("Omega:");
        pmUtility.prettyPrint(omega);
        W = omega.inverse();
        System.out.println("Weights:");
        pmUtility.prettyPrint(W);
    }

    @Override
    public double f_to_minimize(double[] x) {
        long t1 = System.currentTimeMillis();
        if (TeacherConstants.MODEL_VII) {
            x[3] = Math.max(x[3], -0.9);
            x[3] = Math.min(x[3], 0.9);
        } else {
            if (TeacherConstants.MODEL_VIII) {
                // model VIII is type types without rho (what the hell is going on with these parameters that i put in here?!?
                x[3] = Math.max(1E-100, x[3]);

                x[4] = Math.max(x[2] + (1.0E-15), x[4]); // this assure it is always to the right of x[2]
                x[5] = Math.max(1.0E-100, x[5]);

                x[6] = Math.max(0, x[6]);
                x[6] = Math.min(1, x[6]); // bound that probability
            } else {
                x[3] = Math.max(x[3], -0.9);
                x[3] = Math.min(x[3], 0.9);
                if (x.length > 4) {
                    x[4] = Math.max(1.0E-100, x[4]);
                }
                if (x.length > 5) {
                    x[5] = Math.max(x[2] + (1.0E-15), x[5]); // this assure it is always to the right of x[2]
                    x[6] = Math.max(1.0E-100, x[6]);

                    x[7] = Math.max(0, x[7]);
                    x[7] = Math.min(1, x[7]); // bound that probability
                }
            }
        }

        Random rng = new Random(777);
        Jama.Matrix expectedProbs = new Jama.Matrix(actionList.size() - 1, 1);

        ArrayList<Future> futureList = new ArrayList<Future>();

        int simsPerMonth = TeacherConstants.NUM_SIMS;

        double numMonthsUse = monthHolidayPermutations.size();
        double adjustment = 0;
        for (int k = 0; k < numMonthsUse; k++) {
            MonthHolidayType t = monthHolidayPermutations.get(k);
            adjustment += t.getFrequencyInPopulation();
        }

        adjustment = 1.0 / adjustment;

        for (int k = 0; k < numMonthsUse; k++) {
            MonthHolidayType t = monthHolidayPermutations.get(k);
            int numHolidays = t.getNumHolidays();
            int numWorkDaysInMonth = t.getNumDaysInMonth();
            futureList.add(tpes.submit(new GenerateHistoryTask(x, rng.nextLong(), numHolidays, numWorkDaysInMonth, false, simsPerMonth, adjustment * t.getFrequencyInPopulation(), actionList)));
        }

        // long t3 = System.currentTimeMillis();
        // System.out.println("Evaluating futureList (" + TeacherConstants.NUM_THREADS + " threads)...");
        int counter = 0;
        bar.setMaximum(futureList.size());
        Jama.Matrix p;
        try {
            for (Future f : futureList) {
                p = (Jama.Matrix) f.get();
                expectedProbs.plusEquals(p);
                bar.setValue((int) counter + 1);
                counter++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // pmUtility.prettyPrintVector(expectedProbs);
        // pmUtility.prettyPrintVector(outcomes);
//        System.out.print("-------------- x: ");
//        pmUtility.prettyPrint(new Jama.Matrix(x, 1));
        if (outputFittedMoments) {
            // need a more nuanced version of this
            // output moments
//        boolean outputEmpiricalMoments = false;
//        if (outputEmpiricalMoments) {
//            for (int i = 0; i < actionList.size() - 1; i++) {
//                String action = pmUtility.stringPrettyPrintVector(actionList.get(i));
//                System.out.println(action + "\t&\t" + outcomes.get(i, 0) + " \\\\");
//            }
//            System.exit(0);
//        }
            for (int i = 0; i < outcomes.getRowDimension(); i++) {
                String s = pmUtility.stringPrettyPrintVector(actionList.get(i), 0);
                s = s.concat(" & " + nf.format(outcomes.get(i, 0)) + " & " + nf.format(expectedProbs.get(i, 0)) + " \\\\");
                System.out.println(s);
            }
            // pmUtility.prettyPrint(pmUtility.concatMatrix(outcomes, expectedProbs));
        }
        // System.exit(0);

        Jama.Matrix moments = outcomes.minus(expectedProbs);
        double val = (((moments.transpose()).times(W)).times(moments)).get(0, 0);

        // momentMatched.update(expectedProbs);

        val = TeacherConstants.NUM_OBS * val / 2.0;
        // System.out.println("f: " + val);
        long t2 = System.currentTimeMillis();
        // System.out.println("USE_GRID: "+TeacherConstants.USE_GRID+" t: "+(t2-t1));
        return val;
    }

    public ArrayList<MonthHolidayType> getMonthHolidayPermutations() {
        return monthHolidayPermutations;
    }

// this is the actual empirical distribution of the moments!!!
    public Jama.Matrix getOutcomes() {
        return outcomes;
    }

//    public void solveUsingKNitro(double[] guess) {
//        //---- DEFINE THE OPTIMIZATION TEST PROBLEM.
//        //---- FOR MORE INFORMATION ABOUT THE PROBLEM DEFINITION, REFER
//        //---- TO THE KNITRO MANUAL, ESPECIALLY THE SECTION ON THE
//        //---- CALLABLE LIBRARY.
//        int n = guess.length - 1;
//        int objGoal = KnitroJava.KTR_OBJGOAL_MINIMIZE;
//        int objType = KnitroJava.KTR_OBJTYPE_GENERAL;
//
//        // make sure that the problem is defined as unbounded
//        double[] bndsLo = new double[n];
//        double[] bndsUp = new double[n];
//        for (int i = 0; i < n; i++) {
//            bndsLo[i] = -KnitroJava.KTR_INFBOUND;
//            bndsUp[i] = KnitroJava.KTR_INFBOUND;
//        }
//
//        // number of constraints
//        int m = 0;
//        int[] cType = {};
//        double[] cBndsLo = {};
//        double[] cBndsUp = {};
//        int nnzJ = 0;
//        int[] jacIxConstr = {};
//        int[] jacIxVar = {};
//        int nnzH = 0;
//        int[] hessRow = {};
//        int[] hessCol = {};
//
//        double[] daXInit = new double[guess.length - 1];
//        for (int i = 0; i < guess.length - 1; i++) {
//            daXInit[i] = guess[i + 1];
//        }
//
//
//        //---- SETUP AND RUN KNITRO TO SOLVE THE PROBLEM.
//
//        //---- CREATE A SOLVER INSTANCE.
//        KnitroJava solver = null;
//        try {
//            solver = new KnitroJava();
//        } catch (java.lang.Exception e) {
//            System.err.println(e);
//            return;
//        }
//
//        // ---- DEMONSTRATE HOW TO SET KNITRO PARAMETERS.
//        if (solver.setCharParamByName("outlev", "none") == false) {
//            System.err.println("Error setting parameter 'outlev'");
//            return;
//        }
//        // solver.setIntParamByName("outlev", 0);
//        // solver.setIntParamByName("debug", 0);
//        if (solver.setDoubleParamByName("feastol", 1.0E-10) == false) {
//            System.err.println("Error setting parameter 'feastol'");
//            return;
//        }
//        if (solver.setIntParamByName("gradopt", 2) == false) {
//            System.err.println("Error setting parameter 'gradopt'");
//            return;
//        }
//        if (solver.setIntParamByName("hessopt", 2) == false) {
//            System.err.println("Error setting parameter 'hessopt'");
//            return;
//        }
//
//        //---- INITIALIZE KNITRO WITH THE PROBLEM DEFINITION.
//        if (solver.initProblem(n, objGoal, objType, bndsLo, bndsUp,
//                m, cType, cBndsLo, cBndsUp,
//                nnzJ, jacIxVar, jacIxConstr,
//                nnzH, hessRow, hessCol,
//                daXInit, null) == false) {
//            System.err.println("Error initializing the problem, " + "KNITRO status = " + solver.getKnitroStatusCode());
//            return;
//        }
//
//        //---- ALLOCATE ARRAYS FOR REVERSE COMMUNICATIONS OPERATION.
//        double[] daX = new double[n];
//        double[] daLambda = new double[m + n];
//        double[] daObj = new double[1];
//        double[] daC = new double[m];
//        double[] daObjGrad = new double[n];
//        double[] daJac = new double[nnzJ];
//        double[] daHess = new double[nnzH];
//
//        // exampleHS15 thisObject = new exampleHS15();
//
//        //---- SOLVE THE PROBLEM.  IN REVERSE COMMUNICATIONS MODE, KNITRO
//        //---- RETURNS WHENEVER IT NEEDS MORE PROBLEM INFORMATION.  THE CALLING
//        //---- PROGRAM MUST INTERPRET KNITRO'S RETURN STATUS AND CONTINUE
//        //---- SUPPLYING PROBLEM INFORMATION UNTIL KNITRO IS COMPLETE.
//        int nKnStatus;
//        int nEvalStatus = 0;
//        do {
//            nKnStatus = solver.solve(nEvalStatus, daObj, daC,
//                    daObjGrad, daJac, daHess);
//            if (nKnStatus == KnitroJava.KTR_RC_EVALFC) {
//                //---- KNITRO WANTS daObj AND daC EVALUATED AT THE POINT x.
//                daX = solver.getCurrentX();
//                // daObj[0] = thisObject.evaluateFC(daX, daC);
//                daObj[0] = evaluateFC(daX, daC);
//            } else if (nKnStatus == KnitroJava.KTR_RC_EVALGA) {
//                //---- KNITRO WANTS daObjGrad AND daJac EVALUATED AT THE POINT x.
//                daX = solver.getCurrentX();
//                // thisObject.evaluateGA(daX, daObjGrad, daJac);
//                evaluateGA(daX, daObjGrad, daJac);
//            } else if (nKnStatus == KnitroJava.KTR_RC_EVALH) {
//                //---- KNITRO WANTS daHess EVALUATED AT THE POINT x.
//                daX = solver.getCurrentX();
//                daLambda = solver.getCurrentLambda();
//                // thisObject.evaluateH(daX, daLambda, daHess);
//                evaluateH(daX, daLambda, daHess);
//            }
//
//            //---- ASSUME THAT PROBLEM EVALUATION IS ALWAYS SUCCESSFUL.
//            //---- IF A FUNCTION OR ITS DERIVATIVE COULD NOT BE EVALUATED
//            //---- AT THE GIVEN (x, lambda), THEN SET nEvalStatus = 1 BEFORE
//            //---- CALLING solve AGAIN.
//            nEvalStatus = 0;
//        } while (nKnStatus > 0);
//
//        //---- DISPLAY THE RESULTS.
//        System.out.print("KNITRO finished, status " + nKnStatus + ": ");
//        switch (nKnStatus) {
//            case KnitroJava.KTR_RC_OPTIMAL:
//                System.out.println("converged to optimality.");
//                break;
//            case KnitroJava.KTR_RC_ITER_LIMIT:
//                System.out.println("reached the maximum number of allowed iterations.");
//                break;
//            case KnitroJava.KTR_RC_NEAR_OPT:
//            case KnitroJava.KTR_RC_FEAS_XTOL:
//            case KnitroJava.KTR_RC_FEAS_FTOL:
//            case KnitroJava.KTR_RC_FEAS_NO_IMPROVE:
//                System.out.println("could not improve upon the current iterate.");
//                break;
//            case KnitroJava.KTR_RC_TIME_LIMIT:
//                System.out.println("reached the maximum CPU time allowed.");
//                break;
//            default:
//                System.out.println("failed.");
//        }
//
//        //---- EXAMPLES OF OBTAINING SOLUTION INFORMATION.
//        System.out.println("  optimal value = " + daObj[0]);
//        daX = solver.getCurrentX();
//        daLambda = solver.getCurrentLambda();
//        System.out.println("  solution feasibility violation    = " + solver.getAbsFeasError());
//        System.out.println("           KKT optimality violation = " + solver.getAbsOptError());
//        System.out.println("  number of function evaluations    = " + solver.getNumberFCEvals());
//
//        //---- BE CERTAIN THE NATIVE OBJECT INSTANCE IS DESTROYED.
//        solver.destroyInstance();
//
//        for (int i = 0; i < daX.length; i++) {
//            guess[i + 1] = daX[i];
//        }
//    }
//
//    private double evaluateFC(double[] daX, double[] daC) {
//        // daX is what we usually call guess or x
//        // daC is the constraint vector: you fill it it here and that is how knitro knows if something is violated or not
//        // daX starts counting at 0 and not 1, so we'll need to move everything over by one and pass it to f_to_minimize
//        // this could potentially work out very nicely!
//        double[] guessX = new double[daX.length + 1];
//        for (int i = 0; i < daX.length; i++) {
//            guessX[i + 1] = daX[i];
//        }
//
//        // no need to fill daC since I have no constraints
//
//        return f_to_minimize(guessX);
//    }
//
//    private void evaluateGA(double[] daX, double[] daObjGrad, double[] daJac) {
//        throw new UnsupportedOperationException("KNitro Gradient: Not yet implemented");
//    }
//
//    private void evaluateH(double[] daX, double[] daLambda, double[] daHess) {
//        throw new UnsupportedOperationException("KNitro Hessian: Not yet implemented");
//    }
}
