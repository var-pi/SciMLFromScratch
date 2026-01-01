# SciML from Scratch

A pedagogical library featuring *Numerical Methods for Differential Equations* and *Machine Learning Optimization Algorithms*, built entirely in Julia.

## 🎯 Project Goal
The primary objective of this repository is to pull back the curtain on high-performance libraries like [SciML](https://github.com/SciML). By implementing these algorithms from the ground up, this project serves as a deep dive into the mathematical internals, stability analysis, and dispatch-oriented programming patterns that make Julia's scientific ecosystem so powerful.

## 🚀 Current Features

### Numerical Integrators

- [ ] **Forward Euler Method**: The fundamental building block of numerical integration for Initial Value Problems (IVPs).
> *Goal:* Implement it to be as quick as possible.

$$y_{n+1} = y_n + h f(t_n, y_n)$$

### Optimization Algorithms

- [ ] **Naive Gradient Descent**: A pure implementation of the vanilla steepest descent algorithm. 
> *Goal:* Explore the challenges of local minima and convergence

$$\theta_{next} = \theta - \eta \nabla J(\theta)$$
