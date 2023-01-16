#include <iostream> //reads in the iosream library
#include "utilities.h" //reads in the library utilities.h

using namespace std; //uses namespace 


int main()
{
    int totalSeconds = 86400; //defines and declares the total seconnds as 86400
    double pi = 3.141592653589793; //defines and decalers pi as a variable
    double omega = (360*(pi/180.0))/totalSeconds; //defines and declares omega 
    
    int arraySize = 4323; //defines and declares the array size as 4323 
    double GS[arraySize]; //declares the array GS of size 4323 (arraySize)
    
    // GS[0] = -2314.87; //sets the first value of GS 
    // GS[1] = 4663.275; //sets the second value of GS
    // GS[2] = 3673.747; //sets the third value of GS
    
    string file = "GSPosition.csv"; //sets the string file equal to the file GSPosition.csv
    
    rotate(GS, arraySize, omega); //calls the rotate function which takes in GS, arraySize, and omega
    write_csv(GS, arraySize, file); //calls the write_csv function which takes in GS, arraySize, and file
    
    return 0;
    
}

