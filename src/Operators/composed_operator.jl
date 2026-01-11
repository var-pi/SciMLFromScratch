struct ComposedOperator{A<:AbstractOperator,B<:AbstractOperator} <: AbstractOperator
    A::A
    B::B
end

apply(C::ComposedOperator, u) = apply(C.A, apply(C.B, u))
