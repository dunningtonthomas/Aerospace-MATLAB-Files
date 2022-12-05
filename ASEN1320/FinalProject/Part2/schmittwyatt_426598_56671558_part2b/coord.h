class Coord //declares a class called Coord
{
    
    public: //calls for public declaration
        void setPoint(double xs, double ys, double zs, double xg, double yg, double zg); //declares a public class function for Point that is void
        bool setFlag(); //declares a public function for Flag that is a boolean
        void displayInfo(); //declares a public function for displayInfo of type void 
        
        
    private: //calls for private declaration
        double xspoint; //declares a private class for xspoint
        double yspoint; //declares a private class for yspoint
        double zspoint; //declares a private class for zspoint
        double xgpoint; //declares a private class for xgpoint
        double ygpoint;  //declares a private class for ygpoint
        double zgpoint;  //declares a private class for zgpoint
        double phipoint;  //declares a private class for phipoint
        double flagpoint;  //declares a private class for flagpoint
        double ElevationAngle; //declares a private class for ElevationAngle
};