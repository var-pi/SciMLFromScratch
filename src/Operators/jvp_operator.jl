@kwdef struct JvpOperator{Op<:AbstractOperator,U} <: AbstractLinearOperator
    A::Op   # the residual operator
    u::U    # current point where J is evaluated
    eps::Float64 = 1e-8
end

apply((; A, u, eps)::JvpOperator, v) = (A(u .+ eps .* v) .- A(u)) ./ eps

prototype_in(Jop::JvpOperator) = prototype_in(Jop.A)
prototype_out(Jop::JvpOperator) = prototype_out(Jop.A)
