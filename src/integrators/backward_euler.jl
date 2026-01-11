import LinearAlgebra: I

@kwdef struct BackwardEuler{A<:AbstractNonlinearAlgorithm} <: AbstractODEAlgorithm
    nlalg::A = Newton()
end

@inline function step(integ::Integrator{<:BackwardEuler})
    (; alg, f, u, p, t, dt) = integ
    (; nlalg) = alg

    g(x) = x - u - dt * f(x, p, t + dt)

    prob = NonlinearProblem(; A = NonlinearOperator((y, u) -> y .= g(u), u, u), u0 = u)
    sol, _ = solve(prob, nlalg)
    sol.u
end
