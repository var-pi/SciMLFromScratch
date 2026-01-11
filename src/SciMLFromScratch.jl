module SciMLFromScratch

abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
abstract type AbstractSciMLSolution end

@enum ReturnCode begin
    Default
    Success
    MaxIters
end

include("Operators/Operators.jl")

include("Problems/Problems.jl")

include("Linear/Linear.jl")
include("Nonlinear/Nonlinear.jl")
include("Integrators/Integrators.jl")

include("Solutions/Solutions.jl")

export solve
export ReturnCode, Default, Success, MaxIters

end
