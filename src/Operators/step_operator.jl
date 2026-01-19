@kwdef struct StepOperator{Alg<:AbstractSciMLAlgorithm,Op} <: AbstractNonlinearOperator
    alg::Alg
    A::Op
end

prototype_in((; A)::StepOperator) = prototype_in(A)
prototype_out((; A)::StepOperator) = prototype_out(A)
