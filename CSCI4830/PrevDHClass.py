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

class DH_Link:
    #Variable for transformation matrix for a given link
    transMat = []
    def denavMatrix(self, d, theta, a, alpha):       
        #Define the transformations involved
        # rotX = [[1, 0, 0, 0],
        #         [0, np.cos(alpha), -1*np.sin(alpha), 0],
        #         [0, np.sin(alpha), np.cos(alpha), 0],
        #         [0, 0, 0, 1]]
        
        # transX = [[1, 0, 0, a], 
        #           [0, 1, 0, 0],
        #           [0, 0, 1, 0],
        #           [0, 0, 0, 1]]
        
        # rotZ = [[np.cos(theta), -1*np.sin(theta), 0, 0],
        #         [np.sin(theta), np.cos(theta), 0, 0],
        #         [0, 0, 1, 0],
        #         [0, 0, 0, 1]]
        
        # transZ = [[1, 0, 0, 0], 
        #           [0, 1, 0, 0],
        #           [0, 0, 1, d],
        #           [0, 0, 0, 1]]
        
        # #Calculate the transformation matrix
        # xMat = np.matmul(rotX, transX)
        # zMat = np.matmul(rotZ, transZ)
        # DH_mat = np.matmul(xMat, zMat)
        
        # Directly use the result of the transformations in one 
        # Can also use the method shown above using the elementary transforms
        DH_mat = [[np.cos(theta), -1*np.sin(theta), 0, a],
                  [np.sin(theta) * np.cos(alpha), np.cos(alpha)*np.cos(theta), -1*np.sin(alpha), -1*np.sin(alpha) * d],
                  [np.sin(theta) * np.sin(alpha), np.cos(theta) * np.sin(alpha), np.cos(alpha), np.cos(alpha) * d],
                  [0, 0, 0, 1]]
        
        return DH_mat
        
    
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

q = np.array([1, 1, 1, -1, 1, 1, 1])

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


# Instantiate the classes
link1 = DH_Link()
link2 = DH_Link()
link3 = DH_Link()
link4 = DH_Link()
link5 = DH_Link()
link6 = DH_Link()
link7 = DH_Link()

#Create the transformation matrices using the modified DH parameters
link1.transMat = link1.denavMatrix(0.333, q[0], 0, 0)
link2.transMat = link2.denavMatrix(0, q[1], 0, -1*np.pi/2)
link3.transMat = link3.denavMatrix(0.316, q[2], 0, np.pi/2)
link4.transMat = link4.denavMatrix(0, q[3], 0.0825, np.pi/2)
link5.transMat = link5.denavMatrix(0.384, q[4], -0.0825, -1*np.pi/2)
link6.transMat = link6.denavMatrix(0, q[5], 0, np.pi/2)
link7.transMat = link7.denavMatrix(0.107, q[6], 0.088, np.pi/2)

# Matrix multiplication
T02 = np.matmul(link1.transMat, link2.transMat)
T03 = np.matmul(T02, link3.transMat)
T04 = np.matmul(T03, link4.transMat)
T05 = np.matmul(T04, link5.transMat)
T06 = np.matmul(T05, link6.transMat)
T07 = np.matmul(T06, link7.transMat)

#Output
print(T07)

















