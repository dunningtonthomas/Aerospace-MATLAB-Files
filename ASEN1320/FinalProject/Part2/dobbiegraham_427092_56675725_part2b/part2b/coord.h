class Coord {
    
    public:
    
    // Constructors
    Coord();
    Coord(double xs, double ys, double zs, double xg, double yg, double zg);
    
    // Public methods
    
    // Sets the visability flag and phi
    bool setFlag();
    
    // Loads data into the class
    void setPoint(double xs, double ys, double zs, double xg, double yg, double zg);
    
    // displays all info for testing
    void displayInfo();
    
    // Specificaly retreaves phi in degrees
    double getPhi();
    
    
    private:
    
    // Normalizes vectors
    double normVec(double vec[], int vec_len);
    
    // Private vars
    double xspoint, yspoint, zspoint, xgpoint, ygpoint, zgpoint, phipoint;
    bool flagpoint;
    
    
};