struct ResidualOperator{AlgT<:AbstractSciMLAlgorithm,Op,U,T} <: AbstractNonlinearOperator
    A::Op
    u::U
    t::T
    dt::T

    ResidualOperator{AlgT}(A::Op, u::U, t::T, dt::T) where {AlgT,Op,U,T} =
        new{AlgT,Op,U,T}(A, u, t, dt)
end

function apply!(y, (; A, u, t, dt)::ResidualOperator, x)
    apply!(y, A, (x, t + dt))
    @. y = x - u - dt * y
end

prototype_in(R::ResidualOperator) = prototype_in(R.A)[1]
prototype_out(R::ResidualOperator) = prototype_out(R.A)
