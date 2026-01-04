module SciMLFromScratch

include("types.jl")

include("problems.jl")

include("integrators/euler.jl")
include("optimizers/gd.jl")

include("solutions.jl")

export solve, ODEProblem, ForwardEuler, ODESolution, OptimizationProblem, GradientDescent

end
