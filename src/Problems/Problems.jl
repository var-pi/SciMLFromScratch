using LinearAlgebra: UniformScaling

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

struct _NonlinearProblem{A,U} <: AbstractNonlinearProblem
    A::A # A(u) = 0, nonlinear operator
    u0::U
end

abstract type AbstractLinearProblem <: AbstractSciMLProblem end

struct LinearProblem{TA,Tu,Tb} <: AbstractLinearProblem
    A::TA      # Function: A(u)
    u0::Tu     # Initial guess
    b::Tb      # Right-hand side
end

function LinearProblem(A::Union{AbstractArray, Number, UniformScaling}, u0, b)
    LinearProblem(u -> A * u, u0, b)
end

export ODEProblem, OptimizationProblem, NonlinearProblem, LinearProblem
