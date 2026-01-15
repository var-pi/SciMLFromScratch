using LinearAlgebra: norm, diagm

@testset "Nonlinear" begin

    function solve_example(u0, alg)

        A = NonlinearOperator((y, u) -> y .= exp.(u) .- 1, zeros(2), zeros(2))
        prob = NonlinearProblem(; A, u0)

        u★ = [0.0, 0.0]

        solve(prob, alg), u★, prob
    end

    function check_interface(alg::NLAlg)

        ((; u), (; iter, retcode)), _, (; A, u0) = solve_example([0.2, 1.3], alg)
        (; atol, maxiter) = alg

        @testset "Interface" begin

            @test size(u) == size(u0)
            @test norm(A(u)) < atol
            @test iter < maxiter
            @test retcode == Success
        end
    end

    function check_accuracy(alg::NLAlg, u0s, errs)

        @testset "Accuracy" begin

            for (u0, err) in zip(u0s, errs)

                ((; u), _), u★, _... = solve_example(u0, alg)

                @testset "u0=$(u0)" begin

                    @test norm(u - u★) < err
                end
            end
        end
    end

    @testset "Newton" begin

        alg = Newton()

        check_interface(alg)
        check_accuracy(alg, [[0.2, 1.3]], [9.2817419e-9])
    end

end
