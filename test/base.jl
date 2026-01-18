using LinearAlgebra: norm

function check_interface(alg::AbstractSciMLAlgorithm, u0)

    (_, (; retcode)), _, _ = solve_example(alg, u0)

    @testset "Interface" begin
        @test retcode == Success
    end
end

function check_accuracy(alg::AbstractSciMLAlgorithm, u0s, errs)

    @testset "Accuracy" begin

        for (u0, err) in zip(u0s, errs)
            (sol, _), u★, _ = solve_example(alg, u0)

            @testset "u0=$(u0)" begin
                @test norm(sol.u - u★) < err
            end
        end
    end
end
