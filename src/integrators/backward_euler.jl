import LinearAlgebra: I

@kwdef struct BackwardEuler{A<:NLAlg} <: ODEAlg
    nlalg::A = Newton()
    dt = 0.01
end

@inline function step!((; u, t)::ODEState, (; A)::ODEProb, (; nlalg, dt)::BackwardEuler)
    prob = NonlinearProblem(; A = ResidualOperator{BackwardEuler}(A, u, t, dt), u0 = u)
    sol, _ = solve(prob, nlalg)
    u .= sol.u
end

function apply!(y, (; A, u, t, dt)::ResidualOperator{BackwardEuler}, x)
    apply!(y, A, (x, t + dt))
    @. y = x - u - dt * y
end
