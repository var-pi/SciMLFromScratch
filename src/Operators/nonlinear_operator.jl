struct NonlinearOperator{F} <: AbstractOperator
    apply!::F  # (y, u) -> y = N(u)
end

function apply(A::NonlinearOperator, u)
    A.apply!(similar(u), u)
end
