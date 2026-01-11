using StaticArrays: @SVector, @SArray
using LinearAlgebra: norm, Diagonal, I

@testset "Integrators" begin

    function solve_example(u0, alg)
        prob = ODEProblem(; f = (u, p, t) -> p * u, u0, tspan = (0.0, 0.1), p = 2.0)
        n = 10
        solve(prob, alg; n = n), n, prob.tspan, prob.p, prob, prob.f
    end

    function check_interface(alg::AbstractODEAlgorithm)

        sol, n, tspan, p, prob, f = solve_example([1.0], alg)
        (; retcode) = sol

        ts = range(tspan..., n)

        @testset "Interface" begin

            @test length(sol.t) == length(ts)
            @test all(t -> t[1] ≈ t[2], zip(sol.t, ts))
            @test retcode == Success

        end

    end

    function check_accuracy(alg::AbstractODEAlgorithm, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)
                sol, n, tspan, p, _... = solve_example(u0, alg)

                ts = range(tspan..., n)
                us = [u0 .* exp(p * t) for t in ts]

                @testset "u0=$(u0)" begin

                    @test norm(sol.u - us) < err
                end
            end
        end
    end

    @testset "Forward Euler" begin

        alg = ForwardEuler()

        check_interface(alg)
        check_accuracy(alg, [[1.0], @SArray([2.0; 3.0])], [0.00482, 0.01736])

    end

    @testset "RK4" begin

        alg = RungeKutta4()

        check_interface(alg)
        check_accuracy(alg, [[1.0], @SArray([2.0; 3.0])], [8.7782e-10, 3.1651e-9])

    end

    @testset "Backward Euler" begin

        alg = BackwardEuler()

        check_interface(alg)
        check_accuracy(alg, [@SVector([1.0;])], [0.00497])

    end

end
