import LinearAlgebra: I

@kwdef struct BackwardEuler{A<:NLAlg} <: ODEAlg
    nlalg::A = Newton()
    dt = 0.01
end

@inline function step!(
    (; u, t)::OdeState,
    (; A)::AbstractODEProblem,
    (; nlalg, dt)::BackwardEuler,
)
    prob = NonlinearProblem(; A = BackwardEulerResidualOperator(A, u, t, dt), u0 = u)
    sol, _ = solve(prob, nlalg)
    u .= sol.u
end
