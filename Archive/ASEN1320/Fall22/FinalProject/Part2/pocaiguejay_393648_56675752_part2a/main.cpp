#include "utilities.h"
// To compile "g++ -o Run main.cpp hw6.cpp -lstdc++"
// To run "./Run" 
int main()
{
    int arrSize = 4323;
    double Xo = -2314.87;
    double Yo = 4663.275;
    double Zo = 3673.747;
    double arr[arrSize] = {Xo, Yo, Zo};
    
    double w = (360.0/86400.0);
  
    rotate(arr, arrSize, w); 
    write_csv(arr, arrSize, "GSPosition.csv"); 

    return 0;
}
