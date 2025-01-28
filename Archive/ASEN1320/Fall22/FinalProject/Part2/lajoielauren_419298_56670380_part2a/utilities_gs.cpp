#include <fstream> //including fstream to output to another file
#include <cmath> //including cmath to use trig functions
#include "utilities.h" //including header file

using namespace std;

// Write "rotate" fucntion that takes 1D array of type double of a certain length, and modifies values as instructed  
void rotate (double a[], int size, double theta)
{
    //declaring temp variables to store calculated coordinates
    double Xg = 0;
    double Yg = 0;
    double Zg = 0;
    
    for (int i=0; i<(size); i++)
    {
        //storing the initial coordinates that were passed in from the main function
        double Xo = a[0];
        double Yo = a[1];
        double Zo = a[2];
        
        Xg = ((Xo*(cos(theta))) - (Yo*(sin(theta)))); //calculating new x coordinate
        Yg = ((Xo*(sin(theta))) + (Yo*(cos(theta)))); //calculatin new y coordinate
        Zg = Zo; //storing the z coordinate
    }

    for (int i=0; i<(size/3); i++) //the size is divided by 3 because they are indexed by being multiplied by 3
    //so to make sure it doesn't run too many times the size is divided by 3
    {
     //taking new x and y values and storing them into one array 
    a[(3*i)] = Xg;
    a[(3*i)+1] = Yg; 
    a[(3*i)+2] = Zg;   
    }
   }
   
   void write_csv (double a[], int size, string name)
{
    ofstream Outputstream; //using ofstream to output
    Outputstream.open(name); //opening the file
    
    if (Outputstream.fail()) //If the file has an error opening -> 
    {
            exit; //it ends the program
    }

    for (int i=0; i<(size/3); i++) //same size as rotate function
    {
       Outputstream << a[(3*i)] << ", " << a[(3*i)+1] << ", " << a[(3*i)+2] << endl; //outputting the x, y, z values 
    }
    Outputstream.close(); //closing the file
}