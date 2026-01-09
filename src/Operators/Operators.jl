include("abstract_operator.jl")
include("linear_operator.jl")
include("nonlinear_operator.jl")
include("composed_operator.jl")
include("jvp_operator.jl")

export AbstractOperator, AbstractLinearOperator, LinearOperator, NonlinearOperator,
       ComposedOperator, JvpOperator,
       apply!, apply, compose
