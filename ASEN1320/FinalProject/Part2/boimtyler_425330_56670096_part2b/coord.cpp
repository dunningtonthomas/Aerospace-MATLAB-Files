#include <fstream>
#include <cmath>
#include "coord.h"
#include <iostream>

// WRITE setPoint, setFlag, and displayInfo definitions
// setFlag: No inputs, compute phi(masking angle), set visibility flag by outputting 1 or 0 BOOLEAN
// setPoint: Take 6 double inputs, assigns values to all 6, no outputs
// displayInfo: displays all private values to console

// Mutator Methods

void Coord::setPoint(double Xs, double Ys, double Zs, double Xg, double Yg, double Zg) 
{
    xspoint = Xs;
    yspoint = Ys;
    zspoint = Zs;
    xgpoint = Xg;
    ygpoint = Yg;
    zgpoint = Zg;
}

void Coord::setFlag() 
{
    // compute phi, return a bool
    const double PI = 3.141592653589793;
  
    int array_Size = 1441; 
    
    double Xd = xspoint - xgpoint;
    double Yd = yspoint - ygpoint;
    double Zd = zspoint - zgpoint;
    
    //std::cout << "Xd = " << Xd << ", Xs = " << xspoint << ", Xg = " << xgpoint << std::endl;
    //std::cout << "Yd = " << Yd << ", Ys = " << yspoint << ", Yg = " << ygpoint << std::endl;
    //std::cout << "Zd = " << Zd << ", Zs = " << zspoint << ", Zg = " << zgpoint << std::endl;
    
    double NUMERATOR = ((Xd*xgpoint)+(Yd*ygpoint)+(Zd*zgpoint)); // Sets Numerator
    double DENOMINATOR = ((sqrt(pow(xgpoint, 2) + pow(ygpoint, 2) + pow(zgpoint, 2)))*(sqrt(pow(Xd, 2) + pow(Yd, 2) + pow(Zd, 2)))); // Sets Denominator
    
    double phipoint = (90) - (180.0/PI)*(acos(NUMERATOR/DENOMINATOR)); // Converted equation to degrees
    
    //std::cout << "Phi is " << phipoint << std::endl;
    
    // sets phi point for each part
    
        if (phipoint > 10)
        {
            flagpoint = 1;
        }
        else
        {
            flagpoint = 0;
        }
    }


// Display info
void Coord::displayInfo() 
{
    std::cout << "Xs = " << xspoint << ", Xg = " << xgpoint << std::endl;
    std::cout << "Ys = " << yspoint << ", Yg = " << ygpoint << std::endl;
    std::cout << "Zs = " << zspoint << ", Zg = " << zgpoint << std::endl;
}

bool Coord::getFlag()
{
    return flagpoint;
}