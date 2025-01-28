#include "coord.h"
#include <cmath>
#include <iostream>

// writing the definition of the setPoint function
void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    // setting the variables equal to different points
    xs = xspoint;
    ys = yspoint;
    zs = zspoint;
    xg = xgpoint;
    yg = ygpoint;
    zg = zgpoint;
}

// writing the definition of the setFlag function
bool Coord::setFlag()
{
   const double pi = 3.141592653589793 // defining pi
   
   double Rs[3] = {xspoint, yspoint, zspoint};
   double Rgs[3] = {xgpoint, ygpoint, zgpoint};
   
   double xd = (Rs[0] - Rgs[0]);
   double yd = (Rs[1] - Rgs[1]);
   double zd = (Rs[2] - Rgs[2]);
   
   double Rd[3] = {xd,yd,zd};
   
    double Rd_Rgs = (xd * xgpoint) + (yd * ygpoint) + (zd * zgpoint);
   double Rd_Abs = sqrt((pow(xd,2)) + (pow(yd,2)) + (pow(zd,2)));
   double Rgs_Abs = sqrt((pow(xgpoint,2)) + (pow(ygpoint,2)) + (pow(zgpoint,2)));
   double angle = (180.0/pi) * (acos((Rd_Rgs) / (Rd_Abs * Rgs_Abs)));
   double elevation = 90.0 - angle;
   
   // using if statements for the boolean based on the angle
    if(elevation > 10.0)
    {
        flagpoint = 1;
        
        return 1;
    }
    else if(elevation <= 10.0)
    {
        flagpoint = 0;
        
        return 0;
    }
}

// writing the definition of the displayInfo function
double Coord::displayInfo()
{
    cout << xspoint << ", " << yspoint << ", " << zspoint << ", " << xgpoint << ", " << ygpoint << ", " << zgpoint << ", " << phipoint ", " << flagpoint << endl;
}
