#include <iostream>
#include <fstream>
#include "utilities.h"              //include neccesary libraries and header files

using namespace std; 



int main(){
    
    //Declare variables and arrays 
    int size = 4323;  
    double a[size];
    int x = 0; 
    int n = 3; 
  
    // for loop iterating for the number of seconds in a day, jumping by 60 seconds for each minute in the day 
    for (int i = 0; i <= 86400; i+=60)
    {
        double init[n] = {-2314.87, 4663.275, 3673.747};            //declares initial ground station coordinates 
        double theta = (360.0/86400)*i;                             //setting up the value of a theta that updates with each iteration of for loop since angle of ground station to satellite changes with each minute 
        
        rotate(init, n, theta);     // calling rotate function with necessary inputs
       
       
       //Array with 1441 rows and each row is equal to the coordinates of the ground station at every single minute of the day, it is in for loop because each of the x,y,z coordinates updates to be the xyz of the init array during that for loop iteration
        a[x] = init[0];             
        a[x+1] = init[1]; 
        a[x+2] = init[2]; 
        x+=3;
        
        
       
    }
    
    
     write_csv(a, size, "GSPosition.csv");      //calling write CSV func to output data to a csv document 
    
    
    return 0; 
}

