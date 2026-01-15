abstract type AbstractODEAlgorithm <: AbstractSciMLAlgorithm end

@kwdef mutable struct OdeState{U,T}
    u::U
    t::T
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; u0, tspan)::AbstractODEProblem) = OdeState(; u = copy(u0), t = tspan[1])

function solve(prob::AbstractODEProblem, alg::AbstractODEAlgorithm; dt)
    state = init(prob)

    while state.t + dt <= prob.tspan[2]
        perform_step!(state, prob, alg; dt)
    end

    state.retcode = Success
    ODESolution(state), ODEDiagnostics(state)
end

function perform_step!(
    state::OdeState,
    prob::AbstractODEProblem,
    alg::AbstractODEAlgorithm;
    dt,
)
    step!(state, prob, alg; dt)
    state.t += dt
    state.iter += 1
end

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export AbstractODEAlgorithm, ForwardEuler, BackwardEuler, RungeKutta4
