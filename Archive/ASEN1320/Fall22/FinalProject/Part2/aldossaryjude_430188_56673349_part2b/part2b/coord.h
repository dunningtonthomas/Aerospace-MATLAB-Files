#include <string>

class Coord {
    
    private:
    //Accessor Methods
    double xs_point; 
    double ys_point;
    double zs_point;
    double xg_point;
    double yg_point;
    double zg_point;
    double phi_point;
    bool flag_point;
    
    public:
    //Mutator Methods
    void setPoint(double xs_point, double ys_point, double zs_point, double xg_point, double yg_point, double zg_point);
    bool setFlag();
    void displayInfo();
    
};