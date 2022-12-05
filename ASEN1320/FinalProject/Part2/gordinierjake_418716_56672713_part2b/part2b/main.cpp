#include <iostream>
#include <fstream>
#include <string>
#include <cmath>
#include "coord.h"
using namespace std;

double pi = 3.141592653589793 // declaring pi

// creating the setPoint function
void coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg) 
{
    xs = xspoint;
    ys = yspoint;
    zs = zspoint;
    xg = xgpoint;
    yg = ygpoint;
    zg = zgpoint;
}

// creating the setFlag function
bool coord::setFlag()
{
// variable declaration
 double xd;
 double yd;
 double zd;
 
 // solving equations for xd,yd, and zd
 xd = xspoint - xgpoint;
 yd = yspoint - ygpoint;
 zd = zspoint - zgpoint;
 
 // setting up the equations giving in the problem description
 double Rd_Rgs = (xd * xgpoint) + (yd * ygpoint) + (zd * zgpoint);
 double Rd_Abs = sqrt((pow(xd,2)) + (pow(yd,2)) + (pow(zd,2)));
 double Rgs_Abs = sqrt((pow(xgpoint,2)) + (pow(ygpoint,2)) + (pow(zgpoint,2)));
 
 phipoint = (pi/2.0) - acos(Rd_Rgs/(Rgs * Rd_Abs));
 
 // using if statements to create the boolean
 if (10.0*(pi/180.0) < phipoint)
 {
   flagpoint = 1;
 }
 else
 {
   flagpoint = 0;
 }
 
 cout << flagpoint << ", " << phipoint << endl;
 return flagpoint;
  
};

void Coord::displayInfo() // creating the function to display the data points
{
    cout << xspoint << ", " << yspoint << ", " << zspoint << ", " << xgpoint << ", " << ygpoint << ", " << zgpoint << ", " << phipoint ", " << flagpoint;
}


int main()
{
    
  Coord coord1[1441], coord2[1441];
    
  // Opening the csv file from part 2.1
  ifstream myInputFile;
  string fileName = "GSPosition.csv";
  myInputFile.open(fileName);
  
  // opening the sat position 1 csv file created in matlab
  ifstream myInputFile1;
  string fileName1 = "Sat1Position.csv";
  myInputFile.open(fileName1);
  
  // opening the sat position 2 csv file created in matlab
  ifstream myInputFile2;
  string fileName2 = "Sat2Position.csv";
  myInputFile.open(fileName2);
  
  // reading the data to a csv file
  ofstream sat1vis, sat2vis;
  sat1vis.open("Sat1Visibility.csv");
  sat2vis.open("Sat2Visibility.csv");
  
  // variable declaration 
  double xs1, ys1, zs1, xg1, yg1, zg1, xs2, ys2, zs2;
  string x,y,z;
  
  // using a for loop to assign the values to the various objects
  for (int i = 0; i < 1441; i++)
  {
    getline(Sat1, x, ',');
    getline(Sat1, y, ',');
    getline(Sat1, z);
    xs1 = stod(x);
    ys1 = stod(y);
    zs1 = stod(z);
    
    getline(Sat2, x, ',');
    getline(Sat2, y, ',');
    getline(Sat2, z);
    xs2 = stod(x);
    ys2 = stod(y);
    zs2 = stod(z);
    
    getline(GS, x, ',');
    getline(GS, y, ',');
    getline(GS, z);
    xg1 = stod(x);
    yg2 = stod(y);
    zg1 = stod(z);
    
    
    coord1[i].setPoint(xs1, ys1, zs1, xg1, yg1, zg1);
    sat1vis << coord1[i].setFlag() << endl;
    
    coord2[i].setPoint(xs2, ys2, zs2, xg1, yg1, zg1);
    sat2vis << coord2[i].setFlag() << endl;
    
  }
  
  
  // closing all of the input and output files
    outputFile.close();
    myInputFile.close();
    myInputFile1.close();
    myInputFile2.close();
    return 0;
}





