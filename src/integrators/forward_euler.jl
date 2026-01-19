@kwdef struct ForwardEuler{T} <: ODEAlg
    dt::T = 0.01
end

function apply!(y, (; alg, A)::StepOperator{<:ForwardEuler}, (; u, t))
    (; dt) = alg

    y.u .= u .+ dt .* A((u, t))
    y.t = t + dt
end
