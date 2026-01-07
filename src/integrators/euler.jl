import LinearAlgebra: I

struct ForwardEuler <: AbstractODEAlgorithm end
struct BackwardEuler <: AbstractODEAlgorithm end

@inline step(::ForwardEuler, f, u, p, t, dt) = u + dt * f(u, p, t)

@inline function step(::BackwardEuler, f, u, p, t, dt; df, alg = Newton())
    g(x) = x - u - dt * f(x, p, t + dt)
    dg(x) = I - dt * df(x, p, t + dt)

    prob = NonlinearProblem(g, dg, u)
    sol = solve(prob, alg)
    sol.u
end
