using LinearAlgebra: norm

@kwdef mutable struct LState{U,V} <: AbstractState
    u::U
    b::V
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, b, u0)::LProb) = LState(; u = copy(u0), b, r = b .- A(u0))

update_params!(y, S::StepOperator{<:LAlg}, (; u, b)) = y.r .= b .- S.A(u)

success_condition((; r)::LState, ::LProb, (; atol)::LAlg) = norm(r) < atol

include("richardson.jl")
export LAlg, Richardson
