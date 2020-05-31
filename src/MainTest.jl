include("./ScalarLatticeQFT.jl")
using Plots

N = 100;  Δ = 0.1;
Nmeas = 10; Nsweeps = 10;

Measurements = ScalarLatticeQFT.MonteCarlo(Δ,N,Nmeas,Nsweeps)


autocorrelation = sum([ [[sum(Measurements[j,:].*Measurements[j+i,:]) for i = 0:(Nmeas-j)];zeros(j-1)] for j = 1:(Nmeas-10)] )
autocorrelation = autocorrelation/autocorrelation[1]

plot(autocorrelation)
plot!(x-> exp(-sqrt(0.1)*x))
plot!(xlim=(0,100))
