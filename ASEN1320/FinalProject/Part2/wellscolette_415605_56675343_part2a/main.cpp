//libraries
#include "utilities.h"
#include <cmath>
#include <string>

using namespace std;


int main()
{
   
 //declaring variables
double t = 60.0;
double w = (360.0 / 86400.0);
double theta = w * t;
int N = (86400 / 60) + 1;
double angle;
double GSposition[1441 * 3];
string filename = "GSPosition.csv";


//creating a for loop to iterate over the gs positions throughout time
for (int i = 0; i < N; i++)
{
    //declaring variables in for loop
    angle = theta * i;
    double gsArray[3] = {-2314.87, 4663.275, 3673.747};
    
    //calling rotate function
    rotate(gsArray, N, angle);
    

    GSposition[i * 3] = gsArray[0]; //setting Gs position array equal to gsArray[0]
    GSposition[i * 3 + 1] = gsArray[1]; //setting gs position array equal to gsArray[1]
    GSposition[i * 3 + 2] = gsArray[2]; //setting gs position array equal to gsArray[2]
}


//takes the values from the before_rotation file to use the values in the void function
write_csv(GSposition, N, filename);

return 0;

}
