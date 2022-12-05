#include <iostream>

class Coord
{
    
        
    public:
    
        void setPoint(double xs,double ys, double zs, double xg, double yg, double zg);
        bool setFlag();
        void displayInfo();
        
    private:
        
        
        double xspoint;
        double yspoint;
        double zspoint;
        double xgpoint;
        double ygpoint;
        double zgpoint;
        double phipoint;
        double flagpoint;
        
        
};
    
