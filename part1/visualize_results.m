function vis = visualize_results(q,pos,pd,theta_d,t)
%plot tracking
addpath ("visualization/")

th1 = q(1,:,:);
th2 = q(2,:,:);
th3 = q(3,:,:);
th4 = q(4,:,:);

val1(:,1) = th1(1,1,:);
val2(:,1) = th2(1,1,:);
val3(:,1) = th3(1,1,:);
val4(:,1) = th4(1,1,:);

t1 = pos(:,1,:);
t2 = pos(:,2,:);
t3 = pos(:,3,:);
t4 = pos(:,4,:);

v1(:,1) = t1(1,1,:);
v2(:,1) = t2(1,1,:);
v3(:,1) = t3(1,1,:);
v4(:,1) = t4(1,1,:);

figure(1)
subplot(5,1,1); plot(t, pd(:,1)-v1(:,1));
subplot(5,1,2); plot(t, pd(:,2)-v2(:,1));
subplot(5,1,3); plot(t, pd(:,3)-v3(:,1));
subplot(5,1,4); plot(t, theta_d(:,1)-v4(:,1));
subplot(5,1,5);

figure(2)
subplot(5,1,1); plot(t, val1(:,1));
subplot(5,1,2); plot(t, val2(:,1));
subplot(5,1,3); plot(t, val3(:,1));
subplot(5,1,4); plot(t, val4(:,1));
subplot(5,1,5);

end