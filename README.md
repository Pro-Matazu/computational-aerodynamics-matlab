# Computational Aerodynamics MATLAB
MATLAB projects in computational aerodynamics: stream surfaces, streamlines, and a panel-method airfoil solver (in progress).

Hi, I'm Muhammad Kabir Matazu, a final-year Aerospace Engineering student at the Air Force Institute of Technology (AFIT), Kaduna, Nigeria. This repository holds the MATLAB projects I'm building to teach myself computational aerodynamics, working up from fundamentals toward a panel-method airfoil solver.

Everything here is written and documented by me as I learn. Each project's README explains the method, shows the results, and states where the method stops working.

## Projects

### [Stream surfaces and streamlines](stream-surfaces-and-streamlines/)
Given a 3D velocity field and a seed point, find the stream surfaces through that point and the streamline where they intersect. The project has three parts, and each one addresses the limitation of the one before it.

| Part | Approach | Status |
|---|---|---|
| [1](stream-surfaces-and-streamlines/part1-manual-integration/) | Manual integration: derive the surfaces on paper, then plot them in MATLAB | Done (13 Oct 2026) |
| [2](stream-surfaces-and-streamlines/part2-symbolic-math-method/) | Symbolic integration: MATLAB finds the surfaces from u, v, w, then plots them | Done (14 Oct 2026) |
| [3](stream-surfaces-and-streamlines/part3-numerical-integration/) | Numerical integration: ode45 traces the streamline directly | Done (23 Oct 2026) |

## Tools

MATLAB R2021a, with the Symbolic Math Toolbox for Part 2 of the Stream surfaces and streamlines project

## Contact

LinkedIn: [Muhammad Kabir Matazu](https://linkedin.com/in/muhammad-kabir-matazu)

Email: [kamuhammad11@gmail.com](mailto:kamuhammad11@gmail.com)
