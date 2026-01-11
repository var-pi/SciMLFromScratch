abstract type AbstractLinearSolution <: AbstractSciMLSolution end

struct LinearSolution{U,R} <: AbstractLinearSolution
    u::U           # final solution vector
    r::R           # final residual vector
    iter::Int      # number of iterations performed
    converged::Bool
end

function LinearSolution(state::LinearState)
    (; u, r, iter, converged) = state

    LinearSolution(u, r, iter, converged)
end

abstract type AbstractNonlinearSolution <: AbstractSciMLSolution end

struct NonlinearSolution{I,O} <: AbstractNonlinearSolution
    u::I
    Au::O
    iter::Int
    converged::Bool
end

function NonlinearSolution(state::NonlinearState)
    (; u, Au, iter, converged) = state

    NonlinearSolution(u, Au, iter, converged)
end

abstract type AbstractODESolution <: AbstractSciMLSolution end

struct ODESolution{T, U, Prob, A} <: AbstractODESolution
    t::T             # Time points
    u::U             # State values
    retcode::Symbol  # Status (e.g., :Success, :MaxIters)
    prob::Prob       # The original ODEProblem
    alg::A           # The algorithm used
end

function ODESolution(prob, integ, us, retcode)
    (; tspan) = prob
    (; alg, dt) = integ

    ts = StepRangeLen(tspan[1], dt, length(us))

    ODESolution(ts, us, retcode, prob, alg)
end

export LinearSolution, NonlinearSolution, ODESolution
