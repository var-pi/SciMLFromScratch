using StaticArrays: @SVector, @SArray
using LinearAlgebra: norm, Diagonal, I

@testset "Integrators" begin

    function solve_example(u0, alg)
        prob = ODEProblem(; f = (u, p, t) -> p * u, u0, tspan = (0.0, 0.1), p = 2.0)
        n = 10
        solve(prob, alg; n = n), n, prob.tspan, prob.p, prob, prob.f
    end

    function check_interface(alg::AbstractODEAlgorithm)

        (_, diag), n, tspan, p, prob, f = solve_example([1.0], alg)
        (; retcode) = diag

        @testset "Interface" begin

            @test retcode == Success

        end

    end

    function check_accuracy(alg::AbstractODEAlgorithm, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)
                (sol, _), n, tspan, p, _... = solve_example(u0, alg)

                u = u0 .* exp(p * tspan[2])

                @testset "u0=$(u0)" begin

                    @test norm(sol.u - u) < err
                end
            end
        end
    end

    @testset "Forward Euler" begin

        alg = ForwardEuler()

        check_interface(alg)
        check_accuracy(alg, [[1.0], @SArray([2.0; 3.0])], [0.0026718, 0.0096332])

    end

    @testset "RK4" begin

        alg = RungeKutta4()

        check_interface(alg)
        check_accuracy(alg, [[1.0], @SArray([2.0; 3.0])], [4.8733e-10, 1.7571e-9])

    end

    @testset "Backward Euler" begin

        alg = BackwardEuler()

        check_interface(alg)
        check_accuracy(alg, [@SVector([1.0;])], [0.0027583])

    end

end
