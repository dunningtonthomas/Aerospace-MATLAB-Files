#include "coord.h"
#include <string>
#include <cmath>
#include <iostream>

void Coord::setPoint(double xs,double ys,double zs,double xg,double yg,double zg)
{
    xspoint = xs;
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;
}

bool Coord::setFlag()
{
    
    double Rs[3] = { xspoint, yspoint, zspoint };
    const double pi = 3.141592653589793;
              
    double Rgs[3] = {xgpoint, ygpoint, zgpoint};
    double xd = xspoint-xgpoint;
    double yd = yspoint-ygpoint;
    double zd = zspoint-zgpoint;
            
    double Rd[3] = {xd, yd, zd};
           
    double RdRgs = (xd*xgpoint) + (yd*ygpoint) + (zd*zgpoint);
    double RdPos = sqrt(pow(xd,2) + pow(yd,2) + pow(zd,2));
    double RgsPos = sqrt(pow(xgpoint,2) + pow(ygpoint,2) + pow(zgpoint,2));
 
    double maskingangle = (pi/2)-acos((RdRgs)/(RdPos*RgsPos));
 
    bool angle;
 
    angle = true;
    if ( maskingangle>10 )
     angle = 1;
    else 
     angle = 0;
 
    return 0;
}

void Coord::displayInfo()
{
   std ::  cout << xspoint << yspoint << xspoint << xgpoint << ygpoint << zgpoint << std ::endl;
}
