@kwdef struct JvpOperator{Op<:AbstractOperator,U} <: AbstractLinearOperator
    A::Op   # the residual operator
    u::U    # current point where J is evaluated
    eps::Float64 = 1e-8
end

function apply(Jv::JvpOperator, v)
    (; A, u, eps) = Jv
    ε = eps
    return (A(u .+ ε .* v) .- A(u)) ./ ε
end

prototype_in(Jvp::JvpOperator) = Jvp.u
prototype_out(Jvp::JvpOperator) = prototype_out(Jvp.A)
