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
    prob = NonlinearProblem(; A = BackwardEulerResidualOperator(A, u, t, dt), u0 = u)
    sol, _ = solve(prob, nlalg)
    u .= sol.u
end
