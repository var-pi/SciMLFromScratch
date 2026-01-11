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
function step(state::NonlinearState{<:Newton})
    (; alg, u, Au, A) = state
    (; linalg) = alg

    prob = LinearProblem(; A = JvpOperator(A, u, 1e-8), b = Au, u0 = zero(Au))
    sol = solve(prob, linalg)
    u - sol.u
end
