#include "coord.h"
#include <string>

// global variables 
 //double const PI = 3.141592653589793;
 //double Rs = [xspoint,yspoint,zspoint];
 //double Rgs = [xgpoint,ygpoint,zgpoint];
 //double Rd = Rs - Rgs;
 
//public functions 
 double coord:: setPoint(xspoint,yspoint,zspoint,xgpoint,ygpoint,zgpoint){
  xspoint = xs;
  yspoint = ys;
  zspoint = zs;
  xgpoint = xg;
  ygpoint = yg;
  zgpoint = zg;
   return 0;
 }
 
bool coord:: setFlag(){
 
 double const PI = 3.141592653589793;
 double Rs = [xspoint,yspoint,zspoint];
 double Rgs = [xgpoint,ygpoint,zgpoint];
 double Rd = Rs - Rgs;
 
   RdRgs = (Rd[0]*Rgs[0]) + (Rd[1]*Rgs[1]) + (Rd[2]*Rgs[2]);
   absvRgs = sqrt(Rgs[0]^2 + Rgs[1]^2 + Rgs[2]^2);
   absvRd = sqrt(Rd[0]^2 + Rd[1]^2 + Rd[2]^2); 
   
   maskingAngle = (PI/2) - arccos((Rd * Rgs)/(abs(Rd) * abs(Rgs));
   
   if maskingAngle < 10
      flagpoint = 0;
   return 0;
  
  if else maskingAngle > 80
     flagpoint = 0;
  return 0;
   
  if else maskingAngle < 80 
     flagpoint = 1;
  return 1;
   
  if else maskingAngle > 10
     flagpoint = 1;
  return 1; 
}

 
 void std::string displayInfo(){
  cout << xspoint << " " << yspoint << " " << zspoint << " " <<xgpoint << " " <<ygpoint << zgpoint <<endl;
  
  return 0;
 }

 
 

