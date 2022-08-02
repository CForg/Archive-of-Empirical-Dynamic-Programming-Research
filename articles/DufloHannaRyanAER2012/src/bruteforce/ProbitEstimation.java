/*
 * ProbitEstimation.java
 *
 * Created on Jun 2, 2007, 12:20:59 PM
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
import java.io.Serializable;
import java.text.NumberFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Random;
import java.util.TreeSet;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Future;
import javax.swing.JFrame;
import javax.swing.JProgressBar;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;
import mcmc.gibbsLTEGeneralized;
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
public class ProbitEstimation implements optimization.Uncmin_methods, mcmc.mcmcFunction, Serializable {

    JTable TableResults = null;
    NumberFormat nf = NumberFormat.getInstance();
    ArrayList<Jama.Matrix> workHistories = new ArrayList<Jama.Matrix>();
    ArrayList<Integer> daysInMonth = new ArrayList<Integer>();
    ArrayList<Integer> holidayList = new ArrayList<Integer>();
    Calendar cal = Calendar.getInstance();
    TreeSet<Integer> distributionDays = new TreeSet<Integer>();
    ArrayList<Integer> teacherIDList = new ArrayList<Integer>();
    ArrayList<Integer> teacherIDIndex = new ArrayList<Integer>();
    ArrayList<Double> testScoreList = new ArrayList<Double>();
    ArrayList<Double> controlOpenList = new ArrayList<Double>();
    ArrayList<Double> workedLastMonthList = new ArrayList<Double>();
    ExecutorService tpes = null;
    int daysInLongestMonth = 0;
//    static double[] nodes = {3.436159118, 2.532731674, 1.756683649, 1.036610829, 0.3429013272};
//    static double[] weights = {0.7640432855 * Math.pow(10, -5), 0.1343645746 * Math.pow(10, -2), 0.03387439445, 0.2401386110, 0.6108626337};
    static double[] nodes = {
        2.45340708300901249903e-01, 7.37473728545394358719e-01,
        1.23407621539532300786e+00, 1.73853771211658620678e+00,
        2.25497400208927552311e+00, 2.78880605842813048055e+00,
        3.34785456738321632688e+00, 3.94476404011562521040e+00,
        4.60368244955074427298e+00, 5.38748089001123286199e+00
    };
    static double[] weights = {
        4.62243669600610089640e-01, 2.86675505362834129720e-01,
        1.09017206020023320014e-01, 2.48105208874636108814e-02,
        3.24377334223786183217e-03, 2.28338636016353967260e-04,
        7.80255647853206369398e-06, 1.08606937076928169398e-07,
        4.39934099227318055366e-10, 2.22939364553415129254e-13
    };
    //    // 100 points
//    static double[] nodes = {1.10795872422439482889e-01, 3.32414692342231807054e-01,
//        5.54114823591616988249e-01, 7.75950761540145781976e-01,
//        9.97977436098105243902e-01, 1.22025039121895305882e+00,
//        1.44282597021593278768e+00, 1.66576150874150946983e+00,
//        1.88911553742700837153e+00, 2.11294799637118795206e+00,
//        2.33732046390687850509e+00, 2.56229640237260802502e+00,
//        2.78794142398198931316e+00, 3.01432358033115551667e+00,
//        3.24151367963101295043e+00, 3.46958563641858916968e+00,
//        3.69861685931849193984e+00, 3.92868868342767097205e+00,
//        4.15988685513103054019e+00, 4.39230207868268401677e+00,
//        4.62603063578715577309e+00, 4.86117509179121020995e+00,
//        5.09784510508913624692e+00, 5.33615836013836049734e+00,
//        5.57624164932992410311e+00, 5.81823213520351704715e+00,
//        6.06227883261430263882e+00, 6.30854436111213512156e+00,
//        6.55720703192153931598e+00, 6.80846335285879641431e+00,
//        7.06253106024886543766e+00, 7.31965282230453531632e+00,
//        7.58010080785748888415e+00, 7.84418238446082116862e+00,
//        8.11224731116279191689e+00, 8.38469694041626507474e+00,
//        8.66199616813451771409e+00, 8.94468921732547447845e+00,
//        9.23342089021916155069e+00, 9.52896582339011480496e+00,
//        9.83226980777796909401e+00, 1.01445099412928454695e+01,
//        1.04671854213428121416e+01, 1.08022607536847145950e+01,
//        1.11524043855851252649e+01, 1.15214154007870302416e+01,
//        1.19150619431141658018e+01, 1.23429642228596742953e+01,
//        1.28237997494878089065e+01, 1.34064873381449101387e+01
//    };
//    static double[] weights = {
//        2.18892629587439125060e-01, 1.98462850254186477710e-01,
//        1.63130030502782941425e-01, 1.21537986844104181985e-01,
//        8.20518273912244646789e-02, 5.01758126774286956964e-02,
//        2.77791273859335142698e-02, 1.39156652202318064178e-02,
//        6.30300028560805254921e-03, 2.57927326005909017346e-03,
//        9.52692188548619117497e-04, 3.17291971043300305539e-04,
//        9.51716277855096647040e-05, 2.56761593845490630553e-05,
//        6.22152481777786331722e-06, 1.35179715911036728661e-06,
//        2.62909748375372507934e-07, 4.56812750848493951350e-08,
//        7.07585728388957290740e-09, 9.74792125387162124528e-10,
//        1.19130063492907294976e-10, 1.28790382573155823282e-11,
//        1.22787851441012497000e-12, 1.02887493735099254677e-13,
//        7.54889687791524329227e-15, 4.82983532170303334787e-16,
//        2.68249216476037608006e-17, 1.28683292112115327575e-18,
//        5.30231618313184868536e-20, 1.86499767513025225814e-21,
//        5.56102696165916731717e-23, 1.39484152606876708047e-24,
//        2.91735007262933241788e-26, 5.03779116621318778423e-28,
//        7.10181222638493422964e-30, 8.06743427870937717382e-32,
//        7.27457259688776757460e-34, 5.11623260438522218054e-36,
//        2.74878488435711249209e-38, 1.10047068271422366943e-40,
//        3.18521787783591793076e-43, 6.42072520534847248278e-46,
//        8.59756395482527161007e-49, 7.19152946346337102982e-52,
//        3.45947793647555044453e-55, 8.51888308176163378638e-59,
//        9.01922230369355617950e-63, 3.08302899000327481204e-67,
//        1.97286057487945255443e-72, 5.90806786503120681541e-79
//    };
    Jama.Matrix empiricalDistribution;

    public ProbitEstimation(double[] guess, JProgressBar bar, ExecutorService tpes) {
        this.tpes = tpes;
        go(guess, bar);
    }

    private void go(double[] guess, JProgressBar bar) {
        nf.setMinimumFractionDigits(10);
        System.out.println("Using " + TeacherConstants.NUM_THREADS + " threads in thread pool");
        // first, load and process the data
        // i need teacher-month histories
        GenerateActionList listGen = new GenerateActionList(TeacherConstants.NUM_PERIODS_MATCH, 2);
        ProcessTeacherData process = new ProcessTeacherData(listGen.getList(), bar);

        // i can replace complete histories in dataprocess with simulated data
        workHistories = process.getCompleteHistories();
        daysInMonth = process.getDaysInMonth();
        holidayList = process.getHolidayList();
        distributionDays = process.getDistributionDays();
        teacherIDList = process.getTeacherIDList();
        testScoreList = process.getTestScoreList();
        controlOpenList = process.getControlOpenList();
        workedLastMonthList = process.getWorkedLastMonthList();
        TreeSet<Integer> teacherTree = new TreeSet<Integer>(teacherIDList);
        teacherIDIndex = new ArrayList<Integer>(teacherTree);
        daysInLongestMonth = process.getMaxDaysWorked();
        empiricalDistribution = process.getEmpiricalDistribution();
        System.out.println("Max days worked: " + daysInLongestMonth);
        System.out.println("Number of teachers: " + teacherIDIndex.size());

        if (TeacherConstants.MODEL_VI) {
            if (guess.length != teacherIDIndex.size() + 1 + 1) {
                System.out.println("Parameter vector length not correct.  Currently " + guess.length + " and should be " + (teacherIDIndex.size() + 2));
                guess = new double[teacherIDIndex.size() + 2];
            }
        }

        int numParams = guess.length - 1;
        double[] xpls = new double[numParams + 1];
        double[] fpls = new double[2];
        double[] gpls = new double[numParams + 1];
        int[] itrmcd = new int[2];
        double[][] a = new double[numParams + 1][numParams + 1];
        double[] udiag = new double[numParams + 1];
        double[] typsiz = new double[numParams + 1];
        double[] fscale = {0, 1E-8};
        int[] method = {0, 1};  // 1 line search 2 double dogleg 3 more-hebdon
        int[] iexp = {0, 0}; // 1 if expensive to evaluate
        int[] msg = {0, 0};
        int[] ndigit = {0, 15}; // number of good digits in minimand
        int[] itnlim = {0, 150};
        int[] iagflg = {0, 0};
        int[] iahflg = {0, 0};
        double[] dlt = {0, 1};
        double[] gradtl = {0, 1E-15};
        double[] stepmx = {0, 1E3};
        double[] steptl = {0, 1E-15};

        boolean estimateModel = true;

        boolean plotFunction = false;
        if (plotFunction) {
            double trueRho = guess[3];
            double trueP = guess[9];
            
            // calculateWeightingMatrix(guess);
            
            JFrame plotFrame = new JFrame("Plot objective function");
            plotFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
            plotFrame.setBounds(20, 20, 1000, 800); // big!

            XYSeriesCollection dataset = new XYSeriesCollection();
            XYSeries xy = new XYSeries("GMM");
            bar.setMaximum(16);
            int counter = 1;
            dataset.addSeries(xy);
            ChartPanel panel = new ChartPanel(ChartFactory.createXYLineChart("GMM Objective", "p", "Q_n", dataset, PlotOrientation.VERTICAL, false, false, false));
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

        double[] Sigma = new double[guess.length];

        boolean gridSearchModel_IX = false;
        if (gridSearchModel_IX && TeacherConstants.MODEL_IX) {
            System.out.println("Grid searching MODEL_IX");
            boolean first = true;
            double bestValue = f_to_minimize(guess);
            double[] best = new double[guess.length];
            for (guess[1] = 0; guess[1] <= 0.05; guess[1] += 0.0025) {
                for (guess[2] = -1.5; guess[2] <= 1.5; guess[2] += 0.1) {
                    for (guess[3] = -1; guess[3] <= 1; guess[3] += 0.1) {
                        double v = f_to_minimize(guess);
                        if (v < bestValue || first) {
                            first = false;
                            bestValue = v;
                            best[1] = guess[1];
                            best[2] = guess[2];
                            best[3] = guess[3];
                            System.out.print("Best value at: " + bestValue + " ");
                            pmUtility.prettyPrint(new Jama.Matrix(best, 1));
                        }
                    }
                }
            }
            guess[1] = best[1];
            guess[2] = best[2];
            guess[3] = best[3];
        }

        boolean gridSearchModel_XI = false;
        if (gridSearchModel_XI && TeacherConstants.MODEL_XI) {
            // beta, mu, sigma, yesterday
            System.out.println("Grid searching MODEL_XI");
            boolean first = true;
            System.out.println("Pre-grid search level: " + f_to_minimize(guess));
            double bestValue = f_to_minimize(guess);
            double[] best = new double[guess.length];
            for (guess[1] = 0; guess[1] <= 0.05; guess[1] += 0.0025) {
                for (guess[2] = -1.5; guess[2] <= 1.5; guess[2] += 0.20) {
                    for (guess[3] = 0; guess[3] <= 5; guess[3] += 0.4) {
                        for (guess[4] = -1; guess[4] <= 1; guess[4] += 0.20) {
                            double v = f_to_minimize(guess);
                            if (v < bestValue || first) {
                                first = false;
                                bestValue = v;
                                best[1] = guess[1];
                                best[2] = guess[2];
                                best[3] = guess[3];
                                best[4] = guess[4];
                                System.out.print("Best value: " + bestValue + " ");
                                pmUtility.prettyPrint(new Jama.Matrix(best, 1));
                            } else {
                                // System.out.print("Current value: " + v + " ");
                                // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
                            }
                        }
                    }
                }
            }
            guess[1] = best[1];
            guess[2] = best[2];
            guess[3] = best[3];
            guess[4] = best[4];
        }

        boolean gridSearchModel_13 = false;
        if (gridSearchModel_13 && TeacherConstants.MODEL_13) {
            // beta, mu, attendance, test
            System.out.println("Grid searching MODEL_13");
            boolean first = true;
            System.out.println("Pre-grid search level: " + f_to_minimize(guess));
            double bestValue = f_to_minimize(guess);
            double[] best = new double[guess.length];
            for (guess[1] = 0; guess[1] <= 0.05; guess[1] += 0.0025) {
                for (guess[2] = -1.5; guess[2] <= 1.5; guess[2] += 0.25) {
                    for (guess[3] = -1; guess[3] <= 1; guess[3] += 0.25) {
                        for (guess[4] = -1; guess[4] <= 1; guess[4] += 0.25) {
                            double v = f_to_minimize(guess);
                            if (v < bestValue || first) {
                                first = false;
                                bestValue = v;
                                best[1] = guess[1];
                                best[2] = guess[2];
                                best[3] = guess[3];
                                best[4] = guess[4];
                                System.out.print("Best value: " + bestValue + " ");
                                pmUtility.prettyPrint(new Jama.Matrix(best, 1));
                            } else {
                                // System.out.print("Current value: " + v + " ");
                                // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
                            }
                        }
                    }
                }
            }
            guess[1] = best[1];
            guess[2] = best[2];
            guess[3] = best[3];
            guess[4] = best[4];
        }

        boolean gridSearchModel_14 = false;
        if (gridSearchModel_14 && TeacherConstants.MODEL_14) {
            // beta, mu, attendance, test, yesterday
            System.out.println("Grid searching MODEL_14");
            boolean first = true;
            System.out.println("Pre-grid search level: " + f_to_minimize(guess));
            double bestValue = f_to_minimize(guess);
            double[] best = new double[guess.length];
            for (guess[1] = 0; guess[1] <= 0.05; guess[1] += 0.005) {
                for (guess[2] = -3; guess[2] <= 3; guess[2] += 0.5) {
                    for (guess[3] = -0.5; guess[3] <= 0.5; guess[3] += 0.5) {
                        for (guess[4] = -0.5; guess[4] <= 0.5; guess[4] += 0.5) {
                            for (guess[5] = -1.5; guess[5] <= 1.5; guess[5] += 0.5) {
                                double v = f_to_minimize(guess);
                                if (v < bestValue || first) {
                                    first = false;
                                    bestValue = v;
                                    best[1] = guess[1];
                                    best[2] = guess[2];
                                    best[3] = guess[3];
                                    best[4] = guess[4];
                                    best[5] = guess[5];
                                    System.out.print("Best value: " + bestValue + " ");
                                    pmUtility.prettyPrint(new Jama.Matrix(best, 1));
                                } else {
                                    // System.out.print("Current value: " + v + " ");
                                    // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
                                }
                            }
                        }
                    }
                }
            }
            guess[1] = best[1];
            guess[2] = best[2];
            guess[3] = best[3];
            guess[4] = best[4];
            guess[5] = best[5];
        }

        boolean gridSearchModel_15 = false;
        if (gridSearchModel_15 && TeacherConstants.MODEL_15) {
            // beta, mu, attendance, test, yesterday, sigma
            System.out.println("Grid searching MODEL_15");
            boolean first = true;
            System.out.println("Pre-grid search level: " + f_to_minimize(guess));
            double bestValue = f_to_minimize(guess);
            double[] best = new double[guess.length];
            for (guess[1] = 0; guess[1] <= 0.05; guess[1] += 0.005) {
                for (guess[2] = -3; guess[2] <= 3; guess[2] += 0.5) {
                    for (guess[3] = 0; guess[3] <= 0; guess[3] += 0.5) {
                        for (guess[4] = 0; guess[4] <= 0; guess[4] += 0.5) {
                            for (guess[5] = -1.5; guess[5] <= 1.5; guess[5] += 0.5) {
                                for (guess[6] = 0; guess[6] <= 2; guess[6] += 0.33) {
                                    double v = f_to_minimize(guess);
                                    if (v < bestValue || first) {
                                        first = false;
                                        bestValue = v;
                                        best[1] = guess[1];
                                        best[2] = guess[2];
                                        best[3] = guess[3];
                                        best[4] = guess[4];
                                        best[5] = guess[5];
                                        best[6] = guess[6];
                                        System.out.print("Best value: " + bestValue + " ");
                                        pmUtility.prettyPrint(new Jama.Matrix(best, 1));
                                    } else {
                                        // System.out.print("Current value: " + v + " ");
                                        // pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
                                    }
                                }
                            }
                        }
                    }
                }
            }
            guess[1] = best[1];
            guess[2] = best[2];
            guess[3] = best[3];
            guess[4] = best[4];
            guess[5] = best[5];
            guess[6] = best[6];
        }

        boolean gridSearchModel_16 = false;
        if (gridSearchModel_16 && TeacherConstants.MODEL_16) {
            System.out.println("Fmin at initial vector: " + f_to_minimize(guess));
            // how to do this?
            // take the other parameters as given, and search over the heterogeneity parameters
            guess[1] = 0.007; //        beta
            guess[2] = -4.5;  //        mu_1
            guess[3] = 0;  //           test
            guess[4] = 0;  //           attendance
            guess[5] = 0;  //           yesterday
            guess[6] = 0.597;  //       sigma_1
            guess[7] = 1.5072; //       mu_2
            guess[8] = 1; //            sigma_2
            guess[9] = 0.13; //         p
            System.out.println("Fmin at paper's parameter values: " + f_to_minimize(guess));
            // search over 2,6,7,8,9
            // just fix sigma at 1 to start
            guess[6] = 1;
            guess[8] = 1;
            double lowest = 0;
            boolean first = true;

            double[] best = new double[guess.length];

            ArrayList<Future<MCData>> futureList = new ArrayList<Future<MCData>>(workHistories.size());

            System.out.println("Grid search for two types for MODEL_16");
            for (guess[1] = 0; guess[1] <= 0.1; guess[1] += 0.01) {
                for (guess[2] = -4; guess[2] <= 3; guess[2] += 1.5) {
                    for (guess[7] = guess[2] + 1E-10; guess[7] <= 4; guess[7] += 0.5) {
                        for (guess[9] = 0; guess[9] <= 1.0; guess[9] += 0.25) {
                            futureList.add(tpes.submit(new MonteCarloTask_Model_16(guess, controlOpenList, testScoreList, workHistories, daysInMonth, holidayList, daysInLongestMonth)));
                        }
                    }
                }
            }

            try {
                for (Future<MCData> f : futureList) {
                    MCData mcd = f.get();
                    if (mcd.getValue() < lowest || first) {
                        lowest = mcd.getValue();
                        first = false;
                        for (int i = 0; i < guess.length; i++) {
                            best[i] = mcd.getGuess()[i];
                        }
                    }
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            for (int i = 0; i < guess.length; i++) {
                guess[i] = best[i];
            }
        }

        if (estimateModel) {
            optimization.Uncmin_f77 minimizer = new optimization.Uncmin_f77(true);

            System.out.println("Pre-optimization level: " + f_to_minimize(guess));

            boolean useLTE = true;
            boolean useKNitro = false;
            boolean useUncmin = true;

            boolean zeroVector = false;
            if (zeroVector) {
                for (int i = 0; i < guess.length; i++) {
                    guess[i] = 0;
                }
            }

            /**
             * Uncomment this if you wish to use KNITRO to solve the problem.
             */
