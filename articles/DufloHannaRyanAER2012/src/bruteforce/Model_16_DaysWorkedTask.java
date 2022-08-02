/*
 * GenerateHistoryTask.java
 *
 * Created on August 18, 2006, 4:59 PM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */
package bruteforce;

import data.FullHistoryData;
import data.SimulatedHistoryData;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Random;
import java.util.concurrent.Callable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class Model_16_DaysWorkedTask implements Serializable, Callable<SimulatedHistoryData> {

    private double controlOpen;
    private double teacherScore;
    private double[] x;
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
    private int numHolidays;
    private int daysInMonth;
    private Random rng;

    /** Creates a new instance of GenerateHistoryTask */
    public Model_16_DaysWorkedTask(double[] x, double controlOpen, double teacherScore, int daysInMonth, int numHolidays, long rngSeed) {
        this.x = x;
        this.controlOpen = controlOpen;
        this.teacherScore = teacherScore;
        this.daysInMonth = daysInMonth;
        this.numHolidays = numHolidays;
        rng = new Random(rngSeed);
    }

    public SimulatedHistoryData call() throws Exception {
        SimulatedHistoryData data = new SimulatedHistoryData();

        ArrayList<Double> weightList = new ArrayList<Double>();
        for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
            for (double sign = -1; sign <= 1; sign += 2) {
                double weight = weights[nodeIndex] * Math.pow(Math.PI, -0.5);
                weightList.add(weight);
            }
        }

        ArrayList<StateSpaceIIDYesterday> stateSpaceList = new ArrayList<StateSpaceIIDYesterday>();
        for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
            for (double sign = -1; sign <= 1; sign += 2) {
                double mu1 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[6]) + x[2] + x[3] * controlOpen + x[4] * teacherScore;
                stateSpaceList.add(new StateSpaceIIDYesterday(x[1], mu1, daysInMonth, x[5]));
            }
        }

        // prob of type 2 is x[9]
        double probType2 = Math.max(0, x[9]);
        probType2 = Math.min(1, x[9]);

        ArrayList<StateSpaceIIDYesterday> stateSpaceList2 = new ArrayList<StateSpaceIIDYesterday>();
        for (int nodeIndex = 0; nodeIndex < nodes.length; nodeIndex++) {
            for (double sign = -1; sign <= 1; sign += 2) {
                double mu2 = sign * (nodes[nodeIndex] * Math.sqrt(2) * x[8]) + x[7] + x[3] * controlOpen + x[4] * teacherScore;
                stateSpaceList2.add(new StateSpaceIIDYesterday(x[1], mu2, daysInMonth, x[5]));
            }
        }

//        double sumWeights = 0;
        double daysWorkedResult = 0;
        double costResult = 0;
        
        for (int si = 0; si < stateSpaceList.size(); si++) {
            StateSpaceIIDYesterday s = stateSpaceList.get(si);
            StateSpaceIIDYesterday s2 = stateSpaceList2.get(si);

            FullHistoryData fh = s.generateFullHistory(numHolidays, daysInMonth, rng.nextLong());
            FullHistoryData fh2 = s2.generateFullHistory(numHolidays, daysInMonth, rng.nextLong());

            daysWorkedResult += fh.getNumberDaysWorked() * (1.0 - probType2) * weightList.get(si);
            costResult += fh.getCost() * (1.0 - probType2) * weightList.get(si);
            daysWorkedResult += fh2.getNumberDaysWorked() * probType2 * weightList.get(si);
            costResult += fh2.getCost() * (probType2) * weightList.get(si);
        }

        // System.out.println(daysWorkedResult+" "+costResult);

        data.setExpectedNumberDaysWorked(daysWorkedResult);
        data.setExpectedCost(costResult);

        return data;
    }
}
