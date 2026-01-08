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

abstract type AbstractOptimizationSolution <: AbstractSciMLSolution end

struct OptimizationStats
    nf::Int         # Number of function evaluations
    ng::Int         # Number of gradient evaluations
    nh::Int         # Number of Hessian evaluations
    niter::Int      # Total iterations performed
    time::Float64   # Total time in seconds
end

struct OptimizationSolution{U, O, P, A} <: AbstractOptimizationSolution
    u::U            # Optimized parameters
    objective::O    # f(u, p)
    retcode::Symbol # :Success, :MaxIters, etc.
    prob::P         # The original problem
    alg::A          # Algorithm used
    stats::OptimizationStats
end

abstract type AbstractNonlinearSolution <: AbstractSciMLSolution end

struct NonlinearSolution{U} <: AbstractNonlinearSolution
    u::U
    fu::U
    iter::Int
    converged::Bool
end

function NonlinearSolution(state::NonlinearState)
    (; u, fu, iter, converged) = state

    NonlinearSolution(u, fu, iter, converged)
end

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

export ODESolution, OptimizationSolution, NonlinearSolution, LinearSolution
