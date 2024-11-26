# 1-dimensional-elasto-dynamics

----

This MATLAB code implements a 1-dimensional finite element method (FEM) for solving the elasto-dynamics problem.


# 1D Elasto-Dynamics FEM Implementation Review

## 1. Problem Setup
The governing equation is:

```math
\nabla \cdot \sigma + \rho a = 0
```

where:
- σ: Stress
- ρ: Density
- a: Acceleration

## 2. Mesh Generation
- Domain boundaries: `xstart = 0` to `xend = 1`
- Number of elements (`tne`): 100
- Element type: Q2 (quadratic elements)

The `CreateMesh` function generates:
- Element lengths (L)
- Node coordinates (x)
- Connectivity arrays (lnn, egnn)

## 3. Material Properties
- Elasticity tensor (E): 200,000 (units not specified)
- Density (ρ): 1160 (units not specified)

## 4. Pre-calculation
### Gaussian Quadrature
- Used for integral evaluation over elements
- Number of Gauss points (ngp): 3

### Shape Functions
- Interpolate values within elements
- Derivatives used for element matrix computation

## 5. Element Matrices
For each element, three main components are computed:
- Mass matrix (Me)
- Stiffness matrix (Ke)
- Force vector (Fe)

### Key Equations:

Mass Matrix:
```math
M_e = \int N^T \rho N \, J \, dx
```

Stiffness Matrix:
```math
K_e = \int B^T \frac{E}{J} B \, J \, dx
```

Force Vector:
```math
F_e = \int N^T f \, J \, dx
```

where:
- N: Shape functions
- B: Shape function derivatives
- J: Jacobian determinant
- f: Force function (example: f = (3x + x²)eˣ)

## 6. Global Assembly
Element matrices are assembled into global system:
- Global mass matrix (M)
- Global stiffness matrix (K)
- Global force vector (F)

## 7. Boundary Conditions
Two types implemented:
- Dirichlet Boundary: Node 1 fixed
- Neumann Boundary: Prescribed force at last node

Matrices are partitioned into:
- Free (f) degrees of freedom
- Prescribed (p) degrees of freedom

## 8. Time Integration (Newmark Method)
### Parameters:
- Total time (T): 1 second
- Time step (dt): 0.01 seconds
- Newmark parameters:
  ```math
  \gamma = 0.5
  ```
  ```math
  \beta = 0.5
  ```

### Algorithm Steps:
1. Initialize displacement (U), velocity (V), and acceleration (A)

2. Initial acceleration:
```math
A = M_{ff}^{-1} (F_f - K_{ff} U_f)
```

3. For each time step:

   a. Displacement Predictor:
   ```math
   U_{f,n} = U_{f,n-1} + \Delta t V_{f,n-1} + \frac{\Delta t^2}{2}(1-2\beta)A_{f,n-1}
   ```

   b. Velocity Predictor:
   ```math
   V_{f,n} = V_{f,n-1} + \Delta t(1-\gamma)A_{f,n-1}
   ```

   c. Solve for Acceleration:
   ```math
   A_{f,n} = (M_{ff} + \beta\Delta t^2K_{ff})^{-1}(F_{f,n} - K_{ff}U_{f,n})
   ```

   d. Correctors:
   ```math
   U_{f,n} = U_{f,n} + \beta\Delta t^2A_{f,n}
   ```
   ```math
   V_{f,n} = V_{f,n} + \gamma\Delta t A_{f,n}
   ```

## 9. Post-Processing
Real-time visualization of:
- Displacement distribution
- Velocity distribution
- Acceleration distribution

## 10. Key Features
1. 1D FEM Implementation
2. Dynamic Analysis using Newmark Method
3. Quadratic Elements (Q2)
4. Gaussian Quadrature Integration
5. Mixed Boundary Conditions

## Applications
The code is suitable for:
- Wave propagation analysis in 1D elastic media
- Dynamic response studies under time-varying loads
- Stress and displacement analysis in 1D structures
- Educational purposes in computational mechanics

## Technical Implementation Notes
- Written in MATLAB
- Modular structure with separate mesh generation
- Efficient matrix operations using MATLAB's built-in functions
- Real-time visualization capabilities

This implementation serves as an excellent example of numerical methods in computational mechanics, specifically for elastic wave propagation problems in one dimension.

---

