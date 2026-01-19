function solve(prob::AbstractSciMLProblem, alg::AbstractSciMLAlgorithm)
    state = init(prob)

    while state.retcode == Default && state.iter < maxiter(alg)
        apply!(state, StepOperator(; alg, prob.A), state)
        success_condition(state, prob, alg) && (state.retcode = Success)
        state.iter += 1
    end

    solutionConstructor(prob)(state), diagnosticsConstructor(prob)(state)
end

function apply!(y, S::StepOperator{<:AbstractSciMLAlgorithm}, x)
    _apply!(y, S, x)
    update_params!(y, S, x)
end

success_condition(::AbstractState, ::AbstractSciMLProblem, ::AbstractSciMLAlgorithm) = false


export solve
