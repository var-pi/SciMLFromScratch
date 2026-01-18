abstract type AbstractNonlinearOperator <: AbstractOperator end

struct NonlinearOperator{F,U,V} <: AbstractNonlinearOperator
    apply!::F           # (y, u) -> y = A(u)
    prototype_in::U     # u
    prototype_out::V    # y
end

apply!(y, A::NonlinearOperator, u) = A.apply!(y, u)
