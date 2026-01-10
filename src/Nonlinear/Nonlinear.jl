using LinearAlgebra: ⋅

abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

struct NonlinearState{A,U,Op<:AbstractNonlinearOperator,JOp}
    alg::A
    u::U             # current iterate
    Au::U            # residual at current iterate
    A::Op             # residual function
    J::JOp           # Jacobian / derivative function (or nothing)
    iter::Int        # iteration counter
    converged::Bool
end

function init(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    (; u0, A, J) = prob
    NonlinearState(alg, u0, A(u0), A, J, 0, false)
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
    (; alg, u, Au, A, J, iter, converged) = state
    (; atol) = alg

    u = step(state)
    Au = A(u)
    iter += 1
    converged = Au⋅Au < atol^2

    NonlinearState(alg, u, Au, A, J, iter, converged)
end

include("newton.jl")
export AbstractNonlinearAlgorithm, Newton
