#include <iostream>
#include <cmath>
#include <string>
#include <fstream>
#include "utilities.h"

using namespace std;
/*
void rotate(double GS[], int arraySize, double Theta);
void write_csv(double GS[], int M, string csvoutput);
*/
int main()
{
    double w = 360/86400;
    int t = 60;
    double Theta = w * t;
    double x0 = -2314.87;
    double y0 = 4663.275;
    double z0 = 3673.747;
 
 //vector<double> linspace(double 0, double 86400, int 60)
 
 double initposition[3] = {x0, y0, z0};
 double gspos[4323];
 
 //gspos[0]=initposition[0];
 //gspos[1]=initposition[1];
 //gspos[2]=initposition[2];
 
 rotate(gspos, 4323, Theta);
 write_csv(gspos, 4324, "GSPosition.csv");
 
 
 
 
 
    return 0;
}