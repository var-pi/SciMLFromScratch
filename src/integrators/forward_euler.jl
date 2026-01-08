struct ForwardEuler <: AbstractODEAlgorithm end

@inline function step(integ::Integrator{<:ForwardEuler})
    (; f, u, p, t, dt) = integ

    u + dt * f(u, p, t)
end
