using LinearAlgebra: norm

abstract type AbstractLinearAlgorithm <: AbstractSciMLAlgorithm end

struct LinearState{U,V}
    u::U           # current iterate
    r::V           # residual r = b - A*x
    iter::Int
    retcode::ReturnCode
end

function init(prob::AbstractLinearProblem)
    (; A, b, u0) = prob

    r0 = b - A(u0)
    LinearState(u0, r0, 0, Default)
end

function solve(prob::AbstractLinearProblem, alg::AbstractLinearAlgorithm)
    state = init(prob)
    (; maxiter) = alg

    while state.retcode == Default && state.iter < maxiter
        state = perform_step(state, prob, alg)
    end

    LinearSolution(state), LinearDiagnostics(state)
end

function perform_step(
    state::LinearState,
    prob::AbstractLinearProblem,
    alg::AbstractLinearAlgorithm,
)
    (; iter, retcode) = state
    (; A, b) = prob
    (; atol) = alg

    u_new = step(state, prob, alg)
    r_new = b - A(u_new)
    (norm(r_new) < atol) && (retcode = Success)

    LinearState(u_new, r_new, iter + 1, retcode)
end

include("richardson.jl")
export AbstractLinearAlgorithm, Richardson
