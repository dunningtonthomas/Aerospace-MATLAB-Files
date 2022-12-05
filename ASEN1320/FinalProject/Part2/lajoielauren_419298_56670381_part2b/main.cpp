#include "Coord.h"

int main()
{
    //declaring size to be used for arrays and forloops
    int size = 1440;
    
    //declaring string variables to store the values inputted from the files in get line
    string sat1X;
    string sat1Y;
    string sat1Z;
    string sat2X;
    string sat2Y;
    string sat2Z;
    string gsX;
    string gsY;
    string gsZ;
    
    //declaring arrays to store the values stored in the string variables and then converted to doubles
    double Xs1[size];
    double Ys1[size];
    double Zs1[size];
    double Xs2[size];
    double Ys2[size];
    double Zs2[size];
    double Xg[size];
    double Yg[size];
    double Zg[size];
    
    
    bool flagPoint;
    
    //declaring string variables and intializing them with the names of the files to be inputted
    //and declaring fstream to input files
    string Sat1file = "Sat1Position.csv";
    fstream input1;
    string Sat2file = "Sat2Position.csv";
    fstream input2;
    string GSfile = "GSPosition.csv";
    fstream inputGS;
    
    //declaring arrays 
    int Sat1Visibility[size];
    int Sat2Visibility[size];
    double Sat1coordinates[size];
    double Sat2coordinates[size];
    double GScoordinates[size];
    
    //declaring class objects
    Coord Sat1[size];
    Coord Sat2[size];
    
    //opening 1st file
    input1.open(Sat1file);
    if (input1.fail()) //If the file has an error opening -> 
        {
            cerr << "Error opening input file <" << Sat1file << ">" << endl; //it prints out an error message
            return 1; //and end the program
        }
    
    //opening 2nd file    
    input2.open(Sat2file);
    if (input2.fail()) //If the file has an error opening -> 
        {
            cerr << "Error opening input file <" << Sat2file << ">" << endl; //it prints out an error message
            return 1; //and end the program
        }
    
    //opening 3rd file   
    inputGS.open(GSfile);
        if (inputGS.fail()) //If the file has an error opening -> 
            {
                cerr << "Error opening input file <" << GSfile << ">" << endl; //it prints out an error message
                return 1; //and end the program
            }
        
    
    for (int i=0; i<size; i++)
    {
        //using get line to read the values into string variables
        //will move to the next variable when it hits a comma
        getline(input1, sat1X, ',');
        getline(input1, sat1Y, ',');
        getline(input1, sat1Z); //at the end it doesn't look for a comma
        
        //storing the string converted into a double into a temp variable
        double a = stod(sat1X);
        double b = stod(sat1Y);
        double c = stod(sat1Z);
        
        //storing the temp variables into the arrays
        Xs1[i] = a;
        Ys1[i] = b;
        Zs1[i] = c;
        
    }
    
    for (int i=0; i<size; i++)
    {
        //using get line to read the values into string variables
        //will move to the next variable when it hits a comma
        getline(inputGS, gsX, ',');
        getline(inputGS, gsY, ',');
        getline(inputGS, gsZ);

        //storing the string converted into a double into a temp variable
        double d = stod(gsX);
        double e = stod(gsY);
        double f = stod(gsZ);
        
        //storing the temp variables into the arrays
        Xg[i] = d;
        Yg[i] = e;
        Zg[i] = f;
        
    }
    
    for (int i=0; i<size; i++)
    {
        //using get line to read the values into string variables
        //will move to the next variable when it hits a comma
        getline(input2, sat2X, ',');
        getline(input2, sat2Y, ',');
        getline(input2, sat2Z);
        
        //storing the string converted into a double into a temp variable
        double g = stod(sat2X);
        double h = stod(sat2Y);
        double j = stod(sat2Z);
        
        //storing the temp variables into the arrays
        Xs2[i] = g;
        Ys2[i] = h;
        Zs2[i] = j;
    }
    
    //declaring fstreams to use for outputs
    fstream Sat1output;
    fstream Sat2output;
    
    //opening the output files
    Sat1output.open("Sat1Visibility.csv");
    Sat2output.open("Sat2Visibility.csv");
    
    for (int i=0; i<size; i++)
    {
        //calling setPoint for both Sat1 and Sat2
        Sat1[i].setPoint(Xs1[i], Ys1[i], Zs1[i], Xg[i], Yg[i], Zg[i]);
        Sat2[i].setPoint(Xs2[i], Ys2[i], Zs2[i], Xg[i], Yg[i], Zg[i]);
        
        //calling and outputting setFlag for sat1 and sat2
        Sat1output << Sat1[i].setFlag() << endl;
        Sat2output << Sat2[i].setFlag() << endl;
     
    }
    
    //closing all of the files
    input1.close();
    input2.close();
    inputGS.close();
    Sat1output.close();
    Sat2output.close();
}