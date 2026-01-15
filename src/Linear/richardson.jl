@kwdef struct Richardson{T} <: LAlg
    α::T = 0.2
    atol::T = 1e-8
    maxiter::Int = 100
end

step!((; u, r)::LinearState, ::AbstractLinearProblem, (; α)::Richardson) = u .+= α * r
