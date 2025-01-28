#include <string>
class Coord{
    
    private:
        double Xspoint;         // Satallite Coordinates X Y Z
        double Yspoint;
        double Zspoint;
        double Xgpoint;         // Ground Coordinates X Y Z
        double Ygpoint;
        double Zgpoint;
        double phipoint;        // PHI, Masking Angle
        double flagpoint;       // Visibility Flag Point (iv)
        
    public:
    // Mutator Methods
        void setPoint(double Xs, double Ys, double Zs, double Xg, double Yg, double Zg);       // Set Values to Private members
        bool setFlag();                                     // Setting (iv) Points
        void displayInfo();
};