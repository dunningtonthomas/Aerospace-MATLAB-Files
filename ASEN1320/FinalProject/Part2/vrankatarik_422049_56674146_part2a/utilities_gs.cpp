#include <fstream>
#include <cmath>
#include "utilities.h"  

using namespace std; 



void rotate(double position[], int size, double angledegree) //modified rotate function that iterates on itself 
{
   const double pi = 3.141592653589793;       //angle conversion
   double anglerad = angledegree * (pi/180);
   
   double tempx = position[0];          //creating temp variables for first 3 positions (x y z)
   double tempy = position[1];
   double tempz = position[2];
   
   
   for (int i=3; i<size; i += 3){  //increases by 3 to essentialy divide array into x y z
      
      position[i] = cos(anglerad) * tempx - sin(anglerad) * tempy;           //updates position of x 
      position[i+1] = sin(anglerad) * tempx + cos(anglerad) * tempy;         //updates position of y 
      position[i+2] = tempz;                                                 //updateds position of z
      
      tempx = position[i];       //updates temps so function iterates on itself
      tempy = position[i+1];
      
      
   }
   
}




void write_csv(double position[], int size, std::string file)
{
   
   ofstream outputfile;      //declares output file
   outputfile.open(file);
   
   for (int i=0; i<size; i += 3){
      
      
      outputfile << position[i] << ", " << position[i+1] << ", " << position[i+2] << "\n";   //prints rotated x y z vals to output file
      
   }
   
   outputfile.close();
  
   
}