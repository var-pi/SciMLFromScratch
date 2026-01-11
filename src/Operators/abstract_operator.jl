abstract type AbstractOperator end

# Default interface
function apply(A::AbstractOperator, u)
    error("apply(::$(typeof(A)), u) not implemented")
end

function compose(A::AbstractOperator, B::AbstractOperator)
    ComposedOperator(A, B)
end

(A::AbstractOperator)(u) = apply(A, u)
prototype_in(A::AbstractOperator) = A.prototype_in
prototype_out(A::AbstractOperator) = A.prototype_out
