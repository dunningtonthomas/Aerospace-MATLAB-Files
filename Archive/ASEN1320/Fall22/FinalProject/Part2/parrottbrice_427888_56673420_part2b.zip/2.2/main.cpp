#include <iostream>
//#include <ifstream>
#include <string>
#include "coord.h"
#include <fstream>
#include <cstdlib>

using namespace std; 

int main()
{
    coord sat1Coords[1441];
    coord sat2Coords[1441];
    coord gsCoords[1441];
    
    //read in csv's 
    ifstream file;
    file.open("Sat1Position.csv");
    
    double sat1Pos[4323];
    
    string tempString;
    
    for (int i=0;i<4323;i++)
    {
        getline(file, tempString, ',');
        sat1Pos[i]=stod(tempString);
        
        
    }
    
    file.close();
    
    //read in csv's 
    ifstream file2;
    file2.open("Sat2Position.csv");
    
    double sat2Pos[4323];
    
    string tempString2;
    
    for (int i=0;i<4323;i++)
    {
        getline(file2, tempString2, ',');
        sat2Pos[i]=stod(tempString2);
        
        
    }
    
    file2.close();
    
    //read in csv's 
    ifstream file3;
    file2.open("GSPosition.csv");
    
    double GSPos[4323];
    
    string tempString3;
    
    for (int i=0;i<4323;i++)
    {
        getline(file3, tempString3, ',');
        GSPos[i]=stod(tempString3);
        
        
    }
    
    file3.close();
    
    //use set point to fill coordinate variables of coord objects
    
    for (int i=0;i<4323;i+=3)
    {
        sat1Coords[i].setPoint(sat1Pos[i], sat1Pos[i+1], sat1Pos[i+2], GSPos[i], GSPos[i+1], GSPos[i+2]);
        sat2Coords[i].setPoint(sat2Pos[i], sat2Pos[i+1], sat2Pos[i+2], GSPos[i], GSPos[i+1], GSPos[i+2]);
        
    }
    
    for (int i=0;i<4323;i+=3)
    {
        sat1Coords[i].setFlag();
        sat2Coords[i].setFlag();
        
    }
    
    double sat1Visibility[1441];
    double sat2Visibility[1441];
    
  
    ofstream myOutputFile; 
    myOutputFile.open("Sat1.Visibility");
    
    ofstream myOutputFile2; 
    myOutputFile2.open("Sat2.Visibility");
    
    //iterate through array and execute statement block for every 2 values of i
    for(int i = 0;i<1441;i++)
    {
        //print values stored at locations i and location i+1, which corresponds to each pair of coordinates
        myOutputFile << i << ", " << sat1Coords[i].getFlagPoint() <<  endl;
        myOutputFile2 << i << ", " << sat2Coords[i].getFlagPoint() <<  endl;
    }

    
    
    return 0; 
}