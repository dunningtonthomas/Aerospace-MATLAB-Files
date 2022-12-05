#include <string>


class Coord
{
private:
   double xspoint;
   double yspoint;
   double zspoint;
   double xgpoint;
   double ygpoint;
   double zgpoint;
   double phipoint;
   bool flagpoint;
   
   
public:
    void setPoint(double, double, double, double, double, double);
    bool setFlag();
    void displayInfo();
    
};