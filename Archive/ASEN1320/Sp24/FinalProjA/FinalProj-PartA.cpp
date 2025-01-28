#include <iostream>
#include <cmath>
#include <fstream>
#include <string>
using namespace std;


const int size = 10;   // size of 1D arrays

// function to read the aircraft data
void readFile(string inputFilename, double V_N[], double V_E[], double V_D[], double yaw[], double pitch[], double roll[], int size);


// functions to obtain the 3*3 rotation matrices:  R_3(yaw) , R_2(pitch) , R_1(roll) 
void yawMatFunc(double yaw_rad, double yawMat[][3]);
void pitchMatFunc(double pitch_rad, double pitchMat[][3]);
void rollMatFunc(double roll_rad, double rollMat[][3]);


// function that applies the 3 rotation matrices to velocity vector in NED and obtains velocity vector in body frame
void Rot_NED_to_Body(double yaw[], double pitch[], double roll[], const double V_N[], const double V_E[], const double V_D[], double V_X[], double V_Y[], double V_Z[], int size);


// function that calculates the V_t, angle of attack and angle of sideslip from the velocity in the body frame
void velParams(const double V_X[], const double V_Y[], const double V_Z[], double V_t[], double Attack_angDeg[], double sideSlip_angDeg[], int size);


// function that returns the std of V_t
double calculateSTD(const double V_t[], int size);



// function to return true if the difference between magnitude of velocity vector in two systems is < 1 mm/s
bool checkMagVel(const double V_N[], const double V_E[], const double V_D[], const double V_X[], const double V_Y[], const double V_Z[], int size);


// function to write V_t, angle of attack and angle of sideslip to a CSV file 
void writeCSV(string outputFileName, const double V_t[], const double Attack_angDeg[], const double sideSlip_angDeg[], int size);





// main function 
int main( )
{
   // variable declaration 
   string inputFilename = "aircraftdata.txt";
   string outputFileName = "output.csv";
     
   double V_N[size], V_E[size], V_D[size], yaw[size], pitch[size], roll[size]; 
   double V_X[size], V_Y[size], V_Z[size];
   double V_t[size], Attack_angDeg[size], sideSlip_angDeg[size];
   
   // read the aircraft data from the txt file
   readFile(inputFilename,V_N, V_E, V_D, yaw, pitch, roll, size);

   for (int i = 0; i < size; i++)
       cout << V_N[i] << " " << V_E[i] << " " << V_D[i] << " " << yaw[i] << " " << pitch[i] << " " <<  roll[i] << endl; 
   
   
   
   
   // call the rotation function
   Rot_NED_to_Body(yaw, pitch, roll, V_N, V_E, V_D, V_X, V_Y, V_Z, size);

   
   // print out Velocity in body frame
   for (int i = 0; i < size; i++)
       cout << V_X[i] << " " << V_Y[i] << " " << V_Z[i] << endl; 
       
   
   // check mag in two different frames 
   bool checkD;
   checkD = checkMagVel(V_N, V_E, V_D, V_X, V_Y, V_Z, size);
   if (true)
       cout << "Is the magnitude of velocity vector the same in two frames: YES!\n";
   else
       cout << "Is the magnitude of velocity vector the same in two frames: NO!\n";
 

   
   // call function to get V_t and angle of attack and side slip
   velParams(V_X, V_Y, V_Z, V_t, Attack_angDeg, sideSlip_angDeg, size);


 
   // print out V_t and angle of attack and side slip
   for (int i = 0; i < size; i++)
       cout << V_t[i] << " " << Attack_angDeg[i] << " " << sideSlip_angDeg[i] << endl; 
   
   // STD of V_t
   double std_Vt;
   std_Vt = calculateSTD(V_t, size);
   cout << "std of V_t: " << std_Vt << endl;
   
   //  function to write V_t and angle of attack and side slip into a CSV file
    writeCSV(outputFileName, V_t, Attack_angDeg, sideSlip_angDeg, size);

   
   return 0;   
}



// function to read the aircraft data
void readFile(string inputFilename, double V_N[], double V_E[], double V_D[], double yaw[], double pitch[], double roll[], int size)
{
   ifstream inputStream;
   inputStream.open(inputFilename);
   
   if (inputStream.fail())
   {
      cout << "Error: The input file " << inputFilename << " did not open properly!\n";
      return;
   }
   
   // read the header line
   string header[6];
   for (int i = 0; i < 6; i++){
        inputStream >> header[i];
        //cout << header[i] << endl;
   }
     
        
   // reader the data 
   int j = 0;
   while (!inputStream.eof())
   {
        inputStream >> V_N[j] >> V_E[j] >> V_D[j] >> yaw[j] >> pitch[j] >>  roll[j]; 
        j++;
   }
   
   
   inputStream.close();
   
}


// functions to obtain the 3*3 rotation matrices:  R_3(yaw) , R_2(pitch) , R_1(roll) 
void yawMatFunc(double yaw_rad, double yawMat[][3])
{
   yawMat[0][0] = cos(yaw_rad);
   yawMat[0][1] = sin(yaw_rad);
   yawMat[0][2] = 0;
   yawMat[1][0] = -sin(yaw_rad);
   yawMat[1][1] = cos(yaw_rad);
   yawMat[1][2] = 0;
   yawMat[2][0] = 0;
   yawMat[2][1] = 0;
   yawMat[2][2] = 1;
   
}


void pitchMatFunc(double pitch_rad, double pitchMat[][3])
{
   pitchMat[0][0] = cos(pitch_rad);
   pitchMat[0][1] = 0;
   pitchMat[0][2] = -sin(pitch_rad);
   pitchMat[1][0] = 0;
   pitchMat[1][1] = 1;
   pitchMat[1][2] = 0;
   pitchMat[2][0] = sin(pitch_rad);
   pitchMat[2][1] = 0;
   pitchMat[2][2] = cos(pitch_rad);
}

