#include "coord.h"
#include <cmath>
#include <iostream>

bool Coord::setFlag()
{
  double xd = xspoint - xgpoint;
  double yd = yspoint - ygpoint;
  double zd = zspoint - zgpoint;

  double dotProduct = xd * xgpoint + yd * ygpoint + zd * zgpoint;
  double magRgs = std::sqrt(std::pow(xgpoint, 2) + std::pow(ygpoint, 2) + std::pow(zgpoint, 2));
  double magRd = std::sqrt(std::pow(xd, 2) + std::pow(yd, 2) + std::pow(zd, 2));

  phipoint = M_PI_2 - std::acos(dotProduct / (magRgs * magRd));

  flagpoint = phipoint > 10 * (M_PI / 180);
  return flagpoint;
}

void Coord::setPoint(double xs, double ys, double zs, double xg, double yg, double zg)
{
  xspoint = xs;
  yspoint = ys;
  zspoint = zs;
  xgpoint = xg;
  ygpoint = yg;
  zgpoint = zg;
}

void Coord::displayInfo()
{
  std::cout << "xspoint: " << xspoint << std::endl;
  std::cout << "yspoint: " << yspoint << std::endl;
  std::cout << "zspoint: " << zspoint << std::endl;
  std::cout << "xgpoint: " << xgpoint << std::endl;
  std::cout << "ygpoint: " << ygpoint << std::endl;
  std::cout << "zgpoint: " << zgpoint << std::endl;
  std::cout << "phipoint: " << phipoint << std::endl;
  std::cout << "flagpoint: " << flagpoint << std::endl;
}