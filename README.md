# SciML from Scratch

A pedagogical library featuring [**Numerical Methods for Differential Equations**](https://en.wikipedia.org/wiki/Numerical_methods_for_ordinary_differential_equations) and [**Optimization Algorithms**](https://en.wikipedia.org/wiki/Mathematical_optimization), built entirely in [Julia](https://julialang.org).

## 🎯 Project Goal
The primary objective of this repository is to demystify high-performance libraries like [SciML](https://github.com/SciML). By implementing these algorithms from the ground up, this project serves as a deep dive into their mathematical foundations, stability considerations, and Julia-specific dispatch patterns that make the scientific ecosystem so efficient.

## 🚀 Current Features

### Numerical Integrators
- [**SArray**](https://github.com/JuliaArrays/StaticArrays.jl) — Enforce [immutability](https://en.wikipedia.org/wiki/Immutable_object).
- [**IIP**](https://en.wikipedia.org/wiki/In-place_algorithm) — Reject in-place operations due to immutability.
- **SaveEveryStep** — Save intermediate values for simplicity.

> - [x] [**Forward Euler Method**](https://en.wikipedia.org/wiki/Euler_method) — The fundamental building block of numerical integration for [Initial Value Problems](https://en.wikipedia.org/wiki/Initial_value_problem).
> - **Goal** — Implement it to be as quick as possible.
> 
> $$y_{n+1} = y_n + h f(t_n, y_n)$$

### Optimization Algorithms

> - [ ] [**Naive Gradient Descent**](https://en.wikipedia.org/wiki/Gradient_descent) — A pure implementation of the vanilla steepest descent algorithm. 
> - **Goal** — Explore the challenges of local minima and convergence
> 
> $$\theta_{\text{next}} = \theta - \eta \nabla J(\theta)$$
