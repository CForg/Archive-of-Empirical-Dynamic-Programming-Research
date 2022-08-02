/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package data;

import Jama.Matrix;
import java.io.Serializable;

/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class SimulatedHistoryData implements Serializable {

    private double expectedNumberDaysWorked;
    private double expectedCost;
    private Jama.Matrix distributionDaysWorked;

    public double getExpectedNumberDaysWorked() {
        return expectedNumberDaysWorked;
    }

    public void setExpectedNumberDaysWorked(double expectedNumberDaysWorked) {
        this.expectedNumberDaysWorked = expectedNumberDaysWorked;
    }

    public double getExpectedCost() {
        return expectedCost;
    }

    public void setExpectedCost(double expectedCost) {
        this.expectedCost = expectedCost;
    }

    /**
     * @return the distributionDaysWorked
     */
    public Jama.Matrix getDistributionDaysWorked() {
        return distributionDaysWorked;
    }

    /**
     * @param distributionDaysWorked the distributionDaysWorked to set
     */
    public void setDistributionDaysWorked(Jama.Matrix distributionDaysWorked) {
        this.distributionDaysWorked = distributionDaysWorked;
    }
    
}
