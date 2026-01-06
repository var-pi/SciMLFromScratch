using LinearAlgebra: ⋅

function newton_solve(f, df, u0; tol=1e-8, maxiter=50)
    u = u0
    tol² = tol^2
    for _ in 1:maxiter
        Δ = df(u) \ f(u)
        u -= Δ
        Δ⋅Δ < tol² && return u
    end
    error("Newton-Raphson did not converge in $maxiter iterations")
end
