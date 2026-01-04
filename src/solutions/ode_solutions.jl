abstract type AbstractODESolution <: AbstractSciMLSolution end

struct ODESolution{T, U, Prob, A} <: AbstractODESolution
    t::T             # Time points
    u::U             # State values
    retcode::Symbol  # Status (e.g., :Success, :MaxIters)
    prob::Prob       # The original ODEProblem
    alg::A           # The algorithm used
end
