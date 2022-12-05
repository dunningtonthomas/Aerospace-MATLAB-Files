#include "coord.h"
#include <cmath>
#include <cstdlib>
#include <iostream>
using namespace std; 


bool coord::getFlagPoint()
{
    return flagpoint;
}




void coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
    xspoint=xs;
    yspoint=ys;
    zspoint=zs;
    xgpoint=xg; 
    ygpoint=yg;
    zgpoint=zg;
}

bool coord::setFlag()
{
    double xs=xspoint;
    double ys=yspoint;
    double zs=zspoint;
    double xg= xgpoint; 
    double yg=ygpoint;
    double zg=zgpoint;
    
  
    //define PI
    double const PI=3.141592653;
    
    //define vector components of Rd
    double xd=xs-xg; 
    double yd=ys-yg;
    double zd=zs-zg;
    
    //define vector normilizations of Rd and Rgs
    double Rd=sqrt(pow(xd,2)+pow(yd,2)+pow(zd,2));
    double Rgs=sqrt(pow(xg,2)+pow(yg,2)+pow(zg,2));
    
    //define inner prodeuct of Rd dot Rgs
    double RdRgs=(xd*xg)+(yd*yg)+(zd*zg);
    
    //define masking angle
    phipoint=(PI/2.0)-acos(RdRgs/(Rd*Rgs));
    
    //convert elevation angle to degrees
    double phipointDeg=phipoint*(180/PI);
    
    if (phipointDeg>10&&phipoint<170)
    {
        return 1; 
        
    }
    
    return 0;
}

void coord::displayInfo()
{
    cout << "xspoint: " << xspoint << endl; 
    cout << "yspoint: " << yspoint << endl;
    cout << "zspoint: " << zspoint << endl;
    
    cout << "xgpoint: " << xspoint << endl; 
    cout << "ygpoint: " << yspoint << endl;
    cout << "zgpoint: " << zspoint << endl;
    
    cout << "phipoint: " << phipoint << endl;
    cout << "flagpoint: " << flagpoint << endl; 
    

}

