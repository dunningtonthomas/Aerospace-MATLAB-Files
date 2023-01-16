#include "utilities.h"

// Write a main function that
// (1) initilizes the size of 1D array, array elements, and angle (you can pick values for these)
// (2) calls "rotate" and "write_csv" functions
// To compile, type "g++ -o Run main.cpp hw6.cpp -lstdc++" in the commandline
// To run, type "./Run" in the commandline 

int main () 
{
    int arraySize = 1442*3;
    double GSinit[arraySize] = {-2314.87,4663.275,3673.747};
    double angle = 0; 
    
    rotate(GSinit,arraySize,angle);
    write_csv(GSinit,arraySize,"GSPosition.csv");

    return 0;
}