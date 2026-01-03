abstract type AbstractODESolution <: AbstractSciMLSolution end

struct ODESolution{T, U, Prob, A} <: AbstractODESolution
    t::T             # Time points
    u::U             # State values
    prob::Prob       # The original ODEProblem
    alg::A           # The algorithm used
    retcode::Symbol  # Status (e.g., :Success, :MaxIters)
end
