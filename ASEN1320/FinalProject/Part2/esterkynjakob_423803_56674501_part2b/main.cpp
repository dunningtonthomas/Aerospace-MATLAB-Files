#include <iostream>
#include <fstream>
#include <string>
#include "coord.h"

using namespace std;

int main()
{
    //Declaring inputs
    ifstream Sat1Position;
    ifstream Sat2Position;
    ifstream GSPosition;
    
    //Declaring outputs
    ofstream Sat1Visibility;
    ofstream Sat2Visibility;
    
    //Open input files
    Sat1Position.open("Sat1Position.csv");
    Sat2Position.open("Sat2Position.csv");
    GSPosition.open("GSPosition.csv");
    
    //Open output files
    Sat1Visibility.open("Sat1Visibility.csv");
    Sat2Visibility.open("Sat2Visibility.csv");
    
    //Array Size (Number of time points)
    int arrSize = 1441;
    
    //Creating Sat1 and Sat2 arrays of objects
    Coord Sat1[arrSize];
    Coord Sat2[arrSize];
    
    //Declaring arrays of coordinate values to use in for loop
    double xs1Arr[arrSize];
    double ys1Arr[arrSize];
    double zs1Arr[arrSize];
    double xs2Arr[arrSize];
    double ys2Arr[arrSize];
    double zs2Arr[arrSize];
    double xgArr[arrSize];
    double ygArr[arrSize];
    double zgArr[arrSize];
    
    for (int i=0; i<arrSize; i++)
    {
        //Reading in coords as individual 1D arrays
        Sat1Position >> xs1Arr[i] >> ys1Arr[i] >> zs1Arr[i];
        Sat2Position >> xs2Arr[i] >> ys2Arr[i] >> zs2Arr[i];
        GSPosition >> xgArr[i] >> ygArr[i] >> zgArr[i];
        
        //Setting coords as values of Sat objects using setPoint function
        Sat1[i].setPoint(xs1Arr[i], ys1Arr[i], zs1Arr[i], xgArr[i], ygArr[i], zgArr[i]);
        Sat2[i].setPoint(xs2Arr[i], ys2Arr[i], zs2Arr[i], xgArr[i], ygArr[i], zgArr[i]);
        
        //Assessing visibility with setFlag function and writing to csv file
        Sat1Visibility << Sat1[i].setFlag() << endl;
        Sat2Visibility << Sat2[i].setFlag() << endl;
    }
    
    //Closing input files
    Sat1Position.close();
    Sat2Position.close();
    GSPosition.close();
    
    //Closing output files
    Sat1Visibility.close();
    Sat2Visibility.close();
    
    return 0;
}
    
