#include "coord.h"
#include <cmath>
#include <iostream>

using namespace std;

bool Coord::setFlag() 
{
    double xd = xspoint - xgpoint, yd = yspoint - ygpoint, zd = zspoint - zgpoint;                  //initializing d variables
    double top = xd*xgpoint + yd*ygpoint + zd*zgpoint;                                              //initializing numerator of formula
    double AbRgs = sqrt(pow(xgpoint,2) + pow(ygpoint, 2) + pow(zgpoint,2));                         //calculating the absolute value of Rgs
    double AbRd = sqrt(pow(xd,2) + pow(yd,2) + pow(zd,2));                                          //calculating the absolute value of Rd
    double PI = 3.141592653589793;                                                                  //initializing PI
    
    phipoint = (PI/2.0) - acos(top/(AbRgs*AbRd));                                                   //calculating phipoint
    
    double phideg = phipoint*(180.0/PI);                                                            //converting phipoint to degrees
    
    if(phideg > 10)                             //if statement to determine boolean value
    {
        return true;
    }
    else 
    {
        return false;
    }
}

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    xspoint = xs;               //assigning variables from inputs
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;
}

void Coord::displayInfo()
{
    cout << "xspoint = " << xspoint << endl;            //displaying values
    cout << "yspoint = " << yspoint << endl;
    cout << "zspoint = " << zspoint << endl;
    cout << "xgpoint = " << xgpoint << endl;
    cout << "ygpoint = " << ygpoint << endl;
    cout << "zgpoint = " << zgpoint << endl;
    cout << "phipoint = " << phipoint << endl;
    cout << "flagpoint = " << flagpoint << endl;
}