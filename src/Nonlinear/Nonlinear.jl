using LinearAlgebra: norm

abstract type NLAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct NLState{U,V} <: AbstractState
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, u0)::NLProb) = NLState(; u = copy(u0), r = A(u0))

step_condition((; retcode, iter)::NLState, ::NLProb, (; maxiter)::NLAlg) =
    retcode == Default && iter < maxiter

after_step!((; u, r)::NLState, (; A)::NLProb, ::NLAlg) = r .= A(u)

success_condition((; r)::NLState, (; atol)::NLAlg) = norm(r) < atol

include("newton.jl")
export NLAlg, Newton
