using BenchmarkTools
using StaticArrays: SVector

function _test()
    function f(u̇, u, p, t)
        @. u̇ = 2 * u
        nothing
    end
    prob = ODEProblem(f, collect([1.0, 2.0, 3.0]), (0, 1), nothing)
    solve(prob, SciMLFromScratch.ForwardEuler(); dt = 1e-2)
end

function test()
    @btime _test()
end
