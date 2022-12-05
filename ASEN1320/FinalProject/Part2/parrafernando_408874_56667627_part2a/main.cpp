#include "utilities.h"
#include "utilities_gs.cpp"

int main () 
{
//Variable Declaration
double w = 360.0/ 86400.0;          // Rotation Rate (w) degrees/seconds
double x0 = -2314.87;               // Initial Goldstone Observatory position  
double y0 = 4663.275;               // on Earth in x, y, z, coordinates
double z0 = 3673.747;
int N = 1441*3;                     // Size for 3 coordinates (x,y,z) for 1441
int M = 3;                          // positions in a given day
double GSPosition[N];               // Goldstone Observatory Position array 
                                    // throughout one day
    for (int i = 0; i < 1441; i++) 
     {
         double t = i * 60;         // Time should iterate every 60 seconds  
         double theta = w * t;      // since the rotation rate is in degrees 
                                    // per seconds
        double GS[M] = {x0, y0, z0};// Goldstone Observatory Initial Position

    //Calling User Defined Function (UDF) #1
    //Of note, the for loop will iterate the UDF #1 for the amount of minutes 
    // in a given resulting in a different position for every minute. 
    rotate(GS, M, theta);

    GSPosition[i*3] = GS[0];    //    
    GSPosition[(i*3) + 1] = GS[1];
    GSPosition[(i*3) + 2] = GS[2];
    }

//Calling User Defined Function #2 
write_csv(GSPosition, N, "GSPosition.csv");


return 0; 
}

