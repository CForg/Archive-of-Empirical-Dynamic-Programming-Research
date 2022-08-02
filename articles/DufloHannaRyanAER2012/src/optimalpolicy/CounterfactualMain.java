/*
 * 
 * This is the main program for executing optimizations and running the
 * counterfactuals.  You can change which models are run through commenting
 * below.  See TeacherConstants.java for an explanation of what each model
 * estimates.
 * 
 */
package optimalpolicy;

import bruteforce.BruteForceEstimation;
import bruteforce.Explorer;
import bruteforce.ProbitEstimation;
import constants.TeacherConstants;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import javax.swing.JLabel;
import javax.swing.JProgressBar;
import javax.swing.UIManager;
import org.gridgain.grid.Grid;
import org.gridgain.grid.GridException;
import org.gridgain.grid.GridFactory;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class CounterfactualMain {

    JProgressBar ProgressBar = new JProgressBar();
    JLabel LabelTime = new JLabel();
    ExecutorService tpes = null;

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        try {
            UIManager.setLookAndFeel(UIManager.getSystemLookAndFeelClassName());
        } catch (Exception e) {
            e.printStackTrace();
        }
        new CounterfactualMain().execute();
    }

    private void execute() {

        if (TeacherConstants.USE_GRID) {
            try {
                GridFactory.start();
                Grid grid = GridFactory.getGrid();
                tpes = grid.newGridExecutorService();
            } catch (GridException ex) {
                // Logger.getLogger(this.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            tpes = Executors.newFixedThreadPool(TeacherConstants.NUM_THREADS);
        }

        TeacherConstants.MODEL_I = false;
        TeacherConstants.MODEL_IV = false;
        TeacherConstants.MODEL_V = false;
        TeacherConstants.MODEL_VI = false;
        TeacherConstants.MODEL_VII = false;
        TeacherConstants.MODEL_VIII = false;

        MainOptimalPolicy mop = new MainOptimalPolicy(tpes);
        mop.initializeGUI();

        TeacherConstants.USE_WINDOW = false;
        TeacherConstants.DAYS_WINDOW = 3;
        if (TeacherConstants.USE_WINDOW) {
            System.out.println("Using a window model with " + TeacherConstants.DAYS_WINDOW + " on either side of the month change.");
        }

        System.out.println("Evaluating Model V (common beta and mu; iid errors): ");
        TeacherConstants.MODEL_V = true;
        runMinimization();
        mop.execute();
        TeacherConstants.MODEL_V = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("*   Evaluating Model 18 (iid beta, mu, last month shifter):                                          *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_18 = true;
//        runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_18 = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("*   Evaluating Model 21 (iid beta, mu, yesterday, last month shifter):                               *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_21 = true;
//        runMinimization();
//        // // mop.execute();
//        TeacherConstants.MODEL_21 = false;
//
//        System.out.println("******************************************************************************************************");
//        System.out.println("*   Evaluating Model 19 (iid beta, mu/sigma, yesterday, last month shifter):                         *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_19 = true;
//        runMinimization();
//        // // mop.execute();
//        TeacherConstants.MODEL_19 = false;
//
//        System.out.println("******************************************************************************************************");
//        System.out.println("*   Evaluating Model 20 (iid beta, mu/sigma, yesterday, last month, score, attendance                *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_20 = true;
//        // runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_20 = false;

//
//        System.out.println("Evaluating Model VI (common beta; fixed effect mu; iid errors): ");
//        TeacherConstants.MODEL_VI = true;
//        runMinimization();
//        // mop.execute();
//        TeacherConstants.MODEL_VI = false;
//
//        System.out.println("Evaluating Model VII (common beta, mu, and rho): ");
//        TeacherConstants.MODEL_VII = true;
//        runMinimization();
//        // mop.execute();
//        TeacherConstants.MODEL_VII = false;
//
//        System.out.println("Evaluating Model IV (common beta and rho; one mixture on mu): ");
//        TeacherConstants.MODEL_IV = true;
//        runMinimization();
//        // mop.execute();
//        TeacherConstants.MODEL_IV = false;
//
//        System.out.println("Evaluating Model I (common beta and rho; two mixtures on mu): ");
//        TeacherConstants.MODEL_I = true;
//        // runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_I = false;
//
//        System.out.println("Evaluating Model VIII (common beta; two mixtures on mu; iid errors): ");
//        TeacherConstants.MODEL_VIII = true;
//        runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_VIII = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("*   Evaluating Model V (iid beta, mu):                                                               *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_V = true;
//        runMinimization();
//        // // mop.execute();
//        TeacherConstants.MODEL_V = false;
////
//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model IX (common beta, mu; yesterday):                                                  *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_IX = true;
//        runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_IX = false;

//
//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model XII (common beta; one dimension of heterogeneity):                                *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_XII = true;
//        runMinimization();
//        // // mop.execute();
//        TeacherConstants.MODEL_XII = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model XI (common beta; one dimension of heterogeneity and yesterday shifter):           *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_XI = true;
//        runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_XI = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model X (common beta; two dimensions of heterogeneity yesterday):                       *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_X = true;
//        runMinimization();
//        // mop.execute();
//        TeacherConstants.MODEL_X = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model 13 (common beta; scores, attendance):                                             *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_13 = true;
//        runMinimization();
//        // // mop.execute();
//        TeacherConstants.MODEL_13 = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model 14 (common beta; yesterday, scores, attendance):                                  *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_14 = true;
//        runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_14 = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model 15 (common beta; one mixture on mu; iid errors; yesterday, scores, attendance):   *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_15 = true;
//        runMinimization();
//        // mop.execute();
//        TeacherConstants.MODEL_15 = false;

//        System.out.println("******************************************************************************************************");
//        System.out.println("* Evaluating Model 16 (common beta; two mixtures on mu; iid errors; yesterday, scores, attendance):  *");
//        System.out.println("******************************************************************************************************");
//        TeacherConstants.MODEL_16 = true;
//        runMinimization();
//        mop.execute();
//        TeacherConstants.MODEL_16 = false;

        tpes.shutdown();
        // System.exit(0);
    }

    private void runMinimization() {
        if (TeacherConstants.MODEL_VII || TeacherConstants.MODEL_V || TeacherConstants.MODEL_VI) {
            TeacherConstants.NUM_POINTS_HETEROGENEITY_SAMPLE = 1;
        }

        double[] guess = Explorer.getGuess();

        if (TeacherConstants.MODEL_19 || TeacherConstants.MODEL_20 || TeacherConstants.MODEL_21 || TeacherConstants.MODEL_18 || TeacherConstants.MODEL_V || TeacherConstants.MODEL_IX || TeacherConstants.MODEL_X || TeacherConstants.MODEL_XI || TeacherConstants.MODEL_XII || TeacherConstants.MODEL_VI || TeacherConstants.MODEL_VIII || TeacherConstants.MODEL_16 || TeacherConstants.MODEL_13 || TeacherConstants.MODEL_14 || TeacherConstants.MODEL_15) {
            try {
                ProbitEstimation probit = new ProbitEstimation(guess, ProgressBar, tpes);
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
            boolean useOptimalWeights = false;
            BruteForceEstimation brutus = new BruteForceEstimation(ProgressBar, LabelTime, useOptimalWeights, tpes);

            brutus.setGuess(guess);
            try {
                guess = brutus.call();
            } catch (Exception e) {
                e.printStackTrace();
                System.exit(0);
            }
        }
    }
}
