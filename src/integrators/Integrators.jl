abstract type AbstractODEAlgorithm <: AbstractSciMLAlgorithm end

@kwdef mutable struct OdeState{U,T}
    u::U
    t::T
    retcode::ReturnCode = Default
end

init((; u0, tspan)::AbstractODEProblem) = OdeState(; u = copy(u0), t = tspan[1])

function solve(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; dt)
    integ = init(prob)

    while integ.t + dt <= prob.tspan[2]
        perform_step!(integ, prob, alg; dt)
    end

    integ.retcode = Success
    ODESolution(integ), ODEDiagnostics(Success)
end

function perform_step!(
    integ::OdeState,
    prob::AbstractODEProblem,
    alg::AbstractODEAlgorithm;
    dt,
)
    step!(integ, prob, alg; dt)
    integ.t += dt
end

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export AbstractODEAlgorithm, ForwardEuler, BackwardEuler, RungeKutta4
