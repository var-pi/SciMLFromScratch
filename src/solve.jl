function solve(prob::AbstractSciMLProblem, alg::AbstractSciMLAlgorithm)
    state = init(prob)

    while state.retcode == Default && state.iter < maxiter(alg)
        apply!(state, StepOperator(; alg, prob.A), state)
        success_condition(state, prob, alg) && (state.retcode = Success)
        state.iter += 1
    end

    solutionConstructor(prob)(state), diagnosticsConstructor(prob)(state)
end

success_condition(::AbstractState, ::AbstractSciMLProblem, ::AbstractSciMLAlgorithm) = false


export solve
