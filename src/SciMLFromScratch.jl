module SciMLFromScratch

include("types.jl")

include("problems/ode_problems.jl")

include("integrators/euler.jl")

export ForwardEuler, solve

end
