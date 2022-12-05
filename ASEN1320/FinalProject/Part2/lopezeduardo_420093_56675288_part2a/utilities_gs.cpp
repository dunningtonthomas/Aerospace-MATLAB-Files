#include "utilities.h"
#include <iostream>
#include <fstream>

using namespace std;
int num_stations = 1;

void rotate(double GS[], int num_stations, double theta)
{
    for(int i=0; i < 1; i++)
    {
        double pi = 3.141592653589793;
        
        double x;
        double y;
        double z;
        
        
        GS[3*i] = x;
        GS[3*i+1] = y;
        GS[3*i+2] = z;
        
        double w = 360 / 86400;
        
        double t = i*60;
        
        double theta = ((w*t)*pi /180); //rotation in rad
        
        
        x = GS[3*i]*cos(theta) - GS[3*i+1]*sin(theta);
        y = GS[3*i]*sin(theta) + GS[3*i+1]*cos(theta);
        z = GS[3*i+2];
        
        
    }
        
 }
   int size =3;
   
void write_csv(double GS[], int size, std::string filename)
{
      ofstream outputfile;
      outputfile.open(filename);
      
      for(int i=0; i < 1441; i++)  
      {
          outputfile << GS[3*i] << ", " << GS[3*i+1] << ", " << GS[3*i+2] << endl;
      }

      outputfile.close();
}









