struct Richardson{T} <: AbstractLinearAlgorithm
    α::T        # relaxation parameter
    atol::T
    maxiter::Int
end

Richardson() = Richardson(0.2, 1e-8, 100)

step!((; u, r)::LinearState, ::AbstractLinearProblem, (; α)::Richardson) = u .+= α * r
