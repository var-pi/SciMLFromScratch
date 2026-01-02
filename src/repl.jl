using BenchmarkTools
using StaticArrays: SVector, SArray
using CairoMakie: lines!, Figure, Axis
using EllipsisNotation
using InteractiveUtils

function _test()
    function f(u̇, u, p, t)
        @. u̇ = 2 * u
        nothing
    end
    prob = ODEProblem(f, SArray{Tuple{2, 3}}([1.0 2.0 5.0; 3.0 4.0 6.0]), (0, 1), nothing)
    solve(prob, SciMLFromScratch.ForwardEuler(); dt = 1e-3)
end

function test()
    @btime _test()
end
