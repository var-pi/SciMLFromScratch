abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end

abstract type AbstractODEAlgorithm <: AbstractSciMLAlgorithm end
abstract type AbstractOptimizer <: AbstractSciMLAlgorithm end
