@kwdef struct StepOperator{Alg<:AbstractSciMLAlgorithm,Op} <: AbstractNonlinearOperator
    alg::Alg
    A::Op
end

wrapped_op(A::StepOperator) = A.A
