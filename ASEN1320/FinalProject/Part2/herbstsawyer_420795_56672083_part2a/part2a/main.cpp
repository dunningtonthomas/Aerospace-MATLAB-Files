#include "utilities.h"
#include <string>

using std::string;

int main()
{
  const int minutesPerDay = 24 * 60;
  const int dimensions = 3;
  const int length = (minutesPerDay + 1) * dimensions;

  const double omega = 360.0 / (minutesPerDay * 60);

  double coordinates[length] = {-2314.87, 4663.275, 3673.747};

  for (int i = 1; i <= minutesPerDay; i++)
  {
    int t = i * 60;

    double theta = omega * t;

    double toRotate[dimensions] = {coordinates[0], coordinates[1], coordinates[2]};
    rotate(toRotate, dimensions, theta);

    for (int j = 0; j < dimensions; j++)
    {
      coordinates[i * dimensions + j] = toRotate[j];
    }
  }

  string outputFilename = "GSPosition.csv";

  write_csv(coordinates, length, outputFilename);

  return 0;
}