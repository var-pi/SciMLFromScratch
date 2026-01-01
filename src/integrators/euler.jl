struct ForwardEuler <: AbstractODEAlgorithm end

function solve(prob::AbstractODEProblem, ::ForwardEuler; dt)
    f = get_f(prob)
    u = copy(get_u0(prob))
    t₀, t₁ = get_tspan(prob)
    p = get_p(prob)

    ts = t₀:dt:t₁
    us = Vector{typeof(u)}(undef, length(ts))
    us[1] = copy(u)

    for (i, t) in enumerate(ts[1:end-1])
        u += dt * f(u, p, t)
        us[i+1] = u
    end

    return (t=ts, u=us)
end
