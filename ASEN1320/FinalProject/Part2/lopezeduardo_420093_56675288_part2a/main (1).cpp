#include "utilities.h"
#include "utilities_gs.cpp"
#include <iostream>
#include <fstream>

using namespace std;

int main()
{
    int num_stations = 1;
    
    double GS_Position[1441*3];
  
 for (int i=0; i< 1441; i++)  
{
    double GS[3] = {-2314.87, 4663.275, 3673.747};
    
    
    double w = 360/86400;
    double t = i * 60;
    double theta = w * t;
    
    rotate(GS, num_stations, theta); 
    
    GS_Position[3*i] = GS[0];
    GS_Position[3*i+1] = GS[1];
    GS_Position[3*i+2] = GS[2];
}




string filename = "GSPosition.csv";

write_csv(GS_Position, 1441*3, filename);

return 0;
}
