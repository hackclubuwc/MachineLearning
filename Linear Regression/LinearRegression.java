package com.company;

import java.util.Arrays;

public class Main {

    static double trainingCaseDiscrepancy(double X, double y, double[] theta) {
        return (hTheta(X, theta) - y);
    }

    static double hTheta(/* Single training case of length n */double x, double[] theta) {
        return theta[0] + theta[1]*x; // h(theta, x) = theta0 + theta1 * x;
    }

    // Non-vectorized
    static public double computeCost(double[] X, double[] y, double[] theta) {
        int m = X.length; // Number of training cases
        double cost = 0.0;
        for (int i = 0; i < X.length; i++)
            cost += Math.pow(trainingCaseDiscrepancy(X[i], y[i], theta), 2);
        cost /= (2.0*m);
        return cost;
    }

    static public double[] train(double[] X, double[] y, double[] theta) {
        double alpha = 0.000001;
        double iters = 1000000;
        int m = X.length; // Number of training cases
        double[] tempTheta = new double[2]; // Used to simultaneously update weights
        for (int k = 0; k < iters; k++) {
            double summation = 0.0;
            double updateOne = 0.0;
            for (int i = 0; i < m; i++) {
                summation += trainingCaseDiscrepancy(X[i], y[i], theta);
                updateOne += (summation * X[i]);
            }
            updateOne *= alpha * (1.0/m);
            double updateZero = summation * alpha * (1.0/m);
            tempTheta[0] = theta[0] - updateZero;
            tempTheta[1] = theta[1] - updateOne; // Based on differentiation
            theta = tempTheta;
        }
        return theta;
    }

    public static double predict(double x, double[] theta) {
        return hTheta(x, theta);
    }

    public static void main(String[] args) {
        double X[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 2.5, 3.5, 4.5, 0.1367, 890.1};
        double y[] = {10, 20, 30, 40, 50, 60, 70, 80, 90, 25, 35, 45, 1.367, 8901};
        double theta[] = {0, 0};
        theta = train(X, y, theta);
        System.out.print("Cost after training at theta = " + "[" + theta[0] + ", " + theta[1] + "]" + " is " + computeCost(X, y, theta) + "\n");
        System.out.print("Actual   |   Predictions" + "\n" + "==========================" + "\n");
        for (int i = 0; i < y.length; i++) {
            System.out.print(y[i] + "      " + predict(X[i], theta) + "\n");
        }
    }
}
