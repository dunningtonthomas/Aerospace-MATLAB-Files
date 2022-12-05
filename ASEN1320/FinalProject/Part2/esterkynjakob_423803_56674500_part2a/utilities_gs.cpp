# include <fstream>
# include <iostream>
# include <cmath>
# include "utilities.h"
using namespace std;

void rotate(double gndcoords[], int arrSize, double theta){
    for (int i = 3; i<= arrSize; i+=3){
        gndcoords[i] = gndcoords[i-3]*cos(theta) - gndcoords[i-2]*sin(theta);
        gndcoords[i+1] = gndcoords[i-3]*sin(theta) + gndcoords[i-2]*cos(theta);
        gndcoords[i+2] = gndcoords[2];
    }
    
}

void write_csv(double gndcoords[], int arrSize, std::string fileName){
    ofstream outputFile;
    outputFile.open(fileName);
    
    //Gives error message if file does not open correctly
    if(!outputFile.is_open()){
        cout << "Failed to open the output_file.txt" << endl;
        exit(1);
    }
    
    for(int i=0; i<arrSize; i+=3){
        outputFile << gndcoords[i] << " " << gndcoords[i+1] << " " << gndcoords[i+2] << endl;
    }
    
    outputFile.close();
}