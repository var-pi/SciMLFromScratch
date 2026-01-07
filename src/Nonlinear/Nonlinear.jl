using LinearAlgebra: norm

struct Newton <: AbstractNonlinearAlgorithm 
    maxiter::Int
    atol::Float64
end

function Newton()
    Newton(50, 1e-8)
end

struct NonlinearState{U,F,DF,A}
    u::U             # current iterate
    fu::U            # residual at current iterate
    f::F             # residual function
    df::DF           # Jacobian / derivative function (or nothing)
    alg::A
    iter::Int        # iteration counter
    converged::Bool
end

function init(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm)
    u0 = prob.u0
    f = prob.f
    df = prob.df
    NonlinearState(u0, f(u0), f, df, alg, 0, false)
end

function solve(prob::NonlinearProblem, alg::Newton)
    state = init(prob, alg)

    #return state.u / (1 - 0.1 / 9 * 2.0)

    while !state.converged && state.iter < alg.maxiter
        state = perform_step(state)
    end

    state.u
end

function perform_step(state::NonlinearState)
    (; u, fu, f, df, alg, iter, converged) = state

    u = step(alg, fu, df, u)
    fu = f(u)
    iter += 1
    converged = norm(fu) < alg.atol

    NonlinearState(u, fu, f, df, alg, iter, converged)
end

function step(::Newton, fu, df, u)
    u - df(u) \ fu
end
