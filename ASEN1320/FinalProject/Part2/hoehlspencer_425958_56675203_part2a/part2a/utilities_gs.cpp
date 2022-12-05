#include <iostream>
#include <cmath>
#include <fstream>
#include "utilities.h"

using namespace std; 


void rotate(double init[], int size, double theta)          //declaring and defining prototype function   
{ 
    
    // Declaring variables 
    const double PI = 3.141592653589793; 
    double thet = theta * (PI/180);    
    double x0 = -2314.87; 
    double y0 = 4663.275 ; 
    double z0 = 3673.747; 
    int n = 3;              
    
    
 //equation updating init array for each new theta after rotation of earth
          init[0] = (x0*cos(thet)) - (y0*sin(thet)); 
          init[1] = (x0*sin(thet)) + (y0*cos(thet));
          init[2] = z0; 
          
          
      



}


void write_csv(double a[], int girth, string outputFile)   //UDF
{
    ofstream output;                //opens an output file stream named output 
    output.open(outputFile);       //opens the file with the name that the string outputFile dictates   
    
    for (int i = 0; i < girth; i+=3)        //for loop iterating for one whole set of coordinates for a single ground station location, incrementing by 3 so it prints out next position of the ground station
    {
        output << a[i] <<  " ," << a[i+1] << " ," << a[i+2] << "\n";               //outputs values of x coordinates, y coordinates, and z coordinates to output.csv file by referencing their positions in the array which was updated using the rotate function 
    }
    
}