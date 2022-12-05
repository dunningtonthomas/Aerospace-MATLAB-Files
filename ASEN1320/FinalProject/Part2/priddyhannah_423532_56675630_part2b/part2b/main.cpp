#include <iostream>
#include <string>
#include <fstream>
#include <cmath>
#include "coord.h"

using namespace std;

int main(){
    ifstream Sat1;
    ifstream Sat2;
    ifstream GS;
    ofstream Sat1Visibility;
    ofstream Sat2Visibility;
    
    Sat1.open("Sat1Position.csv");
    Sat2.open("Sat2Position.csv");
    GS.open("GSPosition.csv");
    Sat1Visibility.open("Sat1Visibility.csv");
    Sat2Visibility.open("Sat2Visibility.csv");
    
    // double sat1x, sat1y, sat1z, sat2x, sat2y, sat2z, gsx, gsy, gsz;
    string ssat1x, ssat1y, ssat1z, ssat2x, ssat2y, ssat2z, sgsx, sgsy, sgsz;
    
    for (int i = 0; i < 1440; i++)
    {
        getline(GS, sgsx, ',');
        getline(GS, sgsy, ',');
        getline(GS, sgsz);
        double gsx = stod(sgsx);
        double gsy = stod(sgsy);
        double gsz = stod(sgsz);
        
        getline(Sat1, ssat1x, ',');
        getline(Sat1, ssat1y, ',');
        getline(Sat1, ssat1z);
        double sat1x = stod(ssat1x);
        double sat1y = stod(ssat1y);
        double sat1z = stod(ssat1z);
        
        getline(Sat2, ssat2x, ',');
        getline(Sat2, ssat2y, ',');
        getline(Sat2, ssat2z, ',');
        double sat2x = stod(ssat2x);
        double sat2y = stod(ssat2y);
        double sat2z = stod(ssat2z);

        Coord sat1;
        
        sat1.setPoint(sat1x, sat1y, sat1z, gsx, gsy, gsz);
        bool a = sat1.setFlag();
        Sat1Visibility << a << "\n";
        
        Coord sat2;
        
        sat1.setPoint(sat2x, sat2y, sat2z, gsx, gsy, gsz);
        bool b = sat2.setFlag();
        Sat2Visibility << b << "\n";


    }
    
    
    return 0;
}