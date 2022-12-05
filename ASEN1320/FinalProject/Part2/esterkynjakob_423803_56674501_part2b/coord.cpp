// -- Defining the methods of class Coord

#include <iostream>
#include <cmath>
#include "coord.h"
using namespace std;

//Defining setPoint function mutator method
void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    xspoint = xs;
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;
}

//Defining setFlag function to determine when the satellite is visible
bool Coord::setFlag()
{
    const double pi = 3.141592653589793;

    double rdx = xspoint - xgpoint;
    double rdy = yspoint - ygpoint;
    double rdz = zspoint - zgpoint;
   
    double rdrg = (rdx*xgpoint) + (rdy*ygpoint) + (rdz*zgpoint);
    double normrd = (sqrt(pow(rdx,2) + pow(rdy,2) + pow(rdz,2)));
    double normrg = (sqrt(pow(xgpoint,2) + pow(ygpoint,2) + pow(zgpoint,2)));
    double phi = (pi/2.0) - acos(rdrg/(normrd*normrg));
    phipoint = phi*180.0/pi;
    
    if (phipoint >= 10.0)
    {
        flagpoint = 1;
    }
    
    else
    {
        flagpoint = 0;
    }
    return flagpoint;
}

//Defining displayInfo function
void Coord::displayInfo()
{
    cout << xspoint << endl;
    cout << yspoint << endl;
    cout << zspoint << endl;
    cout << xgpoint << endl;
    cout << ygpoint << endl;
    cout << zgpoint << endl;
    cout << flagpoint << endl;
    cout << phipoint << endl;
}