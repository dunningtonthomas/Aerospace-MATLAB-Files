
//Class Coord is defined with private location values and public mutator methods that modify
//inputted data, store and pull data from private location values, and display values.
class Coord
{
    private:
    //Members
    double xspoint;
    double yspoint;
    double zspoint;
    double xgpoint;
    double ygpoint;
    double zgpoint;
    double phipoint;
    bool flagpoint;
    
    public:
    //Mutator Methods
    void setPoint(double xspoint, double yspoint, double zspoint, double xgpoint, double ygpoint, double zgpoint);
    bool setFlag();
    
    //Accessor Methods
    void displayInfo(); 
};