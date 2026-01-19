struct ResidualOperator{AlgT<:ODEAlg,Op<:OdeOperator,U,T} <: AbstractNonlinearOperator
    A::Op
    u::U
    t::T
    dt::T

    ResidualOperator{AlgT}(A::Op, u::U, t::T, dt::T) where {AlgT,Op,U,T} =
        new{AlgT,Op,U,T}(A, u, t, dt)
end

prototype_in(R::ResidualOperator) = prototype_in(R.A)[1]
prototype_out(R::ResidualOperator) = prototype_out(R.A)
