#include"coord.h"//includes header file with class
#include<string>
#include<iostream>
#include<fstream>
using namespace std;

int main(){
    Coord sc1; //creates array of class type Coord
    Coord sc2;// creates array for other space craft
    
    ifstream sat1; // creates instance of ifstream for both sats and ground station
    ifstream sat2;
    ifstream gs;
    
    ofstream csv1 ("Sat1Visibility.csv"); // creates file to be edited 
    ofstream csv2 ("Sat2Visibility.csv"); //going to be used with setFlag

    gs.open("GSPosition.csv"); //opens the position csv files for satellites and ground station
    sat1.open("Sat1Position.csv");
    sat2.open("Sat2Position.csv");
    
    // getline needs string input
    string SXs1,SYs1,SZs1,SXs2,SYs2,SZs2,SXgs,SYgs,SZgs; 
    
    
    for(int i=0; i<1440; i++){ //runs for each minute of the day collecting data into the class and finding if it is visible
        //gets x y z value from csv file as string with ',' char delimeter
        getline(sat1, SXs1, ',');
        getline(sat1, SYs1, ',');
        getline(sat1, SZs1);
        // gets position value for sat 2
        getline(sat2, SXs2, ',');
        getline(sat2, SYs2, ',');
        getline(sat2, SZs2);
        // position for ground station
        getline(gs, SXgs, ',');
        getline(gs, SYgs, ',');
        getline(gs, SZgs);
        
        //converts the string variables to doubles to be passed through setpoint
        double Xs1 = stod(SXs1);
        double Ys1 = stod(SYs1);
        double Zs1 = stod(SZs1);
        
        double Xs2 = stod(SXs2);
        double Ys2 = stod(SYs2);
        double Zs2 = stod(SZs2);
        
        double Xgs = stod(SXgs);
        double Ygs = stod(SYgs);
        double Zgs = stod(SZgs);
        
        //assigns private variables at this time step to be used in the class in both instances 
        sc1.setPoint(Xs1,Ys1,Zs1,Xgs,Ygs,Zgs);
        sc2.setPoint(Xs2,Ys2,Zs2,Xgs,Ygs,Zgs);
        
      
        // prints true or false in each iteration for each minute of the day
        csv1 << sc1.setFlag()<<endl;
        csv2 << sc2.setFlag()<<endl;
        
        
    }
csv1.close();
csv2.close();
    
    
}