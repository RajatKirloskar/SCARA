%main code
clear all;
close all;
clc
Ts=0.001;

q0 = [-0.927293431584587
-1.28700579042062
0.700000000000000
2.21429922200521];

qt1 = [];
qt2 = [];
qt3 = [];
qt4 = [];

s1 = zeros(3401,1);
s2 = zeros(3401,1);
s3 = zeros(3401,1);
s4 = zeros(3401,1);

t = [];
theta_d = [];
theta_d_dot = [];
theta_d_dot_dot = [];


p0 = [0 -0.8 0];
p1 = [0 -0.8 0.5];
p2 = [0.5 -0.6 0.5];
p3 = [0.8 0.0 0.5];
p4 = [0.8 0.0 0.0];

t0 = 0.0;
t1 = 0.6;
t2 = 2.0;
t3 = 3.4;
t4 = 4.0;

tf1 = t1-t0;
tf2 = t2-t1;
tf3 = t3-t2;
tf4 = t4-t3;

q_dotdot_c1 = (4*(p1 - p0))/(tf1^2)*1.4;
q_dotdot_c2 = (4*(p2 - p1))/(tf2^2)*1.4;
q_dotdot_c3 = (4*(p3 - p2))/(tf3^2)*1.4;
q_dotdot_c4 = (4*(p4 - p3))/(tf4^2)*1.4;

tc1 = (tf1/2) - 0.5*(((tf1^2*norm(q_dotdot_c1)) - 4*norm((p1-p0)))/norm(q_dotdot_c1))^0.5;
tc2 = (tf2/2) - 0.5*(((tf2^2*norm(q_dotdot_c2)) - 4*norm((p2-p1)))/norm(q_dotdot_c2))^0.5;
tc3 = (tf3/2) - 0.5*(((tf3^2*norm(q_dotdot_c3)) - 4*norm((p3-p2)))/norm(q_dotdot_c3))^0.5;
tc4 = (tf4/2) - 0.5*(((tf4^2*norm(q_dotdot_c4)) - 4*norm((p4-p3)))/norm(q_dotdot_c4))^0.5;

for tt = 0:Ts:0.6 %Segment 1
    if(tt>=0 && tt<=tc1)
       qt1(end+1,:) = p0 + (0.5*q_dotdot_c1*tt^2);  
    elseif(tt>tc1 && tt<=(t1-tc1))
       qt1(end+1,:) = p0 + q_dotdot_c1*tc1*(tt-(tc1/2));
    elseif(tt>(t1-tc1) && tt<=t1)
       qt1(end+1,:) = p1 - 0.5*q_dotdot_c1*((tf1-tt)^2);
     else
       qt1(end+1,:) = qt1(end,:);
    end
end
d = 0;
for i =1:600
  d = norm(qt1(i+1,:)-qt1(i,:))+d;
  s1(i+1 ,:) = d;
end
   
   s1(602:3401) = s1(601);
   pos1 = ((s1*(p1-p0)/norm(p1-p0)));



for tt = 0:Ts:1.4  % Segment 2
    if(tt>=0 && tt<=tc2)
       qt2(end+1,:) = p1 + (0.5*q_dotdot_c2*tt^2); 
    elseif(tt>tc2 && tt<=(tf2-tc2))
       qt2(end+1,:) = p1 + q_dotdot_c2*tc2*(tt-(tc2/2));
    elseif(tt>(tf2-tc2) && tt<=tf2)
       qt2(end+1,:) = p2 - 0.5*q_dotdot_c2*((tf2-tt)^2);
    elseif(tt>tf2)
       qt2(end+1,:) = qt2(end,:);
    else
        qt2(end+1,:) = [0 0 0];
    end
    
end
d = 0;
for i =1:1400
        d = norm(qt2(i+1,:)-qt2(i,:))+d;
        s2(i+400,:) = d;
end
s2(1:400) = 0;
s2(1801:3401) = s2(1800);
pos2 = ((s2*(p2-p1)/norm(p2-p1)));


for tt = 0:Ts:1.4 %Segment 3
    if(tt>=0 && tt<=tc3)
       qt3(end+1,:) = p2 + (0.5*q_dotdot_c3*tt^2);
    elseif(tt>tc3 && tt<=(tf3-tc3))
       qt3(end+1,:) = p2 + q_dotdot_c3*tc3*(tt-(tc3/2));
    elseif(tt>(tf3-tc3) && tt<=tf3)
       qt3(end+1,:) = p3 - 0.5*q_dotdot_c3*((tf3-tt)^2);
    elseif(tt>tf3)
       qt3(end+1,:) = qt3(end,:);
    else
       qt3(end+1,:) = [0 0 0];
    end
end
d = 0;
for i =1:1400
        d = norm(qt3(i+1,:)-qt3(i,:))+d;
        s3(i+1601,:) = d;
end
s3(1:1600) = 0;
s3(3002:3401) = s3(3000);
pos3 = ((s3*(p3-p2)/norm(p3-p2)));



for tt = 0:Ts:0.6  %Segment 4
    if(tt>=0 && tt<=tc4)
       qt4(end+1,:) = p3 + (0.5*q_dotdot_c4*tt^2); 
    elseif(tt>tc4 && tt<=(tf4-tc4))
       qt4(end+1,:) = p3 + q_dotdot_c4*tc4*(tt-(tc4/2));
    elseif(tt>(tf4-tc4) && tt<=tf4)
       qt4(end+1,:) = p4 - 0.5*q_dotdot_c4*((tf4-tt)^2);
    elseif(tt>tf4)
       qt4(end+1,:) = qt4(end,:);
    else
       qt4(end+1,:) = [0 0 0];
    end
end
d = 0;
for i =1:600
        d = norm(qt4(i+1,:)-qt4(i,:))+d;
        s4(i+2801,:) = d;
end
s4(1:2800) = 0;
pos4 = ((s4*(p4-p3)/norm(p4-p3)));

for i = t0:Ts:t3
    t(end+1,:) = i;
    theta_d(end+1,:) = 0;
    theta_d_dot(end+1,:) = 0;
    theta_d_dot_dot(end+1,:) = 0;
end    


T_ant = t0:Ts:t3;
pd = p0 + pos1 + pos2 + pos3 + pos4;

pd_dot = diff(pd/Ts);
pd_dot(3401,:) = pd_dot(3400,:);
pd_dot_dot = diff(pd_dot/Ts);
pd_dot_dot(3401,:) = pd_dot_dot(3400);

figure(1)
plot(pd)
xlabel("Time");
ylabel("Position");
legend("x","y","z")
figure(2)
plot(pd_dot)
xlabel("Time");
ylabel("Velocity");
legend("x","y","z")
figure(3)
plot(pd_dot_dot)
xlabel("Time");
ylabel("Acceleration");
legend("x","y","z")
figure(4)
plot3(pd(:,1),pd(:,2),pd(:,3))


save('generated_traj');




