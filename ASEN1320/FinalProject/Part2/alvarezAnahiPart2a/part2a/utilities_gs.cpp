#include <iostream>
#include <cmath>
#include "utilities.h"
#include <string>
using namespace std;


void rotate(double GroundS[], int arrSize , double degree) //first function before the rotation
{

 const double PI = 3.141592653589793;
 
 double Xg; //variable of equation 1
 double Yg; //variable of equation 2
 
 double w = 360/86400;
 int i = 0;
 
 double theta = degree*(PI/180); ///conversion of degrees to radians
 

 Xg = cos(theta)*GroundS[i] - sin(theta)*GroundS[i+1]; //x new equation
 Yg = sin(theta)*GroundS[i] + cos(theta)*GroundS[i+1]; //y new equation
 double Zg = GroundS[2];

 GroundS[i] = Xg; 
 GroundS[i+1]= Yg;
 GroundS[i+2]= Zg;
 
}


void write_csv(double GroundS[], int arrSize, std::string inputFile) //2nd function
{
 ofstream MyInputFile; //writing in the file
 MyInputFile.open(inputFile); //opening the file
 
 for (int i = 0; i < arrSize; i+=3) //for loop in order to output correspoding values after the rotation
{
 MyInputFile << GroundS[i] << ", " << GroundS[i+1] << ", " << GroundS[i+2] << endl;
}
MyInputFile.close();
}