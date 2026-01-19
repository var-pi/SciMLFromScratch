@kwdef struct ForwardEuler{T} <: ODEAlg
    dt::T = 0.01
end

function apply!(y::ODEState, (; alg, A)::StepOperator{<:ForwardEuler}, (; u, t)::ODEState)
    (; dt) = alg
    y.u .= u .+ dt .* A((u, t))
    y.t = t + dt
end
