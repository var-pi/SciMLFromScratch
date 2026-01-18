abstract type AbstractSciMLProblem end
abstract type AbstractSciMLAlgorithm end
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
