module SciMLFromScratch

abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
abstract type AbstractSciMLSolution end

abstract type AbstractODEAlgorithm <: AbstractSciMLAlgorithm end
abstract type AbstractOptimizer <: AbstractSciMLAlgorithm end
abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

include("Problems/Problems.jl")

include("Integrators/Integrators.jl")
include("Optimizers/Optimizers.jl")
include("Nonlinear/Nonlinear.jl")

include("Solutions/Solutions.jl")
end
