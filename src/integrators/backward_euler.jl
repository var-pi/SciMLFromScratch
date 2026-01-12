import LinearAlgebra: I

@kwdef struct BackwardEuler{A<:AbstractNonlinearAlgorithm} <: AbstractODEAlgorithm
    nlalg::A = Newton()
end

@inline function step!(
    (; u, t)::OdeState,
    (; A)::AbstractODEProblem,
    (; nlalg)::BackwardEuler;
    dt,
)
    g(x) = x - u - dt * A((x, t + dt))

    prob = NonlinearProblem(; A = NonlinearOperator((y, u) -> y .= g(u), u, u), u0 = u)
    sol, _ = solve(prob, nlalg)
    u .= sol.u
end
