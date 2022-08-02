/*
 * TeacherConstants.java
 *
 * Created on June 19, 2006, 11:27 AM
 *
 * To change this template, choose Tools | Template Manager
 * and open the template in the editor.
 */

package constants;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class TeacherConstants {

    // Game primitives
    public static int BONUS_CUTOFF = 10;
    public static double BONUS = 50;
    public static double MINIMUM_PAYMENT = 500;
    public static int NUM_OBS = 100;

    // GMM Parameters
    public static int NUM_PERIODS_MATCH = 5;

    // Starting values for parameters
    public static double BETA = 0.014;
    public static double MU = -0.107; 
    public static double RHO = 0.461; 
    public static double MU_VARIANCE = 0.153; 
    public static double MU2 = 3.616; 
    public static double MU2_VARIANCE = 0.26; 
    public static double PROB_MU2 = 0.047; 
    
    public static int NUM_THREADS = 8;
    
    public static int NUM_ERRORS = 200;  // want 200
    public static int NUM_SIMS = 25000;  // want 25000
    public static int NUM_POINTS_HETEROGENEITY_SAMPLE = 128;  // want 128

    public static boolean USE_GUI = false;

    // model specification booleans
    public static boolean MODEL_I = false; // IV + second normal for mu
    public static boolean MODEL_IV = false; // four basic parameters: one normal distribution of heterogeneity on \mu
    public static boolean MODEL_V = false; // Model V is: everyone has the same beta and mu, rho = 0
    public static boolean MODEL_VI = false; // Model VI is: everyone has same beta, individual mu (fixed effects model), iid (rho = 0)
    public static boolean MODEL_VII = false; // Model VII: simplest possible model with beta,mu,rho shared the same by everyone
    public static boolean MODEL_VIII = false; // Model VIII: this is model_I with iid errors

    // models with yesterday shifter
    public static boolean MODEL_IX = false;  // model IX: model V (iid, no heterogeneity) with a shifter for whether we worked the last day or not
    public static boolean MODEL_X = false;  // this is iid model with two types of heterogeneity and yesterday shifter (model VIII plus yesterday shifter)
    public static boolean MODEL_XI = false;  // model XI: iid model with yesterday shifter and one dimension of heterogeneity
    public static boolean MODEL_XII = false; // model XII: iid model with one dimension of heterogeneity

    // models using information from the control group to shift the outside option
    public static boolean MODEL_13 = false;  // model 13: this is the iid model without any types, using control group and scores to shift outside option
    public static boolean MODEL_14 = false;  // model 14: this is the iid model without any types, using control group and scores to shift outside option, plus yesterday shifter
    public static boolean MODEL_15 = false;  // model 15: this is the iid model with one dimension of heterogeneity, control group and test scores, plus yesterday shifter
    public static boolean MODEL_16 = false;  // model 16: this is the iid model with two dimensions of heterogeneity, control group and test scores, plus yesterday shifter

    // models using information from last month
    public static boolean MODEL_18 = false; // model 18: beta, mu, last month
    public static boolean MODEL_19 = false; // model 18: beta, mu/sigma, yesterday, last month
    public static boolean MODEL_20 = false; // model 18: beta, mu/sigma, attendance and test score, yesterday, last month
    public static boolean MODEL_21 = false; // model 18: beta, mu, yesterday, last month

    // use only window of days around the change
    public static boolean USE_WINDOW = false;
    public static int DAYS_WINDOW = 3;  // number of days on either side of end of month to use in construction LLH

    // models using the chunks of days worked indicators
    public static int LENGTH_WORK_BLOCK = 1;
    public static int WORK_BLOCK_THRESHOLD = 1;
    public static int NUM_BLOCKS = 2;  // we have to define a convention of what to return if the month is not long enough
    // for now, just return zeros if that's the case (this is a normalization that shouldn't be informative)
    public static boolean MODEL_17 = false;  // AR(1) model with no heterogeneity; discrete blocks of days worked (test mule)

    public static Integer MIN_DAYS_REQUIRED = 24;

    public static boolean SIMULATE_DATA = false;
    public static boolean USE_GRID = false;

    public static double SIMULATED_BETA = 0.0163;
    public static double SIMULATED_MU1 = -0.323;
    public static double SIMULATED_SIGMA1 = 0.552;
    public static double SIMULATED_MU2 = 1.50;
    public static double SIMULATED_SIGMA2 = 1.884;
    public static double SIMULATED_PROB2 = 0.23;
    public static double SIMULATED_YESTERDAY = 0.0737;
    public static double SIMULATED_MU1_SINGLE = -0.323;

}
