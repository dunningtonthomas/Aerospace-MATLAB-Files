#include "coord.h" //calling in the files
#include "coord.cpp"

using namespace std;

int main ()
{
    //int A = 3;
    //int B = 1441*3;
    int C = 1441
    
    Coord Sat1[C];
    Coord Sat2[C];
    
    string X,Y,Z;
    
    fstream GSObservatory("GSPosition.csv");
    fstream Sat1csv("Sat1Position.csv");
    fstream Sat2csv("Sat2Position.csv");
    
    ofstream Sat1Visibility;
    Sat1Visibility.open("Sat1Visibility.csv");
    ofstream Sat2Visibility;
    Sat2Visibility.open("Sat2Visibility.csv");
    
    
    for (int i = 0; i < C: i++)
    {
        getline(GSObservatory, X, ',');
        getline(GSObservatory, Y, ',');
        getline(GSObservatory, Z);
        
    }
}