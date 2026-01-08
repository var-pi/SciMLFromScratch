using LinearAlgebra: ⋅

@testset "Optimizers" begin

    function solve_example(u0, alg)
        f = (u, p) -> u⋅u
        grad = (u, p) -> 2 .* u
        p = nothing
        prob = OptimizationProblem(f, u0, p, grad)
        solve(prob, alg), prob, alg
    end

    function check_interface(alg)
        sol, prob, alg = solve_example(1.0, alg)

        @testset "Interface" begin

            @test size(sol.u) == size(prob.u0)
            @test sol.retcode == :Success
            @test sol.prob === prob
            @test sol.alg === alg
            @test sol.stats.niter <= 66
            @test sol.stats.time < 1e-5
        end
    end

    @testset "Gradient Descent" begin 

        alg = GradientDescent()

        check_interface(alg)
    end
end
