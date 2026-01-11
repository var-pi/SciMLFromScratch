using LinearAlgebra: norm

abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

@kwdef mutable struct NonlinearState{U,V}
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, u0)::AbstractNonlinearProblem) = NonlinearState(; u = copy(u0), r = A(u0))

function solve(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    state = init(prob)

    while state.retcode == Default && state.iter < alg.maxiter
        perform_step!(state, prob, alg)
    end

    NonlinearSolution(state), NonlinearDiagnostics(state)
end

function perform_step!(
    state::NonlinearState,
    prob::AbstractNonlinearProblem,
    alg::AbstractNonlinearAlgorithm,
)
    (; u, r), (; A), (; atol) = state, prob, alg

    step!(state, prob, alg)

    r .= A(u)

    (norm(r) < atol) && (state.retcode = Success)

    state.iter += 1
end

include("newton.jl")
export AbstractNonlinearAlgorithm, Newton
