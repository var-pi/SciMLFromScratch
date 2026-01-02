abstract type AbstractODEProblem <: AbstractSciMLProblem end

function _not_implemented_error(func, obj)
    error("Function $(nameof(func)) is not implemented for the type $(typeof(obj)).")
end

const ODE_INTERFACE_FUNCTIONS = [:get_f, :get_u₀, :get_tspan, :get_p]

for func_name in ODE_INTERFACE_FUNCTIONS
    @eval begin
        $func_name(prob::AbstractODEProblem) = _not_implemented_error($func_name, prob)
    end
end

struct ODEProblem{F, U, T, P} <: AbstractODEProblem
    f::F
    u₀::U
    tspan::T
    p::P
end

get_f(prob::ODEProblem)     = prob.f
get_u₀(prob::ODEProblem)    = prob.u₀
get_tspan(prob::ODEProblem) = prob.tspan
get_p(prob::ODEProblem)     = prob.p
