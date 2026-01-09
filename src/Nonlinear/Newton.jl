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
    (; alg, u, df, fu) = state
    (; linalg) = alg

    #J = JvpOperator(f, u, 1e-8)

    ## LinearProblem: Jδ = fu
    #prob = LinearProblem(J, fu, zero(fu))

    prob = LinearProblem(LinearOperator(df(u)), zero(fu), fu)
    sol = solve(prob, linalg)
    u - sol.u
end
