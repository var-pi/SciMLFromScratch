function solve(prob::AbstractSciMLProblem, alg::AbstractSciMLAlgorithm)
    state = init(prob)

    while state.retcode == Default && state.iter < maxiter(alg)
        step!(state, prob, alg)
        after_step!(state, prob, alg)
        success_condition(state, prob, alg) && (state.retcode = Success)
        state.iter += 1
    end

    solutionConstructor(prob)(state), diagnosticsConstructor(prob)(state)
end

after_step!(::AbstractState, ::AbstractSciMLProblem, ::AbstractSciMLAlgorithm) = return

success_condition(::AbstractState, ::AbstractSciMLProblem, ::AbstractSciMLAlgorithm) = false

finalize(::AbstractState) = return


export solve
