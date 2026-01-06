struct ForwardEuler <: AbstractODEAlgorithm end
struct BackwardEuler <: AbstractODEAlgorithm end
using Base: print_module_path_file

@inline step(::ForwardEuler, f, u, p, t, dt) = u + dt * f(u, p, t)


import LinearAlgebra: norm, I

"""
newton_solve(g, dg, u0; tol=1e-8, maxiter=50)

Generic Newton-Raphson solver.
- g: function whose root we want
- dg: derivative / Jacobian of g
- u0: initial guess
"""
function newton_solve(f, df, u0; tol=1e-8, maxiter=50)
    u = u0
    for _ in 1:maxiter
        Δ = df(u) \ f(u)    # solve linear system (Jacobian * Δ = g(u))
        u -= Δ
        if norm(Δ) < tol
            return u
        end
    end
    error("Newton-Raphson did not converge in $maxiter iterations")
end


# Solve u_{n+1} = u_n + dt * f(u_{n+1}, p, t+dt)
@inline function step(::BackwardEuler, f, u, p, t, dt; df)
    g(u_next) = u_next - u - dt .* f(u_next, p, t+dt)
    function dg(u_next)
        I - dt * df(u_next, p, t+dt)
    end
    newton_solve(g, dg, u)
end
