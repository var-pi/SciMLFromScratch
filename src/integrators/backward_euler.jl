import LinearAlgebra: I

struct BackwardEuler{A <: AbstractNonlinearAlgorithm} <: AbstractODEAlgorithm
    nlalg::A
end

function BackwardEuler()
    BackwardEuler(Newton())
end

@inline function step(integ::Integrator{<:BackwardEuler})
    (; alg, f, u, p, t, dt, df) = integ
    (; nlalg) = alg

    g(x) = x - u - dt * f(x, p, t + dt)
    dg(x) = I - dt * df(x, p, t + dt)

    prob = NonlinearProblem(g, dg, u)
    (solve(prob, nlalg)).u
end
