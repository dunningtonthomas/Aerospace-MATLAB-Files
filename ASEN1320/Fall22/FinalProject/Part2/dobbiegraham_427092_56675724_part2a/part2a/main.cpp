#include "utilities.h"
#include <iostream>

using namespace std;

// Set initial variables
const double GS_init[] = {-2314.87 , 4663.275, 3673.747};
const double total_time = 86400;
const double anglular_speed_degrees = 360/total_time;


int main(){
    
    // Set length of position data
    const int data_len = (total_time/60) * 3;
    double GS[data_len];
    
    for(int t = 0; t < total_time; t += 60){ // Loop over overy time step
        
        // Create temp pos data
        double GS_temp[3] = {GS_init[0] , GS_init[1], GS_init[2]};
        
        // Calculate angle
        double theta_degrees = anglular_speed_degrees * t;
        
        // Rotate func
        rotate(GS_temp, 3, theta_degrees);
        
        
        // Convert t to index with i
        int i = (t/60)*3;
        
        // if(i < 20){
        //     cout << GS_temp[0] << " " << GS_temp[1] << " " << GS_temp[2] << " " << i << endl;
        // }
        
        // Copy in data to data array
        GS[i] = GS_temp[0];
        GS[i + 1] = GS_temp[1];
        GS[i + 2] = GS_temp[2];
    }
    
    // Write data to file
    write_csv(GS, data_len, "GSPosition.csv");
    
    return 0;
}