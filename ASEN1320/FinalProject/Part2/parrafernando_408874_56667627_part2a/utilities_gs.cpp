#include "utilities.h"
#include <string>
#include <fstream>
#include <cmath>

using namespace std;


//User Defined Function #1 Performs the position updates given in Equations; 
// (i) 1st argument is a 1D array of type double that stores the x, y,  and 
//     z positions of N number times as it rotates for a given day. 
// (ii) 2nd argument is an integer type corresponding to the length of the 
//      coordninates; namely x, y, and z. 
//(iii) the 3rd argument is the rotational angle (in degrees) of type double
void rotate(double GS[], int M, double theta)
{
    double PI = 3.141592653589793;
    double radians = (theta * PI)/180;  
    
    for (int i=0; i < (M/3); i++)                                                                 
    {   
        double w = 360 / 86400;   // Rotation Rate in degrees per second
        double t = i * 60;        // Time should iterate every 60 seconds  
        double theta = w * t;     // since the Rotation Rate is in degrees per
                                  // seconds giving us our Angle the Earth 
                                  // rotated at time (t)
   
        double x = GS[i*3];        
        double y = GS[(i*3) +1];
        double z = GS[(i*3) +2]; 
        
        GS[i*3] = (x * cos(radians)) -  (y * sin(radians));
        GS[(i*3) + 1] = (x * sin(radians)) + (y * cos(radians));
        GS[(i*3) + 2]= z;
    }

}

//User Defined Function (UDF) #2
void write_csv(double GS[], int N, std::string filename)
{
  
  ofstream outputStream;
  outputStream.open(filename);
   
    for (int i=0; i < (N/3); i++)
  {
      outputStream << GS[i*3] << ", " << GS[(i*3) + 1]  << ", " << GS[(i*3) + 2] <<endl; 
  }
   
  outputStream.close();
}
