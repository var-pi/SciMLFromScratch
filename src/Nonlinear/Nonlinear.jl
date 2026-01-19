using LinearAlgebra: norm

@kwdef mutable struct NLState{U,V} <: AbstractState
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, u0)::NLProb) = NLState(; u = copy(u0), r = A(u0))

update_params!(y, S::StepOperator{<:NLAlg}, (; u)) = y.r .= S.A(u)

success_condition((; r)::NLState, ::NLProb, (; atol)::NLAlg) = norm(r) < atol

include("newton.jl")
export NLAlg, Newton
