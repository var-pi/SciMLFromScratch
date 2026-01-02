using BenchmarkTools
using StaticArrays: @SVector, SArray
using CairoMakie: lines!, Figure, Axis
using EllipsisNotation
using InteractiveUtils

f(u, p, t) = 2 * u

function _test()
    u0 = @SVector [1.0 + 0.1*i for i in 0:10]
    tspan = (0.0, 1.0)
    prob = ODEProblem(f, u0, tspan, nothing)
    solve(prob, SciMLFromScratch.ForwardEuler(); n = 101)
end

function test()
    @btime _test()
end
