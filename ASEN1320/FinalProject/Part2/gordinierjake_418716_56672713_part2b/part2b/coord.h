#include <iostream>
#include <cmath>
#include <string>

// creating a class 
class Coord
{
    // Private Attributes
    private:
    
    double xspoint;
    double yspoint;
    double zspoint;
    double xgpoint;
    double ygpoint;
    double zgpoint;
    double phipoint;
    bool flagpoint;
    
    public:
    //Accessor Methods
    void displayInfo();
    
    // Mutator Methods
    void setPoint(double, double, double, double, double, double);
    bool setFlag();
    
};