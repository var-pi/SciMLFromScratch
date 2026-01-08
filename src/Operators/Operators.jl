include("abstract_operator.jl")
include("linear_operator.jl")
include("nonlinear_operator.jl")
include("composed_operator.jl")
include("jvp_operator.jl")

export AbstractOperator, LinearOperator, NonlinearOperator,
       ComposedOperator, JvpOperator,
       apply, compose
