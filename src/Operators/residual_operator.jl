struct BackwardEulerResidualOperator{A,U,T} <: AbstractNonlinearOperator
    A::A
    u::U
    t::T
    dt::T
end

function apply!(y, (; A, u, t, dt)::BackwardEulerResidualOperator, x)
    apply!(y, A, (x, t + dt))
    @. y = x - u - dt * y
end

prototype_in(R::BackwardEulerResidualOperator) = prototype_in(R.A)[1]
prototype_out(R::BackwardEulerResidualOperator) = prototype_out(R.A)
