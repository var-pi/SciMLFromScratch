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
    u = copy(u0)
    retcode = :MaxIters
    i = 0
    ng = 0
    t0 = time()

    abstol2 = abstol^2
    reltol2 = reltol^2
    while i < maxiters
        g = grad(u, p)
        ng += 1

        if g⋅g < abstol2 + u⋅u * reltol2
            retcode = :Success
            break
        end

        u -= lr*g
        i += 1
    end

    stats = OptimizationStats(1, ng, 0, i, time() - t0)
    return OptimizationSolution(u, f(u, p), retcode, prob, alg, stats)
end
