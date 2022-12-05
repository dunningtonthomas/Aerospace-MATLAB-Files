#include <cmath>
#include <fstream>
#include <string>
#include "coord.h"

using namespace std;

int main()
{
    //Variable Declaration:
    int arraysize = 1441;
    ifstream Sat1;
    ifstream Sat2;
    ifstream Gs;
    ofstream SatVis1;
    ofstream SatVis2;
    string x;
    string y;
    string z;
    
    //Class declaration:
    Coord Sat1_position[arraysize];
    Coord Sat2_position[arraysize];
    
    //Opening files:
    Sat1.open("Sat1Position.csv");
    Sat2.open("Sat2Position.csv");
    Gs.open("Gs.csv");
    SatVis1.open("Sat1Visibility.csv");
    SatVis2.open("Sat2Visibility.csv");
    
    //Sat 1 & Sat 2 position for-loop
    for (int i=0; i<arraysize; i++)
    {
        // Reading in the csv for Ground Station
        getline(Gs, x, ',');
        getline(Gs, y, ',');
        getline(Gs, z);
        //Converting string to double
        double Gs_x, Gs_y, Gs_z;
        Gs_x = stod(x);
        Gs_y = stod(y);
        Gs_z = stod(z);
        
        
        
        //Reading in the csv for Ground Station
        getline(Sat1, x, ',');
        getline(Sat1, y, ',');
        getline(Sat1, z);
        //Converting string to double
        double Sat1_x, Sat1_y, Sat1_z;
        Sat1_x = stod(x); 
        Sat1_y = stod(y);
        Sat1_z = stod(z);
        //Implementing setPoint, setFlag functions for Sat 1 position.
        Sat1_position[i].setPoint(Sat1_x, Sat1_y, Sat1_z, Gs_x, Gs_y, Gs_z);
        SatVis1 << Sat1_position[i].setFlag() << endl;
        
        
        // Reading in the csv for Ground Station
        getline(Sat2, x, ',');
        getline(Sat2, y, ',');
        getline(Sat2, z);
        //Converting string to double
        double Sat2_x, Sat2_y, Sat2_z;
        Sat2_x = stod(x); 
        Sat2_y = stod(y);
        Sat2_z = stod(z);
        //Implementing setPoint, setFlag functions for Sat 1 position.
        Sat2_position[i].setPoint(Sat2_x, Sat2_y, Sat2_z, Gs_x, Gs_y, Gs_z);
        SatVis2 << Sat2_position[i].setFlag() << endl;
    }
    
    //Closing all files
    Sat1.close();
    Sat2.close();
    Gs.close();
    SatVis1.close();
    SatVis2.close();
    
    return 0;
}