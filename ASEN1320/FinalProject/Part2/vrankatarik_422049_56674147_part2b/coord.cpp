#include <fstream>
#include <iostream>
#include <cmath>
#include "coord.h"  

using namespace std;  

const double pi = 3.141592653589793;


bool Coord::setFlag()   //setflag function- uses given equation to calculate phi, then returns 1 if the value is greater than 10 degrees and 0 otherwise
{
    double xd = xspoint-xgpoint;
    double yd = yspoint-ygpoint;
    double zd = zspoint-zgpoint;
    double dot = (xd*xgpoint)+(yd*ygpoint)+(zd*zgpoint);
    double absrgs = sqrt((xgpoint * xgpoint) + (ygpoint * ygpoint) + (zgpoint * zgpoint));
    double absrd = sqrt((xd * xd) + (yd * yd) + (zd * zd));
    double phi = (pi/2.0) - (acos(dot/(absrgs * absrd)));
    double phideg = phi * (180.0/pi);
    phipoint = phideg;
    if (phideg > 10) {
        flagpoint = 1;
        return 1;
    }
    else {
        flagpoint = 0;
        return 0;
    }
}




void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)   //simple function to set points to be used in the setflag function
{
    
    xspoint = xs;
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;
    
}


void Coord::displayInfo()  //function that prints all private class attributes
{
    
   cout << xspoint << ", " << yspoint << ", " << zspoint << ", " << xgpoint << ", " << ygpoint << ", " << zgpoint << ", " << phipoint << ", " << flagpoint << endl;
    
}
