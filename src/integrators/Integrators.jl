@kwdef mutable struct ODEState{U,T} <: AbstractState
    u::U
    t::T
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; u0, tspan)::ODEProb) = ODEState(; u = copy(u0), t = tspan[1])

success_condition((; t)::ODEState, (; tspan)::ODEProb, (; dt)::ODEAlg) = t + dt > tspan[2]

function apply!(y, S::StepOperator{<:ODEAlg}, (; u, t))
    _apply!(y, S, (; u, t))
    y.t = t + S.alg.dt
end

include("forward_euler.jl")
include("backward_euler.jl")
include("rk4.jl")
export ODEAlg, ForwardEuler, BackwardEuler, RungeKutta4
