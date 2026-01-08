using LinearAlgebra: mul!

struct LinearOperator{F} <: AbstractOperator
    apply!::F  # (y, u) -> y = A(u)
end

function apply(A::LinearOperator, u)
    A.apply!(similar(u), u)
end

LinearOperator(A::AbstractMatrix) = LinearOperator((y,u)->mul!(y, A, u))
