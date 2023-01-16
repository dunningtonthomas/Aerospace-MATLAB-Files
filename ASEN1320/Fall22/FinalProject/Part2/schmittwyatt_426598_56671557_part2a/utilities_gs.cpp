#include <fstream> //uses the fstream library
#include <cmath> //uses the cmath library
#include "utilities.h" //calls the utilities.h file
using namespace std; //uses namespace


void rotate(double coordinates[], int arraySize, double omega){ //declares void as a udf and calls for a double integer and double 
    
    double PI = 3.141592653589793; //declares and defines pi
    double Time; //declares a double variable time
    
    
    for(int i=0; i < arraySize; i+=3){ //declares a for loop to store x and y data
        
        double thetaRad = omega*Time; //declares a double variable thetarad which multiplies omega and time
        coordinates[0] = -2314.87; //declares the first coordinate in the coordinate array which will be the first x value
        coordinates[1] = 4663.275; //decalres the second coordinate in the coordniate array which will be the first y value
        coordinates[2] = 3673.747; //declares the second coordinate in the coordinate array which will be the first z value
        double tempx;  //declares a temporary variable for x
        tempx = coordinates[0];  //defines the temperorary variable for x as equal to the first value of the coordinates array
     
        double tempy; //declares a temporary variable for y 
        tempy = coordinates[1];  //defines the temporary variable for y as equal to coordinates array of the first value
        
        double tempz = coordinates[2]; //declares a temporary variable for z and sets it equal to the second coordinate point
        
        coordinates[i] = cos(thetaRad)*tempx - tempy*sin(thetaRad);  //defines the coordinate array for x values with the equation
        
        coordinates[i+1] = sin(thetaRad)*tempx + cos(thetaRad)*tempy;  //defines the coordinate array for y values with the equation
        
        coordinates[i+2] = tempz; //defines coordinates for i+2 equal to the temprary variable for z
        
        Time= Time + 60.0; //iterates time so that it increases by an hour or 60 minutes each time.
    }
}

void write_csv(double groundStations[], int arraySize, string file){ //declares another void udf as write_csv as variables for a double integer and string
    
    ofstream outputfile; //allows you to put your output in a different file
    outputfile.open(file); //opens the new file and calls for the file
    
    for(int i=0; i < arraySize; i+=3){ //runs a for loop in order to output to the file the x and y coordinates
        
        outputfile << groundStations[i] << "," << groundStations[i+1] << "," << groundStations[i+2] << endl; //prints to the file the positions of the coordinates in the order of x,y,z
    }
    
    outputfile.close(); //closes the output file 
}
