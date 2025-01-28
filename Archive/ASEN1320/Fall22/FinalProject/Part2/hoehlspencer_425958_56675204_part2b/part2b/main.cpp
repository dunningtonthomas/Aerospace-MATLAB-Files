  #include <iostream>
  #include <string>
  #include <fstream>
  #include "coord.h"
  
  
  using namespace std; 
  
  
  int main()
  {
   // Declares object array of size 1441 
     Coord Sat1[1441]; 
     Coord Sat2[1441]; 
     
     // Opens input streams and declares the files they are coming from, then defines 3 strings which each line must be separated into
      ifstream ground;
      ground.open("GSPosition.csv");
      string stringx, stringy, stringz; 
      
      ifstream sat1;
      sat1.open("Sat1Position.csv");
      string stringa, stringb, stringc; 
      
      ifstream sat2;
      sat2.open("Sat2Position.csv"); 
      string stringL, stringM, stringN; 
      
      
      //opens output files that data will be written into
      ofstream file1;
      file1.open("Sat1Visibility.csv");
      
      ofstream file2;
      file2.open("Sat2Visibility.csv");
      
    for(int i = 0; i < 1441; i++)
      {
       //takes data from each line in ground input stream and then separates it into 3 strings, and then turns those strings into doubles 
       getline(ground, stringx, ',');
       getline(ground, stringy, ','); 
       getline(ground, stringz); 
       double x = stod(stringx);
       double y = stod(stringy);
       double z = stod(stringz); 
       
     
    //takes data from each line in sat1 input stream and then separates it into 3 strings, and then turns those strings into doubles 
       getline(sat1, stringa, ',');
       getline(sat1, stringb, ','); 
       getline(sat1, stringc); 
       double a = stod(stringa);
       double b = stod(stringb);
       double c = stod(stringc); 
       
       
      
    
       //takes data from each line in sat2 input stream and then separates it into 3 strings, and then turns those strings into doubles 
       getline(sat2, stringL, ',');
       getline(sat2, stringM, ','); 
       getline(sat2, stringN); 
       double L = stod(stringL);
       double M = stod(stringM);
       double N = stod(stringN); 
       
      
     //calls setPoint function for the sat1 array and the sat2 array from coord.cpp which allows setFlag to use the values from the read in files 
      Sat1[i].setPoint(a, b, c, x, y, z);    
      Sat2[i].setPoint(L, M, N, x, y, z);
      
      
     //writes to file and outputs a boolean value in the Ith index of the sat1 and sat2 array that tells whether or not the respective satellite is in view of the ground station
      file1 << Sat1[i].setFlag() << endl;
      file2 << Sat2[i].setFlag() << endl;
      
     }
      
    return 0;   
  }
  
  