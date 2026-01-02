struct ForwardEuler <: AbstractODEAlgorithm end
using InteractiveUtils

function solve(prob::ODEProblem{F, U, T, P}, ::ForwardEuler; dt) where {F, U, T, P}
    (; f, u0, tspan, p) = prob
    t0, t1 = tspan

    n = Int(fld(t1 - t0, dt)) + 1
    us = Vector{U}(undef, n)
    us[1] = u0

    t = t0
    @fastmath for i in 1:(n-1)
        us[i+1] = us[i] + dt * f(us[i], p, t)
        t += dt
    end

    (t=t0:dt:t1, u=us)
end
