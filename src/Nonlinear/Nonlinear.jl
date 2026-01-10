using LinearAlgebra: ⋅

abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

struct NonlinearState{A,U,V,Op<:AbstractNonlinearOperator}
    alg::A
    u::U             # current iterate
    Au::V            # residual at current iterate
    A::Op             # residual function
    iter::Int        # iteration counter
    converged::Bool
end

function init(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    (; u0, A) = prob
    NonlinearState(alg, u0, A(u0), A, 0, false)
end

function solve(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    state = init(prob, alg)
    (; maxiter) = alg

    while !state.converged && state.iter < maxiter
        state = perform_step(state)
    end

    NonlinearSolution(state)
end

function perform_step(state::NonlinearState)
    (; alg, u, Au, A, iter, converged) = state
    (; atol) = alg

    u = step(state)
    Au = A(u)
    iter += 1
    converged = Au⋅Au < atol^2

    NonlinearState(alg, u, Au, A, iter, converged)
end

include("newton.jl")
export AbstractNonlinearAlgorithm, Newton
