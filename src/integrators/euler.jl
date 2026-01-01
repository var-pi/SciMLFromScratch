struct ForwardEuler <: AbstractODEAlgorithm end

function solve(prob::AbstractODEProblem, ::ForwardEuler; dt)
    println("Works?")

    f = get_f(prob)
    u = copy(get_u0(prob))
    t₀, t₁ = get_tspan(prob)
    p = get_p(prob)

    ts = t₀:dt:t₁
    us = [copy(u)]

    for t in ts[1:end-1]
        u += dt * f(u, p, t)
        push!(us, copy(u))
    end

    return (t=ts, u=us)
end
