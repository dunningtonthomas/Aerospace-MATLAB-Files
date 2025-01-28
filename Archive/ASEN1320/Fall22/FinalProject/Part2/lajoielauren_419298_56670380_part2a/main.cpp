#include "utilities.h" //including the header file

int main()
{
    //declaring the array size to be used for for loops and arrays
    int arraysize = 1441*3;
    
    //decalring the value of omega
    //both numbers have a .0 to make them doubles 
    double w = (360.0/86400.0);
    
    //declaring gssize to be used for arrays
    int gssize = 3;
    //declaring and initilizing gsinit array which contains the initial coordinates of the groundstation
    double gsinit[gssize] = {-2314.87, 4663.275, 3673.747};
    
    //declaring an array to store calculated coordinates in
    double position[arraysize];
    
    for (int i=0; i<(1441); i++)
    {
        //initilizing the array to have the values of the initial coordinates that will then be updates with the calculated coordinates
        double gsposition[gssize] = {gsinit[0], gsinit[1], gsinit[2]};
        
        double const PI = 3.141592653589793; //declaring PI as a constant
        
        double theta = (w*(60*i)*PI)/180; //calculating theta and converting it to radians
        
        //calling the rotate function
        //passing in gsposition array, the gssize and theta
        rotate(gsposition, gssize, theta); 
        
        //taking the calculated coordinates from rotate and storing them into the position array
        position[3*i] = gsposition[0];
        position[(3*i)+1] = gsposition[1];
        position[(3*i)+2] = gsposition[2];
        
    } 

    //calling write csv
    //passing in the position array, the array size and giving the file a name
    write_csv(position, arraysize, "GSPosition.csv");
    
    return 0;
}