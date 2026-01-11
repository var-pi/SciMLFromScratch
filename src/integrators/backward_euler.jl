import LinearAlgebra: I

@kwdef struct BackwardEuler{A<:AbstractNonlinearAlgorithm} <: AbstractODEAlgorithm
    nlalg::A = Newton()
end

@inline function step!(
    integ::OdeState,
    prob::AbstractODEProblem,
    (; nlalg)::BackwardEuler;
    dt,
)
    (; u, t) = integ
    (; f, p) = prob

    g(x) = x - u - dt * f(x, p, t + dt)

    prob = NonlinearProblem(; A = NonlinearOperator((y, u) -> y .= g(u), u, u), u0 = u)
    sol, _ = solve(prob, nlalg)
    u .= sol.u
end
