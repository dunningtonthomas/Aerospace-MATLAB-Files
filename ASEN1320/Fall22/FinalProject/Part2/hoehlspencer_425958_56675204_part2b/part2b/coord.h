class Coord {
  
    //Public functions 
    public: 
        //mutator function
        void setPoint(double xs, double ys, double zs, double xg, double yg, double zg);
        
        //accessor functions
        bool setFlag();             //accesses whether or not satellite is visible 
        void displayInfo(); 
    
    
    //private variables that cannot accidentally be changed
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
