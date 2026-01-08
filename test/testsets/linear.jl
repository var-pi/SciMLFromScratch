using LinearAlgebra: norm

@testset "Linear" begin

    function solve_example(u0, alg)

        A = [4.0 1.0; 1.0 3.0]         # SPD 2x2 matrix
        b = [6.0, 7.0]                 # RHS

        prob = LinearProblem(A, u0, b)

        u = [1.0, 2.0]

        solve(prob, alg), u, prob, alg
    end

    function check_interface(alg::AbstractLinearAlgorithm)

        sol, _, prob, alg = solve_example(zeros(2), alg)
        (; atol) = alg, maxiter

        @testset "Interface" begin

            @test size(sol.u) == size(prob.u0)
            @test norm(prob.A * sol.u - prob.b) < atol
            @test size(sol.r) == size(prob.u0)
            @test sol.iter < maxiter
            @test sol.converged
        end
    end

    function check_accuracy(alg::AbstractLinearAlgorithm, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)
                sol, u, _... = solve_example(u0, alg)

                @testset "u0=$(u0)" begin

                    @test norm(sol.u - u) < err
                end
            end
        end
    end

    @testset "Richardson" begin

        α = 0.2                        # Richardson relaxation parameter
        atol = 1e-8
        maxiter = 100
        alg = Richardson(α, atol, maxiter)

        check_interface(alg)
        check_accuracy(alg, [zeros(2)], [2.28777e-9])
    end

end
