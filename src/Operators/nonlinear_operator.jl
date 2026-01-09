abstract type AbstractNonlinearOperator <: AbstractOperator end

struct NonlinearOperator{F,I,O} <: AbstractNonlinearOperator
    apply!::F           # (y, u) -> y = A(u)
    prototype_in::I     # u
    prototype_out::O    # y
end

function apply!(y, A::NonlinearOperator, u)
    A.apply!(y, u)
end

function apply(A::NonlinearOperator, u)
    y = similar(A.prototype_out)
    apply!(y, A, u)
    y
end

(A::NonlinearOperator)(u) = apply(A, u)

