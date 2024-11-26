# 1-dimensional-elasto-dynamics

----

Here is a properly formatted review for your GitHub repository, with the equations written using LaTeX-style syntax (Markdown + MathJax compatibility). You can copy this and paste it directly into your README.md or any other Markdown file in your repository.

---

# **1D Elasto-Dynamics Code: Explanation**

This MATLAB code implements a 1-dimensional finite element method (FEM) for solving the elasto-dynamics problem. The following is a detailed breakdown of the code's key components.

---

## **1. Governing Equation**

The problem is modeled using the elasto-dynamic equation:

\[
\nabla \cdot \sigma + \rho a = 0
\]

where:

- \(\sigma\): Stress
- \(\rho\): Density
- \(a\): Acceleration

The code uses FEM to calculate the dynamic response of a material to time-varying forces.

---

## **2. Mesh Generation**

- **Domain**: Defined between \(x_{\text{start}} = 0\) and \(x_{\text{end}} = 1\).
- **Number of Elements**: \(t_{\text{ne}} = 100\).
- **Element Type**: Quadratic elements (\(Q_2\)).

Using the custom `CreateMesh` function, the following are calculated:

- Element lengths (\(L\)).
- Node coordinates (\(x\)).
- Connectivity arrays for the FEM mesh.

---

## **3. Material Properties**

- **Elasticity tensor** (\(E\)): \(E = 200{,}000\).
- **Density** (\(\rho\)): \(\rho = 1160\).

These values are constant within each element.

---

## **4. Pre-calculation**

### **Gaussian Quadrature**
To integrate element matrices numerically, the Gaussian quadrature method is used with \(n_{\text{gp}} = 3\) points.

---

### **Shape Functions**
Quadratic shape functions (\(Q_2\)) and their derivatives are computed to interpolate and evaluate quantities over an element.

---

## **5. Element Matrices**

The element-level **mass matrix**, **stiffness matrix**, and **force vector** are computed for each element using Gaussian quadrature.

### **Key Equations**

1. **Mass Matrix** (\(M_e\)):

\[
M_e = \int N^T \rho N \, J \, dx
\]

2. **Stiffness Matrix** (\(K_e\)):

\[
K_e = \int B^T \frac{E}{J} B \, J \, dx
\]

3. **Force Vector** (\(F_e\)) (with an example force):

\[
F_e = \int N^T \cdot \text{force} \, J \, dx
\]

Where:

- \(N\): Shape function matrix.
- \(B\): Derivatives of the shape functions.
- \(J\): Jacobian determinant.

A sample force is given by:

\[
\text{force} = (3x + x^2)e^x
\]

---

## **6. Global Matrix Assembly**

After calculating element-level matrices, they are assembled into global matrices:

- Global **mass matrix** (\(\bar{M}\)).
- Global **stiffness matrix** (\(\bar{K}\)).
- Global **force vector** (\(\bar{F}\)).

---

## **7. Boundary Conditions**

- **Dirichlet Boundary**: Node 1 is fixed.
- **Neumann Boundary**: The last node has a prescribed force.

Global matrices and vectors are partitioned into free (\(f\)) and fixed (\(p\)) degrees of freedom for boundary condition application.

---

## **8. Time Integration (Newmark Method)**

The **Newmark method** is used to perform time integration. It is a second-order implicit method for solving dynamic problems.

### **Time Parameters**
- **Total time**: \(T = 1\) second.
- **Time step size**: \(dt = 0.01\).
- **Newmark Parameters**:
  - \(\gamma = 0.5\)
  - \(\beta = 0.5\)

---

### **Solution Steps**

1. **At \(t = 0\):**
   The initial acceleration is computed as:

   \[
   A = M_{ff}^{-1} \left( F_f - K_{ff} U_f \right)
   \]

2. **System decomposition**:
   For faster computation, \(M_{ff} + K_{ff} (dt^2 \cdot \beta)\) is decomposed.

3. **For \(t > 0\):**
   At every time step, the following steps are performed:
   - **Predict displacement** (\(U\)) and velocity (\(V\)).
   - Solve for the new acceleration (\(A\)).
   - Correct \(U\) and \(V\) using the computed \(A\).

---

## **9. Post-Processing**

Displacement, velocity, and acceleration are plotted at each time step to visualize their evolution. The plots reveal how the material reacts dynamically under the applied force.

---

## **10. Key Features of the Code**

- **1D Finite Element Analysis**:
  Uses a 1-dimensional mesh with quadratic elements for higher accuracy.
- **Dynamic Problem**:
  Solves for displacements, velocities, and accelerations over time.
- **Efficient Computation**:
  Employs Gaussian quadrature and Newmark time integration.
- **Visualization**:
  Offers real-time plots of the solution during the simulation.

---

### **Applications**

This code can be used to simulate:

1. Wave propagation in elastic media.
2. Dynamic material response under applied loads.
3. Distribution of stress and displacement in 1D structures.

---

You can now add this explanation to your GitHub repository! If you want any further modifications or additional details, let me know.
