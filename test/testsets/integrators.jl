using LinearAlgebra: norm, Diagonal, I

@testset "Integrators" begin

    function solve_example(u0, alg)
        prob = ODEProblem(;
            A = OdeOperator((y, u, p, t) -> y .= p .* u, 2.0, zero(u0), zero(u0)),
            u0,
            tspan = (0.0, 0.1),
        )
        dt = 0.01
        solve(prob, alg; dt), dt, prob.tspan, prob.A.p, prob, prob.A
    end

    function check_interface(alg::AbstractODEAlgorithm)

        (_, diag), dt, tspan, p, prob, f = solve_example([1.0], alg)
        (; retcode) = diag

        @testset "Interface" begin

            @test retcode == Success

        end

    end

    function check_accuracy(alg::AbstractODEAlgorithm, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)
                (sol, _), dt, tspan, p, _... = solve_example(u0, alg)

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
        check_accuracy(alg, [[1.0], [2.0; 3.0]], [0.0024084, 0.0086834])

    end

    @testset "RK4" begin

        alg = RungeKutta4()

        check_interface(alg)
        check_accuracy(alg, [[1.0], [2.0; 3.0]], [3.2033e-10, 1.1550e-9])

    end

    @testset "Backward Euler" begin

        alg = BackwardEuler()

        check_interface(alg)
        check_accuracy(alg, [[1.0;]], [0.0024784])

    end

end
