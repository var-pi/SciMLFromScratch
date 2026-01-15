@kwdef struct RungeKutta4 <: ODEAlg
    dt = 0.01
end

@inline function step!((; u, t)::ODEState, (; A)::AbstractODEProblem, (; dt)::RungeKutta4)
    k1 = A((u, t))
    k2 = A((u + dt*k1/2, t + dt/2))
    k3 = A((u + dt*k2/2, t + dt/2))
    k4 = A((u + dt*k3, t + dt))
    u .+= dt/6 * (k1 + 2k2 + 2k3 + k4)
end
