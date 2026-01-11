struct Newton{L<:AbstractLinearAlgorithm} <: AbstractNonlinearAlgorithm
    linalg::L
    maxiter::Int
    atol::Float64
end

function Newton(linalg::AbstractLinearAlgorithm)
    Newton(linalg, 50, 1e-8)
end

function Newton()
    Newton(Richardson())
end

# u_new = u - df(u) \ f(u)
function step!(
    (; u, r)::NonlinearState,
    (; A)::AbstractNonlinearProblem,
    (; linalg)::AbstractNonlinearAlgorithm,
)
    prob = LinearProblem(; A = JvpOperator(; A, u), b = r, u0 = zero(r))
    sol, _ = solve(prob, linalg)

    u .-= sol.u
end
