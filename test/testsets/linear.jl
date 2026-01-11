using LinearAlgebra: norm, mul!

@testset "Linear" begin

    function solve_example(u0, alg)

        M = [4.0 1.0; 1.0 3.0]
        A = LinearOperator((y, u) -> mul!(y, M, u), zeros(2), zeros(2))
        b = [6.0; 7.0]

        prob = LinearProblem(; A, b, u0)

        u★ = [1.0; 2.0]

        solve(prob, alg), u★, prob, alg
    end

    function check_interface(alg::AbstractLinearAlgorithm)

        sol, _, prob, alg = solve_example(zeros(2), alg)
        (; atol, maxiter) = alg
        (; u, r, iter, converged) = sol
        (; A, u0, b) = prob

        @testset "Interface" begin

            @test size(u) == size(u0)
            @test norm(A(u) - b) < atol
            @test size(r) == size(u0)
            @test iter < maxiter
            @test converged
        end
    end

    function check_accuracy(alg::AbstractLinearAlgorithm, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)

                sol, u★, _... = solve_example(u0, alg)
                (; u) = sol

                @testset "u0=$(u0)" begin

                    @test norm(u - u★) < err
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
