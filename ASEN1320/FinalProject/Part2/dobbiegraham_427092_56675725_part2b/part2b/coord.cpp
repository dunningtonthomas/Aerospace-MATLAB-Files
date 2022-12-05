#include <iostream>
#include <math.h>
#include "coord.h"

#define PI 3.141592653589793238 


// Constructors
Coord::Coord(){};

Coord::Coord(double xs, double ys, double zs, double xg, double yg, double zg){
    
    setPoint(xs, ys, zs, xg, yg, zg);
}

// Loads data
void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg){
    
    xspoint = xs;
    yspoint = ys;
    zspoint = zs;
    xgpoint = xg;
    ygpoint = yg;
    zgpoint = zg;
    
    return;
}


// Set visability flag
bool Coord::setFlag(){
    
    // Create Rd vector
    double Rd[3] = { xspoint - xgpoint, yspoint - ygpoint, zspoint - zgpoint };
    double Rgs[3] = {xgpoint , ygpoint , zgpoint};
    
    // Take dot product of Rd and Rgs
    double Rd_dot_Rgs = 0;
    for(int i = 0; i < 3; i++){
        
        Rd_dot_Rgs += Rd[i] * Rgs[i];
    }
    

    // Normalize Rd and Rgs
    double normRd = normVec(Rd, 3);
    double normRgs = normVec(Rgs, 3);
   
    // Calculate phi in rad
    double phipoint_rad = PI/2 - acos(Rd_dot_Rgs / (normRgs * normRd));
    
    // Convert
    phipoint = phipoint_rad *180 / PI;
    
    // Set vis flag based on theta
    if(phipoint >= 10){
        
        flagpoint = true;
        return true;
        
    }else{
        
        flagpoint = false;
        return false;
    }
    
}


double Coord::normVec(double vec[], int vec_len){
    
    // Normalizes the vector
    double squared_total;
    
    for(int i = 0; i < vec_len; i++){
        squared_total += pow(vec[i], 2);
    }
    
    return sqrt(squared_total);
}


void Coord::displayInfo(){
    
    std::cout << "xspoint " << xspoint << std::endl;
    std::cout << "yspoint " << yspoint << std::endl;
    std::cout << "zspoint " << zspoint << std::endl;
    std::cout << "xgpoint " << xgpoint << std::endl;
    std::cout << "ygpoint " << ygpoint << std::endl;
    std::cout << "zgpoint " << zgpoint << std::endl;
    std::cout << "phipoint " << phipoint << std::endl;
    std::cout << "flagpoint " << flagpoint << std::endl;
    
    return;
}

double Coord::getPhi(){
    
    return phipoint;
}