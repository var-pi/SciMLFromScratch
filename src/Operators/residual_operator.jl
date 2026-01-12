struct BackwardEulerResidualOperator{A,U,T} <: AbstractNonlinearOperator
    A::A
    u::U
    t::T
    dt::T
end

function ((; A, u, t, dt)::BackwardEulerResidualOperator)(x)
    x .- u .- dt .* A((x, t + dt))
end

prototype_in(R::BackwardEulerResidualOperator) = prototype_in(R.A)
prototype_out(R::BackwardEulerResidualOperator) = prototype_out(R.A)
