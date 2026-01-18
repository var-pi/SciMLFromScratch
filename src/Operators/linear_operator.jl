using LinearAlgebra: mul!

abstract type AbstractLinearOperator <: AbstractOperator end

struct LinearOperator{F,U,V} <: AbstractLinearOperator
    apply!::F           # (y, u) -> y = A(u)
    prototype_in::U     # u
    prototype_out::V    # y
end

function LinearOperator(M::AbstractMatrix)
    v = zeros(size(M)[1])
    LinearOperator((y, u) -> mul!(y, M, u), v, v)
end

apply!(y, A::LinearOperator, u) = A.apply!(y, u)
