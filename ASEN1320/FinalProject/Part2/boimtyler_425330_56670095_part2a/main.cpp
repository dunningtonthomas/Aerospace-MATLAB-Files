#include <iostream>
#include <fstream>
#include <cmath>
#include "utilities.h"

// Write a main function that
// (1) initilizes the size of 1D array, array elements, and angle (you can pick values for these)
// (2) calls "rotate" and "write_csv" functions
// To compile by doing g++ -o MAIN_PROGRAM main1.cpp utilities_gs.cpp -lstdc++, then ls will have a main program
// To run, type "./MAIN_PROGRAM" in the commandline 

using namespace std;

int main(){
    const double PI = 3.141592653589793;
    int arraySize = 2*1441;
    double arrayN[arraySize];
    double angle;
    
    rotate(arrayN, arraySize, angle);
    
    write_csv(arrayN, arraySize, "GSPosition.csv");
    
    
    return 0;
}
