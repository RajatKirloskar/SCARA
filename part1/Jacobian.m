function [jacobian,xe_dot] = Jacobian(q,qdot)

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

A_b0 = mb;
A_b1 = (mb*m1);
A_b2 = (mb*m1*m2);
A_b3 = (mb*m1*m2*m3);

A_b4 = (mb*M);

p4_p0 = A_b4(1:3,4) - A_b0(1:3,4);
p4_p1 = A_b4(1:3,4) - A_b1(1:3,4);
p4_p3 = A_b4(1:3,4) - A_b3(1:3,4);

zb0 = A_b0(1:3,3);
zb1 = A_b1(1:3,3);
zb2 = A_b2(1:3,3);
zb3 = A_b3(1:3,3);

zb0 = zb0';
zb1 = zb1';
zb2 = -zb2';
zb3 = zb3';

p4_p0 = p4_p0.';
p4_p1 = p4_p1.';
p4_p3 = p4_p3.';

z0_cross_p4_p0 = cross(zb0,p4_p0);
z1_cross_p4_p1 = cross(zb1,p4_p1);
z3_cross_p4_p3 = cross(zb3,p4_p3);

% jacobian = [z0_cross_p4_p0(1,1) z1_cross_p4_p1(1,1) zb2(1,1) z3_cross_p4_p3(1,1);
%             z0_cross_p4_p0(1,2) z1_cross_p4_p1(1,2) zb2(1,2) z3_cross_p4_p3(1,2);
%             z0_cross_p4_p0(1,3) z1_cross_p4_p1(1,3) zb2(1,3) z3_cross_p4_p3(1,3);
%             zb0(1,1) zb1(1,1) 0 zb3(1,1);
%             zb0(1,2) zb1(1,2) 0 zb3(1,2);
%             zb0(1,3) zb1(1,3) 0 zb3(1,3)];

%Removing dependent rows

jacobian = [z0_cross_p4_p0(1,1) z1_cross_p4_p1(1,1) zb2(1,1) z3_cross_p4_p3(1,1);
            z0_cross_p4_p0(1,2) z1_cross_p4_p1(1,2) zb2(1,2) z3_cross_p4_p3(1,2);
            z0_cross_p4_p0(1,3) z1_cross_p4_p1(1,3) zb2(1,3) z3_cross_p4_p3(1,3);
            zb0(1,3) zb1(1,3) 0 zb3(1,3)];
 
xe_dot = jacobian*qdot;
xe_dot = xe_dot';

 end

function [m] = dk(theta,d,a,alpha)
    m = [cos(theta) -sin(theta)*cos(alpha) sin(theta)*sin(alpha) a*cos(theta);
         sin(theta) cos(theta)*cos(alpha) -cos(theta)*sin(alpha) a*sin(theta);
         0 sin(alpha) cos(alpha) d;
         0 0 0 1];
end
