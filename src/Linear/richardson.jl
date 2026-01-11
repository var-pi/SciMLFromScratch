struct Richardson{T} <: AbstractLinearAlgorithm
    α::T        # relaxation parameter
    atol::T
    maxiter::Int
end

function Richardson()
    Richardson(0.2, 1e-8, 100)
end

function step!(state::LinearState, ::AbstractLinearProblem, alg::Richardson)
    (; u, r) = state
    (; α) = alg

    u .= u + α * r
end
