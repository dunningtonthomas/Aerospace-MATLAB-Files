#include <iostream>
#include <fstream>
#include <cmath>
#include "coord.h"

// g++ -o COORD main.cpp coord.cpp , ./COORD to run this

using namespace std;

int main(){
    
    const double PI = 3.141592653589793;
    
    // Opens the files
    fstream inputStreamSat1;
    fstream inputStreamSat2;
    fstream inputStreamGS;
    inputStreamSat1.open("Sat1Position.csv");
    inputStreamSat2.open("Sat2Position.csv");
    inputStreamGS.open("GSPosition.csv");
    
    int array_Size = 1441; 
    // Creates arrays for Sat 1, 2, and GS
    double Sat1Array[array_Size][3];
    double Sat2Array[array_Size][3];
    double GSArray[array_Size][3];
    double Sat1RadiusArray[array_Size];
    // Variables used ina for loop to set equal to array (read in csv)
    string tempvarX;
    string tempvarY;
    string tempvarZ;
    string tempvarA;
    string tempvarB;
    string tempvarC;
    
    Coord Sat1[array_Size];
    Coord Sat2[array_Size];
     
     
    ofstream outputStream; // opens the output stream
    outputStream.open("Sat1Visibility.csv"); // creates the file name called output as a csv file 
    ofstream outputStream2; // opens the output stream
    outputStream2.open("Sat2Visibility.csv"); // creates the file name called output as a csv file
    
    for (int i=0; i<array_Size; i++)
    {
        // SATTELITE 1 X,Y,Z
        getline(inputStreamSat1, tempvarX, ',');
        getline(inputStreamSat1, tempvarY, ',');
        getline(inputStreamSat1, tempvarZ);

        Sat1Array[i][0] = stod(tempvarX);
        Sat1Array[i][1] = stod(tempvarY);
        Sat1Array[i][2] = stod(tempvarZ);
        // GROUND STATION X,Y,Z
        getline(inputStreamGS, tempvarX, ',');
        getline(inputStreamGS, tempvarY, ',');
        getline(inputStreamGS, tempvarZ);

        GSArray[i][0] = stod(tempvarX);
        GSArray[i][1] = stod(tempvarY);
        GSArray[i][2] = stod(tempvarZ);
        
        Sat1[i].setPoint(Sat1Array[i][0], Sat1Array[i][1], Sat1Array[i][2], GSArray[i][0], GSArray[i][1], GSArray[i][2]);
        
        Sat1[i].setFlag();
        
        //cout << "Flag: " << Sat1[i].getFlag() << ", X1: " << Sat1Array[0][0] << ", Y1: " << Sat1Array[0][1] << ", Z1: " << Sat1Array[0][2] << endl;
        
        //ofstream outputStream; // opens the output stream
        //outputStream.open("Sat1Visibility.csv"); // creates the file name called output as a csv file
        outputStream << Sat1[i].getFlag() << endl;
        
       
        // SATTELITE 2 X,Y,Z (AFTER SAT1 FLAG IS EXPORTED)
        getline(inputStreamSat2, tempvarA, ',');
        getline(inputStreamSat2, tempvarB, ',');
        getline(inputStreamSat2, tempvarC);

        Sat2Array[i][0] = stod(tempvarA);
        Sat2Array[i][1] = stod(tempvarB);
        Sat2Array[i][2] = stod(tempvarC);
        
        Sat2[i].setPoint(Sat2Array[i][0], Sat2Array[i][1], Sat2Array[i][2], GSArray[i][0], GSArray[i][1], GSArray[i][2]);
        
        Sat2[i].setFlag();
        
       //ofstream outputStream2; // opens the output stream
        //outputStream2.open("Sat2Visibility.csv"); // creates the file name called output as a csv file
        outputStream2 << Sat2[i].getFlag() << endl;
        
   
    }
    inputStreamSat1.close();
    
    inputStreamSat2.close();
    
    inputStreamGS.close();
    
    return 0;
}
