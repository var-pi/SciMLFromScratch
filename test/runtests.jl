using SciMLFromScratch: GradientDescent
using Test
using StaticArrays: @SVector, @SArray
using SciMLFromScratch
using LinearAlgebra: norm, Diagonal

@testset "Forward Euler" begin

    f = (u, p, t) -> p * u
    u0 = 1.0
    tspan = (0.0, 0.1)
    p = 2.0
    prob = ODEProblem(f, u0, tspan, p)

    n = 10
    sol = solve(prob, ForwardEuler(); n = n)

    @test norm(sol.u .- exp.(2 .* range(tspan..., n))) < 0.005

end

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

@testset "RK4" begin

    tspan = (0.0, 0.1)
    alg = RungeKutta4()
    n = 10

    function _solve(u0)
        f = (u, p, t) -> p * u
        p = 2.0
        prob = ODEProblem(f, u0, tspan, p)
        solve(prob, alg; n = n), prob, alg
    end

    @testset "General" begin
        sol, prob = _solve(1.0)

        @test norm(sol.u .- exp.(2 .* range(tspan..., n))) < 8.8e-10
    end

end

@testset "Backward Euler" begin

    tspan = (0.0, 0.1)
    alg = BackwardEuler()
    n = 10
    p = 2.0

    function _solve(u0)
        f = (u, p, t) -> p * u
        df = (u, p, t) -> Diagonal(fill(p, length(u)))
        prob = ODEProblem(f, u0, tspan, p)
        solve(prob, alg; n = n, df = df), prob, alg
    end

    @testset "General" begin
        sol, prob = _solve([1.0])
        true_u = [[exp(p * t)] for t in range(tspan..., n)]
        @test norm(sol.u .- true_u) < 0.005
    end

end
