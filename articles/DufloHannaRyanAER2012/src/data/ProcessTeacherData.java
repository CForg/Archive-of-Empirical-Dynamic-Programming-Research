/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import JSci.maths.statistics.NormalDistribution;
import Jama.Matrix;
import bruteforce.MonthHolidayType;
import bruteforce.StateSpaceFast;
import bruteforce.StateSpaceIID;
import bruteforce.StateSpaceIIDYesterday;
import constants.TeacherConstants;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.text.NumberFormat; 
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.Random;
import java.util.TreeSet;
import javax.swing.JProgressBar;
import utility.pmUtility;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class ProcessTeacherData {

    private Matrix outcomes;
    private ArrayList<Jama.Matrix> actionList;
    private int numObs = 0;
    private ArrayList<Jama.Matrix> workHistories = new ArrayList<Jama.Matrix>();
    private ArrayList<Integer> daysInMonth = new ArrayList<Integer>();
    private ArrayList<Integer> holidayList = new ArrayList<Integer>();
    private TreeSet<Integer> distributionDays = new TreeSet<Integer>();
    private ArrayList<Integer> teacherIDList = new ArrayList<Integer>();
    private ArrayList<Double> testScoreList = new ArrayList<Double>();
    private ArrayList<Double> controlOpenList = new ArrayList<Double>();
    private ArrayList<Double> workedLastMonthList = new ArrayList<Double>();
    private ArrayList<MonthHolidayType> monthHolidayPermutations = new ArrayList<MonthHolidayType>();
    private ArrayList<Jama.Matrix> completeHistories = new ArrayList<Jama.Matrix>();
    private int maxDaysInMonth = 0;
    private int maxDaysWorked = 0;
    Jama.Matrix edf = new Jama.Matrix(28, 1);
    private JProgressBar bar;
    boolean usePhotoAug2009 = false;

    public ProcessTeacherData(ArrayList<Matrix> actionList, JProgressBar bar) {
        this.actionList = actionList;
        this.bar = bar;
        if(TeacherConstants.MODEL_20) {
            usePhotoAug2009 = true;
        }
        preprocessData();
        processData();
    }

    public Matrix getEmpiricalDistribution() {
        return edf;
    }

    public void processData() {
        outcomes = new Jama.Matrix(actionList.size() - 1, 1);
        Jama.Matrix outcomesMonthly = new Jama.Matrix(actionList.size() - 1, 1);
        Jama.Matrix outcomesIndividual = new Jama.Matrix(actionList.size() - 1, 1);

        preprocessData(); // this is to get the number of days in each month right and to count holidays
        // TreeSet<Integer> teacherTree = new TreeSet<Integer>();

        // load in data here, store empirical probabilities in outcomes Jama.Matrix
        // now have to sort out by month as well
        try {
            BufferedReader in = new BufferedReader(new FileReader("data/camerasMay2009Drop.csv"));
            if (usePhotoAug2009) {
                in = new BufferedReader(new FileReader("data/photos_AUG_31_09.csv"));
            }
            BufferedWriter out = new BufferedWriter(new FileWriter("data/empirical.csv"));
            // String line = "";
            String line = in.readLine(); // get rid of the headers

            // all the info needed to read one record and track if we have a new person-month
            Integer ID = null;
            Integer year = null;
            Integer month = null;
            Double controlOpen = null;
            Double testScore = null;
            Double workedLastMonth = null;

            Jama.Matrix history = new Jama.Matrix(TeacherConstants.NUM_PERIODS_MATCH, 1);
            Jama.Matrix completeHistory = new Jama.Matrix(27, 1);

            int dayCounter = 0;
            int censorHolidays = 0;
            int daysWorked = censorHolidays * holidayList.get(numObs);

            while (line != null) {
                line = in.readLine();
                // System.out.println(line);
                if (line != null) {
                    int a = 0;
                    int b = line.indexOf(",", a);
                    Integer currentID = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentYear = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentMonth = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentDay = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // Integer currentWeekday = new Integer(line.substring(a, b));
                    // a = b + 1;
                    // b = line.indexOf(",", a);
                    Integer currentHoliday = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentWorked = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    String currentDate = line.substring(a, b);
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // day of week would be here
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // weekday_fix would be here
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // block string would be here
                    a = b + 1;
                    b = line.indexOf(",", a);
                    controlOpen = new Double(line.substring(a, b));
                    a = b + 1;

                    if (!usePhotoAug2009) {
                        testScore = new Double(line.substring(a));
                    } else {
                        b = line.indexOf(",", a);
                        testScore = new Double(line.substring(a, b));
                        a = b + 1;
                        b = line.indexOf(",", a);
                        // String lagYear = line.substring(a,b);
                        // lag year
                        a = b + 1;
                        b = line.indexOf(",", a);
                        // String lagMonth = line.substring(a,b);
                        a = b + 1;
                        workedLastMonth = new Double(line.substring(a));
                    }

                    if (ID != null) {
                        if (currentID.intValue() != ID.intValue() || currentYear.intValue() != year.intValue() || currentMonth.intValue() != month.intValue()) {
                            // this means we have a new one, and should process the old
                            // pmUtility.prettyPrintVector(history);
                            // System.out.println(daysWorked);
                            for (int j = 0; j < actionList.size() - 1; j++) {
                                Jama.Matrix action = actionList.get(j);
                                if ((history.minus(action)).normF() == 0) {
                                    outcomes.set(j, 0, outcomes.get(j, 0) + 1);
                                    outcomesMonthly.set(j, 0, outcomesMonthly.get(j, 0) + 1);
                                    outcomesIndividual.set(j, 0, outcomesIndividual.get(j, 0) + 1);
                                }
                            }
                            workHistories.add(history.copy());
                            completeHistories.add(completeHistory.copy());

                            // pmUtility.prettyPrintVector(history);
                            teacherIDList.add(currentID.intValue());
                            controlOpenList.add(controlOpen);
                            testScoreList.add(testScore);
                            workedLastMonthList.add(workedLastMonth);

                            numObs++;
                            if (daysInMonth.get(numObs) >= TeacherConstants.MIN_DAYS_REQUIRED) {
                                edf.set(daysWorked, 0, edf.get(daysWorked, 0) + 1);
                                out.write(daysWorked + "\n");
                            }
                            if (daysWorked > maxDaysWorked) {
                                maxDaysWorked = daysWorked;
                            }
                            dayCounter = 0;
                            daysWorked = censorHolidays * holidayList.get(numObs);
                            history = new Jama.Matrix(TeacherConstants.NUM_PERIODS_MATCH, 1);
                            completeHistory = new Jama.Matrix(27, 1);
                        }
                    }

                    // pmUtility.prettyPrintVector(history);
                    // System.out.println(line);
                    GregorianCalendar greg = new GregorianCalendar(currentYear.intValue(), currentMonth.intValue() - 1, currentDay.intValue());
                    if (greg.get(Calendar.DAY_OF_WEEK) != 1) {
                        // day 4 is Sunday
                        if (currentHoliday.intValue() == 0) {
                            if (currentWorked.intValue() == 1) {
                                if (dayCounter < TeacherConstants.NUM_PERIODS_MATCH) {
                                    history.set(dayCounter, 0, 1);
                                }
                                if (dayCounter < 27) {
                                    completeHistory.set(dayCounter, 0, 1);
                                }
                                daysWorked++;
                            }
                            dayCounter++;
                        }
                    }

                    ID = new Integer(currentID.intValue());
                    year = new Integer(currentYear.intValue());
                    month = new Integer(currentMonth.intValue());
                } else {
                    // take care of last observation
                    // pmUtility.prettyPrintVector(history);
                    // System.out.println(daysWorked);
                    for (int j = 0; j < actionList.size() - 1; j++) {
                        Jama.Matrix action = actionList.get(j);
                        if ((history.minus(action)).normF() == 0) {
                            outcomes.set(j, 0, outcomes.get(j, 0) + 1);
                            outcomesMonthly.set(j, 0, outcomesMonthly.get(j, 0) + 1);
                            outcomesIndividual.set(j, 0, outcomesIndividual.get(j, 0) + 1);
                        }
                    }
                    workHistories.add(history.copy());
                    completeHistories.add(completeHistory.copy());
                    teacherIDList.add(ID.intValue());
                    controlOpenList.add(controlOpen);
                    testScoreList.add(testScore);
                    workedLastMonthList.add(workedLastMonth);

                    if (daysInMonth.get(numObs) >= TeacherConstants.MIN_DAYS_REQUIRED) {
                        edf.set(daysWorked, 0, edf.get(daysWorked, 0) + 1);
                        out.write(daysWorked + "\n");
                    }
                    if (daysWorked > maxDaysWorked) {
                        maxDaysWorked = daysWorked;
                    }
                    numObs++;
                }
            }
            in.close();
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
            System.exit(0);
        }
        TeacherConstants.NUM_OBS = numObs;
        // System.out.println("Number of observations: " + numObs);
        outcomes.timesEquals(1.0 / numObs);

        // okay, let's clean out the data of all the months with less than 24 days worked
        ArrayList<Jama.Matrix> workHistoriesTemp = new ArrayList<Jama.Matrix>();
        ArrayList<Integer> daysInMonthTemp = new ArrayList<Integer>();
        ArrayList<Integer> holidayListTemp = new ArrayList<Integer>();
        ArrayList<Jama.Matrix> completeHistoriesTemp = new ArrayList<Jama.Matrix>();

        ArrayList<Integer> teacherIDListTemp = new ArrayList<Integer>();
        ArrayList<Double> testScoreListTemp = new ArrayList<Double>();
        ArrayList<Double> controlOpenListTemp = new ArrayList<Double>();
        ArrayList<Double> workedLastMonthListTemp = new ArrayList<Double>();

        for (int i = 0; i < workHistories.size(); i++) {
            if (daysInMonth.get(i).intValue() >= TeacherConstants.MIN_DAYS_REQUIRED) {
                workHistoriesTemp.add(workHistories.get(i));
                daysInMonthTemp.add(daysInMonth.get(i));
                holidayListTemp.add(holidayList.get(i));
                completeHistoriesTemp.add(completeHistories.get(i));
                teacherIDListTemp.add(teacherIDList.get(i));
                testScoreListTemp.add(testScoreList.get(i));
                controlOpenListTemp.add(controlOpenList.get(i));
                workedLastMonthListTemp.add(workedLastMonthList.get(i));
            }
        }
        workHistories = workHistoriesTemp;
        daysInMonth = daysInMonthTemp;
        holidayList = holidayListTemp;
        completeHistories = completeHistoriesTemp;
        teacherIDList = teacherIDListTemp;
        testScoreList = testScoreListTemp;
        controlOpenList = controlOpenListTemp;
        workedLastMonthList = workedLastMonthListTemp;

        numObs = workHistories.size();

        // i want to go through and enumerate all the combinations of days in the month and holidays, and figure out how many of each type there are
        for (int i = 0; i < workHistories.size(); i++) {
            int monthLength = daysInMonth.get(i);
            int holidays = holidayList.get(i);
            int index = monthHolidayPermutations.indexOf(new MonthHolidayType(monthLength, holidays));
            // System.out.println(index);
            if (index > -1) {
                MonthHolidayType type = monthHolidayPermutations.get(index);
                type.incrementFrequencyInPopulation();
            } else {
                monthHolidayPermutations.add(new MonthHolidayType(monthLength, holidays));
            }
        }

        // System.out.println("Number of month-holiday combinations: " + monthHolidayPermutations.size());
        for (MonthHolidayType t : monthHolidayPermutations) {
            t.normalize(workHistories.size());
        }

        System.out.println("Edf: ");
        edf.timesEquals(1.0 / numObs);
        pmUtility.prettyPrintVector(edf);
        double avgWorked = 0;
        for (int i = 0; i < edf.getRowDimension(); i++) {
            avgWorked += i * edf.get(i, 0);
        }
        System.out.println("Sample average number of days worked (verify whether holidays are counted): " + avgWorked);
        // System.exit(0);
        if (TeacherConstants.SIMULATE_DATA) {
            Random rng = new Random();
            // replace the true simulated histories with simulated counterparts
            NormalDistribution normal = new NormalDistribution();
            outcomes = new Jama.Matrix(actionList.size() - 1, 1);

            Jama.Matrix edf2 = new Jama.Matrix(maxDaysInMonth + 1, 1);
            ArrayList<Jama.Matrix> simulatedData = new ArrayList<Jama.Matrix>();
            bar.setMaximum(workHistories.size());
            for (int ij = 0; ij < workHistories.size(); ij++) {
                double beta = TeacherConstants.SIMULATED_BETA;
                double mu = TeacherConstants.SIMULATED_MU1;
                double yesterdayShifter = TeacherConstants.SIMULATED_YESTERDAY;

                int daysInCurrentMonth = daysInMonth.get(ij);
                int numHolidays = holidayList.get(ij);
                if (TeacherConstants.MODEL_XI || TeacherConstants.MODEL_XII || TeacherConstants.MODEL_15) {
                    // one type of heterogeneity on mu
                    mu = TeacherConstants.SIMULATED_MU1_SINGLE + TeacherConstants.SIMULATED_SIGMA1 * normal.inverse(rng.nextDouble());
                }
                if (TeacherConstants.MODEL_VIII || TeacherConstants.MODEL_16 || TeacherConstants.MODEL_X) {
                    if (Math.random() > TeacherConstants.PROB_MU2) {
                        mu = TeacherConstants.SIMULATED_MU1 + TeacherConstants.SIMULATED_SIGMA1 * normal.inverse(rng.nextDouble());
                    } else {
                        mu = TeacherConstants.SIMULATED_MU2 + TeacherConstants.SIMULATED_SIGMA2 * normal.inverse(rng.nextDouble());
                    }
                }
                if (TeacherConstants.MODEL_16 || TeacherConstants.MODEL_15 || TeacherConstants.MODEL_14) {
                    // System.out.println("test score: "+testScoreList.get(ij)+" control: "+controlOpenList.get(ij));
                    // System.out.print("Old mu: "+mu);
                    mu += (-0.3) * controlOpenList.get(ij);
                    mu += (-0.002) * testScoreList.get(ij);
                    // System.out.println(" New mu: "+mu);
                }
                // non-yesterday models: V, XII, VIII
                if (TeacherConstants.MODEL_VIII || TeacherConstants.MODEL_V || TeacherConstants.MODEL_XII) {
                    StateSpaceIID s = new StateSpaceIID(beta, mu, daysInCurrentMonth);
                    FullHistoryData fhd = s.generateFullHistory(numHolidays, daysInCurrentMonth);
                    edf2.set(fhd.getNumberDaysWorked(), 0, edf2.get(fhd.getNumberDaysWorked(), 0) + 1);
                    simulatedData.add(fhd.getFullHistory());
                }
                if (TeacherConstants.MODEL_17) {
                    double rho = 0.1;
                    StateSpaceFast s = new StateSpaceFast(beta, mu, rho, rng.nextLong(), daysInCurrentMonth);
                    FullHistoryData fhd = s.generateFullHistory(numHolidays, daysInCurrentMonth);
                    edf2.set(fhd.getNumberDaysWorked(), 0, edf2.get(fhd.getNumberDaysWorked(), 0) + 1);
                    simulatedData.add(fhd.getFullHistory());
                }
                if (TeacherConstants.MODEL_VII) {
                    double rho = 0.1;
                    StateSpaceFast s = new StateSpaceFast(beta, mu, rho, rng.nextLong(), daysInCurrentMonth);
                    Jama.Matrix history = s.generateHistory(numHolidays, daysInCurrentMonth);
                    for (int j = 0; j < actionList.size() - 1; j++) {
                        Jama.Matrix action = actionList.get(j);
                        if ((history.minus(action)).normF() == 0) {
                            outcomes.set(j, 0, outcomes.get(j, 0) + 1);
                        }
                    }
                }
                if (TeacherConstants.MODEL_16 || TeacherConstants.MODEL_15 || TeacherConstants.MODEL_14 || TeacherConstants.MODEL_X || TeacherConstants.MODEL_XI) {
                    StateSpaceIIDYesterday s = new StateSpaceIIDYesterday(beta, mu, daysInCurrentMonth, yesterdayShifter);
                    FullHistoryData fhd = s.generateFullHistory(numHolidays, daysInCurrentMonth, rng.nextLong());
                    edf2.set(fhd.getNumberDaysWorked(), 0, edf2.get(fhd.getNumberDaysWorked(), 0) + 1);
                    simulatedData.add(fhd.getFullHistory());
                    // problem with length of days/histories is not generated here; this all checks out fine
                }

                bar.setValue(ij + 1);
            }
            System.out.println("Simulated distribution of days worked:");
            edf2.timesEquals(1.0 / workHistories.size());
            outcomes.timesEquals(1.0 / workHistories.size());
            pmUtility.prettyPrintVector(edf2);
            // System.exit(0);
            completeHistories = simulatedData;
            System.out.println("Using simulated data instead of true data");
            edf = edf2;
        }

        // if we want to censor the complete data, this would be the place to do it
        // this information is stored in completeHistories
        if (TeacherConstants.MODEL_17) {
            try {
                System.out.println("Model 17: Turning Complete Histories Into Censored Blocks");
                System.out.println("Block length: " + TeacherConstants.LENGTH_WORK_BLOCK);
                System.out.println("Number of blocks: " + TeacherConstants.NUM_BLOCKS);
                System.out.println("NumObs: " + numObs + " CompleteHistories: " + completeHistories.size());
                outcomes = new Jama.Matrix(actionList.size() - 1, 1);
                bar.setMaximum(completeHistories.size());
                int progress = 0;
                // for (Jama.Matrix underlyingHistory : completeHistories) {
                for (int ij = 0; ij < completeHistories.size(); ij++) {
                    Jama.Matrix underlyingHistory = completeHistories.get(ij);
//                    pmUtility.prettyPrintVector(underlyingHistory);

//                    Jama.Matrix block = new Jama.Matrix(TeacherConstants.NUM_BLOCKS, 1);
//                    int counter = 0;
//                    for (int b = 0; b < TeacherConstants.NUM_BLOCKS; b++) {
//                        int numWorkedInBlock = 0;
//                        for (int d = 0; d < TeacherConstants.LENGTH_WORK_BLOCK; d++) {
//                            numWorkedInBlock += underlyingHistory.get(counter, 0);
//                            counter++;
//                        }
//                        if (numWorkedInBlock >= TeacherConstants.WORK_BLOCK_THRESHOLD) {
//                            block.set(b, 0, 1);
//                        }
//                    }

                    progress++;
                    Jama.Matrix block = new Jama.Matrix(TeacherConstants.NUM_BLOCKS, 1);
                    int numWorkDays = Math.min(TeacherConstants.NUM_BLOCKS * TeacherConstants.LENGTH_WORK_BLOCK, daysInMonth.get(ij) - holidayList.get(ij));
                    int numWorkedInBlock = 0;
                    int counter = 0;
                    int blockCounter = 0;
                    for (int t = 0; t < numWorkDays; t++) {
                        numWorkedInBlock += underlyingHistory.get(t, 0);
                        counter++;
                        if (counter == TeacherConstants.LENGTH_WORK_BLOCK) {
                            counter = 0;
                            if (numWorkedInBlock >= TeacherConstants.WORK_BLOCK_THRESHOLD) {
                                block.set(blockCounter, 0, 1);
                            }
                            blockCounter++;
                            numWorkedInBlock = 0;
                        }
                    }

                    // need to figure out where this one goes
                    for (int j = 0; j < actionList.size() - 1; j++) {
                        Jama.Matrix action = actionList.get(j);
                        if ((block.minus(action)).normF() == 0) {
                            outcomes.set(j, 0, outcomes.get(j, 0) + 1);
                        }
                    }
                    bar.setValue(progress);
                }
                NumberFormat nf = NumberFormat.getInstance();
                nf.setMinimumIntegerDigits(3);
                for (int i = 0; i < actionList.size() - 1; i++) {
                    System.out.print(nf.format(outcomes.get(i, 0)) + "\t");
                    pmUtility.prettyPrintVector(actionList.get(i));
                }
                // System.exit(0);
                outcomes.timesEquals(1.0 / numObs);
                System.out.print("Outcomes under block: ");
                pmUtility.prettyPrintVector(outcomes);
                // System.exit(0);
            } catch (Exception e) {
                e.printStackTrace();
                System.exit(0);
            }
        }

//        for (int ij = 0; ij < completeHistories.size(); ij++) {
//            Jama.Matrix history = completeHistories.get(ij);
//            int numHolidays = holidayList.get(ij);
//            int daysInCurrentMonth = daysInMonth.get(ij);
//            System.out.println("WorkDays: " + (daysInCurrentMonth - numHolidays) + " History.rows: " + history.getRowDimension());
//            if (daysInCurrentMonth - numHolidays != history.getRowDimension()) {
//                System.out.println("Difference!");
//                System.exit(0);
//            }
//        }
    }

    public void preprocessData() {
        // how to work out how many days there are in each working month?
        // actually, in this data we have exhaustive ones and zeros (including holidays)
        // so just make a list of the days in each month for each guy, keep it synced, no problem
        try {
            BufferedReader in = new BufferedReader(new FileReader("data/camerasMay2009Drop.csv"));
            if (usePhotoAug2009) {
                in = new BufferedReader(new FileReader("data/photos_AUG_31_09.csv"));
            }
            // String line = ""; // no header file for cameras.txt!
            String line = in.readLine(); // but there is one for data with control group and teacher score data

            // all the info needed to read one record and track if we have a new person-month
            Integer ID = null;
            Integer year = null;
            Integer month = null;
            int numHolidays = 0;
            int dayCounter = 0;
            int lineOfFile = 0;
            int weekendCounter = 2;
            Double controlOpen = null;
            Double testScore = null;
            Double workedLastMonth = null;

            while (line != null) {
                line = in.readLine();
                lineOfFile++;
                // System.out.println(line);
                if (line != null) {
//                    int a = 0;
//                    int b = line.indexOf(",", a);
//                    // turns out that ID is the first 4 out of 5 in this string, not all 5!  it is 10*schoolID + teacherID!  crap!
//                    Integer currentID = new Integer(line.substring(a, b));
//                    a = b + 1;
//                    b = line.indexOf(",", a);
//                    Integer currentYear = new Integer(line.substring(a, b));
//                    a = b + 1;
//                    b = line.indexOf(",", a);
//                    Integer currentMonth = new Integer(line.substring(a, b));
//                    a = b + 1;
//                    b = line.indexOf(",", a);
//                    Integer currentDay = new Integer(line.substring(a, b));
//                    a = b + 1;
//                    b = line.indexOf(",", a);
//                    Integer currentWeekday = new Integer(line.substring(a, b));
//                    a = b + 1;
//                    b = line.indexOf(",", a);
//                    Integer currentHoliday = new Integer(line.substring(a, b));
//                    a = b + 1;
//                    Integer currentWorked = new Integer(line.substring(a));
                    int a = 0;
                    int b = line.indexOf(",", a);
                    Integer currentID = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentYear = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentMonth = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentDay = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // Integer currentWeekday = new Integer(line.substring(a, b));
                    // a = b + 1;
                    // b = line.indexOf(",", a);
                    Integer currentHoliday = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    Integer currentWorked = new Integer(line.substring(a, b));
                    a = b + 1;
                    b = line.indexOf(",", a);
                    String currentDate = line.substring(a, b);
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // day of week would be here
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // weekday_fix would be here
                    a = b + 1;
                    b = line.indexOf(",", a);
                    // block string would be here
                    a = b + 1;
                    b = line.indexOf(",", a);
                    controlOpen = new Double(line.substring(a, b));
                    a = b + 1;
                    // testScore = new Double(line.substring(a));
                    if (!usePhotoAug2009) {
                        testScore = new Double(line.substring(a));
                    } else {
                        b = line.indexOf(",", a);
                        testScore = new Double(line.substring(a, b));
                        a = b + 1;
                        b = line.indexOf(",", a);
                        // String lagYear = line.substring(a,b);
                        // lag year
                        a = b + 1;
                        b = line.indexOf(",", a);
                        // String lagMonth = line.substring(a,b);
                        a = b + 1;
                        workedLastMonth = new Double(line.substring(a));
                    }

                    if (ID != null) {
                        if (currentID.intValue() != ID.intValue() || currentYear.intValue() != year.intValue() || currentMonth.intValue() != month.intValue()) {
                            // this means we have a new one, and should process the old
                            // pmUtility.prettyPrintVector(history);
                            // System.out.println(daysWorked);
                            // want to throw out a few problematic observations: 1211, 2111, 5611, 5711
                            // also want to throw out 1321, 1421, 2454, 5411, and 5521
                            // cut out all less than 24 (strange list if you print it out--teacher changes, etc.)
                            holidayList.add(numHolidays);
                            daysInMonth.add(dayCounter);
                            distributionDays.add(dayCounter);
                            if (dayCounter > maxDaysInMonth) {
                                maxDaysInMonth = dayCounter;
                            }
                            // System.out.println("ID: "+ID+" Year: "+year+" Month: "+month+" Holiday: "+numHolidays+" Max Days in Month: "+dayCounter);
                            numHolidays = 0;
                            dayCounter = 0;
                            // System.exit(0);
                        }
                    }

                    // count up holidays for each guy in order (so order will be same in second go-around)
                    if (currentHoliday.intValue() == 1) {
                        numHolidays++;
                    }
                    // replacing this next line with weekendCounter<7 should do exactly the same thing as what i replaced, plus get the mis-coded days in there correctly
                    // if(currentWeekday.intValue()==1) {
                    GregorianCalendar greg = new GregorianCalendar(currentYear.intValue(), currentMonth.intValue() - 1, currentDay.intValue());
                    weekendCounter = greg.get(Calendar.DAY_OF_WEEK);
                    if (weekendCounter != 1) {
                        // day 1 is Sunday
                        dayCounter++;
                    }

                    /*
                     * No Sundays coded as holidays, fortunately
                    if(currentHoliday.intValue()==1 && currentWeekday.intValue()==0) {
                    System.out.println("Coded as Sunday holiday");
                    }
                     */

                    // System.out.println("dayCounter: "+dayCounter+" numHolidays: "+numHolidays+" lineOfFile: "+lineOfFile);
                    ID = new Integer(currentID.intValue());
                    year = new Integer(currentYear.intValue());
                    month = new Integer(currentMonth.intValue());
                } else {
                    // take care of last observation
                    holidayList.add(numHolidays);
                    daysInMonth.add(dayCounter);
                    distributionDays.add(dayCounter);
                    if (dayCounter > maxDaysInMonth) {
                        maxDaysInMonth = dayCounter;
                    }
                }
            }
            in.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Matrix getOutcomes() {
        return outcomes;
    }

    public ArrayList<Jama.Matrix> getActionList() {
        return actionList;
    }

    public int getNumObs() {
        return numObs;
    }

    public ArrayList<Jama.Matrix> getWorkHistories() {
        return workHistories;
    }

    public void setWorkHistories(ArrayList<Jama.Matrix> workHistories) {
        this.workHistories = workHistories;
    }

    public ArrayList<Integer> getDaysInMonth() {
        return daysInMonth;
    }

    public ArrayList<Integer> getHolidayList() {
        return holidayList;
    }

    public TreeSet<Integer> getDistributionDays() {
        return distributionDays;
    }

    public ArrayList<Integer> getTeacherIDList() {
        return teacherIDList;
    }

    public ArrayList<MonthHolidayType> getMonthHolidayPermutations() {
        return monthHolidayPermutations;
    }

    public ArrayList<Jama.Matrix> getCompleteHistories() {
        return completeHistories;
    }

    public int getMaxDaysWorked() {
        return maxDaysWorked;
    }

    public void setMaxDaysWorked(int maxDaysWorked) {
        this.maxDaysWorked = maxDaysWorked;
    }

    /**
     * @return the testScoreList
     */
    public ArrayList<Double> getTestScoreList() {
        return testScoreList;
    }

    /**
     * @return the controlOpenList
     */
    public ArrayList<Double> getControlOpenList() {
        return controlOpenList;
    }

    /**
     * @return the workedLastMonthList
     */
    public ArrayList<Double> getWorkedLastMonthList() {
        return workedLastMonthList;
    }

    /**
     * @param workedLastMonthList the workedLastMonthList to set
     */
    public void setWorkedLastMonthList(ArrayList<Double> workedLastMonthList) {
        this.workedLastMonthList = workedLastMonthList;
    }
}
