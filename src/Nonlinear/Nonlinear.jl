using LinearAlgebra: ⋅

abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

struct NonlinearState{A,U,V,Op<:AbstractNonlinearOperator}
    alg::A
    u::U             # current iterate
    Au::V            # residual at current iterate
    A::Op             # residual function
    iter::Int        # iteration counter
    retcode::ReturnCode
end

function init(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    (; A, u0) = prob
    NonlinearState(alg, u0, A(u0), A, 0, Default)
end

function solve(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    state = init(prob, alg)
    (; maxiter) = alg

    while state.retcode == Default && state.iter < maxiter
        state = perform_step(state)
    end

    NonlinearSolution(state)
end

function perform_step(state::NonlinearState)
    (; alg, u, Au, A, iter, retcode) = state
    (; atol) = alg

    u = step(state)
    Au = A(u)
    iter += 1
    (Au⋅Au < atol^2) && (retcode = Success)

    NonlinearState(alg, u, Au, A, iter, retcode)
end

include("newton.jl")
export AbstractNonlinearAlgorithm, Newton
