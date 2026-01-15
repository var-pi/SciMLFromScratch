abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
abstract type AbstractSciMLSolution end
abstract type AbstractSciMLDiagnostics end
abstract type AbstractState end

@enum ReturnCode begin
    Default
    Success
    MaxIters
end

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

finalize(::AbstractState) = return

export solve
export ReturnCode, Default, Success, MaxIters
