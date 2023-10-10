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

# CHeck
pandaCheck = rtb.models.DH.Panda()

# %% DH Panda Class




# %% Functions 
# This function returns the DH matrix given the four parameters
def DH_Matrix(d, theta, a, alpha):
    DH_mat = [[np.cos(theta), -1*np.cos(alpha) * np.sin(theta), np.sin(alpha)*np.sin(theta), a*np.cos(theta)],
              [np.sin(theta), np.cos(alpha)*np.cos(theta), -1*np.sin(alpha)*np.cos(theta), a*np.sin(theta)],
              [0, np.sin(alpha), np.cos(alpha), d],
              [0, 0, 0, 1]]
    
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
panda = E1 * E2 * E3 * E4 * E5 * E6 * E7 * E8 * E9 * E10 * E11 * E12 * E13 * E14 * E15

# Evaluate and print the results
output = panda.eval(q)
print(output)



# DH Formulation
T12 = DH_Matrix(0.333, q[0], 0, 0)









