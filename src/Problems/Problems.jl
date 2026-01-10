# ---------------------------------------------------------
# Abstract Problem Types
# ---------------------------------------------------------

"""
    AbstractLinearProblem

Base type for linear operator equations of the form

    A(u) = b

Subtypes are expected to hold the operator `A`, an initial guess, 
and the right-hand side `b`. The operator may be represented either 
as a matrix or an `AbstractLinearOperator` that 
supports application via `apply(A, v)` or `A * v`.
"""
abstract type AbstractLinearProblem <: AbstractSciMLProblem end

"""
    AbstractNonlinearProblem

Base type for nonlinear operator equations of the form

    A(u) = 0

where `A` is a nonlinear operator. Subtypes must specify an operator 
and an initial guess but impose no additional structure.
"""
abstract type AbstractNonlinearProblem <: AbstractSciMLProblem end

"""
    AbstractODEProblem

Base type for initial value problems of ordinary differential equations

    u' = f(u, p, t),
    u(t₀) = u₀.

Subtypes should store the vector field `f`, the initial condition `u0`,
the time span, and parameters `p`.
"""
abstract type AbstractODEProblem <: AbstractSciMLProblem end

"""
    AbstractOptimizationProblem

Base type for optimization problems of the form

    minimize f(u, p)

Subtypes are expected to store an objective function, initial guess,
parameters, and optionally an analytical gradient when provided.
"""
abstract type AbstractOptimizationProblem <: AbstractSciMLProblem end


# ---------------------------------------------------------
# LinearProblem
# ---------------------------------------------------------

"""
    LinearProblem(A, u0, b)

Represents a linear operator equation

    A(u) = b

where:

* `A` is an `AbstractLinearOperator`. Solver implementations should rely on operator actions
  rather than explicit matrix representations.
* `u0` is an initial guess for iterative solvers.
* `b` is the right-hand side.

The problem is solver-agnostic and compatible with matrix-free
linear algebra frameworks.
"""
struct LinearProblem{Op<:AbstractLinearOperator,U,B} <: AbstractLinearProblem
    A::Op
    u0::U
    b::B
end


# ---------------------------------------------------------
# NonlinearProblem
# ---------------------------------------------------------

"""
    NonlinearProblem(A, u0)

Represents a nonlinear operator equation

    A(u) = 0

where:

* `A` is an `AbstractNonlinearOperator` implementing `A(u)`.
* `u0` is an initial guess for a root-finding or nonlinear solver.

External constructions (e.g. finite-difference JVP operators) may be used
to approximate derivatives for Newton-type solvers.
"""
struct NonlinearProblem{Op<:AbstractNonlinearOperator,U} <: AbstractNonlinearProblem
    A::Op
    u0::U
end


# ---------------------------------------------------------
# ODEProblem
# ---------------------------------------------------------

"""
    ODEProblem(f, u0, tspan, p)

Defines an ordinary differential equation initial value problem:

    u' = f(u, p, t),
    u(t₀) = u₀.

Arguments:

* `f` — vector field `(u, p, t) -> ...`
* `u0` — initial condition
* `tspan` — tuple `(t0, t1)`
* `p` — parameters passed to the vector field

This type is solver-agnostic and provides the minimal structural
information required by explicit, implicit, and adaptive ODE solvers.
"""
struct ODEProblem{F, U, T, P} <: AbstractODEProblem
    f::F
    u0::U
    tspan::T
    p::P
end


# ---------------------------------------------------------
# OptimizationProblem
# ---------------------------------------------------------

"""
    OptimizationProblem(f, u0, p, grad)

Represents an optimization problem

    minimize f(u, p)

where:

* `f` is an objective function of the form `f(u, p)`.
* `u0` is the initial guess.
* `p` are optional parameters.
* `grad` is an optional analytical gradient function `(u, p) -> ∇f`.

If `grad` is `nothing`, gradient-based solvers may approximate derivatives
numerically or via automatic differentiation.
"""
struct OptimizationProblem{F, U, P, G} <: AbstractOptimizationProblem
    f::F
    u0::U
    p::P
    grad::G
end


# ---------------------------------------------------------
# Exports
# ---------------------------------------------------------

export ODEProblem, OptimizationProblem, NonlinearProblem, LinearProblem
