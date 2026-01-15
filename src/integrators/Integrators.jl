abstract type ODEAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct ODEState{U,T}
    u::U
    t::T
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; u0, tspan)::ODEProb) = ODEState(; u = copy(u0), t = tspan[1])

step_condition((; t)::ODEState, (; tspan)::ODEProb, (; dt)::ODEAlg) = t + dt <= tspan[2]

after_step!(state::ODEState, ::ODEProb, (; dt)::ODEAlg) = state.t += dt

finalize(state::ODEState) = state.retcode = Success

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export ODEAlg, ForwardEuler, BackwardEuler, RungeKutta4
