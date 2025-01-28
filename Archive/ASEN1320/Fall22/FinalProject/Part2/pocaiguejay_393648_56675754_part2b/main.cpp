#include "coord.h"
#include <fstream>
#include <string>

using namespace std;

int main()
{
    std::string data;
    double GSx, GSy, GSz;
    double Sat1x, Sat1y, Sat1z;
    double Sat2x, Sat2y, Sat2z;
    
    int arrSize = 1441;                             // Matched to Total Time Points to Ground Station
    double Sat1coord[arrSize], Sat2coord[arrSize];                      
    
    // Read in .csv Files
    ifstream Sat1, Sat2, GS;
    Sat1.open("Sat1Position.csv");
    Sat2.open("Sat2Position.csv");
    GS.open("GSPosition.csv");
    
    // Set Ground and Satellite Values
    //Spacecraft (Object 2)

    
    // Set a value of the IV for each obj
    // Visibility Flag (IV) Variable Spacecraft (Object 1)
    // Visibility Flag (IV) Variable Spacecraft (Object 2)
    
    // Export to Sat1Visibility.csv and Sat2Visibility.csv
    ofstream Export1, Export2;
    Export1.open("Sat1Visibility.csv");
    Export2.open("Sat2Visibility.csv");
    
    for(int i = 0; i <= arrSize; i++)
    {
        getline(GS, data, ',');
        GSx = stod(data);
        
        getline(GS, data, ',');
        GSy = stod(data);
        
        getline(GS, data);
        GSz = stod(data);
        
        getline(Sat1, data, ',');
        Sat1x = stod(data);
        
        getline(Sat1, data, ',');
        Sat1y = stod(data);
        
        getline(Sat1, data);
        Sat1z = stod(data);
        
        Coord Sat1;
        Sat1.setPoint(Sat1x, Sat1y, Sat1z, GSx, GSy, GSz);
        Export1 << Sat1.setFlag() << endl;

        
        getline(Sat2, data, ',');
        Sat2x = stod(data);
        
        getline(Sat2, data, ',');
        Sat2y = stod(data);
        
        getline(Sat2, data);
        Sat2z = stod(data);
        
        Coord Sat2;
        Sat2.setPoint(Sat2x, Sat2y, Sat2z, GSx, GSy, GSz);
        Export2 << Sat2.setFlag() << endl;

    }
    
    
    
    
    Export1.close();
    Export2.close();
    Sat1.close();
    Sat2.close();
    GS.close();
    return 0;
}