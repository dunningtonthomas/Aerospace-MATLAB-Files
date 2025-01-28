/* #ifndef checks whether the given token has been #defined earlier in the file 
or in an included file; if not, it includes the code between it and the closing 
#else or, if no #else is present, #endif statement.*/

#ifndef COORD_H
#define COORD_H
#include <string>
#include <iostream>
#include <fstream> 
#include <cmath>
#include <cstdlib>

using namespace std;

class Coord 
{
    //Public Attributes
    public:
        // Mutator Methods
        void setPoint(double, double, double, double, double, double);  
        void displayInfo();
        bool setFlag(); 
        
    // Private Attribuites
    private:
        double xspoint;
        double yspoint;
        double zspoint;
        double xgpoint;
        double ygpoint;
        double zgpoint;
        double phipoint;
        bool flagpoint; 
}; 

#endif