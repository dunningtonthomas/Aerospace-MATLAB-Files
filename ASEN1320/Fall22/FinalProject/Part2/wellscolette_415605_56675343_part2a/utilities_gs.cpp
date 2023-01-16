#include <fstream> //including the fstream library
#include <cmath> //including the cmath library
#include <iostream>
using namespace std;//putting in the standard library


//creating a void UDF function
    void rotate(double gsArray[], int N, double angle) 
{
    //declaring variables
    const double pi = 3.141592653589793;

    
    //declaring ground station x and y positions
    double xg = (cos(angle * (pi / 180.0)) * gsArray[0]) - (sin(angle * (pi/180.0)) * gsArray[1]);
        
   double  yg = (sin(angle * (pi / 180.0)) * gsArray[0]) + (cos(angle* (pi / 180.0)) * gsArray[1]);
   
    double zg = 3673.747;
      
    gsArray [0] = xg; //setting gsArray variable to 0 to xg
    gsArray [1] = yg; //setting gsArray variable to 1 to yg
    gsArray [2] = zg; //setting gsArray variable to 2 to zg
    
    }


//creating a second UDF function
void write_csv( double GSposition[], int N, string filename) 
{
    ofstream outputStream; //output file stream and created the ne angleoutput file
    outputStream.open(filename);//create and open ne anglefile in directory

     
     for (int i = 0; i < (N); i++)//creating a for loop to outpue the 3 new angle location positions
    {
        outputStream << GSposition[i*3] << ", " << GSposition[(i*3) + 1] << "," << GSposition[(i*3) + 2] << endl; //the x,y, and z values of the before_rotation file
    
    }


    outputStream.close(); //closing the stream/file
}
