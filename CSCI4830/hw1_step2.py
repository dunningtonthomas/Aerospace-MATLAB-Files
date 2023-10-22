## Author: Thomas Dunnington
## Date: 10/22/2023


# numpy provides import array and linear algebra utilities
import numpy as np

# the robotics toolbox provides robotics specific functionality
import roboticstoolbox as rtb

# spatial math provides objects for representing transformations
import spatialmath as sm

# Use sys to read command line arguments
import sys



# %% DH_Link for the Panda

class DH_Link:
    # Variable for transformation matrix for a given link
    transMat = []
    
    # Function to calculate the DH transformation matrix
    def denavMatrix(self, d, theta, a, alpha):    
        # Directly use the result of the transformations in one matrix for the MODIFIED DH parameters
        DH_mat = [[np.cos(theta), -1*np.sin(theta), 0, a],
                  [np.sin(theta) * np.cos(alpha), np.cos(alpha)*np.cos(theta), -1*np.sin(alpha), -1*np.sin(alpha) * d],
                  [np.sin(theta) * np.sin(alpha), np.cos(theta) * np.sin(alpha), np.cos(alpha), np.cos(alpha) * d],
                  [0, 0, 0, 1]]
        
        # Can also use the method shown below using the elementary transforms to get the total matrix
        
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
        
        return DH_mat



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

# Instantiate the classes for each link
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

# Matrix multiplication for the final transformation matrix from the base to end effector
A02 = np.matmul(link1.transMat, link2.transMat)
A03 = np.matmul(A02, link3.transMat)
A04 = np.matmul(A03, link4.transMat)
A05 = np.matmul(A04, link5.transMat)
A06 = np.matmul(A05, link6.transMat)
A07 = np.matmul(A06, link7.transMat)

#Output
print(A07)

















