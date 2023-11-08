# Author: Thomas Dunnington
# Date: 11/8/2023


# Import Libraries
import roboticstoolbox as rtb
import sys
import numpy as np


# %% Functions
# Function to compute the geometric jacobian for the given configuration
def compute_geoJacobian(q):
    # Instantiate empty np array for geometric jacobian
    n = q.size
    geoJac = np.zeros([6, n])
    
    # Get the transformation matrices for each link
    A01 = denavMatrix(0.333, q[0], 0, 0)
    A12 = denavMatrix(0, q[1], 0, -1*np.pi/2)
    A23 = denavMatrix(0.316, q[2], 0, np.pi/2)
    A34 = denavMatrix(0, q[3], 0.0825, np.pi/2)
    A45 = denavMatrix(0.384, q[4], -0.0825, -1*np.pi/2)
    A56 = denavMatrix(0, q[5], 0, np.pi/2)
    A67 = denavMatrix(0.107, q[6], 0.088, np.pi/2)
    
    # Matrix multiplication for the final transformation matrix from the base to end effector
    A02 = np.matmul(A01, A12)
    A03 = np.matmul(A02, A23)
    A04 = np.matmul(A03, A34)
    A05 = np.matmul(A04, A45)
    A06 = np.matmul(A05, A56)
    A07 = np.matmul(A06, A67)
    
    # Instantiate a list of the matrices
    Amats = [A01, A12, A23, A34, A45, A56, A67]
    Amats_ee = [A01, A02, A03, A04, A05, A06, A07]
    
    # Loop through each link
    for i in range(n):
        # First joint
        if i == 0:
            currZ = np.array([0.0, 0.0, 1.0]) # First z-axis
            currP = A07[0:3, 3]
            cross = np.cross(currZ, currP)
            pass
            
        pass
    
    
    # Return the jacobian
    return geoJac


# Function to return the DH matrix given DH parameters
def denavMatrix(d, theta, a, alpha):    
    # Directly use the result of the transformations in one matrix for the MODIFIED DH parameters
    DH_mat = [[np.cos(theta), -1*np.sin(theta), 0, a],
              [np.sin(theta) * np.cos(alpha), np.cos(alpha)*np.cos(theta), -1*np.sin(alpha), -1*np.sin(alpha) * d],
              [np.sin(theta) * np.sin(alpha), np.cos(theta) * np.sin(alpha), np.cos(alpha), np.cos(alpha) * d],
              [0, 0, 0, 1]]
    
    return np.array(DH_mat)

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

# Hard code the values of q if there is not command line argument
#Check if q is the right size
if q.size != 7:
    q = np.array([0, -0.3, 0, -1.2, 0, 1.5, 0.79]) #If not, assign values to q
    
    
# Compute the REAL Jacobian
panda_rtb = rtb.models.DH.Panda()
# print(panda_rtb)
# print(panda_rtb.q)

# Print the REAL Jacobian
# panda_rtb.plot(q, block=True)
# panda_rtb.jacob0([0, 0, 0, 0, 0, 0, 0])
print(panda_rtb.jacob0(q))

# Compute the jacobian
geoJac = compute_geoJacobian(q)
print(geoJac)

A01 = denavMatrix(0.333, q[0], 0, 0)






