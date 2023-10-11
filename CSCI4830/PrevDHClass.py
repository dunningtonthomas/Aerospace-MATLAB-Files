## Author: Thomas Dunnington
## Date: 10/9/2023


# numpy provides import array and linear algebra utilities
import numpy as np

# the robotics toolbox provides robotics specific functionality
import roboticstoolbox as rtb

# spatial math provides objects for representing transformations
import spatialmath as sm

# Use sys to read command line arguments
import sys



# %% DH Panda Class

class DH:
    def denavMatrix(self, d, theta, a, alpha):
        DH_mat = [[np.cos(theta), -1*np.cos(alpha) * np.sin(theta), np.sin(alpha)*np.sin(theta), a*np.cos(theta)],
                  [np.sin(theta), np.cos(alpha)*np.cos(theta), -1*np.sin(alpha)*np.cos(theta), a*np.sin(theta)],
                  [0, np.sin(alpha), np.cos(alpha), d],
                  [0, 0, 0, 1]]
        
        
        DH_mat = [[np.cos(theta), -1*np.sin(alpha), 0, a],
                  [np.sin(theta) * np.cos(alpha), np.cos(alpha)*np.cos(theta), -1*np.sin(alpha), -1*np.sin(theta) * d],
                  [np.sin(theta) * np.sin(alpha), np.cos(theta) * np.sin(alpha), np.cos(alpha), np.cos(alpha) * d],
                  [0, 0, 0, 1]]
        return DH_mat
    
    def eval_dh(self, q):
        # q is a vector of the joint angles
        T01 = self.denavMatrix(0.333, q[0], 0, 0)
        T12 = self.denavMatrix(0, q[1], 0, -1*np.pi/2)
        T23 = self.denavMatrix(0.316, q[2], 0, np.pi/2)
        T34 = self.denavMatrix(0, q[3], 0.0825, np.pi/2)
        T45 = self.denavMatrix(0.384, q[4], -0.0825, -1*np.pi/2)
        T56 = self.denavMatrix(0, q[5], 0, np.pi/2)
        T67 = self.denavMatrix(0.107, q[6], 0.088, np.pi/2)
        
        # Matrix multiplication
        T02 = np.matmul(T01, T12)
        T03 = np.matmul(T02, T23)
        T04 = np.matmul(T03, T34)
        T05 = np.matmul(T04, T45)
        T06 = np.matmul(T05, T56)
        T07 = np.matmul(T06, T67)
        
        return T07
        
        
class DH2:
    def eval_dh(self, q):        
        #Order goes tx -> rx -> tz -> rz
        
        # d = 0.333, theta = q1
        E1 = rtb.ET.tz(0.333)
        E2 = rtb.ET.Rz()
        
        # alpha = -90, theta = q2
        E3 = rtb.ET.Rx(-1*np.pi/2)
        E4 = rtb.ET.Rz()

        # alpha = 90, d = 0.316, theta = q3
        E5 = rtb.ET.Rx(np.pi/2)
        E6 = rtb.ET.tz(0.316)
        E7 = rtb.ET.Rz()
        
        # a = 0.0825, alpha = 90, theta = q4
        E8 = rtb.ET.tx(0.0825)
        E9 = rtb.ET.Rx(np.pi/2)
        E10 = rtb.ET.Rz()
        
        # a = -0.0825, alpha = -90, d = 0.384, theta = q5
        E11 = rtb.ET.tx(-0.0825)
        E12 = rtb.ET.Rx(-1*np.pi/2)
        E13 = rtb.ET.tz(0.384)
        E14 = rtb.ET.Rz()
        
        # alpha = 90, theta = q6
        E15 = rtb.ET.Rx(np.pi/2)
        E16 = rtb.ET.Rz()
        
        # a = 0.088, alpha = 90, d = 0.107, theta = q7
        E17 = rtb.ET.tx(0.088)
        E18 = rtb.ET.Rx(np.pi/2)
        E19 = rtb.ET.tz(0.107)
        E20 = rtb.ET.Rz()
        
        
        

        
        # Combine the elementary transforms
        T07 = E1 * E2 * E3 * E4 * E5 * E6 * E7 * E8 * E9 * E10 * E11 * E12 * E13 * E14 * E15 * E16 * E17 * E18 * E19 * E20
        
        # Evaluate using the q array and return the value
        return T07.eval(q)    



# %% Main Code

# Read the command line
output5 = sys.argv

# Parse command line
qArr = []
first = True
for i in output5:
    if first:
        first = False
        continue
    qArr.append(float(i))

# Convert to numpy array
q = np.array(qArr)

q = np.array([0, -0.3, 0, -2.2, 0, 2, 0.79])

# Franka Emika Panda Example

# Note for for E7 and E11 in the figure above and code below, we use flip=True
# as the variable rotation is in the negative direction.

E1 = rtb.ET.tz(0.333)
E2 = rtb.ET.Rz()
E3 = rtb.ET.Ry()
E4 = rtb.ET.tz(0.316)
E5 = rtb.ET.Rz()
E6 = rtb.ET.tx(0.0825)
E7 = rtb.ET.Ry(flip=True)
E8 = rtb.ET.tx(-0.0825)
E9 = rtb.ET.tz(0.384)
E10 = rtb.ET.Rz()
E11 = rtb.ET.Ry(flip=True)
E12 = rtb.ET.tx(0.088)
E13 = rtb.ET.Rx(np.pi)
E14 = rtb.ET.tz(0.107)
E15 = rtb.ET.Rz()


# Create ETS of the robot
pandaETS = E1 * E2 * E3 * E4 * E5 * E6 * E7 * E8 * E9 * E10 * E11 * E12 * E13 * E14 * E15

# Evaluate and print the results
output = pandaETS.eval(q)
print(output)


# DH 1
# panda = DH()
# finalOut = panda.eval_dh(q)
# print(finalOut)

# DH 2
panda2 = DH2()
finalOut2 = panda2.eval_dh(q)
print(finalOut2)











