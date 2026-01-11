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

        (sol, diag), _, prob, alg = solve_example(zeros(2), alg)
        (; atol, maxiter) = alg
        (; u), (; iter, retcode) = sol, diag
        (; A, u0, b) = prob

        @testset "Interface" begin

            @test size(u) == size(u0)
            @test norm(A(u) - b) < atol
            @test iter < maxiter
            @test retcode == Success
        end
    end

    function check_accuracy(alg::AbstractLinearAlgorithm, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)

                (sol, _), u★, _... = solve_example(u0, alg)
                (; u) = sol

                @testset "u0=$(u0)" begin

                    @test norm(u - u★) < err
                end
            end
        end
    end

    @testset "Richardson" begin

        alg = Richardson()

        check_interface(alg)
        check_accuracy(alg, [zeros(2)], [2.28777e-9])
    end

end
