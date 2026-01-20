@kwdef struct HvvpOperator{Op<:AbstractOperator,U} <: AbstractLinearOperator
    A::Op
    u::U
    eps::Float64 = 1e-5
end

apply!(y, (; A, u, eps)::HvvpOperator, (v, w)) =
    apply!(y, JvpOperator(; A = DirectionalDerivativeOperator(; A, v, eps), u, eps), w)

prototype_in(Hop::HvvpOperator) = prototype_in(Hop.A)
prototype_out(Hop::HvvpOperator) = prototype_out(Hop.A)
