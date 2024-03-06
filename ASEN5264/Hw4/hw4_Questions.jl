using PGFPlots
using Plots
using Distributions


dist = Normal() 

plot(pdf.(dist,collect(-2.0:0.1:2.0)))