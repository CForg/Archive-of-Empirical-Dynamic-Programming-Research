/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package bruteforce;

import java.io.Serializable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
class MCData implements Serializable {

    private double[] guess;
    private double value;

    public MCData(double[] guess, double value) {
        this.guess = guess;
        this.value = value;
    }

    public double[] getGuess() {
        return guess;
    }

    public double getValue() {
        return value;
    }

}
