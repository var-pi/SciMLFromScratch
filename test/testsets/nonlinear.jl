using LinearAlgebra: norm

@testset "Nonlinear" begin

    function solve_example(u0, alg)

        f(u) = exp(u) - 1
        df(u) = exp(u)

        prob = NonlinearProblem(f, df, u0)

        u★ = 0.0

        solve(prob, alg), u★, prob, alg
    end

    function check_interface(alg::AbstractNonlinearAlgorithm)

        sol, _, prob, alg = solve_example(0.2, alg)
        (; atol, maxiter) = alg
        (; u, fu, iter, converged) = sol
        (; f, u0) = prob

        @testset "Interface" begin

            @test size(u) == size(u0)
            @test norm(fu) < atol
            @test iter < maxiter
            @test converged
        end
    end

    function check_accuracy(alg::AbstractNonlinearAlgorithm, u0s, errs)

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

    @testset "Newton" begin

        alg = Newton()

        check_interface(alg)
        check_accuracy(alg, [1.0], [9.2817419e-9])
    end

end
