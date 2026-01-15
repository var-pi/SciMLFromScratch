@kwdef struct ForwardEuler{T} <: ODEAlg
    dt::T = 0.01
end

step!((; u, t)::OdeState, (; A)::AbstractODEProblem, (; dt)::ForwardEuler) =
    u .+= dt .* A((u, t))
