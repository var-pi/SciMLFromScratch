struct Integrator{F, U, P, A, T}
    f::F
    u::U
    p::P
    alg::A
    t::T
    dt::T
end

function init(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; n)
    (; f, u0, tspan, p) = prob
    t0, t1 = tspan
    dt = (t1 - t0) / (n - 1)
    u = u0
    Integrator(f, u, p, alg, t0, dt)
end

function solve(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; n)
    integ = init(prob, alg; n)
    us = Vector{typeof(integ.u)}(undef, n)
    us[1] = integ.u

    @inbounds @fastmath for i in 1:(n-1)
        integ = perform_step(integ)
        us[i+1] = integ.u
    end

    ODESolution(StepRangeLen(prob.tspan[1], integ.dt, n), us, :Success, prob, alg)
end

@inline function perform_step(integ::Integrator)
    (; f, u, p, alg, t, dt) = integ

    u = step(alg, f, u, p, t, dt)
    t += dt

    Integrator(f, u, p, alg, t, dt)
end

include("euler.jl")
include("rk4.jl")
