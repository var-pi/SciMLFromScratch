struct Richardson{T} <: AbstractLinearAlgorithm
    α::T        # relaxation parameter
    atol::T
    maxiter::Int
end

function step(state::LinearState{<:Richardson})
    (; alg, u, r) = state

    # Richardson update: x_{k+1} = x + α * r
    u + alg.α * r
end
