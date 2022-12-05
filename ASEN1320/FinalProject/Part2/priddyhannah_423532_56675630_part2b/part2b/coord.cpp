#include "coord.h"
#include <cmath>
#include <iostream>


bool Coord::setFlag(){ //Set Flag function
    double xd = xspoint - xgpoint;
    double yd = yspoint - ygpoint;
    double zd = zspoint - zgpoint; //declaring the Rd Vector
    phipoint = (3.1415926535/2 - acos((xd*xgpoint + yd*ygpoint + zd*zgpoint)/(sqrt(xd*xd + yd*yd + zd*zd) * (sqrt(xgpoint*xgpoint + ygpoint*ygpoint + zgpoint*zgpoint)))))*180/3.1415926535;
    if (phipoint > 10) //Logic loop determining if the values are valid
    {
        flagpoint = true;
        return flagpoint;
    }
    else
    {
        flagpoint = false;
        return flagpoint;
    }
}

void Coord::displayInfo() const //display function
{
    
    std::cout << "Satellite Coord: [" << xspoint << ", " << yspoint << ", " << zspoint << "]^T \n";
    std::cout << "Ground Station Coord: [" << xgpoint << ", " << ygpoint << ", " << zgpoint << "]^T \n";
    std::cout << "Phi Angle (degrees): " << (phipoint) << std::endl;
    std::cout << "Visibility: " << flagpoint << std::endl; //returns all values to the terminal in vector notation
    
}

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    xspoint = xs;
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;//sets all points
}