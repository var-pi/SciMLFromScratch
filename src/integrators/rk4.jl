struct RungeKutta4 <: AbstractODEAlgorithm end

@inline function step!(integ::OdeState, prob::AbstractODEProblem, ::RungeKutta4; dt)
    (; u, t) = integ
    (; f, p) = prob

    k1 = f(u, p, t)
    k2 = f(u + dt*k1/2, p, t + dt/2)
    k3 = f(u + dt*k2/2, p, t + dt/2)
    k4 = f(u + dt*k3, p, t + dt)
    u .+= dt/6 * (k1 + 2k2 + 2k3 + k4)
end
