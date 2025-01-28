//Libraries used. Did not include <string> as it is already included in utilities.h
#include "utilities.h"
#include <cmath>
#include <fstream>
#include <iostream>

using namespace std;

int main() {
    
    //Initialize initial values as well as GS and its array size
    int arrSize = (86400*3)/60 + 3;
    double GS[arrSize];
    GS[0] = -2314.87;
    GS[1] = 4663.275;
    GS[2] = 3673.747;
    double w = 360.0/86400.0;
    
    //Create two more arrays of size 4323
    int Time[arrSize];
    double angle[arrSize];
    
    //For loop will only run 1441 times as array size was divided by 3. This
    //ensures that the correct length arrays are generated for both Time and
    //angle.
    for(int i=0;i<=((arrSize/3) + 1);i++) {
    Time[i] = 60*i;
    angle[i] = (w * Time[i] * M_PI) / 180.0;
    }
    
    //Call custom rotate and write_csv functions. Rotate only runs once as the 
    //for loop is located inside of its function definition so all values are
    //generated from only one call.
    rotate(GS,arrSize,angle);
    write_csv(GS,arrSize,"GSPosition.csv");    

    return 0;
} 