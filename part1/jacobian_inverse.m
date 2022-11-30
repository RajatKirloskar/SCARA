function q_dotdot = jacobian_inverse(x,q)

[jacobian,~] = Jacobian(q,0);

jacobian_inv = (inv(jacobian));
q_dotdot = jacobian_inv*x;

end