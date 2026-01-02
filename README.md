# SciML from Scratch

A pedagogical library featuring **Numerical Methods for Differential Equations** and **Machine Learning Optimization Algorithms**, built entirely in Julia.

## 🎯 Project Goal
The primary objective of this repository is to demystify high-performance libraries like [SciML](https://github.com/SciML). By implementing these algorithms from the ground up, this project serves as a deep dive into their mathematical foundations, stability considerations, and Julia-specific dispatch patterns that make the scientific ecosystem so efficient.

## 🚀 Current Features

### Numerical Integrators
- **SaveEveryStep** — To simplify the implementation, we save all the intermediary values.
- **SArray** — As the target problems are low-dimensional, we support only SArray as input.
- **IIP** — In order to perform operations on the stack, we do not support inplace functions.

> - [x] **Forward Euler Method** — The fundamental building block of numerical integration for Initial Value Problems (IVPs).
> - **Goal** — Implement it to be as quick as possible.
> 
> $$y_{n+1} = y_n + h f(t_n, y_n)$$

### Optimization Algorithms

> - [ ] **Naive Gradient Descent** — A pure implementation of the vanilla steepest descent algorithm. 
> - **Goal** — Explore the challenges of local minima and convergence
> 
> $$\theta_{\text{next}} = \theta - \eta \nabla J(\theta)$$
