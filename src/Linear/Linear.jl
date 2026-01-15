using LinearAlgebra: norm

abstract type LAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct LState{U,V}
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, b, u0)::AbstractLinearProblem) = LState(; u = copy(u0), r = b .- A(u0))

step_condition((; retcode, iter)::LState, ::AbstractLinearProblem, (; maxiter)::LAlg) =
    retcode == Default && iter < maxiter

after_step!((; u, r)::LState, (; A, b)::AbstractLinearProblem, ::LAlg) = r .= b .- A(u)

success_condition((; r)::LState, (; atol)::LAlg) = norm(r) < atol

finalize(state::LState) = LinearSolution(state), LinearDiagnostics(state)

include("richardson.jl")
export LAlg, Richardson
