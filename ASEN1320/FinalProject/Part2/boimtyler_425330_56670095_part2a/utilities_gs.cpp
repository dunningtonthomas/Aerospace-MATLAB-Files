#include <fstream> // opens the file stream library
#include <cmath> // opens the math function library
#include "utilities.h" // references the utilities header, which has the string library and both function protorypes

using namespace std; // Namespace defines standard functions such as cout and cin

// User Defined Functions 

void rotate(double arrayN[], int arraySize, double angle) // UDF that rotates the coordinates, declares the array, size, and the angle
{
    const double PI = 3.141592653589793; // value of PI
    
    const double w = 360.0/86400.0;
    
    for (int i = 0; i<(arraySize/2); i++) // for loop: x values is array[0], array[2], array[4], and y is array[1], array[3], array[5]
    {
        double radian = (w*i*(PI/3));
        double Xg = cos(radian)*(-2314.87) - sin(radian)*(4663.275); // sets the adjusted value of x using the given equation to a variable, using the original array values
        double Yg = sin(radian)*(-2314.87) + cos(radian)*(4663.275);  // sets the adjusted value of y using the given equation to a variable, using the original array values
        arrayN[2*i] = Xg; // sets the new array value for the x coordinate (even array values)
        arrayN[2*i+1] = Yg; // sets the new array value for the y coordinate (odd array values)
    }
    
}

void write_csv(double arrayN[], int arraySize, std::string filename) // UDF that writes a csv file with the new coordinates
{
    ofstream outputStream; // opens the output stream
    outputStream.open(filename); // creates the file name called output as a csv file
    
    double Zcoord = 3673.747;
    
    for (int i = 0; i<arraySize; i+=2) // for loop to declare the new variables
    {
        outputStream << arrayN[i] << ", " << arrayN[i+1] << ", " << Zcoord << endl; // prints the new coordinate system
    }
}