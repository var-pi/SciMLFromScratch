import LinearAlgebra: I

struct ForwardEuler <: AbstractODEAlgorithm end
struct BackwardEuler <: AbstractODEAlgorithm end

@inline step(::ForwardEuler, f, u, p, t, dt) = u + dt * f(u, p, t)

@inline function step(::BackwardEuler, f, u, p, t, dt; df)
    g(x) = x - u - dt * f(x, p, t + dt)
    dg(u_next) = I - dt * df(u_next, p, t + dt)
    newton_solve(g, dg, u)
end
