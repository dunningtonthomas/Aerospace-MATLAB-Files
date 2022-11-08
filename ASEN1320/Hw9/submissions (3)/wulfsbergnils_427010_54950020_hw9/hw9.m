polynominal_order = 5;                  %declaring poly order
input = readmatrix('naca4412.csv');     %Reading in CSV values
AoA = input(:,1);
C1 = input(:,2);
X = BuildMatrix(AoA,polynominal_order);
poly_coeff = X \ C1;
Cl_fit = PolynomialCurveFit(X,poly_coeff);
MakePlots(AoA,C1,Cl_fit)