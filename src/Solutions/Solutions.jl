# ---------------------------------------------------------
# Abstract Solution Types
# ---------------------------------------------------------

"""
    AbstractLinearSolution

Base type for solutions of linear problems. Subtypes are expected to store the
final solution vector `u`. Additional solver metadata should be placed into the `LinearDiagnostics`.
"""
abstract type AbstractLinearSolution <: AbstractSciMLSolution end

"""
    AbstractNonlinearSolution

Base type for solutions of nonlinear problems. Subtypes store the final solution
vector `u`. Diagnostics such as iteration counts or convergence status are kept
in the `NonlinearDiagnostics`.
"""
abstract type AbstractNonlinearSolution <: AbstractSciMLSolution end

"""
    AbstractODESolution

Base type for solutions of ordinary differential equation problems. Subtypes
store the final state `u`.
"""
abstract type AbstractODESolution <: AbstractSciMLSolution end

# ---------------------------------------------------------
# Linear Solution & Diagnostics
# ---------------------------------------------------------

"""
    LinearSolution(u)

Represents the solution of a linear problem, storing the final solution vector `u`.
"""
struct LinearSolution{U} <: AbstractLinearSolution
    u::U
end

"""
    LinearSolution(state::LinearState)

Outer constructor: builds a `LinearSolution` from a solver `LState`.
"""
LinearSolution(state::LState) = LinearSolution(state.u)

"""
    LinearDiagnostics(iter, retcode)

Stores solver metadata for a linear problem, including iteration count and
termination status.
"""
struct LinearDiagnostics <: AbstractSciMLDiagnostics
    iter::Int
    retcode::ReturnCode
end

"""
    LinearDiagnostics(state::LinearState)

Outer constructor: builds diagnostics from the solver `LState`.
"""
LinearDiagnostics(state::LState) = LinearDiagnostics(state.iter, state.retcode)

# ---------------------------------------------------------
# Nonlinear Solution & Diagnostics
# ---------------------------------------------------------

"""
    NonlinearSolution(u)

Represents the solution of a nonlinear problem, storing the final solution vector `u`.
"""
struct NonlinearSolution{U} <: AbstractNonlinearSolution
    u::U
end

"""
    NonlinearSolution(state::NonlinearState)

Outer constructor: builds a `NonlinearSolution` from a solver `NLState`.
"""
NonlinearSolution(state::NLState) = NonlinearSolution(state.u)

"""
    NonlinearDiagnostics(iter, retcode)

Stores solver metadata for a nonlinear problem, including iteration count and
termination status.
"""
struct NonlinearDiagnostics <: AbstractSciMLDiagnostics
    iter::Int
    retcode::ReturnCode
end

"""
    NonlinearDiagnostics(state::NonlinearState)

Outer constructor: builds diagnostics from the solver `NLState`.
"""
NonlinearDiagnostics(state::NLState) = NonlinearDiagnostics(state.iter, state.retcode)

# ---------------------------------------------------------
# ODE Solution & Diagnostics
# ---------------------------------------------------------

"""
    ODESolution(u)

Represents the solution of an ODE problem. Stores the final state `u`. Intermediate
time steps can be optionally stored via callbacks if needed.
"""
struct ODESolution{U} <: AbstractODESolution
    u::U
end

"""
    ODESolution(integ::Integrator)

Outer constructor: builds an `ODESolution` from an integrator state.
"""
ODESolution(integ::ODEState) = ODESolution(integ.u)

"""
    ODEDiagnostics(retcode)

Stores solver metadata for an ODE problem, including termination status.
"""
struct ODEDiagnostics <: AbstractSciMLDiagnostics
    retcode::ReturnCode
end

ODEDiagnostics(state::ODEState) = ODEDiagnostics(state.retcode)
