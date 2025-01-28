#include <iostream>
#include <cmath>
#include <string>
#include <fstream>
#include "coord.h"

using namespace std;

int main()
{
    Coord coord1[1441];
    Coord coord2[1441];
    
    //double initposition[3] = {x0, y0, z0};
    
    
    ofstream Sat1Visibility;
    ofstream Sat2Visibility;
    
    Sat1Visibility.open("Sat1Visibility.csv");
    Sat2Visibility.open("Sat2Visibility.csv")
    
    fstream Sat1Position("Sat1Position.csv");
    fstream Sat2Position("Sat2Posiiton.csv");
    //fstream GS("GSPosition.csv");
    
    string x0, y0, z0;

for (int i=0; i<1441; i++)
{
    
 getline(Sat1Position, x0, ',');
 getline(Sat1Position, y0, ','); 
 getline(Sat1Position, z0);
 
 double xs1 = stod(x0);
 double ys1 = stod(y0);
 double zs1 = stod(z0);
 
 getline(Sat2Position, x0, ',');
 getline(Sat2Position, y0, ','); 
 getline(Sat2Position, z0);
 
 double xs2 = stod(x0);
 double ys2 = stod(y0);
 double zs2 = stod(z0);
 
 getline(GS, x0, ',');
 getline(GS, y0, ',');
 getline(GS, z0);
 
 double xg1 = stod(x0);
 double yg1 = stod(y0);
 double zg1 = stod(z0);
 
 coord1[i].setPoint(xs1, ys1, zs1, xg1, yg1, zg1);
 coord1[i].displayInfo();
 Sat1Visibility << coord1[i].setFlag() << endl;
 
 coord2[i].setPoint(xs2, ys2, zs2, xg1, yg1, zg1);
 coord2[i].displayInfo();
 Sat2Visibility << coord2[i].setFlag() << endl;
 
}
 
 //write_csv(Sat1Visibility, 0, "Sat1Visibility.csv");
 //write_csv
 
//(Sat2Visibility, 0, "Sat2Visibility.csv");
 
 return 0;
    
}