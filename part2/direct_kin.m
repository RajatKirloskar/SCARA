function [x,z] = direct_kin(q)
a1 = 0.5;
a2 = 0.5;
mb = [1 0 0 0;
      0 1 0 0;
      0 0 1 1;
      0 0 0 1];

theta1 = q(1);
theta2 = q(2);
d3 = q(3);
theta4 = q(4);

m1 = dk(theta1,0,a1,0);
m2 = dk(theta2,0,a2,0);
m3 = dk(0,-d3,0,0);
m4 = dk(theta4,0,0,0);

M = m1*m2*m3*m4;

% A_b0 = mb;
% A_b1 = (mb*m1);
% A_b2 = (mb*m1*m2);
% A_b3 = (mb*m1*m2*m3);

A_b4 = (mb*M);
p = A_b4(1:2,4);
o = theta1 + theta2 + theta4;
z = A_b4(3,4);

x = [p;o];
x = x';
x = double(x);

end
function [m] = dk(theta,d,a,alpha)
    m = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta);
         sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
         0 sin(alpha) cos(alpha) d;
         0 0 0 1];
end

