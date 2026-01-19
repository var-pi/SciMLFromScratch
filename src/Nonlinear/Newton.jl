@kwdef struct Newton{L<:LAlg} <: NLAlg
    linalg::L = Richardson()
    atol::Float64 = 1e-8
    maxiter::Int = 100
end

# u_new = u - df(u) \ f(u)
function apply!(y, (; alg, A)::StepOperator{<:Newton}, (; u, r))
    (; linalg) = alg

    prob = LinearProblem(; A = JvpOperator(; A, u), b = r)
    sol, _ = solve(prob, linalg)

    y.u .= u - sol.u
    y.r .= A(u)
end
