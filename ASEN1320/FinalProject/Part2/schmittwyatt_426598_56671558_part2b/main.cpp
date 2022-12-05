#include <iostream> //uses the iosream library
#include "coord.h" //uses the coord.h file
#include <cmath> //uses the cmath library
#include <string> //uses the string library
#include <fstream> //uses the fstream library

using namespace std; 


int main()
{
    double xsat1, ysat1, zsat1, xsat2, ysat2, zsat2, xgsat1, ygsat1, zgsat1; //declares double variables for 9 variables 
    string x,y,z; //declares a string variable for x y and z
    Coord coord1[1441]; //declares an array for coord1 of size 1441
    Coord coord2[1441]; //declares an array for coord2 of size 1441
    
    fstream GS("GSPosition.csv"); //declares an fstream variable GS which reads the file GSPosition.csv
    fstream Sat1("Sat1Position.csv"); //declares an fstream variable for Sat1 whcih reads the file Sat1Position.csv
    fstream Sat2("Sat2Position.csv"); //declares and fstream variable for Sat2 whcih read the file Sat2Position.csv
    
    ofstream s1v, s2v; //declares ofstream variables for s1v and s2v
    s1v.open("Sat1Visibility.csv"); //opens a file for s1v titled Sat1Visibility.csv
    s2v.open("Sat2Visibility.csv"); //opesn a file for s2v titled Sat2Visibility.csv
    
    for (int i; i<1441; i++) //starts a for loop that oes to 1441 and adds one each time 
    {
    getline(Sat1, x, ','); //using the Sat1 file it gets the x value and then stops at the comma
    getline(Sat1, y, ','); //using the Sat1 file it gets the y value and then stops at the comma
    getline(Sat1, z); //using the Sat1 file it gets the z value
    xsat1 = stod(x); //turns xsat1 into an integer
    ysat1 = stod(y); //turns ysat1 into an integer
    zsat1 = stod(z); //turns zsat1 into an integer
    
    getline(Sat2, x, ','); //using the Sat2 file it gets the x value and then stops at the comma
    getline(Sat2, y, ','); //using the Sat2 file it gets the y value and then stops at the comma
    getline(Sat2, z); //using the GS file it gets the x value
    xsat2 = stod(x); //turns xsat2 into an integer
    ysat2 = stod(y); //turns xsat2 into an integer
    zsat2 = stod(z); //turns xsat2 into an integer
    
    getline(GS, x, ','); //using the GS file it gets the x value and then stops at the comma
    getline(GS, y, ','); //using the GS file it gets the y value and then stops at the comma
    getline(GS, z); //using the GS file it gets the z value
    xgsat1 = stod(x); //turns xgsat into an integer
    ygsat1 = stod(y); //turns ygsat into an integer
    zgsat1 = stod(z); //turns yzsat into an integer
    
    
    coord1[i].setPoint(xsat1, ysat1, zsat1, xgsat1, ygsat1, zgsat1); //calls the setPoint function from coords to iterate every xyz 
    s1v << coord1[i].setFlag() << endl; //calls the setFlag function for s1v
    
    coord2[i].setPoint(xsat2, ysat2, zsat2, xgsat1, ygsat1, zgsat1); //calls the setPoint function from coords to iterate every xyz 
    s2v << coord2[i].setFlag() << endl; //calls the setFlag function for s1v
    
    }
    return 0;
}
