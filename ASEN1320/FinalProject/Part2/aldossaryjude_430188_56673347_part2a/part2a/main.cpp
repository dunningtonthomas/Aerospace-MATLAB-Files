#include "utilities.h"
#include <iostream>

int main() {
    
    int size = 4323;
    double array[size] = {-2314.87, 4663.275, 3673.747};
    double w = 360.0/86400.0;
    double t = 60.0;
    double deg = w*t;
    
    rotate(array, size, deg);
    write_csv(array, size, "Gs.csv");
    
    return 0;
}
