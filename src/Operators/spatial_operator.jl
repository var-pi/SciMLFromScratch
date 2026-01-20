abstract type AbstractSpatialOperator <: AbstractOperator end

abstract type LaplaceOperator <: AbstractSpatialOperator end

function test_laplacian()

    A = NonlinearOperator((y, u) -> y .= u .^ 2, [0.0], [0.0])

    hvvp = HvvpOperator(; A, u = [10.0])
    hvvp(([1.0], [1.0]))
end

export test_laplacian
