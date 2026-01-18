@testset "Linear" begin

    @testset "Richardson" begin

        alg = Richardson()

        check_interface(alg, zeros(2))
        check_accuracy(alg, [zeros(2)], [2.28777e-9])
    end

end
