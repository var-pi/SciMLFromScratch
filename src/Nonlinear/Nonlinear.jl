using LinearAlgebra: norm

abstract type NLAlg <: AbstractSciMLAlgorithm end

@kwdef mutable struct NonlinearState{U,V}
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

init((; A, u0)::AbstractNonlinearProblem) = NonlinearState(; u = copy(u0), r = A(u0))

step_condition(
    (; retcode, iter)::NonlinearState,
    ::AbstractNonlinearProblem,
    (; maxiter)::NLAlg,
) = retcode == Default && iter < maxiter

after_step!((; u, r)::NonlinearState, (; A)::AbstractNonlinearProblem, ::NLAlg) = r .= A(u)

success_condition((; r)::NonlinearState, (; atol)::NLAlg) = norm(r) < atol

finalize(state::NonlinearState) = NonlinearSolution(state), NonlinearDiagnostics(state)

include("newton.jl")
export NLAlg, Newton
