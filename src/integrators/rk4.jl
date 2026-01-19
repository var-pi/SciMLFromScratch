@kwdef struct RungeKutta4{T} <: ODEAlg
    dt::T = 0.01
end

function apply!(y::ODEState, (; alg, A)::StepOperator{<:RungeKutta4}, (; u, t)::ODEState)
    (; dt) = alg
    k1 = A((u, t))
    k2 = A((u + dt*k1/2, t + dt/2))
    k3 = A((u + dt*k2/2, t + dt/2))
    k4 = A((u + dt*k3, t + dt))
    y.u .+= dt/6 * (k1 + 2k2 + 2k3 + k4)
    y.t = t + dt
end
