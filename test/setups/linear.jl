using LinearAlgebra: norm, mul!

function solve_example(alg::LAlg, u0)

    M = [4.0 1.0; 1.0 3.0]
    A = LinearOperator((y, u) -> mul!(y, M, u), zeros(2), zeros(2))
    b = [6.0; 7.0]

    prob = LinearProblem(; A, b, u0)

    u★ = [1.0; 2.0]

    solve(prob, alg), u★, prob
end
