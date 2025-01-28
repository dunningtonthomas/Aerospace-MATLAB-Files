#include "utilities.h"

int main()
{
    int size = 2;                               //declaring variables
    double w = (360.0 / 86400.0);
    double pos [1440][2];
    double input[2880];
    
    for(int i = 0; i<1440; i++)
    {
        double theta = i*60*w;                          //calculating theta every min
        double init [size] = {-2314.87, 4663.275};      //redeclaring initial perameters every loop
        
        rotate(init, size, theta);                      //calling rotate
        
        for(int y = 0; y<2; y++)                        //loop that assighns each iteration to a 2d position array
        {
            pos[i][y] = init[y];
        }
    }
    
    for(int i = 0, y = 0; i<2880; i+=2, y++)            //converting 2d array to 1d array for write function
    {
        input[i] = pos[y][0];
        input[i + 1] = pos[y][1];
    }
    
    write_csv(input, size, "GSPosition.csv");           //calling write function
    
    return 0;
}