#include <string>
#include <iostream>
#include <cmath>
#include <fstream>
#include "utilities_gs.cpp"
#include "utilities.h"

using namespace std;


int main ()
{
    
int arrSize = 4320;
double array[arrSize] = {-2314.87, 4663.275, 3673.747};
double w = 360.0/86400.0;
double t = 60.0;

double array2[arrSize] = {-2314.87, 4663.275, 3673.747};

//double degree = w*t;

double NewL[4320];

for ( int i = 0; i < 1441; i++)//for loop in order to get the corresponding values of x and y
{
double degree = w*(t*i);

array[0]= array2[0];
array[1] = array2[1];
array[2] = array2[2];

rotate(array, 3 , degree);

NewL[3*i] = array[0];
NewL[(3*i)+1] = array[1];
NewL[(3*i)+2] = array[2];



}
write_csv(array, arrSize, "GSPosition.csv");
return 0;
}