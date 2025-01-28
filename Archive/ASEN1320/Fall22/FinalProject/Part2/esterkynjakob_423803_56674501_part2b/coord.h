//Declare class called Coord
class Coord
{

    //Private Members
    private:
        double xspoint, yspoint, zspoint;
        double xgpoint, ygpoint, zgpoint;
        double phipoint;
        int flagpoint;
    
    //Public Methods
    public:
        void setPoint(double xs, double ys, double zs, double xg, double yg, double zg);
        
        bool setFlag();
        
        void displayInfo();
    
};