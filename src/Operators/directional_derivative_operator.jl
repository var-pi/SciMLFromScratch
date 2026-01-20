@kwdef struct DirectionalDerivativeOperator{Op<:AbstractOperator,V} <: AbstractOperator
    A::Op
    v::V
    eps::Float64 = 1e-8
end

function apply!(y, (; A, v, eps)::DirectionalDerivativeOperator, u)
    apply!(y, A, u .+ eps .* v)
    y .-= A(u)
    y ./= eps
end

prototype_in(ddop::DirectionalDerivativeOperator) = prototype_in(ddop.A)
prototype_out(ddop::DirectionalDerivativeOperator) = prototype_out(ddop.A)
