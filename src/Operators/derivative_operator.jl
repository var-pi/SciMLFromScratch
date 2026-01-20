@kwdef struct DerivativeOperator{Op<:AbstractOperator} <: AbstractOperator
    A::Op
    eps::Float64 = 1e-8
end

function apply!(y, (; A, eps)::DerivativeOperator, (u, v))
    apply!(y, A, u .+ eps .* v)
    y .-= A(u)
    y ./= eps
end

wrapped_op(D::DerivativeOperator) = D.A

@kwdef struct SecondDerivativeOperator{Op<:AbstractOperator} <: AbstractLinearOperator
    A::Op
    eps::Float64 = 1e-5
end

apply!(y, (; A, eps)::SecondDerivativeOperator, (u, v, w)) =
    apply!(y, JvpOperator(; A = DirectionalDerivativeOperator(; A, v, eps), u, eps), w)

wrapped_op(D::SecondDerivativeOperator) = D.A
