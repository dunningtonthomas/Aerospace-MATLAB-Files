//Libraries used
#include "coord.h"
#include <fstream>
#include <iostream>

using namespace std;

int main() {

//Initialize two objects within the Coord class imported from the .h file
Coord Sat1Coord[1441];
Coord Sat2Coord[1441];

//Create and open five data streams - 3 to read data in, and two to send data to.
ifstream inputStream1;      //Sat1Position
ifstream inputStream2;      //Sat2Position
ifstream inputStream3;      //GSPosition
ofstream outputStream1;     //Sat1Visibility
ofstream outputStream2;     //Sat2Visibility

inputStream1.open("Sat1Position.csv");
inputStream2.open("Sat2Position.csv");
inputStream3.open("GSPosition.csv");
outputStream1.open("Sat1Visibility.csv");
outputStream2.open("Sat2Visibility.csv");

//Define three matrices that will hold X, Y, and Z position for both sats and the
//ground station.
double Sat1Data[1441][3];
double Sat2Data[1441][3];
double GSPositionData[1441][3];

//Define comma to be used in inputStream
char comma;

//For loop reads in data from satellites and outputs data to visibility csv files using four steps.
for(int i = 0;i<1441;i++) {
    
    //STEP 1: InputStream reads in location data and loads it into matrices so that data can be manipulated.
    inputStream1 >> Sat1Data[i][0] >> comma >> Sat1Data[i][1] >> comma >> Sat1Data[i][2];
    inputStream2 >> Sat2Data[i][0] >> comma >> Sat2Data[i][1] >> comma >> Sat2Data[i][2];
    inputStream3 >> GSPositionData[i][0] >> comma >> GSPositionData[i][1] >> comma >> GSPositionData[i][2];
    
    //STEP 2: Points are assigned into Sat1Coord objects using the setPoint method defined in coord.cpp.
    Sat1Coord[i].setPoint(Sat1Data[i][0], Sat1Data[i][1], Sat1Data[i][2], GSPositionData[i][0], GSPositionData[i][1], GSPositionData[i][2]);
    Sat2Coord[i].setPoint(Sat2Data[i][0], Sat2Data[i][1], Sat2Data[i][2], GSPositionData[i][0], GSPositionData[i][1], GSPositionData[i][2]);
    
    
    //STEP 3: Boolean variables are set to true or false for each of the 1441 locations depending on
    //whether they have access to the station. This is confirmed using the phi method in coord.cpp.
    //In range returns a 1 value for that moment in time, out of range returns 0.
    bool visible1 = Sat1Coord[i].setFlag();
    bool visible2 = Sat2Coord[i].setFlag();
    
    
    //STEP 4: If setFlag returned true value for entry i, the data is stored in the corresponding
    //csv file. If it was out of range, the if statement skips over it and goes to the next i value.
    if(visible1 == true) {
        outputStream1 << Sat1Data[i][0] << "," << Sat1Data[i][1] << "," << Sat1Data[i][2] << endl;
    } 
    if(visible2 == true) {
        outputStream2 << Sat2Data[i][0] << "," << Sat2Data[i][1] << "," << Sat2Data[i][2] << endl;
    } 
 }

//Close all file streams
inputStream1.close();
inputStream2.close();
inputStream3.close();
outputStream1.close();
outputStream2.close();

return 0;
}