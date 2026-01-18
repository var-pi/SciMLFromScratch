module SciMLFromScratch

include("general.jl")

include("Operators/Operators.jl")

include("Problems/Problems.jl")

include("solve.jl")

include("Linear/Linear.jl")
include("Nonlinear/Nonlinear.jl")
include("Integrators/Integrators.jl")

include("Solutions/Solutions.jl")

end
