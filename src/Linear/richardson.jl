using LinearAlgebra: I, eigvals, Matrix

struct Richardson{T} <: AbstractLinearAlgorithm
    α::T        # relaxation parameter
    atol::T
    maxiter::Int
end

function step(state::LinearState{<:Richardson})
    (; alg, u, r) = state
    (; α) = alg

    u + α * r
end
