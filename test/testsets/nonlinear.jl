@testset "Nonlinear" begin

    @testset "Newton" begin

        alg = Newton()

        check_interface(alg, [0.2, 1.3])
        check_accuracy(alg, [[0.2, 1.3]], [9.2817419e-9])
    end

end
