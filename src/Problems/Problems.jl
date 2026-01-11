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

# ---------------------------------------------------------
# LinearProblem
# ---------------------------------------------------------

"""
    LinearProblem(A, b, u0)

Represents a linear operator equation

    A(u) = b

where:

* `A` is an `AbstractLinearOperator`. Solver implementations should rely on operator actions
  rather than explicit matrix representations.
* `b` is the right-hand side.
* `u0` is an initial guess for iterative solvers.

The problem is solver-agnostic and compatible with matrix-free
linear algebra frameworks.
"""
@kwdef struct LinearProblem{Op<:AbstractLinearOperator,B,U} <: AbstractLinearProblem
    A::Op
    b::B
    u0::U
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
@kwdef struct NonlinearProblem{Op<:AbstractNonlinearOperator,U} <: AbstractNonlinearProblem
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
@kwdef struct ODEProblem{F,U,T,P} <: AbstractODEProblem
    f::F
    u0::U
    tspan::T
    p::P
end

# ---------------------------------------------------------
# Exports
# ---------------------------------------------------------

export LinearProblem, NonlinearProblem, ODEProblem
