#include "coord.h"
#include "coord.cpp"

using namespace std;


int main()
{
    Coord Sat1Position[1441];
    
    Coord Sat2Position[1441];
    
    
    ifstream Sat1Positioncsv;
    Sat1Positioncsv.open("Sat1Position.csv");
    
    ifstream Sat2Positioncsv;
    Sat2Positioncsv.open("Sat2Position.csv");
    
    ifstream GSPositioncsv;
    GSPositioncsv.open("GSPosition.csv");
    
    
    ofstream Sat1Visibilitycsv;
    Sat1Visibilitycsv.open("Sat1Visibility.csv");
    
    ofstream Sat2Visibilitycsv;
    Sat2Visibilitycsv.open("Sat2Visibility.csv");
    
    
    
string stringX, stringY, stringZ;
      
for(int i=0; i<1441; i++)
    {
        getline(Sat1Positioncsv, stringX, ',' );
        getline(Sat1Positioncsv, stringY, ',' );
        getline(Sat1Positioncsv, stringZ, ',' );
        
        double Sat1x = stod(stringX);
        double Sat1x = stod(stringY);
        double Sat1x = stod(stringZ);
        
        
        getline(Sat2Positioncsv, stringX, ',' );
        getline(Sat2Positioncsv, stringY, ',' );
        getline(Sat2Positioncsv, stringZ, ',' );
        
        double Sat2x = stod(stringX);
        double Sat2y = stod(stringY);
        double Sat2z = stod(stringZ);
        
        
        getline(GSPositioncsv, stringX, ',');
        getline(GSPositioncsv, stringY, ',');
        getline(GSPositioncsv, stringZ, ',');
        
        double GSx = stod(stringX);
        double GSy = stod(stringY);
        double GSz = stod(stringZ);
        


Sat1Position[i].setPoint();

Sat1Position[i].displayInfo();

Sat1Visibilitycsv << Sat1Position[i].setFlag() << endl;



Sat2Position[i].setPoint();

Sat2Position[i].displayInfo();

Sat2Visibilitycsv << Sat2Position[i].setFlag() << endl;



    }
    
  Sat1Positioncsv.close();
  Sat1Positioncsv.close();
  GSPositioncsv.close();
  Sat1Visibilitycsv.close();
  Sat2Visibilitycsv.close();
  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    return 0;
}