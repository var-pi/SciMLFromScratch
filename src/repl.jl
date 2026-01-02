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
    prob = ODEProblem(f, SArray{Tuple{2, 2}}([1.0 2.0; 3.0 4.0]), (0, 1), nothing)
    @code_warntype solve(prob, SciMLFromScratch.ForwardEuler(); dt = 1e-2)
end

function test()
    _test()
end
