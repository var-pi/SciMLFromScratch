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

function solve(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; n, df = nothing)
    integ = init(prob, alg; n)
    us = Vector{typeof(integ.u)}(undef, n)
    us[1] = integ.u

    @inbounds @fastmath for i in 1:(n-1)
        integ = perform_step(integ; df)
        us[i+1] = integ.u
    end

    ODESolution(prob, integ, us, :Success)
end

@inline function perform_step(integ::Integrator; df)
    (; alg, f, u, p, t, dt) = integ

    u = isnothing(df) ? step(integ) : step(integ; df)
    t += dt

    Integrator(alg, f, u, p, t, dt)
end

include("euler.jl")
include("rk4.jl")
