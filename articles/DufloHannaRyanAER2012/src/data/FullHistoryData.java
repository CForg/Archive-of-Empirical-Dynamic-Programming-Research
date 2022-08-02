/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package data;

import java.io.Serializable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class FullHistoryData implements Serializable {
    
    private Jama.Matrix fullHistory;
    private double cost;
    private int numberDaysWorked;

    public Jama.Matrix getFullHistory() {
        return fullHistory;
    }

    public int getNumberDaysWorked() {
        return numberDaysWorked;
    }

    public void setFullHistory(Jama.Matrix fullHistory) {
        this.fullHistory = fullHistory;
    }

    public double getCost() {
        return cost;
    }

    public void setCost(double cost) {
        this.cost = cost;
    }

    public void setNumberDaysWorked(int numberDaysWorked) {
        this.numberDaysWorked = numberDaysWorked;
    }

}
