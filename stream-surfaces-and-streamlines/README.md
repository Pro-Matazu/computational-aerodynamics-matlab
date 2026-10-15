# Stream surfaces and streamline

Given a 3D steady velocity field and a seed point, this project finds the two stream surfaces that pass through the point and shows the streamline as the curve where they intersect.

It is built in three parts. Each part solves the same problem differently, and each one ends at a limitation that the next part is designed to address.

Parts 1 and 2 were completed on 13 and 14 October 2026, respectively and published to GitHub on ___

## The problem

A streamline is a curve that is tangent to the velocity vector at every point. We know from vector algebra that the cross product of two parallel vectors is zero. If a vector is tangent to another vector at every point, they are parallel at every point. Mathematically, V × ds = 0, where 

```math
\mathbf{V} = u\,\hat{\mathbf{i}} + v\,\hat{\mathbf{j}} + w\,\hat{\mathbf{k}}
```

```math
d\mathbf{s} = dx\,\hat{\mathbf{i}} + dy\,\hat{\mathbf{j}} + dz\,\hat{\mathbf{k}}
```


ds = idx + jdy + kdz. 
  
The cross product will have the components 
  
vdz - wdy = 0
  
wdx - udz = 0

udy - vdx = 0. 

From the components, we see that 

dx/u = dy/v = dz/w. 
