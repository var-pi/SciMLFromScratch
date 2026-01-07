abstract type AbstractODESolution <: AbstractSciMLSolution end

struct ODESolution{T, U, Prob, A} <: AbstractODESolution
    t::T             # Time points
    u::U             # State values
    retcode::Symbol  # Status (e.g., :Success, :MaxIters)
    prob::Prob       # The original ODEProblem
    alg::A           # The algorithm used
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
