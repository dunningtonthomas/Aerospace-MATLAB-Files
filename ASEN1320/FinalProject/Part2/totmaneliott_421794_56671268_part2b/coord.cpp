#include "coord.h"
#include <cmath>
#include <iostream>

using namespace std;

//This file is strictly for defining functions that will be used in main.

//Setpoint function intakes three satellite coords, three ground station coords, and returns nothing.
void Coord::setPoint(double inputXSpoint, double inputYSpoint, double inputZSpoint, double inputXGpoint, double inputYGpoint, double inputZGpoint)
{
    //Set private member values equal to input values.
    xspoint = inputXSpoint;
    yspoint = inputYSpoint;
    zspoint = inputZSpoint;
    xgpoint = inputXGpoint;
    ygpoint = inputYGpoint;
    zgpoint = inputZGpoint;
}
//SetFlag function intakes no values and outputs a true/false boolean.
bool Coord::setFlag()
{
    
    //The matrices are named a little confusingly.
    //Rs = Satellite coordinates, Rgs = Ground stations coords
    //Rd = Distance between satellite and ground station
    double Rs[3] = {xspoint, yspoint, zspoint};
    double Rgs[3] = {xgpoint, ygpoint, zgpoint};
    double Rd[3];
    Rd[0] = Rs[0] - Rgs[0];
    Rd[1] = Rs[1] - Rgs[1];
    Rd[2] = Rs[2] - Rgs[2];
    
    //RdNum and RdDenom stand for Numerator and Denominator respectively. 
    //Breaking apart the equation made this easier to manage.
    double RdNum = ((Rd[0]*Rgs[0]) + (Rd[1]*Rgs[1]) + (Rd[2]*Rgs[2]));
    double RdDenom = (sqrt((Rgs[0]*Rgs[0]) + (Rgs[1]*Rgs[1]) + (Rgs[2]*Rgs[2]))) * (sqrt((Rd[0]*Rd[0]) + (Rd[1]*Rd[1]) + (Rd[2]*Rd[2])));
    
    //Phipoint is calculated using the equation found in the README, converted to degrees from rads.
    phipoint = ((M_PI / 2.0) - acos(RdNum / RdDenom)) * (180.0 / M_PI);
    
    
    //Simple if/else, if phipoint is greater than 10 degrees it returns a true value and doesn't otherwise.
    if(phipoint >= 10) {
        flagpoint = 1;
        return true;
    } else {
        flagpoint = 0;
        return false;
    }
}

//DisplayFunction method simply outputs all private members into console when called in main.
void Coord::displayInfo() 
{
    cout << "XSpoint = " << xspoint << endl;
    cout << "YSpoint = " << yspoint << endl;
    cout << "ZSpoint = " << zspoint << endl;
    cout << "XGpoint = " << xgpoint << endl;
    cout << "YGpoint = " << ygpoint << endl;
    cout << "ZGpoint = " << zgpoint << endl;
    cout << "PhiPoint = " << phipoint << endl;
    cout << "FlagPoint = " << flagpoint << endl;
}