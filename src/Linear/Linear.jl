using LinearAlgebra: norm

abstract type AbstractLinearAlgorithm <: AbstractSciMLAlgorithm end

struct LinearState{ALG,A,B,U}
    alg::ALG
    A::A
    b::B
    u::U           # current iterate
    r::U           # residual r = b - A*x
    iter::Int
    converged::Bool
end

function init(prob::LinearProblem, alg::AbstractLinearAlgorithm)
    A = prob.A
    b = prob.b
    u0 = prob.u0
    r0 = b - A * u0
    LinearState(alg, A, b, u0, r0, 0, false)
end

function solve(prob::LinearProblem, alg::AbstractLinearAlgorithm)
    state = init(prob, alg)

    while !state.converged && state.iter < alg.maxiter
        state = perform_step(state)
    end

    LinearSolution(state)
end

function perform_step(state::LinearState)
    (; alg, A, b, iter) = state

    u_new = step(state)
    r_new = b - A * u_new
    converged = norm(r_new) < alg.atol

    LinearState(alg, A, b, u_new, r_new, iter + 1, converged)
end

struct Richardson{T} <: AbstractLinearAlgorithm
    α::T        # relaxation parameter
    atol::T
    maxiter::Int
end

function step(state::LinearState{<:Richardson})
    (; alg, u, r) = state

    # Richardson update: x_{k+1} = x + α * r
    u + alg.α * r
end

export AbstractLinearAlgorithm, Richardson
