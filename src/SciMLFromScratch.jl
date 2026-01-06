module SciMLFromScratch

include("types.jl")

include("problems.jl")

include("integrators/base.jl")
include("optimizers/gd.jl")

include("solutions.jl")

export solve, ODEProblem, ForwardEuler, ODESolution, OptimizationProblem, GradientDescent, OptimizationSolution, RungeKutta4, BackwardEuler

end
