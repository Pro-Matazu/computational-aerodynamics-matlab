%Stream surfaces and streamlines through a seed point using symbolic method
%Flow field; u = x, v = -y, w = 1 through seed point (1,1,0)
%Requirement: Symbolic math toolbox. See readme for method and limitations
clc;clear;close all
syms x y z real%The symbolic variables are defined as real variables. Our equations are expressed in terms of these variables
u = x; v = -y; w=1;%We define the velocity components. We define them so that each integral involves one variable
V = [u v w];%We define the velocity vector. This line comes handy during our check for stream surfaces
seed = [1 1 0];%This is the point through which the streamline passes(seed point)
%Solving and  evaluating the stream surface:
f1 = int(1/u, x) - int(1/v, y);%This evaluates the equation for the first stream surface (f1 is an expression in x, y, z)
f2 = int(1/w, z) - int(1/u, x);%This evaluates the equation for the second stream surface (f2 is an expression in x, y, z)
c1 = subs(f1, [x y z], seed);%This evaluates f1 at the seed point to get the constant c1
c2 = subs(f2, [x y z], seed);%This evaluates f2 at the seed point to get the constant c2
%Testing to see if the stream surfaces satisfy the gradient test:
gradf1 = gradient(f1, [x y z]);%The line evaluates the gradient vector of the first stream surface
gradf2 = gradient(f2, [x y z]);%The line evaluates the gradient vector of the second stream surface
dot1 = dot(gradf1, V);%This line evaluates the dot product of gradient of f1 and velocity vector so that when the result is zero everywhere, f1 is a stream surface
dot2 = dot(gradf2, V);%This line evaluates the dot product of gradient of f2 and velocity vector so that when the result is zero everywhere, f2 is a stream surface
disp(dot1); disp(dot2);
%Plots:
stream_surface1 = matlabFunction(f1 - c1, 'vars', [x y z]);%This line moves the constant c1 to other side to get the form F(x,y,z) = 0, and make x,y,z the function's variables
stream_surface2 = matlabFunction(f2 - c2, 'vars', [x y z]);%This line moves the constant c2 to other side to get the form F(x,y,z) = 0, and make x,y,z the function's variables
domain = [0.2 3 0.2 5.2 -2 2];%This defines our domain
graph1 = fimplicit3(stream_surface1, domain, FaceAlpha = 0.5, FaceColor = 'b', EdgeColor = 'none');%This line of code draws the first stream surface
hold on
graph2 = fimplicit3(stream_surface2, domain, FaceAlpha = 0.5, FaceColor = 'g', EdgeColor = 'none');%This line of code draws the second stream surface
t = linspace(log(0.2), log(3), 100);%This line defines the limits of a parameter t that defines our streamine: t runs over the values that keep the curve inside the domain box
plot3(exp(t), exp(-t), t, 'r', LineWidth = 3)%This line graphs the streamline from the parametrization of the streamline we did by hand
hold off
%Annotations
title('Stream surfaces and streamline through (1,1,0)')
xlabel('x'); ylabel('y'); zlabel('z');
legend('Stream surface 1', 'Stream surface 2', 'Streamline')
saveas(gcf, 'stream_surfaces_using_symbolic_math_method.png')
%Second test: residual test
residual1 = max(abs(stream_surface1(exp(t), exp(-t), t)));%This provides a numerical test for surface 1 (and streamline). More info in repo
residual2 = max(abs(stream_surface2(exp(t), exp(-t), t)));%This provides a numerical test for surface 2 (and streamline). More info in repo
disp(residual1); disp(residual2);
% Limitation: the streamline (line 28) is parametrized by hand, and the
% surfaces only come out because each integral involves a single variable.
% A velocity field that doesn't separate this way breaks this method.