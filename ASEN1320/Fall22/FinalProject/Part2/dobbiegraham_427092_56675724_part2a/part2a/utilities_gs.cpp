#include "utilities.h"

// Write "rotate" fucntion that takes 1D array of type double of a certain length, and modifies values as instructed 
void rotate(double ws_data[], int data_length, double angle){
    
    double PI = 3.141592653589793;
    double theta = (angle * PI)/ 180.0; //Convert degrees to rads
    
    for(int i = 0; i < data_length; i += 3){
        
        // Get x, y pair from the weather station data
        double x = ws_data[i];
        double y = ws_data[i+1];
        
        // Calculate the rotated x, y pair from the current x and y
        double new_x = x*cos(theta) - y*sin(theta);
        double new_y = x*sin(theta) + y*cos(theta);
        
        // Update the weather station data with rotated cordiates
        ws_data[i] = new_x;
        ws_data[i+1] = new_y;
        
    }
    
    return;
    
}


// Write  "write_csv" function that writes out values stored in 1D array of type double of a certain lenth to cvs file as instructed 
void write_csv(double ws_data[], int data_length, std::string path){
    
    // Create a file object
    std::ofstream csv (path);
    
    for(int i = 0; i < data_length; i += 3){
        
        // Get cords form data
        double x = ws_data[i];
        double y = ws_data[i+1];
        double z = ws_data[i+2];
        
        // Write data to the csv file
        csv << x << ", " << y << ", " << z << "\n";
        
    }
    
    // Close the file
    csv.close();
    return;
    
}