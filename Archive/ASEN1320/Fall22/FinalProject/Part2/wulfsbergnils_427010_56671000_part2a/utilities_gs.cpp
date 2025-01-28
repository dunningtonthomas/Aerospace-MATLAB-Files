#include "utilities.h"
#include <fstream>
#include <cmath>

using namespace std;

void rotate(double pos[], int size, double angDeg)      //rotate function
{
    
    double PI = 3.141592653589793;      //declaring local variable of PI
    double x[size];                     //creating local array
    
    for(int i = 0; i<size; i+=2)        //loop that preforms the calculations
    {
        x[i] = cos(((PI/180)*angDeg))*pos[i] - sin(((PI/180)*angDeg))*pos[i + 1];
        x[i + 1] = sin(((PI/180)*angDeg))*pos[i] + cos(((PI/180)*angDeg))*pos[i + 1];
    }
    
    for(int i = 0; i<size; i++)         //loop that assighns the final calculated variables back to the original array
    {
        pos[i] = x[i];
    }
    
}

void write_csv(double input[], int size, std::string file)        //write function  
{
    
    ofstream wri;       //creating ofstream item
    wri.open(file);     //opening the file that has been created
    
    for(int i = 0; i<2880; i+=2)                //writing to file
    {
        wri << input[i] << ", " << input[i + 1] << ", " << "3673.747" << endl;
    }
    wri.close();                    //closeing the file
    
}