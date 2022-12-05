#include "coord.h"
#include "coord.cpp"
using namespace std;

int main()
{
    
    int C = 1441;
    Coord Sat1[C];
    Coord Sat2[C];
    string x,y,z;
    
    fstream GolStObs("GSPosition.csv");
    fstream Sat1csv("Sat1Visibility.csv");
    fstream Sat2csv("Sat2Visibility.csv");
    
    //opening the sat1 file 
    ofstream Sat1Visibility;
    Sat1Visibility.open("Sat1Visibility.csv");
    
    //opening sat2 file
    ofstream Sat2Visibility;
    Sat2Visibility.open("Sat2Visibility.csv");
    
    for (int i=0; i<C; i++)
    {
        // for Rgs/ gold stone obvs
        getline(GolStObs,x);
        getline(GolStObs,y);
        getline(GolStObs,z);
        double xg = stod(x);
        double yg = stod(y);
        double zg = stod(z);
        
        //for Sat1
        getline(Sat1csv,x);
        getline(Sat1csv,y);
        getline(Sat1csv,z);
        double xSat1 = stod(x);
        double ySat1 = stod(y);
        double zSat1 = stod(z);
        
        //for 2
        getline(Sat2csv,x);
        getline(Sat2csv,y);
        getline(Sat2csv,z);
        double xSat2 = stod(x);
        double ySat2 = stod(y);
        double zSat2 = stod(z);
        
        Sat1[i].setPoint(xSat1,ySat1,zSat1,xg,yg,zg);
        Sat1[i].displayInfo();
        Sat1Visibility << Sat1[i].setFlag() << endl;
        
        Sat2[i].setPoint(xSat2,ySat2,zSat2,xg,yg,zg);
        Sat2[i].displayInfo();
        Sat2Visibility << Sat2[i].setFlag() << endl;
    }
    
    GolStObs.close();
    Sat1csv.close();
    Sat2csv.close();
    Sat1Visibility.close();
    Sat2Visibility.close();
}