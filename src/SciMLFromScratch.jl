module SciMLFromScratch

# how to import a static arrray?

include("types.jl")

include("problems/ode_problems.jl")

include("integrators/euler.jl")

include("repl.jl")

export ForwardEuler, solve

end
