//libraries
#include <iostream>
#include "coord.h"
#include <string>
#include <fstream>
#include <cmath>

using namespace std;


//creating a mutator method through void with inputs xs, ys, zs, xg,yg, zg to set the point
void coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
//setting the points to names
    xspoint = xs; 
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;
    
}

//creating a mutator method through bool to set the flag/visibility
bool coord::setFlag()
{

//declaring our pi, xd, yd, and zd    
    const double pi = 3.141592653589793238;
    double xd = (xspoint - xgpoint);
    double yd = (yspoint - ygpoint);
    double zd = (zspoint - zgpoint);
    

//creating formulas for the Rd*Rs, absolute value of Rd and Rgs to find the phi/ elevation angle
    double Rd_times_Rgs = (xgpoint * xd) + (yd * ygpoint) + (zd * zgpoint);
    
    double Rd_A = sqrt((pow(yd,2)) + (pow(xd,2)) + (pow(zd,2)));
    double Rgs_A = sqrt( (pow(xgpoint,2) ) + (pow(ygpoint,2)) + (pow(zgpoint,2)));
    
    double elevationAngle = (pi/2) - acos((Rd_times_Rgs) / (Rd_A * Rgs_A));
  
  //creating an if statement to say that when the phi angle is greater than 10, then flagpoint is visible or 1. if it's less than or equal to 10, it's not visible or 0
      
    if (elevationAngle > 10.0 * (pi/180.0))
    {
        flagpoint = 1;
        
     
    }
    
    if (elevationAngle<= 10.0 * (pi/ 180.0))
    {
        flagpoint = 0;
        
        
    }
    
    return flagpoint;
    
}

//outputting the points
void coord::displayInfo()
{
    cout << xspoint << ", " << yspoint << ", " << zspoint << ", " << xgpoint << ", " << ygpoint << ", " << zgpoint << endl;
};

