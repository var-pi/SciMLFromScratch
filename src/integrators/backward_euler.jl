import LinearAlgebra: I

@kwdef struct BackwardEuler{A<:NLAlg} <: ODEAlg
    nlalg::A = Newton()
    dt = 0.01
end

function apply!(y, (; A, u, t, dt)::ResidualOperator{<:BackwardEuler}, x)
    apply!(y, A, (x, t + dt))
    @. y = x - u - dt * y
end

function _apply!(y, (; alg, A)::StepOperator{<:BackwardEuler}, (; u, t))
    (; dt, nlalg) = alg

    prob = NonlinearProblem(; A = ResidualOperator{BackwardEuler}(A, u, t, dt), u0 = u)
    sol, _ = solve(prob, nlalg)

    y.u .= sol.u
end
