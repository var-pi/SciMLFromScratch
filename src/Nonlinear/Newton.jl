@kwdef struct Newton{L<:LAlg} <: AbstractNonlinearAlgorithm
    linalg::L = Richardson()
    atol::Float64 = 1e-8
    maxiter::Int = 100
end

# u_new = u - df(u) \ f(u)
function step!(
    (; u, r)::NonlinearState,
    (; A)::AbstractNonlinearProblem,
    (; linalg)::Newton,
)
    prob = LinearProblem(; A = JvpOperator(; A, u), b = r)
    sol, _ = solve(prob, linalg)

    u .-= sol.u
end
