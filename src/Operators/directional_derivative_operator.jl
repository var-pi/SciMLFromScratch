struct DirectionalDerivativeOperator{Op<:DerivativeOperator,V} <: AbstractOperator
    A::Op
    v::V
end

DirectionalDerivativeOperator(; A::AbstractOperator, v, eps = 1e-8) =
    JvpOperator(DerivativeOperator(; A, eps), v)

apply!(y, (; A, v)::DirectionalDerivativeOperator, u) = apply!(y, A, (u, v))

prototype_in(ddop::DirectionalDerivativeOperator) = prototype_in(ddop.A)
prototype_out(ddop::DirectionalDerivativeOperator) = prototype_out(ddop.A)
