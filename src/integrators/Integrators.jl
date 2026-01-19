@kwdef mutable struct ODEState{U,T} <: AbstractState
    u::U
    t::T
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; u0, tspan)::ODEProb) = ODEState(; u = copy(u0), t = tspan[1])

success_condition((; t)::ODEState, (; tspan)::ODEProb, (; dt)::ODEAlg) = t + dt > tspan[2]

step!(ut, (; A)::ODEProb, alg::ODEAlg) = apply!(ut, StepOperator(; alg, A), ut)

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export ODEAlg, ForwardEuler, BackwardEuler, RungeKutta4
