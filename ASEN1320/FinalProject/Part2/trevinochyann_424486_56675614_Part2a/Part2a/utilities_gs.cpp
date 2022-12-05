#include <iostream>
#include <cmath>
#include <string>
#include <fstream>
#include "utilities.h"

using namespace std;

    
    
    void rotate(double GS[], int arraySize, double Theta)
    {
       //Declare 
    double w = 360/86400;
    int t = 60;
    Theta = w * t;
    double x0 = -2314.87;
    double y0 = 4663.275;
    double z0 = 3673.747;
    double xg;
    double yg;
    double zg;
    
    for (int J=0; J < 4320; J += 3)
    {
        xg = x0*cos(Theta) - y0*sin(Theta);
        yg = x0*sin(Theta) - y0*cos(Theta);
        zg = z0;
        GS[J] = xg;
        GS[J+1] = yg;
        GS[J+2] = zg;
    }
    
    
    }
    
    void write_csv(double gspos[], int M, string output)
    {
        ofstream gsposStream;
        gsposStream.open("GSPosition.csv");
        
        for(int J=0; J<4320; J+=2)
        {
        gsposStream << gspos[J] << gspos[J+1] << gspos[J+2] << endl;
        }
        
        gsposStream.close();
    }