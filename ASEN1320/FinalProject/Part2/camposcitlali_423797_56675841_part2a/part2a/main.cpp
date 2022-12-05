#include "utilities.h"
#include "utilities_gs.cpp"

int main()
{
    //declaring variables 
    double w = 360.0 / 86400.0;
    double X0 = -2314.87;
    double Y0 = 4663.257;
    double Z0 = 3673.747;
    int coordSize = 1441 * 3;   //N
    int position = 3;           //M
    double GSPosition[coordSize];
    
    for (int i=0; i<1441; i++)
    {
        double t = i*60;
        double theta = w*t;
        double GroundSt[position] = {X0, Y0, Z0};
        
        rotate(GSPosition, position, theta);
        
        GSPosition[i*3] = GroundSt[0];
        GSPosition[(i*3)+1] = GroundSt[1];
        GSPosition[(i*3)+2] = GroundSt[2];
    }
    
    write_csv(GSPosition, coordSize, "GSPosition.csv");
    
return 0;    
}