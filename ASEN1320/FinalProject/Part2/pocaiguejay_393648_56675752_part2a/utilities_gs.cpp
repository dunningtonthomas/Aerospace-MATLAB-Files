#include <fstream>
#include <cmath>
#include "utilities.h"

using namespace std;

void rotate(double GS[], int arrLength, double w)
{
    const double PI = 3.14159;
    
    for(int i = 0; i < arrLength; i += 3)
    {
        double t = i * 60;
        double Theta = (w*t)*(PI/180.0);
        
        double Xg;
        double Yg;
        double Zg;
        
        Xg = GS[0]*cos(Theta) - GS[1]*sin(Theta);  // X Pos
        
        Yg = GS[0]*sin(Theta) + GS[1]*cos(Theta);  // Y Pos
        
        Zg = GS[2];                                // Z Pos
        
        GS[i]   = Xg;
        GS[i+1] = Yg;
        GS[i+2] = Zg;
        
    }   
}  

void write_csv(double GS[], int arrLength, std::string fileName)
{
    ofstream GSout;
    GSout.open(fileName);

    for(int i = 0; i < arrLength; i += 3)
    {
        GSout << GS[i] << "," << GS[i+1] << "," << GS[i+2] << endl;
    }
    GSout.close();
}