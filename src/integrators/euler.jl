import LinearAlgebra: I

struct ForwardEuler <: AbstractODEAlgorithm end
struct BackwardEuler <: AbstractODEAlgorithm end

@inline step(::ForwardEuler, f, u, p, t, dt) = u + dt * f(u, p, t)

@inline function step(::BackwardEuler, f, u, p, t, dt; df, alg = Newton())
    g(x) = x - u - dt * f(x, p, t + dt)
    dg(u_next) = I - dt * df(u_next, p, t + dt)

    prob = NonlinearProblem(g, u)
    solve(prob, alg; df = dg)
end

# --------------------------------

struct NonlinearProblem{F,U}
    f::F
    u0::U
end

abstract type AbstractNonlinearAlgorithm end

struct Newton <: AbstractNonlinearAlgorithm end

function solve(prob::NonlinearProblem, alg::AbstractNonlinearAlgorithm; df)
    error("Nonlinear solve not implemented for $(typeof(alg))")
end

function solve(prob::NonlinearProblem, ::Newton; df)
    f  = prob.f
    u0 = prob.u0

    tol = 1e-8
    maxiter=50

    u = u0
    tol² = tol^2
    for _ in 1:maxiter
        Δ = df(u) \ f(u)
        u -= Δ
        Δ⋅Δ < tol² && break
    end

    u
end
