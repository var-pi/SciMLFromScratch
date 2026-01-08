module SciMLFromScratch

abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
abstract type AbstractSciMLSolution end

include("Problems/Problems.jl")

include("Integrators/Integrators.jl")
include("Optimizers/Optimizers.jl")
include("Nonlinear/Nonlinear.jl")
include("Linear/Linear.jl")

include("Solutions/Solutions.jl")

export solve
end
