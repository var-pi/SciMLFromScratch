struct OdeOperator{F,P,U,V} <: AbstractOperator
    apply!::F  # (y, u, p, t) -> f(u,t,p) 
    p::P
    prototype_in::U
    prototype_out::V
end

apply!(y, A::OdeOperator, (u, t)) = A.apply!(y, u, A.p, t)
