module SciMLFromScratch

include("types.jl")

include("problems/ode_problems.jl")
include("problems/optimization_problem.jl")

include("integrators/euler.jl")
include("optimizers/gd.jl")

include("solutions/ode_solutions.jl")
include("solutions/optimization_solution.jl")

export solve, ODEProblem, ForwardEuler, ODESolution, OptimizationProblem, GradientDescent

end
