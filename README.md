# SciML from Scratch

A pedagogical library featuring [**Linear Solvers**](https://en.wikipedia.org/wiki/Numerical_linear_algebra), [**Nonlinear Solvers**](https://en.wikipedia.org/wiki/Root-finding_algorithm?utm_source=chatgpt.com), [**Numerical Integrators**](https://www.sciencedirect.com/topics/engineering/numerical-integrator) and [**Optimization Algorithms**](https://en.wikipedia.org/wiki/Mathematical_optimization), built entirely in [Julia](https://julialang.org).

## 🎯 Project Goal
The primary objective of this repository is to demystify high-performance libraries like [SciML](https://github.com/SciML). By implementing these algorithms from the ground up, this project serves as a deep dive into their mathematical foundations, stability considerations, and Julia-specific dispatch patterns that make the scientific ecosystem so efficient.

## 🚀 Current Features

- [**SArray**](https://github.com/JuliaArrays/StaticArrays.jl) — Enforce immutability.
- [**IIP**](https://en.wikipedia.org/wiki/In-place_algorithm) — Reject in-place operations due to immutability.

### Linear Solvers

> - [x] [**Richardson**](https://jschoeberl.github.io/iFEM/iterative/Richardson.html) — Simple relaxation method for linear systems.
> - **Goal** — Implement a standalone linear solver for nonlinear solvers.
>
> $$y_{n+1} = y_{n} + \alpha (b - Ay_{n})$$

### Nonlinear Solvers

> - [x] [**Newton–Raphson**](https://en.wikipedia.org/wiki/Newton%27s_method) — Foundational iterative algorithm for solving nonlinear algebraic equations.
> - **Goal** — Implement a standalone nonlinear solver for implicit integrators.
>
> $$y_{n+1} = y_n - \frac{f(y_n)}{f'(y_n)}$$

### Numerical Integrators

- [**save_everystep**](https://github.com/SciML/DiffEqBase.jl/blob/e6876e274990fb9e70a870666cdb8678de5330f6/src/solve.jl#L334) — Save intermediate values by default for simplicity.

> - [x] [**Forward Euler**](https://en.wikipedia.org/wiki/Euler_method) — The fundamental building block of numerical integration for Initial Value Problems.
> - **Goal** — Understand solver design while exploring Julia internals.
> 
> $$y_{n+1} = y_n + h f(t_n, y_n)$$

> - [x] [**RK4**](https://en.wikipedia.org/wiki/Runge–Kutta_methods) — A standard fourth-order explicit integrator.
> - **Goal** — Explore higher-order methods and generalize the solver interface.
> 
> $$
> \begin{align}
> k_1 &= \ f(t_n, y_n) \\
> k_2 &= \ f\left(t_n + \frac{h}{2}, y_n + h \frac{k_1}{2}\right) \\ 
> k_3 &= \ f\left(t_n + \frac{h}{2}, y_n + h \frac{k_2}{2}\right) \\
> k_4 &= \ f\left(t_n + h, y_n + h k_3\right) \\
> y_{n+1} &= y_n + \frac{h}{6}(k_1 + 2k_2 + 2k_3 + k_4)
> \end{align}
> $$

> - [x] [**Backward Euler**](https://en.wikipedia.org/wiki/Backward_Euler_method) — The simplest implicit method.
> - **Goal** — Learn to implemenet implicit integrators using methods like Newton-Raphson.
> 
> $$y_{n+1} = y_n + h f(t_{n+1}, y_{n+1})$$

### Optimization Algorithms

> - [x] [**Naive Gradient Descent**](https://en.wikipedia.org/wiki/Gradient_descent) — A pure implementation of the vanilla steepest descent algorithm. 
> - **Goal** — Investigate convergence and sensitivity to local minima.
> 
> $$\theta_{n+1} = \theta_{n} - \eta \nabla J(\theta_{n})$$
