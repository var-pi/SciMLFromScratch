struct JvpOperator{F,U} <: AbstractOperator
    F::F      # the residual operator
    u::U      # current point where J is evaluated
    eps::Float64
end

function apply(Jv::JvpOperator, v)
    F = Jv.F
    u = Jv.u
    ε = Jv.eps
    return (apply(F, u .+ ε .* v) .- apply(F, u)) ./ ε
end
