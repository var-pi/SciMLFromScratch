using BenchmarkTools
using StaticArrays: SVector

function _test()
    prob = ODEProblem((u̇, u, p, t) -> u̇ .= 2 .* u, collect([1.0, 2.0, 3.0]), (0, 1), nothing)
    solve(prob, SciMLFromScratch.ForwardEuler(); dt = 1e-2)
end

function test()
    @btime _test()
end
