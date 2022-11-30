# SCARA Manipulator Trajectory Planning

### OBJECTIVE
Part 1- To implement a second order algorithm for kinematic inversion with Jacobian inverse along a given trajectory using MATLAB and Simulink.

Part 2- To implement a second order algorithm for kinematic inversion with Jacobian Pseudo inverse along a given trajectory, for a redundant SCARA manipulator, using MATLAB and Simulink.

### METHODOLOGY
The position and orientation of the end-effector is calculated by computing the direct kinemaics of the SCARA manipulator.

Next, the jacobian matrix is calculated as it maps the relationship between the joint velocities and the corrosponding end effector linear and angular velocities.
The jacobian matrix is then differentiated with repect to time. 

The end goal is to generate a feedback loop which can minimize the error between the desired and calculated position and velocity of the end effector so that the SCARA manipulator follows the desired trajectory. This can be done by implementing the following-

![image](https://user-images.githubusercontent.com/108690286/204675951-9e189878-eb9e-4a1b-9a44-2bd137132c9d.png)
![image](https://user-images.githubusercontent.com/108690286/204676295-fc67e51b-5264-42be-a4b1-56d163ef7dc7.png)

The error between the desired values and the computed values of the for the position and orientation of the end effector is almost 0. This has been proved by the error graph of the computed values for the position/orientation and the desired values against time.

![image](https://user-images.githubusercontent.com/108690286/204674664-a00a57ac-3708-41de-8ef1-bcf1d594c0f9.png)

For the second part of this project, the z-component of the SCARA manipulator has been relaxed thereby making it redundant. We can therefore utilize the redundancy to carry out other tasks like obstacle avoidance. As the maniulator is redundant, the jacobian inverse cannot be calculated. We calculate the jacobian pseudo inverse and everything else remains the same. The formula for Jacobian pseudo inverse is-
![image](https://user-images.githubusercontent.com/108690286/204677197-77fd69e4-c674-4390-a7bc-c4d188200642.png)

