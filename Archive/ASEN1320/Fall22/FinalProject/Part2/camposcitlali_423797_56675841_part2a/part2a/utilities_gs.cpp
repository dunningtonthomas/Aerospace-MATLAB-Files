#include <iostream>
#include <cmath>
#include <string>
#include <fstream>
#include "utilities.h"
using namespace std;

//rotate function 
void rotate(double GroundSt[], int position, double theta)
{
    //GroundSt = ground stations, arrSize= array size
      double const PI = 3.141592653589793;
      double rad = (theta*PI)/180;
      int i = 0;
     // double Xg;
     // double Yg;
     // double Zg;
     // double theta = degrees*(PI/180); 
     //dont know if i need this 
     //double w = 360/86400;
     //int i = 0;
     //double theta = degrees*(PI/180); //deg -> rad

    for(int i=0; i<(position/3); i+=3);
    {
        //equations to find the new updated ground station
        double w = 360/86400;
        double t = i * 60;
        double theta = w*t;
        //z = GroundSt[2];
        double x = GroundSt[i*3];
        double y = GroundSt[(i*3)+1];
        double z = GroundSt[(i*3)+2];
        
        GroundSt[i*3] = (x*cos(rad))-(y*sin(rad));
        GroundSt[(i*3)+1] = (x*sin(rad)) + (y*cos(rad));
        GroundSt[(i*3)+2] = z;
        //double GroundSt[i] = Xg;
        //double GroundSt[i+1] = Yg;
        //double GroundSt[i+2] = Zg;

        //Xg = cos(theta)*GroundSt[i]-sin(theta)*GroundSt[i+1];
        //Yg = sin(theta)*GroundSt[i]+cos(theta)*GroundSt[i+1];
        //Zg = arrSize[i+2];
        
    }
}
    
    //function printing the new x and y positions + z
void write_csv(double GroundSt[], int arrSize, std::string filename)
    {
    //opening the file
    ofstream output;
    output.open(filename);
    
    //printing
    for (int i=0; i<arrSize; i+=3)
    {
        output << GroundSt[i*3] << " " << GroundSt[(i*3)+1] << " " << GroundSt[(i*3)+2] <<endl;
    }
    
    output.close();
    }
