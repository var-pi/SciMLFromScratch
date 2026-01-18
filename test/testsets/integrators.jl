using LinearAlgebra: norm, Diagonal, I

@testset "Integrators" begin

    @testset "Forward Euler" begin

        alg = ForwardEuler()

        check_interface(alg, [1.0])
        check_accuracy(alg, [[1.0], [2.0; 3.0]], [0.0024084, 0.0086834])

    end

    @testset "RK4" begin

        alg = RungeKutta4()

        check_interface(alg, [1.0])
        check_accuracy(alg, [[1.0], [2.0; 3.0]], [3.2033e-10, 1.1550e-9])

    end

    @testset "Backward Euler" begin

        alg = BackwardEuler()

        check_interface(alg, [1.0])
        check_accuracy(alg, [[1.0;]], [0.0024784])

    end

end
