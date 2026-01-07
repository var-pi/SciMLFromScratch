struct Newton <: AbstractNonlinearAlgorithm 
    maxiter::Int
    atol::Float64
end

function Newton()
    Newton(50, 1e-8)
end

step(state::NonlinearState{A}) where A <: Newton = state.u - state.df(state.u) \ state.fu
