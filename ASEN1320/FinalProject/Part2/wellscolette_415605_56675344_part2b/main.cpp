//listing out libraries
#include "coord.h"
#include <string>
#include <fstream>
#include <cmath>
#include <iostream>

using namespace std;

int main()
{
//creating string variable for the GetLine function  
string x, y, z;

//creating array of declaraed class
coord Sat1[1441];
coord Sat2[1441];

//streaming the gs position, sat1 position, and sat 2 positions into file.
fstream GsPos("GSPosition.csv");
fstream Sat1Pos("Sat1Position.csv");
fstream Sat2Pos("Sat2Position.csv");

//outputting and opening stream of a file for sat 1 visibility and sat 2 visibility

ofstream Sat1Vis;
Sat1Vis.open("Sat1Visibility.csv");

ofstream Sat2Vis;
Sat2Vis.open("Sat2Visibility.csv");


//creating for loop to itterate over the positions 
for (int i = 0 ; i < 1441; i++)
{
    
//using getline function to take the values from sat 1 position, store them into string x, y, and z, and stop after ','
getline(Sat1Pos, x, ',');
getline(Sat1Pos, y, ',');
getline(Sat1Pos, z);

//using stod to change the string x, y, aqnd z into double sat1_x, sat1_y, and sat1_z
double sat1_x = stod(x);
double sat1_y = stod(y);
double sat1_z = stod(z);

//using getline function to take the values from sat 2 position, store them into string x,y, and z, and stop after ','
getline(Sat2Pos, x, ',');
getline(Sat2Pos, y, ',');
getline(Sat2Pos, z);

//using stod to change the string x, y, aqnd z into double sat2_x, sat2_y, and sat2_z
double sat2_x = stod(x);
double sat2_y = stod(y);
double sat2_z = stod(z);

//using getline function to take the values from gs position, store them into string x,y, and z, and stop after ','
getline(GsPos, x, ',');
getline(GsPos, y, ',');
getline(GsPos, z);

//using stod to change the string x, y, aqnd z into double xg, yg, zgz
double xg = stod(x);
double yg = stod(y);
double zg = stod(z);

  
//setting the points/values for sat1[i] and showing whether or not they're visible  
Sat1[i].setPoint(sat1_x, sat1_y, sat1_z, xg, yg, zg);
Sat1[i].displayInfo();
Sat1Vis << Sat1[i].setFlag() << endl;

//setting the points/values for sat2[i] and showing whether or not they're visible  
Sat2[i].setPoint(sat2_x, sat2_y, sat2_z, xg, yg, zg);
Sat2[i].displayInfo();
Sat2Vis << Sat2[i].setFlag() << endl;


}


    return 0;

}