void rollMatFunc(double roll_rad, double rollMat[][3])
{
   rollMat[0][0] = 1;
   rollMat[0][1] = 0;
   rollMat[0][2] = 0;
   rollMat[1][0] = 0;
   rollMat[1][1] = cos(roll_rad);
   rollMat[1][2] = sin(roll_rad);
   rollMat[2][0] = 0;
   rollMat[2][1] = -sin(roll_rad);
   rollMat[2][2] = cos(roll_rad);
}



// function that applies the 3 rotation matrices to velocity vector in NED and obtains velocity vector in body frame
void Rot_NED_to_Body(double yaw[], double pitch[], double roll[], const double V_N[], const double V_E[], const double V_D[], double V_X[], double V_Y[], double V_Z[], int size)
{

   for (int k = 0; k < size; k++)
   {
      
      double yaw_rad = yaw[k]*M_PI/180;
      double pitch_rad = pitch[k]*M_PI/180;
      double roll_rad = roll[k]*M_PI/180;
   
      double yawMat[3][3]={0}, pitchMat[3][3]={0}, rollMat[3][3]={0};
   
      int size_col = 3;
      yawMatFunc(yaw_rad, yawMat);
      pitchMatFunc(pitch_rad, pitchMat);
      rollMatFunc(roll_rad, rollMat);
      
      
      
   // Yaw rotation 
   double vecIn1[3]={0}, vecOut1[3]={0};
   vecIn1[0] = V_N[k]; vecIn1[1] = V_E[k]; vecIn1[2] = V_D[k];
   for (int i = 0; i < 3; i++)
   {
       for (int j = 0; j < 3; j++) 
       {
       vecOut1[i] +=  yawMat[i][j]*vecIn1[j];
       }
   }

   // pitch rotation
   double vecIn2[3]={0}, vecOut2[3]={0};
   vecIn2[0] = vecOut1[0]; vecIn2[1] = vecOut1[1]; vecIn2[2] = vecOut1[2];
   for (int i = 0; i < 3; i++)
   {
       for (int j = 0; j < 3; j++) 
       {
       vecOut2[i] +=  pitchMat[i][j]*vecIn2[j];
       }
   }
   
   
   // roll rotation
   double vecIn3[3]={0}, vecOut3[3]={0};
   vecIn3[0] = vecOut2[0]; vecIn3[1] = vecOut2[1]; vecIn3[2] = vecOut2[2];
   for (int i = 0; i < 3; i++)
   {
       for (int j = 0; j < 3; j++) 
       {
       vecOut3[i] +=  rollMat[i][j]*vecIn3[j];
       }
   }
   
   V_X[k] = vecOut3[0]; 
   V_Y[k] = vecOut3[1]; 
   V_Z[k] = vecOut3[2]; 
   
   
   
   } // for (int k = 0, ....)

   
}



// function that calculates the V_t, angle of attack and angle of sideslip from the velocity in the body frame
void velParams(const double V_X[], const double V_Y[], const double V_Z[], double V_t[], double Attack_angDeg[], double sideSlip_angDeg[], int size)
{
   for (int k = 0; k < size; k++)
   {
      V_t[k] = sqrt(V_X[k]*V_X[k]+V_Y[k]*V_Y[k]+V_Z[k]*V_Z[k]);
      Attack_angDeg[k] = atan2(V_Z[k],V_X[k])*180/M_PI;
      sideSlip_angDeg[k] = asin(V_Y[k]/V_t[k])*180/M_PI;
   }
   
}


// function that calculates STD of a 1D array
double calculateSTD(const double V_t[], int size) 
{
    double sum = 0.0;
    for (int i = 0; i < size; ++i) 
    {
        sum += V_t[i];
    }
    double mean = sum / size;

    double sumSquaredDiffs = 0.0;
    for (int i = 0; i < size; ++i) 
    {
        sumSquaredDiffs += (V_t[i] - mean) * (V_t[i] - mean);
    }
    
    double std =  sqrt(sumSquaredDiffs / (size-1));
    
    return std; 
}


// function to check if the magnitude difference is < 1 mm/s
bool checkMagVel(const double V_N[], const double V_E[], const double V_D[], const double V_X[], const double V_Y[], const double V_Z[], int size)
{
   bool result = true;
   double dist_NED;
   double dist_Body;
   for (int i = 0; i < size; i++)
   {
        double dist_NED = sqrt(V_N[i]*V_N[i]+V_E[i]*V_E[i]+V_D[i]*V_D[i]);
        double dist_Body = sqrt(V_X[i]*V_X[i]+V_Y[i]*V_Y[i]+V_Z[i]*V_Z[i]);
        
        if (fabs(dist_NED-dist_Body)>0.001)
        {   
           result = false;
        }
   }
   
   return result;
}


// function to write V_t, angle of attack and angle of sideslip to a CSV file 
void writeCSV(string outputFileName, const double V_t[], const double Attack_angDeg[], const double sideSlip_angDeg[], int size)
{
   ofstream outputStream;
   outputStream.open(outputFileName);
   
   if (outputStream.fail())
   {
      cout << "Error: The output file " << outputFileName << " did not open properly!\n";
      return;
   }
   
   // write the data
   outputStream << "V_t [m/s]" << "," << "Angle of attack [deg]" << "," << "Angle of sideslip [deg]" << endl;
   for (int i = 0; i < size; i++)
        outputStream << V_t[i] << "," << Attack_angDeg[i] << "," << sideSlip_angDeg[i] << endl; 
   
   
   outputStream.close();
   
   
}