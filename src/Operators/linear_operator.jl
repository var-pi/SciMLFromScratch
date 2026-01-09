using LinearAlgebra: mul!

abstract type AbstractLinearOperator <: AbstractOperator end

struct LinearOperator{F,I,O} <: AbstractLinearOperator
    apply!::F           # (y, u) -> y = A(u)
    prototype_in::I     # u
    prototype_out::O    # y
end

function apply!(y, A::LinearOperator, u)
    A.apply!(y, u)
end

function apply(A::LinearOperator, u)
    y = similar(A.prototype_out)
    apply!(y, A, u)
    y
end
