abstract type AbstractOperator end

# Default interface
function apply!(y, A::AbstractOperator, u)
    error("apply!(y, ::$(typeof(A)), u) not implemented")
end

function apply(A::AbstractOperator, u)
    y = similar(prototype_out(A))
    apply!(y, A, u)
    y
end

(A::AbstractOperator)(u) = apply(A, u)
prototype_in(A::AbstractOperator) = A.prototype_in
prototype_out(A::AbstractOperator) = A.prototype_out
