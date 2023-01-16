#include <fstream>
#include <cmath>
#include "coord.h"
#include <iostream>

using namespace std;

bool Coord::setFlag()
{
    const double PI = 3.14159;
    // Calulcating Masking Angle (PHI)
    double Xd, Xg, Xs, Yd, Yg, Ys, Zd, Zg, Zs;
    
    double productOne   = ( (Xd*Xg) + (Yd*Yg) + (Zd*Zg) );                      // Rd * Rgs
    double absoluteRd   = sqrt( pow(Xs-Xg,2) + pow(Ys-Yg,2) + pow(Zs-Zg,2) );            // |Rd|
    double absoluteRgs  = sqrt( pow(Xg,2) + pow(Yg,2) + pow(Zg,2) );            // |Rgs|
    double productTwo   = ( absoluteRd*absoluteRgs );                           // |Rd|*|Rgs|
    double Comp         = ( productOne/productTwo );
    double Phi          = ( PI/2.0 - acos(Comp) );
    double zenith       = ( acos(Comp) );
    
    double Final        = Phi * (180/PI);
    double FinalZenith  = zenith * (180/PI);
    
    if(Final > 10 || FinalZenith < 80 )
    {
        flagpoint = true;
    }
    else
    {
        flagpoint = false;
    }
    
    return flagpoint;
}

void Coord::setPoint(double Xs, double Ys, double Zs, double Xg, double Yg, double Zg)
{  
    // Assign Input Values to the Private Member Satellite Coordinates
    Xspoint = Xs;
    Yspoint = Ys;
    Zspoint = Zs;
    
    // Assign Input Values to the Private Member Ground Coordinates
    Xgpoint = Xg;
    Ygpoint = Yg;
    Zgpoint = Zg;
    
}

void Coord::displayInfo()
{
    cout << "SatX: " << Xspoint << endl;
    cout << "SatY: " << Yspoint << endl;
    cout << "SatZ: " << Zspoint << endl;
    cout << "Ground X: " << Xgpoint << endl;
    cout << "Ground Y: " << Ygpoint << endl;
    cout << "Ground Z: " << Zgpoint << endl;
    cout << "Phi: " << phipoint << endl;
}

