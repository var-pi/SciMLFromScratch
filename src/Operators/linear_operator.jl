using LinearAlgebra: mul!

abstract type AbstractLinearOperator <: AbstractOperator end

struct LinearOperator{F,I,O} <: AbstractLinearOperator
    apply!::F           # (y, u) -> y = A(u)
    prototype_in::I     # u
    prototype_out::O    # y
end

function LinearOperator(M::AbstractMatrix)
    v = zeros(size(M)[1])
    LinearOperator((y, u) -> mul!(y, M, u), v, v)
end

function apply!(y, A::LinearOperator, u)
    A.apply!(y, u)
end

function apply(A::LinearOperator, u)
    y = similar(A.prototype_out)
    apply!(y, A, u)
    y
end

(A::LinearOperator)(u) = apply(A, u)
