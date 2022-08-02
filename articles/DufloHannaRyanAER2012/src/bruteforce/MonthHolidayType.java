package bruteforce;

import java.io.Serializable;

/*
 * MonthHolidayType.java
 *
 * Created on Sep 10, 2007, 3:45:18 PM
 *
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author Stephen P. Ryan (sryan@mit.edu)
 */
public class MonthHolidayType implements Serializable {

    private int numDaysInMonth;
    private int numHolidays;
    private double frequencyInPopulation;
    private int totalCount;

    public MonthHolidayType(int numDaysInMonth, int numHolidays) {
        this.numDaysInMonth = numDaysInMonth;
        this.numHolidays = numHolidays;
        this.frequencyInPopulation = 1;
        this.totalCount = 1;
    }

    public void incrementFrequencyInPopulation() {
        frequencyInPopulation++;
        totalCount++;
    }

    @Override
    public String toString() {
        return "days: " + numDaysInMonth + " holidays: " + numHolidays + " frequency: " + frequencyInPopulation + " count: " + totalCount;
    }

    @Override
    public boolean equals(Object o) {
        MonthHolidayType c = (MonthHolidayType) o;
        if (c.numDaysInMonth == numDaysInMonth && c.numHolidays == numHolidays) {
            return true;
        }
        return false;
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 61 * hash + this.numDaysInMonth;
        hash = 61 * hash + this.numHolidays;
        return hash;
    }

    public void normalize(int size) {
        frequencyInPopulation /= (0.0 + size);
    }

    public int getNumDaysInMonth() {
        return numDaysInMonth;
    }

    public int getNumHolidays() {
        return numHolidays;
    }

    public double getFrequencyInPopulation() {
        return frequencyInPopulation;
    }

    public int getTotalCount() {
        return totalCount;
    }
}
