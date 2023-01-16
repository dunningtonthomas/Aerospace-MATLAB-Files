#include "coord.h" //uses the coord.h file
#include <cmath> //uses the cmath library
#include <iostream> //uses the iosream library

using namespace std;

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg) //calls setpoint function which takes in 6 doubles
{
    xspoint = xs; //sets xspoint equal to xs
    yspoint = ys; //sets yspoint equal to ys
    zspoint = zs; //sets zspoint equal to zs
    xgpoint = xg; //sets xgpoint equal to xg
    ygpoint = yg; //sets ygpoint equal to yg
    zgpoint = zg; //sets zgpoint equal to zg
}

void Coord::displayInfo() //Calls the void function displayInfo
{
    cout << xspoint << yspoint << zspoint << xgpoint << ygpoint << zgpoint << endl; //calls the values to be displayed to the terminal when displayInfo is called
}


bool Coord::setFlag() //calls the the boolean function for setFlag
{
    double pi = 3.141592653589793; //declares pi as a variable
    
    double xd = xspoint - xgpoint; //declares xd equal to xspoint minus xgpoint
    double yd = yspoint - ygpoint; //declares yd equal to yspoint minus ygpoint
    double zd = zspoint - zgpoint; //declares zd equal to zspoint minus zgpoint
    
    
    double RdRgs = (xd * xgpoint) + (yd * ygpoint) + (zd *zgpoint); //declares Rd and Rgs vectors equal to the equation
    
    double AbsRd = sqrt( pow(xd,2) + (pow(yd,2)) + (pow(zd,2)) ); //declares the absolute value of Rd equal to the equation
    
    double AbsRgs = sqrt( pow(xgpoint,2) + (pow(ygpoint,2)) + (pow(zgpoint,2)) ); //decalers absolute Rgs equal to the equation
    
    double ElevationAngle = (pi/2.0) - acos( ( (RdRgs) / (AbsRd * AbsRgs) ) ); //declares ElevationAngle equal to the equation

    
    if (10.0*(pi/180.0) < ElevationAngle) //creates an if statement to determine if the angle is greater than 10pi radians
    {
        flagpoint = 1; //determines if the above statement is true and if it is it sets the flagpoint equal to 1
    }
    else
    {
        flagpoint = 0; //if the aboves statement was false then the function sets the flagpoint equal to 0
    }
    return flagpoint; //returns the flagpoint
}