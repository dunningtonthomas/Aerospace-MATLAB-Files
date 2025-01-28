#include <fstream>
#include <cmath>
#include "utilities.h"

using namespace std;

double const PI = 3.141592653589793;

//"rotate" function that takes 1D array of current relative ground station corrdinates and modifies them to the new coordinates depending on the angle which describes how the stations have moved compated to the satellites
void rotate(double a[], int length, double angle)
{
    //variable to hold current x value to be used after current x has been reassigned to new x 
    double tempX;
    double tempY;
    double tempZ;
    
    //declare omega
    double omega=(360.0/86400.0)*(PI/180);
    int t=0;
    
    
    //iterate through all values of the array
    for (int i = 0;i<length;i+=3)
    {
        angle=t*omega; 
        

       tempX=(a[i]*cos(angle))-(a[i+1]*sin(angle));
       tempY= (a[i]*sin(angle))+(a[i+1]*cos(angle));
       tempZ= a[i+2];
       
       a[i+3]=tempX;
       a[i+4]=tempY;
       a[i+5]=tempZ;
       
       t=+60.0;
       
       
       
       
    }
    
}

//"write_csv" function that writes out values stored in 1D array to an output file
void write_csv(double a[], int length, string fileName)
{
    ofstream myOutputFile; 
    myOutputFile.open(fileName);
    
    //iterate through array and execute statement block for every 2 values of i
    for(int i = 0;i<length;i+=3)
    {
        //print values stored at locations i and location i+1, which corresponds to each pair of coordinates
        myOutputFile << a[i] << ", " << a[i+1] << ", " << a[i+2] << endl;
    }
}