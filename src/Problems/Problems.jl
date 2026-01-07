abstract type AbstractODEProblem <: AbstractSciMLProblem end

struct ODEProblem{F, U, T, P} <: AbstractODEProblem
    f::F
    u0::U
    tspan::T
    p::P
    df::Union{Function, Nothing}
end

function ODEProblem(f, u0, tspan, p)
    ODEProblem(f, u0, tspan, p, nothing)
end

abstract type AbstractOptimizationProblem <: AbstractSciMLProblem end

struct OptimizationProblem{F, U, P, G} <: AbstractOptimizationProblem
    f::F        # The objective function: f(u, p)
    u0::U       # Initial guess
    p::P        # Parameters (useful for SciML context)
    grad::G     # Optional: Analytical gradient function
end

abstract type AbstractNonlinearProblem <: AbstractSciMLProblem end

struct NonlinearProblem{F,U} <: AbstractNonlinearProblem
    f::F
    df::Union{Function, Nothing}
    u0::U
end
