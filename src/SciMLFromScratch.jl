module SciMLFromScratch

abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
abstract type AbstractSciMLSolution end
abstract type AbstractSciMLDiagnostics end

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

function solve(prob::AbstractSciMLProblem, alg::AbstractSciMLAlgorithm)
    state = init(prob)

    while step_condition(state, prob, alg)
        step!(state, prob, alg)
        after_step!(state, prob, alg)
        success_condition(state, alg) && (state.retcode = Success)
        state.iter += 1
    end

    finalize(state)
    solutionConstructor(prob)(state), diagnosticsConstructor(prob)(state)
end

success_condition(state, alg) = false

finalize(_) = return

export solve
export ReturnCode, Default, Success, MaxIters

end
