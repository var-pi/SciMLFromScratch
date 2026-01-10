using LinearAlgebra: UniformScaling

abstract type AbstractLinearProblem <: AbstractSciMLProblem end

struct LinearProblem{Op<:AbstractLinearOperator,U,B} <: AbstractLinearProblem
    A::Op      # Operator: A(u)
    u0::U     # Initial guess
    b::B      # Right-hand side
end

function LinearProblem(A::Union{AbstractArray, Number, UniformScaling}, u0, b)
    LinearProblem(u -> A * u, u0, b)
end

abstract type AbstractNonlinearProblem <: AbstractSciMLProblem end

struct NonlinearProblem{Op<:AbstractNonlinearOperator,U} <: AbstractNonlinearProblem
    A::Op # A(u) = 0, nonlinear operator
    u0::U
end

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

export ODEProblem, OptimizationProblem, NonlinearProblem, LinearProblem
