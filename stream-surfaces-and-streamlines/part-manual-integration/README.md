# Part 1: Manual Integration

In this part, I find the stream surfaces and the streamline for one velocity field by integrating on paper, then use MATLAB only to plot the results. It is the baseline for the other two parts: the same flow is solved symbolically in Part 2 and numerically in Part 3.

Completed: 13 October 2026

## The flow

u = x, v = -y, w = 1          seed point: (1, 1, 0)

## Derivation by hand

A streamline is tangent to the velocity at every point. This implies that V x ds = 0 (the cross product of two parallel vectors is zero), where 

V = iu + jv + kw,   

ds = idx + jdy + kdz

Taking the cross product and simplifying, we have:

dx/u = dy/v = dz/w

Taking the ratios two at a time with u = x, v = -y, w = 1:
   
dx/x = -dy/y   ->   ln x + ln y = k1   ->   x*y = c1 (where c1 = e^(k1))

dx/x = dz/1    ->   z - ln x = c2

The first surface can be written in two equivalent forms, ln x + ln y = k1 or xy = c1. Each equation represents a family of surfaces, one for each constant value. The seed point (1, 1, 0) fixes the constants:

c1 = 1*1 = 1

c2 = 0 - ln (1) = 0

Part 2 uses the log form, so the constant it finds for the first surface is k1 = 0, which describes the same surface as c1 = 1 here.

So the two stream surfaces through the seed point are xy = 1 and z = ln x. Their intersection is the streamline. Choosing t as a free parameter with z = t:

x = e^t,   y = e^(-t),   z = t

At t = 0, this gives (1, 1, 0)

We parametrised the curve using the equations of the stream surfaces, meaning that each point t satisfies both equations for every t; the point (e^t, e^(−t), t) lies on both surfaces, so the curve is part of the intersection. And because every point on both surfaces satisfies z = ln x and y = 1/x, it must equal that expression for t = z, so the curve is the whole intersection.

## What the script does

```stream_surfaces_part1.m``` takes the hand results above and plots them. 

1. Surface z = ln x: ```meshgrid``` builds a grid over x and y (it assigns a value of x for every y), and Z1 = log(X1) gives the height at every grid point. y does not appear in the equation, so the surface is the curve z = ln x extruded (repeated) along y.
2. Surface xy = 1. This equation has no z, so the grid is built over x and z, and Y2 = 1./X2 gives y at every grid point. The surface is the hyperbola xy = 1 extruded (repeated) along z, which is a wall standing along the z-axis.
3. Streamline: ```plot3(exp(t), exp(-t), t)``` draws the parametrised curve in red on top of both surfaces.


The red curve runs along the intersection of the green sheet (z = ln x) and the blue wall (xy = 1), and passes through the seed point (1, 1, 0).

## Key Ideas

- Vectors in, curve out. Matrices in, surface out: ```plot3``` takes vectors and draws a curve; ```surf``` takes matrices from meshgrid and draws a surface.
- Why ```meshgrid```: A surface has two independent variables, so I need every combination of them. ```meshgrid``` builds that grid, and the equation gives the third variable at each point.
- Missing variable means extrusion: If one variable does not appear in the equation, the surface is the same curve repeated along that variable's axis.
- Element-wise operators:  ```1./x2``` needs the dot, because X2 is a matrix.

## Running it
- Requires MATLAB (written in R2021a). No toolboxes are needed.
- Run the script from its own folder. It saves the figure with  ```saveas``` into MATLAB's current folder, so running it from elsewhere can give a "cannot create output file" error.

## Limitation
Everything that matters in this part was done by me on paper: the integration, the constants, and the streamline parametrisation. The script only draws them.
- A different velocity field means redoing the algebra.
- ```surf``` needs each surface rearranged so that one variable is a formula in terms of the other two. That worked here (```y = 1/x``` and ```z = ln x```), but it is not always possible. A sphere, for example, gives two heights for each point, so one formula cannot draw it.
- The plot shows that the red curve lies on both surfaces, but nothing in the script checks it. Part 2 adds a numerical check.

Part 2 removes the hand integration by letting MATLAB's Symbolic Math Toolbox do it, and plots the surfaces implicitly so they no longer need rearranging.
