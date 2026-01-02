struct ForwardEuler <: AbstractODEAlgorithm end
using StaticArrays: MArray, MVector

function solve(prob::AbstractODEProblem, ::ForwardEuler; dt)
    f = get_f(prob)
    u₀ = get_u0(prob)
    t₀, t₁ = get_tspan(prob)
    p = get_p(prob)

    ts = t₀:dt:t₁
    us = similar(ts, typeof(u₀))
    us[1] = copy(u₀)

    u̇ = similar(u₀)
    for i in 1:(length(ts)-1)
        u = us[i]
        f(u̇, u, p, ts[i])
        us[i+1] = @. u + dt * u̇
    end

    return (t=ts, u=us)
end
