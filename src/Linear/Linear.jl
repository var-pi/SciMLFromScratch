using LinearAlgebra: norm

abstract type AbstractLinearAlgorithm <: AbstractSciMLAlgorithm end

struct LinearState{Alg,Op<:AbstractLinearOperator,I,O}
    alg::Alg
    A::Op
    b::O
    u::I           # current iterate
    r::O           # residual r = b - A*x
    iter::Int
    converged::Bool
end

function init(prob::AbstractLinearProblem, alg::AbstractLinearAlgorithm)
    (; A, b, u0) = prob
    r0 = b - apply(A, u0)
    LinearState(alg, A, b, u0, r0, 0, false)
end

function solve(prob::AbstractLinearProblem, alg::AbstractLinearAlgorithm)
    state = init(prob, alg)
    (; maxiter) = alg

    while !state.converged && state.iter < maxiter
        state = perform_step(state)
    end

    LinearSolution(state)
end

function perform_step(state::LinearState)
    (; alg, A, b, iter) = state
    (; atol) = alg

    u_new = step(state)
    r_new = b - apply(A, u_new)
    converged = norm(r_new) < atol

    LinearState(alg, A, b, u_new, r_new, iter + 1, converged)
end

include("richardson.jl")
export AbstractLinearAlgorithm, Richardson
