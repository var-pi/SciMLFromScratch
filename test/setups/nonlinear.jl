function solve_example(alg::NLAlg, u0)

    prob = NonlinearProblem(;
        A = NonlinearOperator((y, u) -> y .= exp.(u) .- 1, zeros(2), zeros(2)),
        u0,
    )

    u★ = [0.0, 0.0]

    solve(prob, alg), u★, prob
end
