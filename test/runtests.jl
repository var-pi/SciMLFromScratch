using SciMLFromScratch, Test

include("setups/linear.jl")
include("setups/nonlinear.jl")
include("setups/integrators.jl")

include("base.jl")

include("testsets/linear.jl")
include("testsets/nonlinear.jl")
include("testsets/integrators.jl")
