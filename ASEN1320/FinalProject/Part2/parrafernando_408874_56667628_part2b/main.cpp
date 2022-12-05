#include "coord.h"
#include "coord.cpp"

using namespace std;


/*============================================================================*/
// User Defined Function that will allow us to separate and store our numerical
// values from our csv files. 
void splitline(string split, string splitStore[])
{
  split += ',';
  int subsplit = 0;
  for (int i = 0; i < (int)split.length(); i++) 
  {
     if(split[i] == ',') 
     {
        subsplit++; 
     }
     else 
     {
         splitStore[subsplit] += split[i]; 
     }
  }
  return; 
}
/*============================================================================*/

int main() 
{
    // Size of Array is the amount of positions per satellite in agiven day. 
    int C = 1441;
    
    // Arrays for both Satellites using our Class Coord
    Coord Sat1[C];
    Coord Sat2[C];
    
    //Temporary values 
    string x, y, z;
    string line, store[A];
    
    // Opening our files to view the Goldstone Observatory, ISS, and Hubble
    // positions throughout a given day. 
    fstream GoldstoneObservatory("GSPosition.csv");
    fstream Sat1csv("Sat1Position.csv");
    fstream Sat2csv("Sat2Position.csv");
    
    // Creating two need files to identify when each satellite is visible from
    // the Goldstone Observatory on Earth. 
    ofstream Sat1Visibility;
    Sat1Visibility.open("Sat1Visibility.csv");
    ofstream Sat2Visibility;
    Sat2Visibility.open("Sat2Visibility.csv");
   
       for (int i = 0; i < C; i++) 
       {
        //getline(filename, string)   
        getline(GoldstoneObservatory, line);
        //splitline(string, array)
        splitline(line, store);
        // Store x, y, and z coordinates in our temporary array as strings. 
        x = store[0];
        y = store[1];
        z = store[2];  
        // Convert our strings (x, y, z) into numerical values. 
        double xg = stod(x);
        double yg = stod(y);
        double zg = stod(z); 
       // Reset our temporary array back to blank string. 
       store[0] = "";
       store[1] = "";
       store[2] = "";
       // Repeat this method for the following two files. 
       
        getline(Sat1csv,line);
        splitline(line,store);
        x = store[0];
        y = store[1];
        z = store[2];
        double xs1 = stod(x);
        double ys1 = stod(y);
        double zs1 = stod(z);
        store[0] = "";
        store[1] = "";
        store[2] = "";
       
        getline(Sat2csv,line);
        splitline(line,store);
        x = store[0];
        y = store[1];
        z = store[2];
        double xs2 = stod(x);
        double ys2 = stod(y);
        double zs2 = stod(z);
       
        store[0] = "";
        store[1] = "";
        store[2] = "";
       
       /* Use our Class Coord arrays for each satellite to set the points 
       retrieved from our csv files as private members in order to iterarte 
       our equations to view if each satellite is in visibility range.*/
       Sat1[i].setPoint(xs1, ys1, zs1, xg, yg, zg); // i) Set values to private 
       Sat1[i].displayInfo();                       // members. ii) Display the
       Sat1Visibility << Sat1[i].setFlag() << endl; // positions retrived.
                                                    // iii) Store a boolean 
       Sat2[i].setPoint(xs2, ys2, zs2, xg, yg, zg); // expression in the files
       Sat2[i].displayInfo();                       // created by using our Class
       Sat2[i].setFlag();                           // setFlag and identify if
       Sat2Visibility << Sat2[i].setFlag() << endl; // a satellite is in visibility
                                                    // range.
       }            
    // Close all files
    GoldstoneObservatory.close(); 
    Sat1csv.close();
    Sat2csv.close();
    Sat1Visibility.close();
    Sat2Visibility.close();
    
    return 0;
}