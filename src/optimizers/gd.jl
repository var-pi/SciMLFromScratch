struct GradientDescent <: AbstractOptimizer end

function solve(prob::AbstractOptimizationProblem, alg::GradientDescent)
    (; f, u0, p, grad) = prob

    u = u0
    while all(g -> g > 1e-4, grad(u))
        u -= 1e-3grad(u)
    end

    return u
end
