#include <fstream>
#include <cmath>
#include "utilities.h"
using namespace std;

// Creating a rotate function
void rotate(double coord[], int arraySize, double omega) 
{
    //variable declaration
    const double PI = 3.141592653589793;
    double t;
    
//rotate function using a for loop
    for(int i = 0; i < arraySize; i+=3)
    {
        coord[0] = -2314.87;
        coord[1] = 4663.275;
        coord[2] = 3673.747;
        
        double thetarad = omega * t; // calculating theta in radians
        
        double tempx = coord[0]; // making a temp variable for x
        
        double tempy = coord[1]; // making a temp variable for y
        
        double tempz = coord[2]; // making a temp variable for z
        
        coord[i] = cos(thetarad) * tempx - sin(thetarad) * tempy;
        
        coord[i+1] = sin(thetarad) * tempx + cos(thetarad) * tempy;
        
        coord[i+2] = tempz;
        
        t = t + 60.0; 
    }
}

// creating a function to write the data to a csv file
void write_csv(double gs[], int arraySize, string file)
{
    //opening the file
    ofstream outputFile;
    outputFile.open(file);
    
    //for loop for writing the csv file
    for(int i = 0; i < arraySize; i+=3)
    {
       outputFile << gs[i] << ", " << gs[i + 1] << "," << gs[i + 2] << endl;
    }
    //closing the file
    outputFile.close();
}