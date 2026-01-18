function solve_example(alg::ODEAlg, u0)
    prob = ODEProblem(;
        A = OdeOperator((y, u, p, t) -> y .= p .* u, 2.0, zero(u0), zero(u0)),
        u0,
        tspan = (0.0, 0.1),
    )

    u★ = u0 .* exp(prob.A.p * prob.tspan[2])

    solve(prob, alg), u★, prob
end
