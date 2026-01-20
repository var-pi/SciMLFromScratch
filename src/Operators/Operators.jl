include("abstract_operator.jl")
include("linear_operator.jl")
include("nonlinear_operator.jl")
include("composed_operator.jl")
include("derivative_operator.jl")
include("jvp_operator.jl")
include("directional_derivative_operator.jl")
include("hvvp_operator.jl")
include("ode_operator.jl")
include("residual_operator.jl")
include("step_operator.jl")
include("spatial_operator.jl")

export AbstractOperator,
    AbstractLinearOperator,
    LinearOperator,
    NonlinearOperator,
    ComposedOperator,
    JvpOperator,
    OdeOperator,
    ResidualOperator,
    apply!,
    apply,
    compose
