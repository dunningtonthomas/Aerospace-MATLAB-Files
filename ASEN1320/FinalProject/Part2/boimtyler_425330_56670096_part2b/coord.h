#include <string>

// 1. WRITE CLASS DEFINITION FOR COORD
// 2. PUBLICS: setPoint, setFlag, and displayInfo
// 3. PRIVATES: xspoint, yspoint, zspoint, xgpoint, ygpoint, zgpoint, phipoint, and flagpoint
// 4. PRIVATE DATA STORES (i) the ground station position (ii) the spacecraft position (iii) the masking angle (φ) (iv) the visibility flag.  
// 5. PUBLIC: SETPOINT USED TO SET VALUES OF PRIVATE AREAS, SETFLAG SETS VISIBILITY FLAG

class Coord
{
    // Private Attributes
    
    private:
        double xspoint; 
        double yspoint;
        double zspoint;
        double xgpoint; 
        double ygpoint;
        double zgpoint;
        double phipoint;
        bool flagpoint;
    
    // Public Attributes
    
    public:
    
    // Accessor Methods
       
        void displayInfo();
        
    // Mutator Methods  HOW DOES THIS WORK?
        void setPoint(double Xs, double Ys, double Zs, double Xg, double Yg, double Zg);
        void setFlag();
        
        bool getFlag();
    
};
