#include <string>

class Coord {
    public:                              //methods
        bool setFlag();
        void setPoint(double xs, double ys, double zs, double xg, double yg, double zg);
        void displayInfo(); 
        
    private:                        //attributes
        double xspoint;
        double yspoint;
        double zspoint;
        double xgpoint;
        double ygpoint;
        double zgpoint;
        double phipoint;
        bool flagpoint;
    
};