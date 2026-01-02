struct ForwardEuler <: AbstractODEAlgorithm end
using InteractiveUtils

function solve(prob::ODEProblem{F, U, T, P}, ::ForwardEuler; n) where {F, U, T, P}
    (; f, u0, tspan, p) = prob
    t0, t1 = tspan

    dt = (t1 - t0) / (n - 1)
    ts = StepRangeLen(t0, dt, n)
    us = Vector{U}(undef, n)
    us[1] = u0

    @inbounds @fastmath for i in 1:(n-1)
        us[i+1] = us[i] + dt * f(us[i], p, ts[i])
    end

    (t=ts, u=us)
end
