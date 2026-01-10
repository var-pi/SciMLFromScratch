abstract type AbstractODEAlgorithm <: AbstractSciMLAlgorithm end

struct Integrator{A, F, U, P, T}
    alg::A
    f::F
    u::U
    p::P
    t::T
    dt::T
end

function init(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; n)
    (; f, u0, tspan, p) = prob

    t0, t1 = tspan
    dt = (t1 - t0) / (n - 1)
    u = u0

    Integrator(alg, f, u, p, t0, dt)
end

function solve(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; n)
    integ = init(prob, alg; n)
    us = Vector{typeof(integ.u)}(undef, n)
    us[1] = integ.u

    @inbounds @fastmath for i in 1:(n-1)
        integ = perform_step(integ)
        us[i+1] = integ.u
    end

    ODESolution(prob, integ, us, :Success)
end

function perform_step(integ::Integrator)
    (; alg, f, u, p, t, dt) = integ

    u = step(integ)
    t += dt

    Integrator(alg, f, u, p, t, dt)
end

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export AbstractODEAlgorithm, ForwardEuler, BackwardEuler, RungeKutta4
