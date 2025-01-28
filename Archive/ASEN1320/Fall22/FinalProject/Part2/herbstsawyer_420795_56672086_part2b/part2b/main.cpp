#include "coord.h"
#include <fstream>
#include <string>
#include <iostream>

int main()
{
  // According to description: "duration of the simulation (1 day)"
  const int length = 24 * 60;

  Coord s1Coords[length];
  Coord s2Coords[length];

  std::ifstream s1Csv("Sat1Position.csv");
  std::ifstream s2Csv("Sat2Position.csv");
  std::ifstream gsCsv("GSPosition.csv");

  std::ofstream s1Vis("Sat1Visibility.csv");
  std::ofstream s2Vis("Sat2Visibility.csv");

  std::string word;

  // Ground station
  double gsCoords[length * 3];

  for (int t = 0; t < length; t++)
  {
    int i = t * 3;

    std::getline(gsCsv, word, ',');
    double xg = std::stod(word);

    std::getline(gsCsv, word, ',');
    double yg = std::stod(word);

    std::getline(gsCsv, word);
    double zg = std::stod(word);

    gsCoords[i] = xg;
    gsCoords[i + 1] = yg;
    gsCoords[i + 2] = zg;
  }

  // Satellite 1
  for (int t = 0; t < length; t++)
  {
    // Satellite
    std::getline(s1Csv, word, ',');
    double xs = std::stod(word);

    std::getline(s1Csv, word, ',');
    double ys = std::stod(word);

    std::getline(s1Csv, word);
    double zs = std::stod(word);

    // Eat 59 lines (59 seconds later)
    for (int i = 0; i < 59; i++)
      std::getline(s1Csv, word);

    Coord coord;
    coord.setPoint(xs, ys, zs, gsCoords[(t * 3) + 0], gsCoords[(t * 3) + 1], gsCoords[(t * 3) + 2]);

    s1Vis << coord.setFlag() << std::endl;
  }

  // Satellite 2
  for (int t = 0; t < length; t++)
  {
    // Satellite
    std::getline(s2Csv, word, ',');
    double xs = std::stod(word);

    std::getline(s2Csv, word, ',');
    double ys = std::stod(word);

    std::getline(s2Csv, word);
    double zs = std::stod(word);

    // Eat 59 lines (59 seconds later)
    for (int i = 0; i < 59; i++)
      std::getline(s2Csv, word);

    Coord coord;
    coord.setPoint(xs, ys, zs, gsCoords[(t * 3) + 0], gsCoords[(t * 3) + 1], gsCoords[(t * 3) + 2]);

    s2Vis << coord.setFlag() << std::endl;
  }

  s1Csv.close();
  s2Csv.close();
  gsCsv.close();

  s1Vis.close();
  s2Vis.close();

  return 0;
}