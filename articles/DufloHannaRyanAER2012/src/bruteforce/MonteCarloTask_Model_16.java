/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bruteforce;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.concurrent.Callable;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
class MonteCarloTask_Model_16 implements Callable<MCData>, Serializable {

    double[] x;
    private ArrayList<Double> controlOpenList;
    private ArrayList<Integer> daysInMonth;
    private ArrayList<Integer> holidayList;
    private ArrayList<Double> testScoreList;
    private ArrayList<Jama.Matrix> workHistories;
    private int daysInLongestMonth;

    public MonteCarloTask_Model_16(double[] guess, ArrayList<Double> controlOpenList, ArrayList<Double> testScoreList, ArrayList<Jama.Matrix> workHistories, ArrayList<Integer> daysInMonth, ArrayList<Integer> holidayList, int daysInLongestMonth) {
        this.controlOpenList = controlOpenList;
        this.daysInLongestMonth = daysInLongestMonth;
        this.daysInMonth = daysInMonth;
        this.holidayList = holidayList;
        this.testScoreList = testScoreList;
        this.workHistories = workHistories;
        x = new double[guess.length];
        for (int i = 0; i < guess.length; i++) {
            x[i] = guess[i];
        }
    }

    public MCData call() throws Exception {
        double llh = 0;
        ExecutorService tpes = Executors.newFixedThreadPool(1);
        ArrayList<Future<Double>> futureList = new ArrayList<Future<Double>>();
        for (int ij = 0; ij < workHistories.size(); ij++) {
            double controlOpen = controlOpenList.get(ij);
            double teacherScore = testScoreList.get(ij);
            futureList.add(tpes.submit(new Model_16_FullyEncapsulatedTask(x, controlOpen, teacherScore, daysInLongestMonth, workHistories.get(ij), daysInMonth.get(ij), holidayList.get(ij))));
        }

        try {
            for (Future<Double> f : futureList) {
                double llh_i = f.get();
                llh += llh_i;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        tpes.shutdown();
        return new MCData(x, llh);
    }
}
