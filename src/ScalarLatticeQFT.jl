module ScalarLatticeQFT

struct Manifold
    points::Array{Float64}
end

struct LineBundle{T}
    f::T
    Manifold::Manifold
end


end # module
