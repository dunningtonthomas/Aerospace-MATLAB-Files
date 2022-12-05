#include "coord.h"

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg) 
{
   // setPoint allows values in our main file to access private members of our class
   xspoint = xs;
   yspoint = ys;
   zspoint = zs;
   xgpoint = xg;
   ygpoint = yg;
   zgpoint = zg; 
}

bool Coord::setFlag() 
{
    double PI = 3.141592653589793;
    
    double Rs[3] = {xspoint, yspoint, zspoint};
    double Rgs[3] = {xgpoint, ygpoint, zgpoint};
    double Rd[3] = {(Rs[0] - Rgs[0]), (Rs[1] - Rgs[1]), (Rs[2]- Rgs[2])}; 
    
    double dotProduct = (Rd[0] * Rgs[0]) + (Rd[1] * Rgs[1]) + (Rd[2] * Rgs[2]); 
    double AbsRgs = sqrt(pow(Rgs[0], 2) + pow(Rgs[1], 2) + pow(Rgs[2], 2));
    double AbsRd = sqrt(pow(Rd[0], 2) + pow(Rd[1], 2) + pow(Rd[2], 2));
    
    double maskingAngle = (180.0/PI) * acos(dotProduct/(AbsRd * AbsRgs));
    phipoint = 90.0 - maskingAngle; 
    
    if (phipoint > 10.0) 
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

void Coord::displayInfo()
{
    cout << xspoint << " " << yspoint << " " << zspoint << " " << xgpoint <<
    " " << ygpoint << " " << zgpoint << endl;
}

