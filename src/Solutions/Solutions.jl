abstract type AbstractLinearSolution <: AbstractSciMLSolution end

struct LinearSolution{U} <: AbstractLinearSolution
    u::U           # final solution vector
end

LinearSolution(state::LinearState) = LinearSolution(state.u)

struct LinearDiagnostics
    iter::Int
    retcode::ReturnCode
end

LinearDiagnostics(state::LinearState) = LinearDiagnostics(state.iter, state.retcode)

abstract type AbstractNonlinearSolution <: AbstractSciMLSolution end

struct NonlinearSolution{U} <: AbstractNonlinearSolution
    u::U
    iter::Int
    retcode::ReturnCode
end

function NonlinearSolution(state::NonlinearState)
    (; u, iter, retcode) = state

    NonlinearSolution(u, iter, retcode)
end

abstract type AbstractODESolution <: AbstractSciMLSolution end

struct ODESolution{T,U} <: AbstractODESolution
    t::T                # Time points
    u::U                # State values
    retcode::ReturnCode # Status (e.g., :Success, :MaxIters)
end

function ODESolution(prob, integ, us, retcode)
    (; tspan) = prob
    (; dt) = integ

    ts = StepRangeLen(tspan[1], dt, length(us))

    ODESolution(ts, us, retcode)
end

export LinearSolution, NonlinearSolution, ODESolution
