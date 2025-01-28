#include "Coord.h" //including the header to have access to the libraries and the class

void Coord::displayInfo()
{
    cout << Xspoint << ", " << Yspoint << ", " << Zspoint << ", " << Xgpoint << ", " << Ygpoint << ", " << Zgpoint << endl;
}


void Coord::setPoint(double Xs, double Ys, double Zs, double Xg, double Yg, double Zg)
{
    //takes the inputted values and sets them equal to the private members
    //so setFlag is able to access the numbers stored in the private members
    Xspoint = Xs;
    Yspoint = Ys;
    Zspoint = Zs;
    Xgpoint = Xg;
    Ygpoint = Yg;
    Zgpoint = Zg;
}


bool Coord::setFlag()
{
    double const PI = 3.141592653589793; //declaring PI as a constant
    
    double RGs[3] = {Xgpoint, Ygpoint, Zgpoint}; // creating the RGs array which contains the ground station coordinates
    double RS[3] = {Xspoint, Yspoint, Zspoint}; // creating the RS array which contains the satelite coordinates
    
    //calculating 
    double Xd = Xspoint - Xgpoint; 
    double Yd = Yspoint - Ygpoint;
    double Zd = Zspoint - Zgpoint;
    
    //creating the Rd array which contains the newly calculated coordinates
    double Rd[3] = {Xd, Yd, Zd};
    
    //calculating RdRGs and absRGs and absRd to be used to calculate PHIpoint 
    double RdRGs = (Xd*Xgpoint)+(Yd*Ygpoint)+(Zd*Zgpoint);
    double absRGs = sqrt((Xgpoint*Xgpoint)+(Ygpoint*Ygpoint)+(Zgpoint*Zgpoint));
    double absRd = sqrt((Xd*Xd)+(Yd*Yd)+(Zd*Zd)); 
    
    //calculating PHi point
    double PHIpoint = ((PI/2.0)-(acos((RdRGs)/(absRd*absRGs))));
    
    //returning a 1 or 0 based on if the satelite is visible by using the calculated PHIpoint
    //converting the angle where the satelites are visible to radians
    double visibilityangle = (10.0*PI)/180.0;
    if (PHIpoint>visibilityangle)
    {
       flagPoint = 1; //true = visible
       return flagPoint;
    }
    else
    {
        flagPoint = 0; //false = invisible
        return flagPoint;
    }
    
}