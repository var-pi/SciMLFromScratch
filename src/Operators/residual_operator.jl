struct ResidualOperator{Alg<:ODEAlg,Op<:OdeOperator,U,T} <: AbstractNonlinearOperator
    A::Op
    u::U
    t::T
    dt::T

    ResidualOperator{Alg}(A::Op, u::U, t::T, dt::T) where {Alg,Op,U,T} =
        new{Alg,Op,U,T}(A, u, t, dt)
end

wrapped_op(R::ResidualOperator) = R.A
prototype_in(R::ResidualOperator) = prototype_in(R.A)[1]
