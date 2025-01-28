class Coord
{
private:
  /*
  Why do we postfix every single variable name with point?
  Yes, we are aware each of these variables has to do with a point.
  That is why it's in a class called "Coord". Or maybe we should have
  renamed variables to xspointcoordpart2b to be more clear. Unusual idea
  but maybe it would have been better to rename the below variables to xs,
  ys, zs, etc... and then rename the parameters for setPoint to _xs,
  _zs, as is convention in C++.

  Also, why do we have the method setPoint() and not just use a constructor
  like would make sense in this context?

  Worse of all, why on earth would we name the variable flagpoint? flagpoint
  represents whether or not the visibility conditions are satisifed, right?
  So why wouldn't it be called visible, or satisifesVisibilityConditions, etc...?
  Same question with setFlag()...
  The word flag gives absolutely no context to what this variable does except
  that it represents something boolean.

  Well, at least we have the context that it is having to do with a point...
  Thank god it's not called just flag.... flagpoint is so much better
  */
  double xspoint, yspoint, zspoint, xgpoint, ygpoint, zgpoint, phipoint;
  bool flagpoint = 0;

public:
  bool setFlag();
  void setPoint(double xs, double ys, double zs, double xg, double yg, double zg);
  void displayInfo();
};