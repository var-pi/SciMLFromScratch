abstract type AbstractSciMLProblem end

abstract type AbstractSciMLAlgorithm end
maxiter(alg::AbstractSciMLAlgorithm) = alg.maxiter
abstract type LAlg <: AbstractSciMLAlgorithm end
abstract type NLAlg <: AbstractSciMLAlgorithm end
abstract type ODEAlg <: AbstractSciMLAlgorithm end
maxiter(::ODEAlg) = Inf

abstract type AbstractSciMLSolution end

abstract type AbstractSciMLDiagnostics end

abstract type AbstractState end

@enum ReturnCode begin
    Default
    Success
    MaxIters
end

export AbstractSciMLProblem,
    AbstractSciMLAlgorithm, AbstractSciMLSolution, AbstractSciMLDiagnostics, AbstractState
export ReturnCode, Default, Success, MaxIters
