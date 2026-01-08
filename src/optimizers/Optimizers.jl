abstract type AbstractOptimizer <: AbstractSciMLAlgorithm end

include("gd.jl")
export AbstractOptimizer, GradientDescent
