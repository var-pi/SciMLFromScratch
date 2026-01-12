struct ForwardEuler <: AbstractODEAlgorithm end

step!((; u, t)::OdeState, (; A)::AbstractODEProblem, ::ForwardEuler; dt) =
    u .+= dt .* A((u, t))
