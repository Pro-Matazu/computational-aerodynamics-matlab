# Part 3: Numerical Integration

Part 1 needed me to integrate by hand, and Part 2 needed the integrals to separate into one-variable pieces and could not divide by a zero velocity component. In this part, MATLAB's `ode45` traces the streamline directly from the velocity field and a seed point. There are no integrals to solve and no division.

Completed: 23 October 2026.

## The idea

Set the common value of the three ratios in `dx/u = dy/v = dz/w` to `dτ`. Solving each ratio for its differential gives

``` math
dx/dτ = u,   dy/dτ = v,   dz/dτ = w
```
or, in vector form with `p = (x, y, z)`,
``` math
dp/dτ = V(p)
```
