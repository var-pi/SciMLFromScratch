abstract type AbstractOperator end

# Default interface
function apply(A::AbstractOperator, u)
    error("apply(::$(typeof(A)), u) not implemented")
end

function compose(A::AbstractOperator, B::AbstractOperator)
    ComposedOperator(A, B)
end

