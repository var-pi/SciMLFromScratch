struct Newton <: AbstractNonlinearAlgorithm 
    maxiter::Int
    atol::Float64
end

function Newton()
    Newton(50, 1e-8)
end

function step(state::NonlinearState{<:Newton})
    (; u, df, fu) = state

    u - df(u) \ fu
end
