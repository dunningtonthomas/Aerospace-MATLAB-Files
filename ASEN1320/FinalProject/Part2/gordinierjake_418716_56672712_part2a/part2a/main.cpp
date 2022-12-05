#include <iostream>
#include "utilities.h"
using namespace std;

int main()
{
  
  // variabe declaration
  int totaltime = 86400;
  double pi = 3.141592653589793;
  
  double omega = (360*(pi/180))/totaltime; // calculating omega in radians
  
  int arraySize = 4323;
  double Groundstation[arraySize];
  
  Groundstation[0] = -2314.87;
  Groundstation[1] = 4663.275;
  Groundstation[2] = 3673.747;
  
  string file = "GSPosition.csv"; // setting the filename
  
  // calling the functions into main
 rotate(Groundstation, arraySize, omega);
 write_csv(Groundstation, arraySize, file);

    return 0;
}
