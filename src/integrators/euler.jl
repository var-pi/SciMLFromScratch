struct ForwardEuler <: AbstractODEAlgorithm end

@inline step(::ForwardEuler, f, u, p, t, dt) = u + dt * f(u, p, t)
