class Coord {                           //naming class
    
    private:                            //declaring private members
        double xspoint;
        double yspoint;
        double zspoint;
        double xgpoint;
        double ygpoint;
        double zgpoint;
        double phipoint;
        bool flagpoint;
        
    public:                                                                                     //declaring public member functions
        void setPoint(double xs, double ys, double zs, double xg, double yg, double zg);
        bool setFlag();
        void displayInfo();
        
};