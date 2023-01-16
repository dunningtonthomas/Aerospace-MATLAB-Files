#include "utilities.h"  //include utilities header file

using namespace std;

int main(){
    
    double p = 60.0;               //creating correct theta angle
    double w = 360.0/86400.0;
    double theta = w * p;
    
    int coords = 3 * (86400.0/60.0);   //x y and z for timesteps of 60 seconds
    double position[coords];
    position[0] = -2314.87;            //initial observatory positions
    position[1] = 4663.275;
    position[2] = 3673.747;
    
    rotate(position, coords, theta);  //calling rotate and csv functions
    
    write_csv(position, coords, "GSPosition.csv");
    
    
}