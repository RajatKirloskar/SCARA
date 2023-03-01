# SCARA Manipulator Trajectory Planning

### OBJECTIVE
Part 1- The aim for the first part of the project is to generate a trajectory in the robot operational space using the trapezoidal velocity profile for each segment passing through a given set of waypoints at the specified time intervals.

Part 2- The goal of this part of the project is to generate the inverse dynamics control approach for our SCARA manipulator to follow the trajectory that has been generated in part 1 of this project, considering that 5 Kg load has been placed at the end effector. 

### METHODOLOGY 
#### PART 1

The first step is to calculate the values of q(t) as per the constraints that need to be obeyed in the Trapezoidal Velocity Profile which imposes an acceleration in the starting phase followed by a cruise velocity and then a deceleration during the arrival phase.

The trajectory has to satisfy some constraints to make the transition from qi to qf in time tf.

The velocity trapezoidal velocity profile in terms of position, velocity and acceleration can be observed from the following graphs below

![image](https://user-images.githubusercontent.com/108690286/222031746-2b6f0e84-3eed-4323-a1db-1ba8f9018326.png)

The following set of polynomials are used to generate the trajectory between the time interval from 0 to tf.

![image](https://user-images.githubusercontent.com/108690286/222031818-3b75f98e-d194-4838-a0df-38b24db39988.png)

The above set of equations are implemented to generate the values of q(t) for each of the 4 segments of the trajectory. 

The most important aspect of this part of the project is to generate a trajectory, such that the manipulator does not make sharp turns in its motion. This has been done by taking an anticipation time of 0.2 seconds into consideration. The basic idea is to start the trajectory of the next segment, 0.2 seconds before the completion of the manipulator’s ongoing trajectory. This allows the manipulator to transition smoothly into the next segment at the waypoints.

The next step is to calculate the arc length of each segment. This is done by calculating the norm of the two consecutive points in intervals of 0.001 seconds and appending them together in an array.  The full trajectory is then obtained by calculating pe according to the formula shown below.

![image](https://user-images.githubusercontent.com/108690286/222031969-b076b530-733e-4d90-b6f8-1c5030bf7bf3.png)

Here, sj is the arc length of the jth segment. A plot of the full trajectory after considering the anticipation time is shown here in 3D space.

![image](https://user-images.githubusercontent.com/108690286/222032005-ed276e7e-162a-4609-8bbd-0a051a20288b.png)

A plot of velocity and acceleration have also been shown here (2-dimensional). The velocity values have been obtained by differentiating the position with respect to time and the acceleration values have been obtained by differentiating the velocity of the manipulator with respect to time. These values are provided as an input to the second order algorithm as the desired position, velocity and acceleration for the manipulator.

Velocity Plot-
![image](https://user-images.githubusercontent.com/108690286/222032168-c8919c8d-f88b-497c-a493-f2b86e9f04a5.png)

Acceleration Plot-
![image](https://user-images.githubusercontent.com/108690286/222032332-c4f0390c-1ecd-496d-99d5-c80c54a1c726.png)

These values are provided as an input to the second order algorithm as the desired position, velocity and acceleration for the manipulator.

#### PART 2

The dynamic model provides a relationship between the joint actuator torques and the motion of the manipulator. The following algorithm for calculating the joint space inverse dynamics control has been implemented-
![image](https://user-images.githubusercontent.com/108690286/222032614-a856ef2d-e8cc-4f2b-aa61-c9187d5c50c2.png)

The B(q) block in the above block diagram is the inertia matrix. It is calculated by using the formula as shown below- 
![image](https://user-images.githubusercontent.com/108690286/222032670-913f6b98-fef4-465e-8dbc-8d47c82e52c3.png)

B(q) accounts for the mass of each link, mass of each motor, moment of inertia as well as the Jacobians for each link and motor of the SCARA manipulator. The contribution of the jacobian columns to the joint velocities are considered up to the link i as shown below.
![image](https://user-images.githubusercontent.com/108690286/222032724-59e67a51-f3e7-43e1-b8b1-babfe4306381.png)

The formula to calculate the column vectors of the Jacobian matrix (for each link) is given by-
![image](https://user-images.githubusercontent.com/108690286/222032795-55dbd410-4b7e-4cc9-9003-294107ae2baa.png)

Similarly, the column vectors of the Jacobian matrix for each motor is given by-
![image](https://user-images.githubusercontent.com/108690286/222032840-2ceff180-2da0-4882-9d55-98a0847ead82.png)
![image](https://user-images.githubusercontent.com/108690286/222032867-c848b3d9-8bab-414a-a2bc-3e1e032004ae.png)

The output of this B(q) block is the inertia matrix which is added to n(q,qdot) which accounts for the forces acting on the manipulator. These forces include forces such as viscous friction and static friction. 

The n(q,qdot) block calculates the sum of the following equation-
![image](https://user-images.githubusercontent.com/108690286/222033201-21aaba3f-3d52-4f71-9300-d6cd2a3469e6.png)

Here, C is a matrix that represents the centrifugal and Coriolis forces acted by the link upon the joint when the manipulator is in motion. The formula used for calculating the C matrix is as follows-
![image](https://user-images.githubusercontent.com/108690286/222033262-88eb4c9e-9045-4628-b6e3-a7b67c7780b2.png)
![image](https://user-images.githubusercontent.com/108690286/222033287-b0788d91-9f0a-4613-91f9-38ea5a794e55.png)
![image](https://user-images.githubusercontent.com/108690286/222033322-0d6c167b-7adf-4351-8351-4b4ed05c3715.png)

F is the diagonal matrix which accounts for the viscous friction forces and g is calculated according to the following formula-
![image](https://user-images.githubusercontent.com/108690286/222033374-ead7946b-0abe-4394-a53d-29fa73a7c59a.png)

Lastly, the manipulator block is supposed to represent the actual SCARA manipulator. The addition of the B(q) and n(q,qdot) provides the joint torques as well as accounts for other external forces  for the manipulator to be able to perform its operations.

The plots for the errors in position, velocity and joint values of the manipulator have been shown below-
![image](https://user-images.githubusercontent.com/108690286/222033413-f32ec975-e071-4a77-b315-bd10552ee914.png)
![image](https://user-images.githubusercontent.com/108690286/222033438-18c6d355-221b-4416-a946-10b0b1bd324f.png)
![image](https://user-images.githubusercontent.com/108690286/222033458-32cb72bc-55ca-447e-a300-70676d97c3d0.png)











