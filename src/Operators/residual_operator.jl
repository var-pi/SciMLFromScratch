struct BackwardEulerResidualOperator{A,U,T} <: AbstractNonlinearOperator
    A::A
    u::U
    t::T
    dt::T
end

#apply!(y, (; A, u, t, dt)::BackwardEulerResidualOperator, x) =
#    y .= x .- u .- dt .* A((x, t + dt))
function apply!(y, (; A, u, t, dt)::BackwardEulerResidualOperator, x)
    g = apply(A, (x, t + dt))
    y .= x .- u .- dt .* g
end

prototype_in(R::BackwardEulerResidualOperator) = prototype_in(R.A)
prototype_out(R::BackwardEulerResidualOperator) = prototype_out(R.A)
