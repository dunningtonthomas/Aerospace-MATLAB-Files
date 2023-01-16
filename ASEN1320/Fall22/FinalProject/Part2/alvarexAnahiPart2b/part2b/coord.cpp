#include <string>
#include <cmath>
#include "coord.h"


const double PI = 3.141592653589793;

bool Coord::setFlag()
{
    double Rs[3] = {Xspoint, Yspoint, Zspoint};
    double Rgs[3] = {Xgpoint, Ygpoint, Zgpoint};
    double Rd = (Rs[1] - Rgs[1]), (Rs[2] - Rgs[2]), (Rs[3] - Rgs[3]);
    
    double Rd_Rgs = ((Rd[0]*Rgs[0]) + (Rd[1]*Rgs[1]) + (Rd[2]*Rgs[2]));
    double absRgs = sqrt(pow(Xg[0],2)+pow(Yg,2)+pow(Zg,2);
    double absRd = sqrt(pow(Xd,2)+pow(Yd,2)+pow(Zd,2));
    
    double masking = 180/PI*(90 - arccos((Rd_Rgs)/absRgs*absRd));
    phipoint = 90.0-maskingAngle;
    
    bool flag;
    
    if (phipoint > 10)
    {
    flagpoint = 1;
    return 1;
    
    }
    else
    {
    flagpoint = 0;
    return 0;
    }
    
}

void Coord::setPoint(double xspoint, double yspoint, double zspoint, double xgpoint, double ygpoint, double zgpoint)

{
    Xs = Xspoint;
    
    Ys = Yspoint
    
    Zs = Zspoint;
    
    Xg = Xgpoint;
    
    Yg = Ygpoint;
    
    Zg = Zgpoint;
    
}

void Coord::DisplayPoint()

{
    cout << Xspoint << " " << Yspoint << " " << Zspoint << " " << Xgpoint << " " << Ygpoint << " " << Zgpoint << endl;
}