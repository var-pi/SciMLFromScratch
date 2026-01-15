# ---------------------------------------------------------
# Abstract Problem Types
# ---------------------------------------------------------

"""
    LProb

Base type for linear operator equations of the form

    A(u) = b

Subtypes are expected to hold the operator `A`, an initial guess, 
and the right-hand side `b`. The operator may be represented either 
as a matrix or an `AbstractLinearOperator` that 
supports application via `apply(A, v)` or `A * v`.
"""
abstract type LProb <: AbstractSciMLProblem end

solutionConstructor(::LProb) = LinearSolution
diagnosticsConstructor(::LProb) = LinearDiagnostics

"""
    NLProb

Base type for nonlinear operator equations of the form

    A(u) = 0

where `A` is a nonlinear operator. Subtypes must specify an operator 
and an initial guess but impose no additional structure.
"""
abstract type NLProb <: AbstractSciMLProblem end

solutionConstructor(::NLProb) = NonlinearSolution
diagnosticsConstructor(::NLProb) = NonlinearDiagnostics

"""
    ODEProb

Base type for initial value problems of ordinary differential equations

    u' = f(u, p, t),
    u(t₀) = u₀.

Subtypes should store the vector field `f`, the initial condition `u0`,
the time span, and parameters `p`.
"""
abstract type ODEProb <: AbstractSciMLProblem end

solutionConstructor(::ODEProb) = ODESolution
diagnosticsConstructor(::ODEProb) = ODEDiagnostics


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
@kwdef struct LinearProblem{Op<:AbstractLinearOperator,B,U} <: LProb
    A::Op
    b::B
    u0::U = zero(prototype_in(A))
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
@kwdef struct NonlinearProblem{Op<:AbstractNonlinearOperator,U} <: NLProb
    A::Op
    u0::U = zero(prototype_in(A))
end


# ---------------------------------------------------------
# ODEProblem
# ---------------------------------------------------------

@kwdef struct ODEProblem{U,T} <: ODEProb
    A::OdeOperator
    u0::U
    tspan::T
end

# ---------------------------------------------------------
# Exports
# ---------------------------------------------------------

export LinearProblem, NonlinearProblem, ODEProblem
