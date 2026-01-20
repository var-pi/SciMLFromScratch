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

wrapped_op(::AbstractOperator) = nothing

(A::AbstractOperator)(u) = apply(A, u)
prototype_in(A::AbstractOperator) =
    (op = wrapped_op(A); isnothing(op) ? A.prototype_in : prototype_in(op))
prototype_out(A::AbstractOperator) =
    (op = wrapped_op(A); isnothing(op) ? A.prototype_out : prototype_out(op))
