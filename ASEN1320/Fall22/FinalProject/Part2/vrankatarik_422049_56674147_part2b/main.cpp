#include <fstream>
#include <iostream>
#include <cmath>
#include "coord.h"

using namespace std;

int main() {
    
    Coord sat1[1440];   //declaring object arrays of class Coord
    Coord sat2[1440];   
    
    double coordsat1[1440][3];   //declaring 2d arrays to be filled by csv files
    double coordsat2[1440][3];
    double coordground[1440][3];
    bool bools1[1440];             //bool arrays to be filled with bool values (1 or 0)
    bool bools2[1440];
    
    string file = "Sat1Position.csv";  //setting file names
    string file1 = "Sat2Position.csv";
    string file2 = "GSPosition.csv";
    
    ifstream myInputFile;
    ifstream myInputFile1;     //creating and opening multiple streams
    ifstream myInputFile2;
    myInputFile.open(file);
    myInputFile1.open(file1);
    myInputFile2.open(file2);
    
    for(int i = 0; i < 1440; i++)     
    {
        for(int j = 0; j < 3; j++)    
        {
            
            myInputFile >> coordsat1[i][j];          //for loop that reads data from input files into empty 2d arrays
            myInputFile1 >> coordsat2[i][j];
            myInputFile2 >> coordground[i][j];
            
        }
        
    }
    
    myInputFile.close();     //closing files
    myInputFile1.close();
    myInputFile2.close();
    
    for(int i = 0; i < 1440; i++)
    {
        sat1[i].setPoint(coordsat1[i][0], coordsat1[i][1], coordsat1[i][2], coordsat1[i][3], coordsat1[i][4], coordsat1[i][5]);    //applying coordsat to 
        sat2[i].setPoint(coordsat2[i][0], coordsat2[i][1], coordsat2[i][2], coordsat2[i][3], coordsat2[i][4], coordsat2[i][5]);
    }
    
    for(int i = 0; i < 1440; i++)         //for loop iterating through each value of sat arrays and giving it a boolean value by running it through the setflag function
    {
        
        if (sat1[i].setFlag() == true){
            
            bools1[i] = 1;
            
        }
        else{
            
            bools1[i] = 0;
            
        }
        if (sat2[i].setFlag() == true){
            
            bools2[i] = 1;
        }
        else{
            
            bools2[i] = 0;
            
        }
            
    }
        
       
        
    
    
   string file3 = "Sat1Visibility.csv";   //declaring output file names
   string file4 = "Sat2Visibility.csv";
   
   ofstream outputfile;   //declaring streams
   ofstream outputfile1;
   
   outputfile.open(file3);  //opening files
   outputfile1.open(file4);
   
   for (int i=0; i < 1440; i++){       //prints boolean values to output csv
      
      outputfile << bools1[i] << "\n";
      outputfile1 << bools2[i] << "\n";
      
   }
   
   outputfile.close();  //closes files
   outputfile1.close();
   
   for (int i=0; i < 1440; i++){   //calls displayinfo function for testing
   sat1[i].displayInfo();
   sat2[i].displayInfo();
   }
}
