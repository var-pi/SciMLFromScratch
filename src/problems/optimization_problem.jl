abstract type AbstractOptimizationProblem <: AbstractSciMLProblem end

struct OptimizationProblem{F, U, P, G} <: AbstractOptimizationProblem
    f::F        # The objective function: f(u, p)
    u0::U       # Initial guess
    p::P        # Parameters (useful for SciML context)
    grad::G     # Optional: Analytical gradient function
end
