struct ForwardEuler <: AbstractODEAlgorithm end

step!((; u, t)::OdeState, (; f, p)::AbstractODEProblem, ::ForwardEuler; dt) =
    u .+= dt .* f(u, p, t)
