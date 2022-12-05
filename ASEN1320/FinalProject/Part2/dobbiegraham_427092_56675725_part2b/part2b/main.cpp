#include "coord.h"
#include <iostream>
#include <fstream>
#include <string>

using namespace std;

// Init values
const int data_len = 1440;

// Blueprints
int readCSV( double x[], double y[], double z[], string path, int len);
void writeCSV(bool ws_data[], int rows, std::string path);


int main(){
    
    // Create data arrays
    double xs1[data_len], ys1[data_len], zs1[data_len], xs2[data_len], ys2[data_len], zs2[data_len], xg[data_len], yg[data_len], zg[data_len];
    
    // Read csv files and load in data
    readCSV(xs1, ys1, zg, "Sat1Position.csv", data_len);
    readCSV(xs2, ys2, zs2, "Sat2Position.csv", data_len);
    readCSV(xg, yg, zg, "GSPosition.csv", data_len);
    
    // Create cor arrays
    Coord sat1[data_len], sat2[data_len];
    
    // Create visability arrays
    bool sat1Vis[data_len] , sat2Vis[data_len];
    
    
    for(int i = 0; i < data_len; i++){ // Loop over ever timestep
        
        // Load data int the cord and set vis flag
        sat1[i].setPoint(xs1[i], ys1[i], zs1[i], xg[i], yg[i], zg[i]);
        sat1Vis[i] = sat1[i].setFlag();
        
        
        sat2[i].setPoint(xs2[i], ys2[i], zs2[i], xg[i], yg[i], zg[i]);
        sat2Vis[i] = sat2[i].setFlag();
        
    }
    
    // Write visability data to files
    writeCSV(sat1Vis, data_len, "Sat1Visibility.csv");
    writeCSV(sat2Vis, data_len, "Sat2Visibility.csv");
    
    return 0;
}


int readCSV( double x[], double y[], double z[], string path, int len){
    
    ifstream file(path);
    
    if(!file.is_open()){
        return -1;
        
    }
    
    string line;
    int i = 0;
    
    while(!file.eof()){
        
        getline(file, line);
        
        
        if(line.length() != 0){
            
            
            string segs[3];
            int numb_segs = 0;
            
            
            for(int j = 0; j < line.length(); j++){
                

                
                char c = line[j];
                
                if((c == ',') and (numb_segs < 3)){
                    
                    numb_segs++;
                    
                }else if(c != ' '){
                    segs[numb_segs] += c;
                }
            }
            
            
            if(i < len){
                x[i] = stod(segs[0]);
                y[i] = stod(segs[1]);
                z[i] = stod(segs[2]);
                
                // cout << x[i] << " " << y[i] << " " << z[i] << endl;
            
                i++;
            }else{
                return -1;
            }
        }
        
    }
    
    return i;
}

// Write  "write_csv" function that writes out values stored in 1D array of type double of a certain lenth to cvs file as instructed 

void writeCSV(bool ws_data[], int rows, std::string path){
    
    // Create a file object
    std::ofstream csv (path);
    
    for(int i = 0; i < rows; i += 1){
        
        // Get cords form data
        
        // Write data to the csv file
        // cout << ws_data[i] << endl;
        csv << ws_data[i] << "\n";
        
    }
    
    // Close the file
    csv.close();
    return;
    
}