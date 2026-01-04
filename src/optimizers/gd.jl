struct GradientDescent <: AbstractOptimizer
    lr::Float64
end
using LinearAlgebra: norm

function solve(prob::AbstractOptimizationProblem, alg::GradientDescent;
               abstol, reltol = 0.0, maxiters = 10^3)
    (; f, u0, p, grad) = prob
    (; lr) = alg
    u = copy(u0)
    retcode = :MaxIters
    i = 0
    t0 = time()

    while i < maxiters
        g = grad(u, p)

        if norm(g) < abstol + norm(u) * reltol
            retcode = :Success
            break
        end

        u -= lr*g
        i += 1
    end

    stats = OptimizationStats(1, i, 0, i, time() - t0)
    return OptimizationSolution(u, f(u, p), retcode, prob, alg, stats)
end
