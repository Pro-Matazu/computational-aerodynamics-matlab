# Part 2: Symbolic Integration

In [Part 1](../part1_manual_integration/), I did the integration by hand and used MATLAB to plot the results. In this part, MATLAB's Symbolic Math Toolbox does the integration, finds the constants from the seed point, and plots the stream surfaces directly from their equations. Two checks confirm that the surfaces are correct.

Completed: 14 October 2026.

## The flow

```
u = x, v = -y, w = z       seed point: (1, 1, 0)
```

The same flow as Part 1, so the two parts can be compared directly. 

## Method

The script `stream_surfaces_using_symbolic_math_method.m` follows the same chain as the hand derivation, `dx/u = dy/v = dz/w`, taking the ratios two at a time.

1. **Declare symbols:** `syms x y z` makes x, y and z symbolic. The `real` declaration matters later (see gradient test).
2. **Integrate:** Each pair of ratios gives one surface expression:
```matlab
f1 = int(1/u, x) - int(1/v, y);    % ln x + ln y
f2 = int(1/w, z) - int(1/u, x);    %z - ln x
```

`int` returns one antiderivative with no `+ c`, so `f1`, `f2` are expressions in x,y,z. The constants come from the seed point.

3. **Find the constants:** `subs` evaluates each expression at the seed point:
```matlab
c1 = subs(f1, [x y z], seed);       %0
c2 = subs(f2, [x y z], seed);       %0
```
The two stream surfaces are `f1 = c1` and `f2 = c2`. These are the same surfaces as in part 1: `ln x + ln y = 0` is `xy = 1`, and `z - ln x` is `z = ln x`. The constant for the first surface is 0 here, and 1 in Part 1, because the surface is written in log form here and in product form there.

4. **Check the surfaces(gradient test):** See below. 
 
5. **Plot:** The surfaces are drawn with `fimplicit3`, and the streamline overlaid.
6. **Check the streamline(residual test):** See below
   
![Stream surfaces and streamlines, symbolic method](stream_surfaces_using_symbolic_method.png/)

## Plotting implicit surfaces

`fimplicit3(F, domain)` draws every point where `F(x,y,z) = 0`, so a surface does not need to be rearranged to give one variable as a formula in the other two. This removes the main limitation of Part 1. The input is `f - c`, which moves the constant to the left side.

**One trap**: if the expression contains only two of the three variables, `fimplicit3` assigns those two to the first two axes. The surface `z - ln x = 0` contains x and z, so it was drawn as `y - ln x = 0` instead. The fix is to make all three variables inputs, even if one is unused:

```matlab
stream_surface2 = matlabFunction(f2 - c2, 'vars', [x y z]);
```

**Choosing the domain box** `[0.2 3  0.2 5.2  -2 2]`:
- `x` must be positive (greater than zero) because of `log`, it starts at 0.2.
- The wall `xy = 1` reaches `y = 5` at `x = 0.2`, so y goes up to 5.2 to avoid clipping it.
- The sheet `z = ln x` reaches `z = -1.61` at `x = 0.2`, so z starts below that, at -2.

The streamline parameter runs from `t = log(0.2)` to `t = log(3)`, which are the values that keep `x = e^t` inside the box.

## Check 1: the gradient test

A function `f` describes a stream surface if the velocity is tangent to the surface everywhere. The gradient of `f` is perpendicular to the surface, so the condition is

```
V · ∇f = 0    everywhere
```

```matlab
grad1 = gradient(f1, [x y z]);    %gradient of f1
grad2 = gradient(f2, [x y z]);    %gradient of f2
dot1 = dot(grad1, V);             % 0
dot2 = dot(grad2, v);             % 0
```

Both return exactly 0 as symbolic expressions, so the test holds at every point and not at seed point.

`syms x y z real` is needed here because `dot` conjugates its first argument. For complex symbols, the result stays as `conj(x)/x - conj(y)/y`, which MATLAB cannot simplify to 0. Declaring the variables real removes the conjugates.

## Check 2: the residual test

The streamline `x = e^t, y = e^(-t), z = t` was derived by hand, so I test it numerically. Substituting its points into both surface equations should give zero:

```matlab
residual1 = max(abs(stream_surface(exp(t), exp(-t), t)));
residual2 = max(abs(stream_surface(exp(t), exp(-t), t)));
```

Both come out as **2.2204e-16.** This is `eps`, the spacing between adjacent double-precision numbers near 1, so the curve lies on both surfaces to within rounding error. It is not exactly 0 because these functions use floating-point arithmetic, while the gradient test uses exact symbolic algebra. 

## Running it

- Requires MATLAB (written in R2021a) with the **Symbolic Math Toolbox**
- Run the script from its own folder. It saves the figure with `saveas` into MATLAB's current folder, so running it from elsewhere can give a "cannot create output file" error.

 ## Limitation

- **Only works when the integrals separate.** `int(1/u, x)` needs `1/u` to depend on x alone, and likewise for the other ratios. For a field like `u = x + y`, the ratio `dx/u = dy/v` cannot be split into one-variable integrals, and the method breaks. Even when each integral separates, it needs a closed form.
- **The streamline is still parametrised by hand.** The surfaces and constants are automatic, but the red curve comes from my own algebra. A new velocity field needs new algebra for it.
- **Division by `u`, `v`, or `w` fails wherever they are zero**, because the method integrates `1/u`, `1/v` and `1/w`.

[Part 3](../part3-numerical-integration/) removes all three by tracing the streamline numerically from `dx/dr = u`, `dy/dr = v`, `dz/dr = w`, with no integrals and no division.
