#include "utilities.h"

int main(){
    
    int t = 86400;// amount of minutes in day
    double w = 360.0/t; // omega value
    int arrsize = 3;//x y z
    double GStemp[4320]; // array that stores all of the location values
    double GS0[]={-2314.87, 4663.275, 3673.747}; //origin
    
    for (int i=0; i<=4320; i+=3){//1440 minutes in a day times 3 for each x y and z value
        double theta = w*((i/3)*60); // for every minute theta is revalued
        double temp[]={-2314.87, 4663.275, 3673.747}; //temporary holds new values
        rotate(temp,arrsize, theta);//calls rotate to shift location
        GStemp[i]=temp[0];// every 3 values will be an x value
        GStemp[i+1]=temp[1];// y values stored after x
        GStemp[i+2]=temp[2];// z after y
       
    }
    
    write_csv(GStemp,4320,"GSPosition.csv");//sorts the 1d array into csv file that is usable
    
    
    
    
}
