#include "coord.h"
#include <cmath>
#include <fstream>
#include <iostream>
#include <string>

using namespace std; 


bool Coord::setFlag()
{
    
    //declaring pi
    double pi = 3.14159265358979;
    
    //distance between satellite and ground station for different coordinates 
    double dx = xspoint-xgpoint; 
    double dy = yspoint - ygpoint; 
    double dz = zspoint - zgpoint; 
    
    //declaring numertor of phipoint function
    double RdxRgs = (dx*xgpoint) + (dy*ygpoint) + (dz*zgpoint);
    
    //declaring absolute value of ground station values and distance values 
    double abvRgs = sqrt((xgpoint*xgpoint + ygpoint*ygpoint + zgpoint*zgpoint));
    double abvRd = sqrt((dx*dx+ dy*dy + dz*dz)); 
    
    
    //calculating phipoint value 
    phipoint = 90 - (180/pi)*(acos(RdxRgs/(abvRgs*abvRd)));
    
    
    //if-else for whether or not satellite is visible
    if (phipoint > 10)
    {
        return 1; 
    }
    
    else
    {
        return 0; 
    }
    

    
}



void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
   xspoint = xs; 
   yspoint = ys;
   zspoint = zs; 
   xgpoint = xg; 
   ygpoint = yg; 
   zgpoint = zg; 
  
}

void Coord::displayInfo() 
{
    cout << xspoint;
    cout << yspoint; 
    cout << zspoint; 
    cout << xgpoint; 
    cout << ygpoint; 
    cout << zgpoint; 
    cout << phipoint; 
    cout << flagpoint; 
}
