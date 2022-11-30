function jdot = jacobian_dot(q,q_dot)

theta1 = q(1);
theta2 = q(2);

theta1_dot = q_dot(1);
theta2_dot = q_dot(2);
    
jd = [-0.5*cos(theta1)*(theta1_dot)-0.5*cos(theta1+theta2)*(theta1_dot+theta2_dot) , -0.5*cos(theta1+theta2)*(theta1_dot+theta2_dot), 0 ,0; 
        -0.5*sin(theta1)*(theta1_dot)-0.5*sin(theta1+theta2)*(theta1_dot+theta2_dot) , -0.5*sin(theta1+theta2)*(theta1_dot+theta2_dot), 0 ,0;
         0, 0, 0, 0 ; 
         0, 0, 0, 0];

jdot = jd*q_dot;
jdot = jdot';

end