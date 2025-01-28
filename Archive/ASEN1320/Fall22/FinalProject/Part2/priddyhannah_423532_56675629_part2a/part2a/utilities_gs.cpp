#include "Head.h"

void rotategs(double points[], int L, double ang []) //rotate function declaration
{
    

    double gsinit[3] = {-2314.87, 4663.275, 3673.747};
    
    double tempx, tempy; //declaring temporary variables for the value swap
    double angle;
     
    for (int i = 0; i < L; i += 3) //for loop - iterated by 3 for sets of 3 point coords
    {
        
        
        if (i != 0)
        {
            angle = ang[(i+1)/3];
        }
        else
        {
            angle = ang[i];
            cout << angle << endl;
        }
        tempx = gsinit[0];
        tempy = gsinit[1]; //assigning to past values to manipulate
        
        points[i] = cos(angle) * tempx - sin(angle) * tempy;
        points[i+1] = cos(angle) * tempy + sin(angle) * tempx; //rotate function
        points[i+2] = gsinit[2];
    }



}

void write_csvgs(double points[], int L, string csv) //output to file
{
    ofstream csvout;
    csvout.open(csv); //initilizing an output csv file

    
    for( int i = 0; i<L; i+=3) //for loop, iteraint through the points array three at a time
    {
        
        csvout << points[i] << ","; //x value
        csvout << points[i + 1] << ",";//y value
        csvout << points[i + 2] << "\n";//z value
        
    }
    


    
    
}