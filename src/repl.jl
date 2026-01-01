using BenchmarkTools

function _test()
    prob = ODEProblem((u, p, t) -> u, 1.0, (0, 10), nothing)
    solve(prob, SciMLFromScratch.ForwardEuler(); dt = 0.1)
end

function test()
    @btime _test()
end
