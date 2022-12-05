#include <iostream> //including iostream library to use cout
#include <fstream> // including fstream to input and output to files
#include <string> //including string library to stroe the variables in get line
#include <cmath> //including cmath to be able to do equations in setFlag

using namespace std;

class Coord
{
    
    //private attributes
    private: 
        double Xspoint;
        double Yspoint;
        double Zspoint;
        double Xgpoint;
        double Ygpoint;
        double Zgpoint;
        double PHIpoint;
        bool flagPoint;
    
    //methods    
    public:
        
        void displayInfo(); //void because it doesn't return any values
        void setPoint(double Xs, double Ys, double Zs, double Xg, double Yg, double Zg); //void because it doesn't return any values
        bool setFlag(); //bool because it returns a bool variable
        
};