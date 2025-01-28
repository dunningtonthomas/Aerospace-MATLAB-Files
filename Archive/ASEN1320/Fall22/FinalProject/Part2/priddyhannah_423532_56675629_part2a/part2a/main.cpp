#include "Head.h"

int main(){
    
    int len = 1440;
    double ang[1440]; //building the angle matrix
    // double gsinit[3] = {-2314.87, 4663.275, 3673.747};
    double points[4320];
  
    for(int i = 0; i < len; i++)
    {
        
        ang[i] = ((2 * 3.1415926535) / 86400) * i * 60; //finding angles with respect to time
    }
    
    rotategs(points, 4320, ang);
    write_csvgs(points, 4320, "GSPosition.csv"); //calling the utilities functions to assign values to GS coordinates and return them in a csv
    
    
    return 0;
}