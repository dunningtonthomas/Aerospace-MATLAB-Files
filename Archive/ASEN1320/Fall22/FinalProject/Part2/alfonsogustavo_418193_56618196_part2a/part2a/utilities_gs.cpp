#include <fstream>
#include <cmath>
#include "utilities.h" // uses the headers in file
using namespace std;
// Write "rotate" fucntion that takes 1D array of type double of a certain length, and modifies values as instructed  
// Write  "write_csv" function that writes out values stored in 1D array of type double of a certain lenth to cvs file as instructed 

void rotate(double location[], int length, double angle){
 const double PI = 3.141592653589793; //constant variable for pi
    for(int i=0;i<length;i+=3){ //increments for every ground station 
    
       double xnew= cos(PI/180*angle)*location[i]-sin(PI/180*angle)*location[i+1]; // xvalue is every other one starting at index 0, trig functions need radian conversion
       double ynew= sin(PI/180*angle)*location[i]+cos(PI/180*angle)*location[i+1];  // yvalue is every other one starting at index 1, trig functions need radian conversion
       
       location[i]= xnew; // updates the array for x which is call to value
       location[i+1] = ynew; // updates the array for y which is call to value
       //no z value
    }
return;
}


void write_csv(double location[], int length, string filename){
    ofstream csv (filename); // sets a variable for output file
    for (int i=0;i<length; i+=3){  //increments for each position of ground station
        
       double x = location[i]; // every other index value starting at 0
       double y = location[i+1]; // every other index value starting at 1
       double z = location[i+2];// every other starting at 2
       
       csv << x << ", " << y << ", "<< z << endl; //prints new values in csv file
        
        
    }
    csv.close(); //closes the output file
    return;
}