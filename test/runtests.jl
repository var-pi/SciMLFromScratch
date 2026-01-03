using Test
using StaticArrays: @SVector
using SciMLFromScratch

@testset "ForwardEuler algorithm" begin
    # Linear scalar ODE: u̇ = λu, exact solution u(t) = u0 * exp(λt)
    λ = 2.0
    f(u, p, t) = λ * u

    u0 = @SVector [1.0]
    tspan = (0.0, 1.0)
    prob = ODEProblem(f, u0, tspan, nothing)

    n = 3
    sol = solve(prob, ForwardEuler(); n = n)

    @testset "Time grid" begin
        @test length(sol.t) == n
        @test sol.t[1] == tspan[1]
        @test sol.t[end] == tspan[2]

        dt = sol.t[2] - sol.t[1]
        @test sol.t[3] - sol.t[2] == dt
    end

    @testset "State values" begin
        @test length(sol.u) == n
        @test sol.u[1] == u0

        dt = (tspan[2] - tspan[1]) / (n - 1)

        # Forward Euler update: u_{k+1} = (1 + λ dt) u_k
        expected_u2 = u0 * (1 + λ * dt)
        expected_u3 = expected_u2 * (1 + λ * dt)

        @test sol.u[2] ≈ expected_u2
        @test sol.u[3] ≈ expected_u3
    end

    @testset "Solution metadata" begin
        @test sol.prob === prob
        @test sol.alg isa ForwardEuler
        @test sol.retcode === :Success
    end

    @testset "Type stability" begin
        @test eltype(sol.u) === typeof(u0)
        @test sol.u isa Vector{typeof(u0)}
    end
end
