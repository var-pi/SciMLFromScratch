struct ForwardEuler <: AbstractODEAlgorithm end

function solve(prob::AbstractODEProblem, ::ForwardEuler; dt)
    f = get_f(prob)
    u = copy(get_u0(prob))
    t₀, t₁ = get_tspan(prob)
    p = get_p(prob)

    ts = t₀:dt:t₁
    us = Vector{typeof(u)}(undef, length(ts))
    us[1] = copy(u)

    u̇ = similar(u)
    is_inplace = methods(f).ms[1].nargs - 1 == 4
    _f = is_inplace ? f : (u̇, u, p, t) -> (u̇ .= f(u, p, t))
    for i in 1:(length(ts)-1)
        _f(u̇, u, p, ts[i])
        @. u += dt * u̇
        us[i+1] = copy(u)
    end

    return (t=ts, u=us)
end

function perform_step!()

end
