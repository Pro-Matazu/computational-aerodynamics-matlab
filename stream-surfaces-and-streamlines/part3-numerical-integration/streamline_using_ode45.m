clc; clear; close all;
seed1 = [1; 1; 0];
rhs1 = @(t, p) [p(1); -p(2); 1]; %This defines the relation (function) that ode45 will take. 
%ode45 always calls this function with the parameter first and the position second. The flow is steady, so t is not used.
disp(rhs1(0, seed1)); %This should return 1 -1 1 (i.e velocity at seed point), in a single column
[T1, P1] = ode45(rhs1, [0 1], seed1);  %This numerically solves for P, with the parameter t going forward (i.e from 0 to 1)
[Tb, Pb] = ode45(rhs1, [0 -1], seed1); %This numerically solves for P, with the parameter t going backwards (i.e from 0 to -1)
Pall = [flipud(Pb); P1]; %This line joins the two curves (forward and backward), so as to allow us do the residual test to both curves at once

%T holds the parameter value at each row of P
%P returns a matrix with each row defining a point (x,y,z), and each column of P is one coordinate

%second test flow: Part 2 cannot solve this flow, because w = 0 makes the ratio dz/w divide by zero.
seed2 = [1; 0; 0];
rhs2 = @(t, p) [-p(2); p(1); 0];
[T2, P2] = ode45(rhs2, [0 2*pi], seed2);

%plots
figure%The first test flow, which is the same flow used in part 1 and 2
plot3(P1(:,1), P1(:,2), P1(:,3), 'r', linewidth = 3);
%This takes the first column of P as x, second as y and third as z and plot each x with its corresponding y and z value
axis equal; grid on
xlabel('x'); ylabel('y'); zlabel('z');
title('Streamline: u=x, v=-y, w=1; seed(1,1,0)');
view(3);
saveas(gcf, 'streamline_using_ode45_flow1.png');
figure%The second test flow, which is the one that breaks part 2 (division by zero)
plot3(P2(:,1), P2(:,2), P2(:,3), 'b', linewidth = 3);
axis equal; grid on
xlabel('x'); ylabel('y'); zlabel('z');
title('Streamline: u=-y, v=x, w=0; seed(1,0,0)');
view(2);
saveas(gcf, 'streamline_using_ode45_flow2.png');

%Overlay
figure%The overlay of the streamline obtained by ode45 onto Part 2 sketch
%The next six lines sketch the two intersecting stream surfaces in Part 2
F1 = @(x, y, z) x.*y -1;    %Stream surface xy = 1
F2 = @(x, y, z) z - log(x); %Stream surface z - ln x = 0
domain = [0.2 3  0.2 5.2  -2 2]; %This is the domain used in part 2
fimplicit3(F1, domain, FaceAlpha = 0.5, FaceColor = 'b', EdgeColor = 'none');
hold on
fimplicit3(F2, domain, FaceAlpha = 0.5, FaceColor = 'g', EdgeColor = 'none');
%The next two lines overlay the streamline obtained in Part 3, onto the graph of the stream surfaces of Part 2
plot3(P1(:, 1), P1(:, 2), P1(:, 3), 'r', linewidth = 3); %The curve obtained starts at t = 0 and terminates at t = 1
plot3(Pb(:, 1), Pb(:, 2), Pb(:, 3), 'r', linewidth = 3); %The curve obtained starts at t = 0 and terminates at t = -1
hold off
xlabel('x'); ylabel('y'); zlabel('z');
title('Overlay of Part 2 and Part 3');
legend('Surface xy = 1', 'Surface z - ln x = 0', 'Streamline using ode45');
saveas(gcf, 'overlay_part2_part3.png');

%Residual test on flow 1(forward and backward curve), against the Part 2 stream surfaces
x = Pall(:,1); y = Pall(:,2); z = Pall(:,3);
residual1 = max(abs(x.*y - 1));
residual2 = max(abs(z - log(x)));
format long
disp(residual1); disp(residual2)
format short