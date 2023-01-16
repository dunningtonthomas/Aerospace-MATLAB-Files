

class Coord //creates class 
{
    private:
    //private data that cannot be directly accessed
        double xspoint;
        double yspoint;
        double zspoint;
        double xgpoint;
        double ygpoint;
        double zgpoint;
        double phipoint;
        bool flagpoint;
    
    
    public:
        Coord(); // constructor
        
        //Mutator
        bool setFlag();// prototype for setFlag function
        void setPoint(double inputXs,double inputYs,double inputZs,double inputXg,double inputYg,double inputZg); //prototype with all inputs
        //Accessor 
        void displayInfo();
        
        
        
};