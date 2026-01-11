abstract type AbstractLinearSolution <: AbstractSciMLSolution end

struct LinearSolution{U} <: AbstractLinearSolution
    u::U           # final solution vector
end

LinearSolution(state::LinearState) = LinearSolution(state.u)

struct LinearDiagnostics <: AbstractSciMLDiagnostics
    iter::Int
    retcode::ReturnCode
end

LinearDiagnostics(state::LinearState) = LinearDiagnostics(state.iter, state.retcode)

abstract type AbstractNonlinearSolution <: AbstractSciMLSolution end

struct NonlinearSolution{U} <: AbstractNonlinearSolution
    u::U
end

NonlinearSolution(state::NonlinearState) = NonlinearSolution(state.u)

struct NonlinearDiagnostics <: AbstractSciMLDiagnostics
    iter::Int
    retcode::ReturnCode
end

NonlinearDiagnostics(state::NonlinearState) =
    NonlinearDiagnostics(state.iter, state.retcode)

abstract type AbstractODESolution <: AbstractSciMLSolution end

struct ODESolution{U} <: AbstractODESolution
    u::U                # State values
end

function ODESolution(integ::Integrator)
    (; u) = integ

    ODESolution(u)
end

struct ODEDiagnostics <: AbstractSciMLDiagnostics
    retcode::ReturnCode # Status (e.g., :Success, :MaxIters)
end

export LinearSolution, NonlinearSolution, ODESolution
