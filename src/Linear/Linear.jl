using LinearAlgebra: norm

abstract type AbstractLinearAlgorithm <: AbstractSciMLAlgorithm end

@kwdef mutable struct LinearState{U,V}
    u::U
    r::V
    iter::Int = 0
    retcode::ReturnCode = Default
end

function init(prob::AbstractLinearProblem)
    (; A, b, u0) = prob

    LinearState(; u = u0, r = b .- A(u0))
end

function solve(prob::AbstractLinearProblem, alg::AbstractLinearAlgorithm)
    state = init(prob)

    while state.retcode == Default && state.iter < alg.maxiter
        perform_step!(state, prob, alg)
    end

    LinearSolution(state), LinearDiagnostics(state)
end

function perform_step!(
    state::LinearState,
    prob::AbstractLinearProblem,
    alg::AbstractLinearAlgorithm,
)
    (; u, r) = state
    (; A, b) = prob

    step!(state, prob, alg)

    r .= b .- A(u)

    norm(r) < alg.atol && (state.retcode = Success)

    state.iter += 1
end

include("richardson.jl")
export AbstractLinearAlgorithm, Richardson
