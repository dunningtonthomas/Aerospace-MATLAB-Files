#include <fstream>
#include <cmath>
#include "utilities.h"
using namespace std;

void rotate (double arr[], int size, double deg) 
{
    //Variable Declaration
    const double pi = 3.141592653589793;
    double theta = deg * pi / 180.0; // changing tha angle from deg to radians
    double xnew,ynew,znew;

    for (int i=0; i<size; i+=3) 
    {
        xnew = arr[i]*cos(theta) - arr[i+1]*sin(theta);
        ynew = arr[i]*sin(theta) + arr[i+1]*cos(theta); 
        znew = arr[i+2];
        
        arr[i+3] = xnew;
        arr[i+4] = ynew;
        arr[i+5] = znew;
    }
}





void write_csv(double arr[], int size, std::string filename)
{
    //Variable Declaration
    ofstream outputStream;
    outputStream.open(filename);

    for (int i=0; i<size; i+=3)
    {
        outputStream << arr[i] << ", " << arr[i+1] << ", " << arr[i+2] << endl;
    }
    
    outputStream.close();
}