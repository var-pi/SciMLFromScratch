struct ComposedOperator{A<:AbstractOperator,B<:AbstractOperator} <: AbstractOperator
    A::A
    B::B
end

compose(A::AbstractOperator, B::AbstractOperator) = ComposedOperator(A, B)

function apply!(y, (; A, B)::ComposedOperator, u)
    apply!(y, B, u)
    apply!(y, A, y)
end

prototype_in((; B)::ComposedOperator) = prototype_in(B)
prototype_out((; A)::ComposedOperator) = prototype_out(A)
