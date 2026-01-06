using Test

@testset "Optimizers" begin

@testset "Gradient Descent" begin 

    function _solve(u0)
        f = (u, p) -> u .^ p
        p = 2.0
        grad = (u, p) -> p*u
        prob = OptimizationProblem(f, u0, p, grad)
        alg = GradientDescent(1e-1)
        solve(prob, alg), prob, alg
    end

    @testset "General" begin
        sol, prob, alg = _solve(1.0)
        @test norm(sol.u) < 1e-5
        @test norm(sol.objective) < 1e-12
        @test sol.prob === prob
        @test sol.alg === alg
        @test sol.retcode == :Success
        @test sol.stats.time < 1e-6
        @test sol.stats.niter <= 66
    end

    @testset "SArray" begin
        sol, _... = _solve(@SArray([2.0; 3.0]))
        @test sol.retcode == :Success
    end
end

end
