#include <iostream>
#include <fstream>
#include <cmath>
#include "coord.h"

using namespace std;

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    xs_point = xs;
    ys_point = ys;
    zs_point = zs;
    xg_point = xg;
    yg_point = yg;
    zg_point = zg;
}


bool Coord::setFlag()
{
    bool flag_point;
    const double pi = 3.141592653589793;
    double angle, xd, yd, zd, RdRgs, Rgs, Rd;
    xd = xs_point - xg_point;
    yd = ys_point - yg_point;
    zd = zs_point - zg_point;
    RdRgs = ((xd*xg_point) + (yd*yg_point) + (zd*zg_point));
    Rgs = sqrt((xg_point*xg_point)+(yg_point*yg_point)+(zg_point*zg_point));
    Rd = sqrt((xd*xd)+(yd*yd)+(zd*zd));
  
    angle = (pi/2)-acos((RdRgs)/(Rd*Rgs));
    angle = angle*180.0/pi;
    cout << angle << endl;
    
    
    if (angle>10)
    {
        flag_point = 1;
        return flag_point;
    }
    else 
    {
        flag_point = 0;
        return flag_point;
    }
}


void Coord::displayInfo()
{
    cout << xs_point << endl;
    cout << ys_point << endl;
    cout << zs_point << endl;
    cout << xg_point << endl;
    cout << yg_point << endl;
    cout << zg_point << endl;
}