//            if (useKNitro) {
//                System.out.print("Before KNITRO: " + pmUtility.stringPrettyPrint(new Jama.Matrix(guess, 1)));
//                solveUsingKNitro(guess);
//                System.out.print("After KNITRO: " + pmUtility.stringPrettyPrint(new Jama.Matrix(guess, 1)));
//            }
            if (useUncmin) {
                minimizer.optif9_f77(numParams, guess, this, typsiz, fscale, method, iexp, msg, ndigit, itnlim, iagflg, iahflg, dlt, gradtl, stepmx, steptl, xpls, fpls, gpls, itrmcd, a, udiag);
                pmUtility.prettyPrint(new Jama.Matrix(guess, 1));
            }
            if (useLTE) {
                String[] name = {"Beta", "Mu", "Rho", "Mu_Sigma", "Mu2", "Mu2Sigma", "ProbMu2"};
                String SigmaFileName = "bruteVar_V";
                if (TeacherConstants.MODEL_VI) {
                    name = new String[1 + teacherIDIndex.size()];
                    name[0] = "Beta";
                    for (int i = 0; i < teacherIDIndex.size(); i++) {
                        name[i + 1] = "Mu_" + i;
                    }
                    SigmaFileName = "bruteVar_VI";
                }
                if (TeacherConstants.MODEL_IX) {
                    SigmaFileName = "bruteVar_IX";
                    name = new String[3];
                    name[0] = "Beta";
                    name[1] = "Mu";
                    name[2] = "Yesterday";
                }
                if (TeacherConstants.MODEL_VIII) {
                    SigmaFileName = "bruteVar_VIIIa";
                    name = new String[6];
                    name[0] = "Beta";
                    name[1] = "Mu_1";
                    name[2] = "Mu_1_Sigma";
                    name[3] = "Mu_2";
                    name[4] = "Mu_2_Sigma";
                    name[5] = "Prob Mu2";
                }
                if (TeacherConstants.MODEL_X) {
                    SigmaFileName = "bruteVar_X";
                    name = new String[7];
                    name[0] = "Beta";
                    name[1] = "Mu_1";
                    name[2] = "Mu_1_Sigma";
                    name[3] = "Mu_2";
                    name[4] = "Mu_2_Sigma";
                    name[5] = "Prob Mu2";
                    name[6] = "Yesterday_Shifter";
                }
                if (TeacherConstants.MODEL_XI) {
                    SigmaFileName = "bruteVar_XI";
                    name = new String[4];
                    name[0] = "Beta";
                    name[1] = "Mu_1";
                    name[2] = "Mu_1_Sigma";
                    name[3] = "Yesterday_Shifter";
                }
                if (TeacherConstants.MODEL_XII) {
                    SigmaFileName = "bruteVar_XII";
                    name = new String[3];
                    name[0] = "Beta";
                    name[1] = "Mu_1";
                    name[2] = "Mu_1_Sigma";
                }
                if (TeacherConstants.MODEL_13) {
                    SigmaFileName = "bruteVar_13";
                    name = new String[4];
                    name[0] = "Beta";
                    name[1] = "Mu";
                    name[2] = "Attendance";
                    name[3] = "TestScore";
                }
                if (TeacherConstants.MODEL_14) {
                    SigmaFileName = "bruteVar_14";
                    name = new String[5];
                    name[0] = "Beta";
                    name[1] = "Mu";
                    name[2] = "Attendance";
                    name[3] = "TestScore";
                    name[4] = "Yesterday";
                }
                if (TeacherConstants.MODEL_15) {
                    SigmaFileName = "bruteVar_15";
                    name = new String[6];
                    name[0] = "Beta";
                    name[1] = "Mu_mean";
                    name[2] = "Attendance";
                    name[3] = "TestScore";
                    name[4] = "Yesterday";
                    name[5] = "Mu_Sigma";
                }
                if (TeacherConstants.MODEL_16) {
                    SigmaFileName = "bruteVar_16";
                    name = new String[9];
                    name[0] = "Beta";
                    name[1] = "Mu_mean";
                    name[2] = "Attendance";
                    name[3] = "TestScore";
                    name[4] = "Yesterday";
                    name[5] = "Mu_sigma";
                    name[6] = "Mu_mean2";
                    name[7] = "Mu_sigma2";
                    name[8] = "ProbType2";
                }
                if (TeacherConstants.MODEL_18) {
                    SigmaFileName = "bruteVar_18";
                    name = new String[3];
                    name[0] = "Beta";
                    name[1] = "Mu";
                    name[2] = "Last Month";
                }
                if (TeacherConstants.MODEL_19) {
                    SigmaFileName = "bruteVar_19";
                    name = new String[5];
                    name[0] = "Beta";
                    name[1] = "Mu_1";
                    name[2] = "Mu_1_Sigma";
                    name[3] = "Yesterday_Shifter";
                    name[4] = "Last Month";
                }
                if (TeacherConstants.MODEL_20) {
                    SigmaFileName = "bruteVar_20";
                    name = new String[7];
                    name[0] = "Beta";
                    name[1] = "Mu_mean";
                    name[2] = "Attendance";
                    name[3] = "TestScore";
                    name[4] = "Yesterday";
                    name[5] = "Mu_Sigma";
                    name[6] = "Last Month";
                }
                if (TeacherConstants.MODEL_21) {
                    SigmaFileName = "bruteVar_21";
                    name = new String[4];
                    name[0] = "Beta";
                    name[1] = "Mu";
                    name[2] = "Yesterday";
                    name[3] = "Last Month";
                }

                if (TeacherConstants.USE_WINDOW) {
                    SigmaFileName = SigmaFileName.concat("Window" + TeacherConstants.DAYS_WINDOW);
                }

                boolean preEstimation = false;
                if (preEstimation) {
                    minimizer.optif9_f77(numParams, guess, this, typsiz, fscale, method, iexp, msg, ndigit, itnlim, iagflg, iahflg, dlt, gradtl, stepmx, steptl, xpls, fpls, gpls, itrmcd, a, udiag);
                }

                long t1 = System.currentTimeMillis();
                gibbsLTEGeneralized lte = new gibbsLTEGeneralized(this, 500, 0, guess, SigmaFileName, name);
                // gibbsLTEGeneralized lte = new gibbsLTEGeneralized(this, 500, 500, guess, name);
                Jama.Matrix results = lte.getChain();
                // pmUtility.prettyPrint(results);
                long t2 = System.currentTimeMillis();
                System.out.println("Time elapsed: " + (t2 - t1) / 1000.0 + " seconds.");

                guess = lte.getLowestPoint();

                try {
                    BufferedWriter out = new BufferedWriter(new FileWriter("data/results.txt"));

                    for (int i = 0; i < numParams; i++) {
                        // guess[i + 1] = pmUtility.mean(results, i + 1);
                        Sigma[i + 1] = Math.pow(pmUtility.standardDeviation(results, i + 1), 2);
                        System.out.println(name[i] + ": lowest: " + nf.format(guess[i + 1]) + " mean: " + nf.format(pmUtility.mean(results, i + 1)) + " median: " + nf.format(pmUtility.median(results, i + 1)) + " stddev: " + nf.format(pmUtility.standardDeviation(results, i + 1)));
                        out.write(name[i] + ": lowest: " + nf.format(guess[i + 1]) + " mean: " + nf.format(pmUtility.mean(results, i + 1)) + " median: " + nf.format(pmUtility.median(results, i + 1)) + " stddev: " + nf.format(pmUtility.standardDeviation(results, i + 1)) + "\n");
                    }
                    out.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
                Object[][] data = new Object[numParams][4];

                for (int i = 0; i < numParams; i++) {
                    data[i][0] = name[i];
                    data[i][1] = nf.format(pmUtility.mean(results, i + 1));
                    data[i][2] = nf.format(pmUtility.median(results, i + 1));
                    data[i][3] = nf.format(pmUtility.standardDeviation(results, i + 1));
                }
                String[] colNames = {"Parameter", "Mean", "Median", "Std.Dev."};
                DefaultTableModel model = new DefaultTableModel(data, colNames);
                if (TableResults != null) {
                    TableResults.setModel(model);
                }

                // pmUtility.prettyPrint(new Jama.Matrix(lte.getLowestPoint(),1));
                guess = lte.getLowestPoint();
            }
            System.out.println("Best f: " + f_to_minimize(guess));
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
            }
            if (TeacherConstants.MODEL_X) {
                model = "X";
            }
            if (TeacherConstants.MODEL_XI) {
                model = "XI";
            }
            if (TeacherConstants.MODEL_XII) {
                model = "XII";
            }
            if (TeacherConstants.MODEL_13) {
                model = "13";
            }
            if (TeacherConstants.MODEL_14) {
                model = "14";
            }
            if (TeacherConstants.MODEL_15) {
                model = "15";
            }
            if (TeacherConstants.MODEL_16) {
                model = "16";
            }
            if (TeacherConstants.MODEL_18) {
                model = "18";
            }
            if (TeacherConstants.MODEL_19) {
                model = "19";
            }
            if (TeacherConstants.MODEL_20) {
                model = "20";
            }
            if (TeacherConstants.MODEL_21) {
                model = "21";
            }

            if (TeacherConstants.USE_WINDOW) {
                model = model.concat("Window" + TeacherConstants.DAYS_WINDOW);
            }

            try {
                System.out.println("Writing results to data/guess" + model + ".dat");
                ObjectOutputStream out = new ObjectOutputStream(new FileOutputStream("data/guess" + model + ".dat"));
                out.writeObject(guess);
                out.writeObject(Sigma);
                out.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public double f_to_minimize(double[] x) {
        double value = 0;

        // this works (everyone has same value at zero vector)
//        for (int i = 0; i < x.length; i++) {
//            x[i] = 0;
//        }

        if (TeacherConstants.MODEL_IX) {
            // x[3] = 0;
            StateSpaceIIDYesterday s = new StateSpaceIIDYesterday(x[1], x[2], daysInLongestMonth, x[3]);
            value += generateSimulatedYesterdayLLH(s);
        }

        // Model V is everyone shares the same two parameters
        // System.out.println("Inside fmin");

        if (TeacherConstants.MODEL_V) {
            // list of statespaces will be degenerate in this case; easy to see if it works in this case
            // to test that iidYesterday is working, can switch in that statespace here and give it a yesterday shifter of zero
            // should give the same results
            boolean testYesterday = false;
            if (testYesterday) {
                StateSpaceIIDYesterday s = new StateSpaceIIDYesterday(x[1], x[2], daysInLongestMonth, 0);
                value += generateSimulatedYesterdayLLH(s);
                // this gives the same answer as the code below, which is reassuring
            } else {
                StateSpaceIID s = new StateSpaceIID(x[1], x[2], daysInLongestMonth);
                ArrayList<StateSpaceIID> stateSpaceList = new ArrayList<StateSpaceIID>();
                stateSpaceList.add(s);
                value += generateSimulatedLLH(stateSpaceList);
            }
        }

        // common mu, beta, shifter on mu for last month's attendance
        if (TeacherConstants.MODEL_18) {
            // x[3] = 0;
            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>(workHistories.size());

            for (int ij = 0; ij < workHistories.size(); ij++) {
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                double workedLastMonth = workedLastMonthList.get(ij);

                futureList.add(tpes.submit(new Model_VI_Task(x[1], x[2] + x[3] * workedLastMonth, daysInLongestMonth, holidayList.get(ij), daysInCurrentMonth, history)));
            }
            try {
                for (Future<Double> f : futureList) {
                    Double llh_i = f.get();
                    value += llh_i;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        // mu/sigma, beta, shifter on mu for last month's attendance, yesterday
        if (TeacherConstants.MODEL_19) {
//            name[0] = "Beta";
//            name[1] = "Mu_1";
//            name[2] = "Mu_1_Sigma";
//            name[3] = "Yesterday_Shifter";
//            name[4] = "Last Month";
            // x[5] = 0;
            // map current x into format taken by the more general model (put zeros in appropriate places)
            // model 15 task takes parameters in order: beta, mu1, control, score, yesterday, sigma1, last month
            double[] guess = new double[7 + 1];
            guess[1] = x[1]; // beta
            guess[2] = x[2]; // mu_1
            guess[3] = 0;    // control
            guess[4] = 0;    // score
            guess[5] = x[4]; // yesterday
            guess[6] = x[3]; // sigma_1
            guess[7] = x[5]; // last month

            double llh = 0;

            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>();
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                double workedLastMonth = workedLastMonthList.get(ij);
                futureList.add(tpes.submit(new Model_15_FullyEncapsulatedTask(guess, controlOpen, teacherScore, workedLastMonth, daysInLongestMonth, workHistories.get(ij), daysInMonth.get(ij), holidayList.get(ij))));
            }

            boolean recordLLH = false;

            try {
                for (Future<Double> f : futureList) {
                    double llh_i = f.get();
                    llh += llh_i;
                    if (recordLLH) {
                        System.out.println(llh_i + "," + llh);
                    }
                }
                if (recordLLH) {
                    System.exit(0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }


            value = llh;
            // System.out.print(value+" ");
            // pmUtility.prettyPrint(new Jama.Matrix(x, 1));
            // System.exit(0);
        }

        // mu/sigma, beta, shifter on mu for last month's attendance, yesterday, score, control block
        if (TeacherConstants.MODEL_20) {
//            name[0] = "Beta";
//            name[1] = "Mu_mean";
//            name[2] = "Attendance";
//            name[3] = "TestScore";
//            name[4] = "Yesterday";
//            name[5] = "Mu_Sigma";
//            name[6] = "Last Month";
            // x[7] = 0;
            // map current x into format taken by the more general model (put zeros in appropriate places)
            // model 15 task takes parameters in order: beta, mu1, control, score, yesterday, sigma1, last month
            double[] guess = new double[7 + 1];
            guess[1] = x[1]; // beta
            guess[2] = x[2]; // mu_1
            guess[3] = x[3]; // control
            guess[4] = x[4]; // score
            guess[5] = x[5]; // yesterday
            // let's try out sigma_1^2
//            guess[6] = x[6]; // sigma_1
            guess[6] = Math.max(0, x[6]);
            guess[6] = Math.sqrt(guess[6]);
            guess[7] = x[7]; // last month

            double llh = 0;

            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>();
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                double workedLastMonth = workedLastMonthList.get(ij);
                futureList.add(tpes.submit(new Model_15_FullyEncapsulatedTask(guess, controlOpen, teacherScore, workedLastMonth, daysInLongestMonth, workHistories.get(ij), daysInMonth.get(ij), holidayList.get(ij))));
            }

            boolean recordLLH = false;

            try {
                for (Future<Double> f : futureList) {
                    double llh_i = f.get();
                    llh += llh_i;
                    if (recordLLH) {
                        System.out.println(llh_i + "," + llh);
                    }
                }
                if (recordLLH) {
                    System.exit(0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }


            value = llh;
            // System.out.print(value+" ");
            // pmUtility.prettyPrint(new Jama.Matrix(x, 1));
            // System.exit(0);
        }

        // mu, beta, shifter on mu for last month's attendance, yesterday
        if (TeacherConstants.MODEL_21) {
//            name[0] = "Beta";
//            name[1] = "Mu";
//            name[2] = "Yesterday";
//            name[3] = "Last Month";
            // x[4] = 0;

            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>(workHistories.size());

            for (int ij = 0; ij < workHistories.size(); ij++) {
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                double workedLastMonth = workedLastMonthList.get(ij);

                double beta = x[1];
                double mu = x[2];
                double yesterdayShifter = x[3];
                mu += x[4] * workedLastMonth;

                futureList.add(tpes.submit(new Model_14_Task(beta, mu, holidayList.get(ij), daysInCurrentMonth, history, yesterdayShifter)));
            }

            try {
                for (Future<Double> f : futureList) {
                    Double llh_i = f.get();
                    value += llh_i;
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (TeacherConstants.MODEL_13) {
            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>(workHistories.size());

            for (int ij = 0; ij < workHistories.size(); ij++) {
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                // System.out.println(daysInCurrentMonth+" "+controlOpen+" "+teacherScore+" "+teacherIDList.get(ij)+" "+holidayList.get(ij));

                futureList.add(tpes.submit(new Model_VI_Task(x[1], x[2] + x[3] * controlOpen + x[4] * teacherScore, daysInLongestMonth, holidayList.get(ij), daysInCurrentMonth, history)));
            }
            try {
//                BufferedWriter out = new BufferedWriter(new FileWriter("model13.csv"));
                for (Future<Double> f : futureList) {
                    Double llh_i = f.get();
                    value += llh_i;
//                    out.write(llh_i + "," + value + "\n");
                }
//                out.close();
//                System.exit(0);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (TeacherConstants.MODEL_14) {
            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>(workHistories.size());

            for (int ij = 0; ij < workHistories.size(); ij++) {
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                // System.out.println(daysInCurrentMonth+" "+controlOpen+" "+teacherScore+" "+teacherIDList.get(ij)+" "+holidayList.get(ij));

                double beta = x[1];
                double mu = x[2];
                mu += x[3] * controlOpen;
                mu += x[4] * teacherScore;
                double yesterdayShifter = x[5];

                futureList.add(tpes.submit(new Model_14_Task(beta, mu, holidayList.get(ij), daysInCurrentMonth, history, yesterdayShifter)));
            }

            boolean recordLLH = false;

            try {
                BufferedWriter out = null;
                if (recordLLH) {
                    out = new BufferedWriter(new FileWriter("model14.csv"));
                }
                for (Future<Double> f : futureList) {
                    Double llh_i = f.get();
                    value += llh_i;
                    if (recordLLH) {
                        out.write(llh_i + "," + value + "\n");
                    }
                }
                if (recordLLH) {
                    out.close();
                    System.out.println("LLH Model_14: " + value);
                    System.exit(0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
            // System.out.print(value+" ");
            // pmUtility.prettyPrint(new Jama.Matrix(x, 1));
            // System.exit(0);
        }

        // Model VI is where everyone shares beta, and has their own mu
        // a little bit more complicated
        // not that much more, x[1] is beta, and x[2+IDindex] is the mu
        if (TeacherConstants.MODEL_VI) {
            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>(workHistories.size());

            for (int ij = 0; ij < workHistories.size(); ij++) {
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                int teacherID = teacherIDList.get(ij);
                int teacherIndex = teacherIDIndex.indexOf(new Integer(teacherID));

                if (daysInCurrentMonth >= TeacherConstants.MIN_DAYS_REQUIRED) {
                    futureList.add(tpes.submit(new Model_VI_Task(x[1], x[2 + teacherIndex], daysInLongestMonth, holidayList.get(ij), daysInCurrentMonth, history)));
                }
            }
            try {
                for (Future<Double> f : futureList) {
                    value += f.get();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (TeacherConstants.MODEL_VIII) {
            // x[1] = Math.max(0, x[1]);
            // x[2] = Math.min(x[2], x[4] - (1.0E-3));  // makes sure this always to the left of x[4]
            x[3] = Math.max(1E-100, x[3]);
            x[4] = Math.max(x[2] + (1.0E-3), x[4]); // this assure it is always to the right of x[2]
            x[5] = Math.max(1.0E-100, x[5]);
            x[6] = Math.max(0, x[6]);
            x[6] = Math.min(1, x[6]); // bound that probability

            if (x[2] > x[4]) {
                System.out.println("WTF!");
            }

            boolean useQuadrature = true;
            if (useQuadrature) {
                double llh = 0;
                double numObs = 0;

                // double probType2 = Math.exp(x[6])/(1.0+Math.exp(x[6]));
                double probType2 = x[6];

                ArrayList<StateSpaceIID> stateSpaceList = new ArrayList<StateSpaceIID>();
                ArrayList<Double> weightList = new ArrayList<Double>();
                for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
                    for (double sign = -1; sign <= 1; sign += 2) {
                        double mu1 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[3]) + x[2];
                        double mu2 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[5]) + x[4];
                        double weight = weights[nodeIndex] * Math.pow(Math.PI, -0.5);
                        weightList.add(weight * (1.0 - probType2));
                        stateSpaceList.add(new StateSpaceIID(x[1], mu1, daysInLongestMonth));
                        weightList.add(weight * probType2);
                        stateSpaceList.add(new StateSpaceIID(x[1], mu2, daysInLongestMonth));
                    }
                }

                for (int ij = 0; ij < workHistories.size(); ij++) {
                    double outerProb = 0;
                    // for (StateSpaceIIDYesterday s : stateSpaceList) {
                    for (int si = 0; si < stateSpaceList.size(); si++) {
                        StateSpaceIID s = stateSpaceList.get(si);
                        double prob = 1;
                        Jama.Matrix history = workHistories.get(ij);
                        int daysInCurrentMonth = daysInMonth.get(ij);
                        int daysWorked = 0;
                        int numHolidays = holidayList.get(ij);
                        int diff = daysInLongestMonth - daysInCurrentMonth;
                        daysWorked += history.get(0, 0);
                        // NOTE: starting at t=1
                        for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                            double p = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays);
                            if (history.get(i, 0) == 1) {
                                prob *= p;
                                daysWorked++;
                            } else {
                                prob *= (1.0 - p);
                            }
                            numObs++;
                        }
                        // System.out.println(prob);
                        outerProb += weightList.get(si) * prob;
                    }
                    // outerProb /= (0.0 + stateSpaceList.size());
                    // cluster likelihoods at the month-teacher level
                    llh += Math.log(outerProb);
                }
                value = llh;
            } else {
                Random rng = new Random(787);
                // model VIII is type types without rho
                ArrayList<Future<StateSpaceIID>> futureList = new ArrayList<Future<StateSpaceIID>>();

                for (int i = 0; i < TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE; i++) {
                    futureList.add(tpes.submit(new Model_VIII_Task(x, rng.nextLong(), daysInLongestMonth)));
                }

                ArrayList<StateSpaceIID> stateSpaceList = new ArrayList<StateSpaceIID>();
                try {
                    for (Future<StateSpaceIID> f : futureList) {
                        stateSpaceList.add(f.get());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                value = generateSimulatedLLH(stateSpaceList);
            }
        }

        if (TeacherConstants.MODEL_X) {
            // x[2] = Math.min(x[2], x[4] - (1.0E-3));  // makes sure this always to the left of x[4]
            // x[2] = Math.min(0, x[2]); // make sure it is always left of zero
            x[3] = Math.max(1E-100, x[3]);
            x[4] = Math.max(x[2] + (1.0E-3), x[4]); // this assure it is always to the right of x[2]
            // x[4] = Math.max(2, x[4]); // make sure it is always to the right of zero
            x[5] = Math.max(1.0E-100, x[5]);
            x[6] = Math.max(0, x[6]);
            x[6] = Math.min(1, x[6]); // bound that probability
            // x[7] is the yesterdayShifter

            // suppose that x[6] = 0;
            // x[6] = 0;
            // as a test, this should give me the same results as the model with just one type
            // verified that it works with one type

            boolean useQuadrature = true;
            if (useQuadrature) {
                double llh = 0;
                double numObs = 0;

                double probType2 = x[6];

                ArrayList<StateSpaceIIDYesterday> stateSpaceList = new ArrayList<StateSpaceIIDYesterday>();
                ArrayList<Double> weightList = new ArrayList<Double>();
                for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
                    for (double sign = -1; sign <= 1; sign += 2) {
                        double mu1 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[3]) + x[2];
                        double mu2 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[5]) + x[4];
                        double weight = weights[nodeIndex] * Math.pow(Math.PI, -0.5);
                        weightList.add(weight * (1.0 - probType2));
                        stateSpaceList.add(new StateSpaceIIDYesterday(x[1], mu1, daysInLongestMonth, x[7]));
                        weightList.add(weight * probType2);
                        stateSpaceList.add(new StateSpaceIIDYesterday(x[1], mu2, daysInLongestMonth, x[7]));
                    }
                }

                for (int ij = 0; ij < workHistories.size(); ij++) {
                    double outerProb = 0;
                    // for (StateSpaceIIDYesterday s : stateSpaceList) {
                    for (int si = 0; si < stateSpaceList.size(); si++) {
                        StateSpaceIIDYesterday s = stateSpaceList.get(si);
                        double prob = 1;
                        Jama.Matrix history = workHistories.get(ij);
                        int daysInCurrentMonth = daysInMonth.get(ij);
                        int daysWorked = 0;
                        int numHolidays = holidayList.get(ij);
                        int diff = daysInLongestMonth - daysInCurrentMonth;
                        int workedYesterday = (int) history.get(0, 0);
                        daysWorked += workedYesterday;
                        // note: starting at t=1
                        for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                            double p = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays, workedYesterday);
                            boolean validDay = true;
                            if (TeacherConstants.USE_WINDOW) {
                                if (i > TeacherConstants.DAYS_WINDOW && i < daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW) {
                                    validDay = false;
                                }
                            }
                            if (history.get(i, 0) == 1) {
                                if (validDay) {
                                    prob *= p;
                                }
                                daysWorked++;
                                workedYesterday = 1;
                            } else {
                                if (validDay) {
                                    prob *= (1.0 - p);
                                }
                                workedYesterday = 0;
                            }
                            numObs++;
                        }
                        outerProb += weightList.get(si) * prob;
                    }
                    // outerProb /= (0.0 + stateSpaceList.size());
                    // cluster likelihoods at the month-teacher level
                    llh += Math.log(outerProb);
                }
                value = llh;
            } else {
                Random rng = new Random(787);
                // model VIII is type types without rho
                ArrayList<Future<StateSpaceIIDYesterday>> futureList = new ArrayList<Future<StateSpaceIIDYesterday>>();
                for (int i = 0; i < TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE; i++) {
                    futureList.add(tpes.submit(new Model_X_Task(x, rng.nextLong(), daysInLongestMonth)));
                }
                ArrayList<StateSpaceIIDYesterday> stateSpaceList = new ArrayList<StateSpaceIIDYesterday>();
                try {
                    for (Future<StateSpaceIIDYesterday> f : futureList) {
                        stateSpaceList.add(f.get());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                value = generateSimulatedLLHYesterday(stateSpaceList);
            }
        }
        //        System.out.println("Value: " + value);
//        System.exit(0);
        if (TeacherConstants.MODEL_XI) {
            x[3] = Math.max(1E-100, x[3]);

            boolean useQuadrature = true;
            if (useQuadrature) {
                double llh = 0;
                double numObs = 0;

                ArrayList<StateSpaceIIDYesterday> stateSpaceList = new ArrayList<StateSpaceIIDYesterday>();
                ArrayList<Double> weightList = new ArrayList<Double>();
                // double sumW = 0;
                for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
                    for (double sign = -1; sign <= 1; sign += 2) {
                        double mu1 = sign * (nodes[nodeIndex] * Math.sqrt(2) * Math.sqrt(x[3])) + x[2];
                        double weight = weights[nodeIndex] * Math.pow(Math.PI, -0.5);
                        //sumW+=weight;
                        weightList.add(weight);
                        stateSpaceList.add(new StateSpaceIIDYesterday(x[1], mu1, daysInLongestMonth, x[4]));
                    }
                }
                // System.out.println(sumW);

                for (int ij = 0; ij < workHistories.size(); ij++) {
                    double outerProb = 0;
                    // for (StateSpaceIIDYesterday s : stateSpaceList) {
                    for (int si = 0; si < stateSpaceList.size(); si++) {
                        StateSpaceIIDYesterday s = stateSpaceList.get(si);
                        double prob = 1;
                        Jama.Matrix history = workHistories.get(ij);
                        int daysInCurrentMonth = daysInMonth.get(ij);
                        int daysWorked = 0;
                        int numHolidays = holidayList.get(ij);
                        int diff = daysInLongestMonth - daysInCurrentMonth;
                        int workedYesterday = (int) history.get(0, 0);
                        daysWorked += workedYesterday;
                        // NOTE: starting at t=1
                        for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                            double p = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays, workedYesterday);
                            boolean validDay = true;
                            if (TeacherConstants.USE_WINDOW) {
                                if (i > TeacherConstants.DAYS_WINDOW && i < daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW) {
                                    validDay = false;
                                }
                            }
                            if (history.get(i, 0) == 1) {
                                if (validDay) {
                                    prob *= p;
                                }
                                daysWorked++;
                                workedYesterday = 1;
                            } else {
                                if (validDay) {
                                    prob *= (1.0 - p);
                                }
                                workedYesterday = 0;
                            }
                            numObs++;
                        }
                        outerProb += weightList.get(si) * prob;
                    }
                    // outerProb /= (0.0 + stateSpaceList.size());
                    // cluster likelihoods at the month-teacher level
                    llh += Math.log(outerProb);
                }
                value = llh;
            } else {
                // shouldn't this work?!?
                // yes, it does (July 16, 2009)
                Random rng = new Random(787);

                ArrayList<Future<StateSpaceIIDYesterday>> futureList = new ArrayList<Future<StateSpaceIIDYesterday>>();

                for (int i = 0; i < TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE; i++) {
                    futureList.add(tpes.submit(new Model_XI_Task(x, rng.nextLong(), daysInLongestMonth)));
                }
                ArrayList<StateSpaceIIDYesterday> stateSpaceList = new ArrayList<StateSpaceIIDYesterday>();
                try {
                    for (Future<StateSpaceIIDYesterday> f : futureList) {
                        stateSpaceList.add(f.get());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                value = generateSimulatedLLHYesterday(stateSpaceList);
            }
        }

        if (TeacherConstants.MODEL_15) {
            // model with one dimension of heterogeneity, and with teacher scores and control group shifters
            // how to integrate these guys?
            x[6] = Math.max(0, x[6]);
            double llh = 0;

            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>();
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                futureList.add(tpes.submit(new Model_15_FullyEncapsulatedTask(x, controlOpen, teacherScore, daysInLongestMonth, workHistories.get(ij), daysInMonth.get(ij), holidayList.get(ij))));
            }

            boolean recordLLH = false;

            try {
                for (Future<Double> f : futureList) {
                    double llh_i = f.get();
                    llh += llh_i;
                    if (recordLLH) {
                        System.out.println(llh_i + "," + llh);
                    }
                }
                if (recordLLH) {
                    System.exit(0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }


            value = llh;
            // System.out.print(value+" ");
            // pmUtility.prettyPrint(new Jama.Matrix(x, 1));
            // System.exit(0);
        }

        if (TeacherConstants.MODEL_16) {
            // model with two dimensions of heterogeneity, and with teacher scores and control group shifters
            // model 18 is using the window around the end of the month only
            // how to integrate these guys?
            x[6] = Math.max(0, x[6]);
            double llh = 0;

            x[9] = Math.min(1, x[9]);
            x[9] = Math.max(0, x[9]);
            // ensure that mean of type 2 is to the right of mean of type 1
            x[7] = Math.max(x[7], x[2] + 1E-3);
            x[7] = Math.max(1, x[7]); // keep to right of 1
            x[2] = Math.min(0, x[2]); // keep to left of zero
            // sigma for type 2 must be positive
            x[8] = Math.max(0, x[8]);

            long t1 = System.currentTimeMillis();

            ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>();
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double controlOpen = controlOpenList.get(ij);
                double teacherScore = testScoreList.get(ij);
                futureList.add(tpes.submit(new Model_16_FullyEncapsulatedTask(x, controlOpen, teacherScore, daysInLongestMonth, workHistories.get(ij), daysInMonth.get(ij), holidayList.get(ij))));
            }

            boolean recordLLH = false;

            try {
                for (Future<Double> f : futureList) {
                    double llh_i = f.get();
                    llh += llh_i;
                    if (recordLLH) {
                        System.out.println(llh_i + "," + llh);
                    }
                }
                if (recordLLH) {
                    System.exit(0);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }

            long t2 = System.currentTimeMillis();

            value = llh;
            // System.out.print((-value) + " ");
            // pmUtility.prettyPrint(new Jama.Matrix(x, 1));
            // System.exit(0);

            // System.out.println("time to evaluate: " + (t2 - t1) / 1000.0);
        }

        if (TeacherConstants.MODEL_XII) {
            // model with only three parameters
            // no yesterday shifter; beta; mu and mu_sigma

            x[3] = Math.max(1E-100, x[3]);
            // x[3] = 0;
            // x[4] = 0;
            boolean useQuadrature = true;
            if (useQuadrature) {
                double llh = 0;
                double numObs = 0;

                ArrayList<StateSpaceIID> stateSpaceList = new ArrayList<StateSpaceIID>();
                ArrayList<Double> weightList = new ArrayList<Double>();
                for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
                    for (double sign = -1; sign <= 1; sign += 2) {
                        double mu1 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[3]) + x[2];
                        double weight = weights[nodeIndex] * Math.pow(Math.PI, -0.5);
                        weightList.add(weight);
                        stateSpaceList.add(new StateSpaceIID(x[1], mu1, daysInLongestMonth));
                    }
                }

                for (int ij = 0; ij < workHistories.size(); ij++) {
                    double outerProb = 0;
                    for (int si = 0; si < stateSpaceList.size(); si++) {
                        StateSpaceIID s = stateSpaceList.get(si);
                        double prob = 1;
                        Jama.Matrix history = workHistories.get(ij);
                        int daysInCurrentMonth = daysInMonth.get(ij);
                        int daysWorked = 0;
                        int numHolidays = holidayList.get(ij);
                        int diff = daysInLongestMonth - daysInCurrentMonth;
                        daysWorked += history.get(0, 0);
                        // note: start at t=1 for comparison
                        for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                            double p = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays);
                            boolean validDay = true;
                            if (TeacherConstants.USE_WINDOW) {
                                if (i > TeacherConstants.DAYS_WINDOW && i < daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW) {
                                    validDay = false;
                                }
                            }
                            if (history.get(i, 0) == 1) {
                                if (validDay) {
                                    prob *= p;
                                }
                                daysWorked++;
                            } else {
                                if (validDay) {
                                    prob *= (1.0 - p);
                                }
                            }
                            numObs++;
                        }
                        outerProb += weightList.get(si) * prob;
                    }
                    // outerProb /= (0.0 + stateSpaceList.size());
                    // cluster likelihoods at the month-teacher level
                    llh += Math.log(outerProb);
                }
                value = llh;
            } else {
                Random rng = new Random(787);

                ArrayList<Future<StateSpaceIID>> futureList = new ArrayList<Future<StateSpaceIID>>();

                for (int i = 0; i < TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE; i++) {
                    futureList.add(tpes.submit(new Model_XII_Task(x, rng.nextLong(), daysInLongestMonth)));
                }
                ArrayList<StateSpaceIID> stateSpaceList = new ArrayList<StateSpaceIID>();
                try {
                    for (Future<StateSpaceIID> f : futureList) {
                        stateSpaceList.add(f.get());
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
                value = generateSimulatedLLH(stateSpaceList);
            }
        }

        return -value;
    }

    public double generateSimulatedYesterdayLLH(StateSpaceIIDYesterday s) {
        double llh = 0;
        double numObs = 0;
        for (int ij = 0; ij < workHistories.size(); ij++) {
            Jama.Matrix history = workHistories.get(ij);
            int daysInCurrentMonth = daysInMonth.get(ij);
            int daysWorked = 0;
            int numHolidays = holidayList.get(ij);
            int diff = daysInLongestMonth - daysInCurrentMonth;
            int workedYesterday = 0;
            daysWorked += history.get(0, 0);
            // starting at t=1 to compare across specifications with worked yesterday
            for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                double prob = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays, workedYesterday);
                // System.out.println(prob);
                // System.out.println(llh);
//                    if (Double.isNaN(prob)) {
//                        System.out.println("NaN probability");
//                    }
//                    if (Double.isInfinite(prob)) {
//                        System.out.println("Infinite probability");
//                    }
                boolean validDay = true;
                if (TeacherConstants.USE_WINDOW) {
                    if (i > TeacherConstants.DAYS_WINDOW && i < daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW) {
                        validDay = false;
                    }
                }
                if (history.get(i, 0) == 1) {
                    if (validDay) {
                        llh += Math.log(prob);
                    }
                    workedYesterday = 1;
                    daysWorked++;

                } else {
//                        if (prob == 1) {
//                            System.out.println("Logging zero after minus 1");
//                            System.out.println("i: " + i + " daysWorked: " + daysWorked);
//                            System.out.println(s);
//                            System.exit(0);
//                        }
                    if (validDay) {
                        llh += Math.log(1.0 - prob);
                    }
                    workedYesterday = 0;
                }
                numObs++;
            }
        }
        // System.out.println("Return llh: " + llh);
        return llh;
    }

    public double generateSimulatedLLH(ArrayList<StateSpaceIID> stateSpaceList) {
        double llh = 0;
//        try {
        // BufferedWriter out = new BufferedWriter(new FileWriter("modelV.csv"));
        // BufferedWriter out2 = new BufferedWriter(new FileWriter("modelV_firstGuy.csv"));
        for (int ij = 0; ij < workHistories.size(); ij++) {
            double outerProb = 0;
            for (StateSpaceIID s : stateSpaceList) {
                // System.out.println(s);
                // System.exit(0);

                double prob = 1;
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                int daysWorked = 0;
                int numHolidays = holidayList.get(ij);
                int diff = daysInLongestMonth - daysInCurrentMonth;
                // NOTE: start at t=1 to compare across specifications equally
                daysWorked += history.get(0, 0);
                for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                    double p = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays);
                    // System.out.println(p);
                    boolean validDay = true;
                    if (TeacherConstants.USE_WINDOW) {
                        if (i > TeacherConstants.DAYS_WINDOW && i < daysInCurrentMonth - numHolidays - TeacherConstants.DAYS_WINDOW) {
                            validDay = false;
                        }
                    }
                    if (history.get(i, 0) == 1) {
                        if (validDay) {
                            prob *= p;
                        }
                        daysWorked++;
                    } else {
                        if (validDay) {
                            prob *= (1.0 - p);
                        }
                    }
//                        if (ij == 0) {
//                            out2.write(i + "," + p + "," + daysWorked + "\n");
//                        }
                }
                outerProb += prob;
            }
            outerProb /= (0.0 + stateSpaceList.size());
            // cluster likelihoods at the month-teacher level
            llh += Math.log(outerProb);
//                out.write(Math.log(outerProb) + "," + llh + "\n");
        }
//            out.close();
//            out2.close();
//            System.exit(0);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
        return llh;
    }

    public void gradient(double[] x, double[] g) {
    }

    public void hessian(double[] x, double[][] h) {
    }

    public double objectiveFunction(double[] x) {
//        System.out.println(f_to_minimize(x));
//        System.exit(0);
        return -f_to_minimize(x);
    }

    public double pi(double[] x) {
        return 1;
    }

    private double generateSimulatedLLHYesterday(ArrayList<StateSpaceIIDYesterday> stateSpaceList) {
        double llh = 0;
        // double numObs = 0;
        for (int ij = 0; ij < workHistories.size(); ij++) {
            double outerProb = 0;
            for (StateSpaceIIDYesterday s : stateSpaceList) {
                double prob = 1;
                Jama.Matrix history = workHistories.get(ij);
                int daysInCurrentMonth = daysInMonth.get(ij);
                int daysWorked = 0;
                int numHolidays = holidayList.get(ij);
                int diff = daysInLongestMonth - daysInCurrentMonth;
                int workedYesterday = (int) history.get(0, 0);
                daysWorked += workedYesterday;
                // NOTE: starting at t=1
                for (int i = 1; i < daysInCurrentMonth - numHolidays; i++) {
                    double p = s.getProbabilityWork(i + 1 + diff + numHolidays, daysWorked + numHolidays, workedYesterday);
                    if (history.get(i, 0) == 1) {
                        prob *= p;
                        daysWorked++;
                        workedYesterday = 1;
                    } else {
                        prob *= (1.0 - p);
                        workedYesterday = 0;
                    }
                    // numObs++;
                }
                outerProb += prob;
            }
            outerProb /= (0.0 + stateSpaceList.size());
            // cluster likelihoods at the month-teacher level
            llh += Math.log(outerProb);
        }
        return llh;
    }

    /**
     * 
     * All of the code for using KNITRO as a solver has been commented out,
     * but is kept here in case anyone wants to explore using this to solve
     * for the parameters.
     * 
     */
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
//        if (solver.setCharParamByName("outlev", "all") == false) {
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
//        double[] guess = new double[daX.length + 1];
//        for (int i = 0; i < daX.length; i++) {
//            guess[i + 1] = daX[i];
//        }
//
//        // no need to fill daC since I have no constraints
//
//        return f_to_minimize(guess);
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
