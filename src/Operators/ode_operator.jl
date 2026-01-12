struct OdeOperator{F,U,V} <: AbstractOperator
    apply!::F  # (y, u, p, t) -> f(u,t,p) 
    p::Any
    prototype_in::U
    prototype_out::V
end

function apply!(y, A::OdeOperator, (u, t))
    A.apply!(y, u, A.p, t)
end

function apply(A::OdeOperator, (u, t))
    y = similar(prototype_out(A))
    apply!(y, A, (u, t))
    y
end
