@testset "Linear" begin

# ----------------------------
# Setup a simple LinearProblem
# ----------------------------
A = [4.0 1.0; 1.0 3.0]         # SPD 2x2 matrix
b = [6.0, 7.0]                 # RHS
u0 = zeros(2)                  # initial guess

prob = LinearProblem(A, u0, b)

# ----------------------------
# Setup a simple iterative solver
# ----------------------------
α = 0.2                        # Richardson relaxation parameter
atol = 1e-8
maxiter = 100
alg = Richardson(α, atol, maxiter)

# ----------------------------
# Solve
# ----------------------------
sol = solve(prob, alg)

# ----------------------------
# Tests
# ----------------------------
@test sol.converged                   # Should converge
@test sol.iter < maxiter             # Should converge in fewer iterations
@test norm(A * sol.u - b) < atol     # Residual small
@test isapprox(sol.u, [1.0, 2.0], atol=1e-4)  # Exact solution



end
