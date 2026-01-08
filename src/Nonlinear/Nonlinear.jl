using LinearAlgebra: ⋅

abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

struct NonlinearState{A,U,F,DF}
    alg::A
    u::U             # current iterate
    fu::U            # residual at current iterate
    f::F             # residual function
    df::DF           # Jacobian / derivative function (or nothing)
    iter::Int        # iteration counter
    converged::Bool
end

function init(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    u0 = prob.u0
    f = prob.f
    df = prob.df
    NonlinearState(alg, u0, f(u0), f, df, 0, false)
end

function solve(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    state = init(prob, alg)

    while !state.converged && state.iter < alg.maxiter
        state = perform_step(state)
    end

    NonlinearSolution(state)
end

function perform_step(state::NonlinearState)
    (; alg, u, fu, f, df, iter, converged) = state

    u = step(state)
    fu = f(u)
    iter += 1
    converged = fu⋅fu < alg.atol^2

    NonlinearState(alg, u, fu, f, df, iter, converged)
end

include("newton.jl")
export AbstractNonlinearAlgorithm, Newton
