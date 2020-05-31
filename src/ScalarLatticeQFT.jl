module ScalarLatticeQFT

struct Manifold
    points::Array{Float64}
end

struct LineBundle{T}
    f::T
    Manifold::Manifold
end

function Sweep(f::Array{Float64,1},Δ::Float64)
    rate = 0;
    N = length(f)
    δij = zeros(N);
    for i=1:N
        #Random Index to shift
        j = rand(1:N);
        δij[j] = 1;
        #Random Shift of size Δ
        δ = 2*Δ*(rand()-0.5);
        #Find Change in Action
        δS = S(f + δ*δij)-S(f);
        #Acceptance Prob:
        AccProb = min(1,exp(-δS))
        if rand() < AccProb
            #Accept the Change:
            f[j] += δ
            rate += 1;
        end
        δij[j] = 0
    end
    rate = rate/N
    return f
end

function Measurement(f::Array{Float64,1},Nsweeps::Int64,Δ::Float64)
    for sweep in 1:Nsweeps
           f = Sweep(f,Δ) 
    end
    return f
end

function MonteCarlo(Δ,N,Nmeas,Nsweeps)
    Measurements = zeros(Nmeas,N);
    for meas in 1:(Nmeas-1)
        Measurements[meas+1,:] = Measurement(Measurements[meas,:],Nsweeps,Δ) 
    end
    return Measurements
end

Δx = 0.1; #Need to get these out of the module in the future 
Der(f) = (1/Δx)*[f[1];[f[i+1]-f[i] for i = 1:(length(f)-1)];(f[end]-f[end-1])];
S(f) = sum(Der(f).*Der(f));

export Manifold, LineBundle
export MonteCarlo

end # module
