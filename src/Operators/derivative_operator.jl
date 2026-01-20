@kwdef struct DerivativeOperator{Op<:AbstractOperator} <: AbstractOperator
    A::Op
    eps::Float64 = 1e-8
end

function apply!(y, (; A, eps)::DerivativeOperator, (u, v))
    apply!(y, A, u .+ eps .* v)
    y .-= A(u)
    y ./= eps
end

prototype_in(Dop::DerivativeOperator) = prototype_in(Dop.A)
prototype_out(Dop::DerivativeOperator) = prototype_out(Dop.A)


@kwdef struct SecondDerivativeOperator{Op<:AbstractOperator} <: AbstractLinearOperator
    A::Op
    eps::Float64 = 1e-5
end

apply!(y, (; A, eps)::SecondDerivativeOperator, (u, v, w)) =
    apply!(y, JvpOperator(; A = DirectionalDerivativeOperator(; A, v, eps), u, eps), w)

prototype_in(Dop::SecondDerivativeOperator) = prototype_in(Dop.A)
prototype_out(Dop::SecondDerivativeOperator) = prototype_out(Dop.A)
