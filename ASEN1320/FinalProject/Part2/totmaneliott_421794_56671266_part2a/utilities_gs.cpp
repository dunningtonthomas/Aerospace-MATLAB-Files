//Libraries used. Did not include <string> as it is already included in utilities.h
#include "utilities.h"
#include <cmath>
#include <fstream>
#include <iostream>

using namespace std;

//Function Definition for Rotate. beforeRotArray is not an entirely accurate name as the
//new values are imposed upon it and then returned.

void rotate(double beforeRotArray[], int size, double angle[]) {

    //Declare initial values for the rotation.
    double xBefore = beforeRotArray[0];
    double yBefore = beforeRotArray[1];
    double zBefore = beforeRotArray[2];

    //Rotation for() loop defines all other data points for GSLocation
    for(int i=0;i<=size;i+=3) {
        
        //The angle i value is divided by 3 because the size of i reaches 1441*3
        //and therefore needs to be divided by 3 as there are only 1441 rows.
        //The for() loop increments by 3 to accomodate this.
        double xAfter = cos(angle[i/3])*xBefore - sin(angle[i/3])*yBefore;
        double yAfter = sin(angle[i/3])*xBefore + cos(angle[i/3])*yBefore;
        double zAfter = zBefore;
        
        //Offset by +3, +4 and +5 because initial i value is 0, therefore the next
        //entries fill up spots 3, 4, and 5 as they should. Since i increments by
        //3 each loop, the next entries will be in slots 6, 7, and 8. And so on.
        beforeRotArray[i+3] = xAfter;
        beforeRotArray[i+4] = yAfter;
        beforeRotArray[i+5] = zAfter;
    }
}

//Function Definition for Rotate
void write_csv(double beforeRotArray[], int size, string filename) {
    
    //Fstream open outputstream to provided filename
    ofstream outputStream;
    outputStream.open(filename);
    
    //for() loop fills out GSPosition line by line, incrementing by 3 as variable size
    //is 1441*3 large, but we only want to run this 1441 times, with three pieces of 
    //data inserted on each loop.
    for(int i=3;i<=size;i+=3) {
        outputStream << beforeRotArray[i] << ", " << beforeRotArray[i+1] << ", " << beforeRotArray[i+2] << endl;
    }

    //Close outputStream to file
    outputStream.close();
    
}