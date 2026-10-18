clear; clc; close all
x = linspace(0.2,3,30);%This line creates a vector for x values of the coordinates 
y = linspace(0,3,30);%This line creates a vector for y values of the coordinates 
z = linspace(-1.5,1.5,30);%This creates a vector for z values of the coordinates
t = linspace(-1,1,100);%This creates a vector for the parameter t used when integrating by hand
[X1, Y1] = meshgrid(x, y);%This builds matrices so that each value of x, is assigned to every value of y to ensure all the points in our domain are covered
Z1 = log(X1);%This defines the relation between the x and z values
surf (X1, Y1, Z1, FaceAlpha = 0.5, FaceColor = 'g', EdgeColor = 'none')%This draws the surface given by z=ln(x), making it green, semitransparent with no edge color
xlabel("x"); ylabel("y"); zlabel("z")%This labels the axes
title("The Stream surfaces: z = lnx and y = 1/x")%This labels the graph
hold on%This ensures the two surfaces, and the curve are drawn on the same graph
[X2, Z2] = meshgrid(x, z);%This creates new matrices such that each value of x, is associated with every value of z(this is the extrusion of the curve along z)
Y2 = 1./X2;%This defines the y coordinate for each of our points that we will plot
surf(X2, Y2, Z2, FaceAlpha = 0.5, FaceColor = 'b', EdgeColor = 'none')%This draws the second surface (y=1/x), making it a blue, half transparent surface with no egde color
plot3(exp(t), exp(-t), t, "r-", LineWidth = 3)%This plots the streamline curve, but uses data from our hand integration. This curve should lie on the intersection points of the two surfaces
view(3)%This sets the standard view of a 3D space
legend('z = ln(x)', 'xy = 1', 'Streamline')
saveas(gcf, 'stream_surfaces_part1.png')
hold off%The next plot command will replace this figure instead of adding to it