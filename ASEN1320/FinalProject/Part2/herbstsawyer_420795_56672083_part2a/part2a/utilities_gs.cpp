#include "utilities.h"
#include <cmath>
#include <fstream>

#define PI 3.141592653589793

// Write "rotate" fucntion that takes 1D array of type double of a certain length, and modifies values as instructed
void rotate(double coordinates[], int length, double degrees)
{
  // Convert to radians
  double radians = degrees * (PI / 180);

  double x0 = coordinates[0];
  double y0 = coordinates[1];
  double z0 = coordinates[2];

  // Iterate through every coordinate
  for (int i = 0; i < length; i += 3)
  {
    coordinates[i] = std::cos(radians) * x0 - std::sin(radians) * y0;
    coordinates[i + 1] = std::sin(radians) * x0 + std::cos(radians) * y0;
    coordinates[i + 2] = z0;
  }
}

// Write  "write_csv" function that writes out values stored in 1D array of type double of a certain lenth to cvs file as instructed
void write_csv(double coordinates[], int length, std::string filename)
{
  std::ofstream out(filename);

  // Write each line
  for (int i = 0; i < length; i += 3)
    out << coordinates[i] << "," << coordinates[i + 1] << "," << coordinates[i + 2] << std::endl;

  out.close();
}