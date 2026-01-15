using LinearAlgebra: norm

abstract type AbstractNonlinearAlgorithm <: AbstractSciMLAlgorithm end

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
    (; maxiter)::AbstractNonlinearAlgorithm,
) = retcode == Default && iter < maxiter

after_step!(
    (; u, r)::NonlinearState,
    (; A)::AbstractNonlinearProblem,
    ::AbstractNonlinearAlgorithm,
) = r .= A(u)

success_condition((; r)::NonlinearState, (; atol)::AbstractNonlinearAlgorithm) =
    norm(r) < atol

finalize(state::NonlinearState) = NonlinearSolution(state), NonlinearDiagnostics(state)

include("newton.jl")
export AbstractNonlinearAlgorithm, Newton
