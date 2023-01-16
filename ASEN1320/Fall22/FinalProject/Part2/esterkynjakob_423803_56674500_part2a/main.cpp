#include <iostream>
#include "utilities.h"
using namespace std;

int main(){
    int arrSize = 3*86400/60+3;
    double gndcoords[arrSize];
    gndcoords[0] = -2314.87;
    gndcoords[1] = 4663.275;
    gndcoords[2] = 3673.747;
    const double pi = 3.141592653589793;
    double omega = (2*pi)/86400;
    double theta = omega*60;
    string filename = "GSPosition.csv";
    rotate(gndcoords, arrSize, theta);
    write_csv(gndcoords, arrSize, filename);
    
    
}