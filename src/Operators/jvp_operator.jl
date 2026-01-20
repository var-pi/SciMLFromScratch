struct JvpOperator{Op<:DerivativeOperator,U} <: AbstractLinearOperator
    A::Op
    u::U
end

JvpOperator(; A::AbstractOperator, u, eps = 1e-8) =
    JvpOperator(DerivativeOperator(; A, eps), u)

apply!(y, (; A, u)::JvpOperator, v) = apply!(y, A, (u, v))

wrapped_op(A::JvpOperator) = A.A
