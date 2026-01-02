struct ForwardEuler <: AbstractODEAlgorithm end
using EllipsisNotation
import StaticArrays

function solve(prob::AbstractODEProblem, ::ForwardEuler; dt)
    f = get_f(prob)
    u₀ = get_u₀(prob)
    t₀, t₁ = get_tspan(prob)
    p = get_p(prob)

    ts = t₀:dt:t₁
    n = length(ts)
    us = zeros(typeof(similar(u₀)), n)
    us[1] .= u₀

    u = similar(u₀)
    u .= u₀
    u̇ = similar(u₀)
    for i in 1:(n-1)
        f(u̇, u, p, ts[i])
        @. u = u + dt * u̇
        us[i+1] .= u
    end

    (t=ts, u=us)
end
