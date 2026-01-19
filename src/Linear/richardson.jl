@kwdef struct Richardson{T} <: LAlg
    α::T = 0.2
    atol::T = 1e-8
    maxiter::Int = 100
end

function _apply!(y, (; alg, A)::StepOperator{<:Richardson}, (; u, b, r))
    (; α) = alg

    @. y.u = u + α * r
end
