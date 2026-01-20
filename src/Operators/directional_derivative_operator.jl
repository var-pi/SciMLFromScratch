struct DirectionalDerivativeOperator{Op<:DerivativeOperator,V} <: AbstractOperator
    A::Op
    v::V
end

DirectionalDerivativeOperator(; A::AbstractOperator, v, eps = 1e-8) =
    JvpOperator(DerivativeOperator(; A, eps), v)

apply!(y, (; A, v)::DirectionalDerivativeOperator, u) = apply!(y, A, (u, v))

wrapped_op(D::DirectionalDerivativeOperator) = D.A
