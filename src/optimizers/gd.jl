struct GradientDescent <: AbstractOptimizer
    lr::Float64
end

function GradientDescent()
    return GradientDescent(1e-5)
end

using LinearAlgebra: ⋅

function solve(prob::AbstractOptimizationProblem, alg::GradientDescent;
               abstol = 1e-6, reltol = 1e-6, maxiters = 10^6)
    (; f, u0, p, grad) = prob
    (; lr) = alg
    u, retcode, i, ng, t0 = u0, :MaxIters, 0, 0, time()
    abstol², reltol² = abstol^2, reltol^2

    @fastmath while i < maxiters
        g = grad(u, p)
        ng += 1

        (g⋅g < abstol² + u⋅u * reltol²) && (retcode = :Success; break)

        u -= lr * g
        i += 1
    end

    OptimizationSolution(u, f(u, p), retcode, prob, alg,
                         OptimizationStats(1, ng, 0, i, time() - t0))
end
