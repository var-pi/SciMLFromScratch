struct Newton{A<:AbstractLinearAlgorithm} <: AbstractNonlinearAlgorithm 
    linalg::A
    maxiter::Int
    atol::Float64
end

function Newton(linalg::AbstractLinearAlgorithm)
    Newton(linalg, 50, 1e-8)
end

function Newton()
    Newton(Richardson(0.2, 1e-8, 100))
end

# u_new = u - df(u) \ f(u)
function step(state::NonlinearState{<:Newton})
    (; alg, u, df, fu) = state

    prob = LinearProblem(df(u), zero(fu), fu)
    sol = solve(prob, alg.linalg)
    u - sol.u
end
