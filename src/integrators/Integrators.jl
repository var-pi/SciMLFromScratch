abstract type ODEAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct ODEState{U,T}
    u::U
    t::T
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; u0, tspan)::AbstractODEProblem) = ODEState(; u = copy(u0), t = tspan[1])

step_condition((; t)::ODEState, (; tspan)::AbstractODEProblem, (; dt)::ODEAlg) =
    t + dt <= tspan[2]

after_step!(state::ODEState, ::AbstractODEProblem, (; dt)::ODEAlg) = state.t += dt

function finalize(state::ODEState)
    state.retcode = Success
    ODESolution(state), ODEDiagnostics(state)
end

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export ODEAlg, ForwardEuler, BackwardEuler, RungeKutta4
