#include"coord.h"
#include<cmath>
#include<iostream>
using namespace std;




Coord::Coord(){
    //empty constructor
}

bool Coord::setFlag(){
    double Xs = xspoint;double Ys = yspoint;double Zs = zspoint;double Xg = xgpoint;double Yg = ygpoint;double Zg = zgpoint;
    //gets all needed vaues for calculations
    
    double Xd = Xs-Xg; 
    double Yd = Ys-Yg;
    double Zd = Zs-Zg;
    
    double numerator = Xd*Xg + Yd*Yg + Zd*Zg; //Rd*Rgs
    
    double Rgs = sqrt(pow(Xg,2) + pow(Yg,2) + pow(Zg,2));//equation for norm Rgs
    double Rd = sqrt(pow(Xd,2)+pow(Yd,2)+pow(Zd,2));// equation for norm Rd
    double radians = acos(numerator/(Rgs*Rd));//value of arccos in radians
    double masking = 90-(radians*(180/3.14159265359)); // converted to degrees and subtracted by 90
    
    if (masking>10){
        return flagpoint = true;//sets private value flagpoint to true(1)
    }
    else{
        return flagpoint = false;// sets value to false(0)
    }
    
}

void Coord::setPoint(double inputXs,double inputYs,double inputZs,double inputXg,double inputYg,double inputZg){
    // assigns a value to the priovate variables
    
    xspoint = inputXs;
    yspoint = inputYs;
    zspoint = inputZs;
    xgpoint = inputXg;
    ygpoint = inputYg;
    zgpoint = inputZg;
}

void Coord::displayInfo(){
    cout<< xspoint<<", "<<yspoint<<", "<<zspoint<< endl;
    cout<< xgpoint<<", "<<ygpoint<<", "<<zgpoint<< endl;
    cout << "phi = "<< phipoint<< endl;
    cout << "flagpoint = "<< flagpoint<< endl;
    //displays the data 
}