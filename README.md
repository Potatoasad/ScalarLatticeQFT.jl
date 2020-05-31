## Hand-wavy indication of What I'm Attempting here

The aim here is to be able to find a modular way to represent Path Integrals on general closed, easy manifolds in a discretized version,
and then be able to solve them using the Metropolis-Hastings algorithm. 

A standard path integral needs the following ingredients:
- A manifold ` M `
- A vector bundle / Line Bundle / Scalar function   `phi` over `M`
- An "action" `S(phi)` that takes in some chosen realisation of `phi` and maps it to a scalar on `M`. 

The path integral is then evaluated as:

```math
Integrate over the space of all `phi` on `M`.
```

## How would you code that?

Many algorithms exist to create discretized versions of manifolds, like a sphere ... or the surface of a cow. The `ApproxFun.jl`
library in Julia is a good place to start in representing Functions on Spaces. 

Once we define our space, we will need to be able to `update` our function probabilistically in such a way that the the ratio of the probability of 
going from function`f1` to function `f2` and viceversa is known. Ideally it should be 1. 

We can take the representation of the function and add different random components to it, accepting the change only when
` rand() < exp(-(S(update(f)) - S(f))) `

This would implement a Metropolis-Hastings Algorithm and would give us representative samples from the `exp(-S[phi])` distribution we would like to see.
We could then use these samples to get correlation functions and what not. 

## What we have so far:

So far I've implemented a very simple working Metropolis-Hastings as a first step. I will see if I can figure out a nice way to add the right abstractions to it. 
