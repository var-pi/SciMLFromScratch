abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
abstract type AbstractSciMLSolution end

abstract type AbstractODEAlgorithm <: AbstractSciMLAlgorithm end
abstract type AbstractOptimizer <: AbstractSciMLAlgorithm end
