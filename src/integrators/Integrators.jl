abstract type ODEAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct OdeState{U,T}
    u::U
    t::T
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; u0, tspan)::AbstractODEProblem) = OdeState(; u = copy(u0), t = tspan[1])

step_condition((; t)::OdeState, (; tspan)::AbstractODEProblem, (; dt)::ODEAlg) =
    t + dt <= tspan[2]

after_step!(state::OdeState, ::AbstractODEProblem, (; dt)::ODEAlg) = state.t += dt

function finalize(state::OdeState)
    state.retcode = Success
    ODESolution(state), ODEDiagnostics(state)
end

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export ODEAlg, ForwardEuler, BackwardEuler, RungeKutta4
