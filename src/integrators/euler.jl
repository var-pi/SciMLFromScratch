import LinearAlgebra: I

struct ForwardEuler <: AbstractODEAlgorithm end
struct BackwardEuler <: AbstractODEAlgorithm end

@inline function step(integ::Integrator{<:ForwardEuler})
    (; f, u, p, t, dt) = integ

    u + dt * f(u, p, t)
end

@inline function step(integ::Integrator{<:BackwardEuler}; df, alg = Newton())
    (; f, u, p, t, dt) = integ

    g(x) = x - u - dt * f(x, p, t + dt)
    dg(x) = I - dt * df(x, p, t + dt)

    prob = NonlinearProblem(g, dg, u)
    (solve(prob, alg)).u
end
