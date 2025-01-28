#include "coord.h"
#include <string>


bool Coord::setFlag()
{
double pi = 3.141592653589793;

Rs[] = {xspoint, yspoint, zspoint };
Rgs[] = {xgpoint, ygpoint, zgpoint};

double Rd = [Rs[0] - Rgs[0], Rs[1] - Rgs[1], Rs[2] - Rgs[2]];

double RdRgs = Rd[0]*Rgs[0] + Rd[1]*Rgs[1] + Rd[2]*Rgs[2];

double lRgsl = sqrt(pow(Rgs[0],2) + pow(Rgs[1],2) + pow(Rgs[2],2));
double lRdl = sqrt(pow(Rd[0],2) + pow(Rd[1],2) + pow(Rd[2],2));

double pi = 3.141592653589793;

double phi = 90 - (arccos(Rdgs/(lRdl * lRgsl))*180)/pi;

if( phi < 10)
{
    flagpoint = 0;
}
else if (phi > 10 && phi < 80)
{
    flagpoint = 1;
}
else if(phi > 80)
{
    flagpoint = 0;
}
    return flagpoint;
    
}

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    double xspoint = xs;
    double yspoint = ys;
   double  zspoint = zs;
   double  xgspoint = xg;
    double ygspoint = yg;
   double  zgspoint = zg;
    
    
}

void Coord::displayInfo()
{
    
    cout << xspoint << ", " << yspoint << ", " << zspoint << ", " << xgpoint << ", " << ygpoint << ", " << zgpoint << endl;
    
}
