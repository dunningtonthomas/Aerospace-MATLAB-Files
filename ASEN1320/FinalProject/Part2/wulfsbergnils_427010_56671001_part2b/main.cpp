#include <iostream>
#include "coord.h"
#include <fstream>
#include <string>
#include <sstream>

using namespace std;

int main()
{
    
    Coord S1pos[1440];                          //initializing object arrays 
    Coord S2pos[1440];
    bool S1Viz[1440];                           //initializing boolean arrays
    bool S2Viz[1440];
    
    ifstream inputS1;                           //creating ifstream objects                              
    ifstream inputS2; 
    ifstream inputG;
    
    double a, b, c, d, e, f;                        //cerating temp variables
    string xs, ys, zs, xg, yg, zg, line, lineG;
    double temp1[1440][3], temp2[1440][3];
    int count = 0;                                  //increment variable 
    
    inputS1.open("Sat1Position.csv");               //opening csv files
    inputS2.open("Sat2Position.csv");
    inputG.open("GSPosition.csv");
    
    while(getline(inputS1, line))           //while loop that uses getline to grab each line of sat1 csv and store in string "line"
    {
        stringstream s1(line);              //creating stringstream object
        getline(s1, xs, ',');               //using getline to store each value in a temp string before stoping at comma and moving on
        a = stod(xs);                       //using stod to convert string to double and store in temp variable
        getline(s1, ys, ',');
        b = stod(ys);
        getline(s1, zs, ',');
        c = stod(zs);
    
        temp1[count][0] = a;                //storing temp doubles in temp array with each cycle
        temp1[count][1] = b;
        temp1[count][2] = c;
        count = count + 1;                  //incrementing counter
    }
    
    count = 0;                              //resetting counter
    
    while(getline(inputG, lineG))           //repeating process with GSP csv
    {
        stringstream sg1(lineG);
        getline(sg1, xg, ',');
        d = stod(xg);
        getline(sg1, yg, ',');
        e = stod(yg);
        getline(sg1, zg, ',');
        f = stod(zg);
        
        temp2[count][0] = d;
        temp2[count][1] = e;
        temp2[count][2] = f;
        count = count + 1;
    }
    
    for(int i = 0; i<1440; i++)             //storing sat1 and GSP values into object array
    {
        a = temp1[i][0];
        b = temp1[i][1];
        c = temp1[i][2];
        d = temp2[i][0];
        e = temp2[i][1];
        f = temp2[i][2];
        
        S1pos[i].setPoint(a,b,c,d,e,f);
        
    }
    
    count = 0;                              //resetting counter
    
    while(getline(inputS2, line))           //storing values from sat2 csv into temp array
    {
        stringstream s2(line);
        getline(s2, xs, ',');
        a = stod(xs);
        getline(s2, ys, ',');
        b = stod(ys);
        getline(s2, zs, ',');
        c = stod(zs);
    
        temp1[count][0] = a;
        temp1[count][1] = b;
        temp1[count][2] = c;
        count = count + 1;
    }
    
    for(int i = 0; i<1440; i++)             //storing sat2 and GSP into object array
    {
        a = temp1[i][0];
        b = temp1[i][1];
        c = temp1[i][2];
        d = temp2[i][0];
        e = temp2[i][1];
        f = temp2[i][2];
        
        S2pos[i].setPoint(a,b,c,d,e,f);
        
    }
    
    for(int i = 0; i<1440; i++)             //using setFlag and storing results in boolean array
    {
        S1Viz[i] = S1pos[i].setFlag();
        S2Viz[i] = S2pos[i].setFlag();
    }
    
    inputS1.close();                        //closing inputs
    inputS2.close();
    inputG.close();
    
    ofstream wri1;                          //creating ofstream objects
    ofstream wri2;
    
    wri1.open("Sat1Visibility.csv");        //creating new files to write to
    wri2.open("Sat2Visibility.csv");
    
    for(int i = 0; i<1440; i++)             //writing to new files
    {
        wri1 << S1Viz[i] << endl;
        wri2 << S2Viz[i] << endl;
    }
    
    wri1.close();                           //closing files
    wri2.close();
    
    return 0;
}