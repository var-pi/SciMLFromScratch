using LinearAlgebra: norm

abstract type LAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct LState{U,V} <: AbstractState
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, b, u0)::LProb) = LState(; u = copy(u0), r = b .- A(u0))

step_condition((; retcode, iter)::LState, ::LProb, (; maxiter)::LAlg) =
    retcode == Default && iter < maxiter

after_step!((; u, r)::LState, (; A, b)::LProb, ::LAlg) = r .= b .- A(u)

success_condition((; r)::LState, (; atol)::LAlg) = norm(r) < atol

include("richardson.jl")
export LAlg, Richardson
