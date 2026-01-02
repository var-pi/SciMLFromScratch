abstract type AbstractODEProblem <: AbstractSciMLProblem end

struct ODEProblem{F, U, T, P} <: AbstractODEProblem
    f::F
    u0::U
    tspan::T
    p::P
end
