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
    Amats_ee = [A01, A02, A03, A04, A05, A06, A07]
    
    # Compute each z axis
    zList = []
    Z0 = np.array([0.0, 0.0, 1.0])
    for i in range(n):
        currTMat = Amats_ee[i]
        zList.append(np.matmul(currTMat[0:3,0:3], Z0))
        
    # Get P from 0 to ee
    P0_ee = A07[0:3, 3] 
    
    # Loop through each link
    for i in range(n):
        # Get the new A matrix
        currTMat = Amats_ee[i]
        
        # P0 to current joint
        P0_curr = currTMat[0:3, 3]
        
        # P from current joint to the end effetor
        currP = P0_ee - P0_curr        
        
        # Get the current z-axis and compute the cross product
        currZ = zList[i]
        currCross = np.cross(currZ, currP)
        
        # Store in the geoJac
        geoJac[0:3, i] = currCross
        geoJac[3:6, i] = currZ
        
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


# Function for forward kinematics
def forwardDH(q):
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
    
    return A07


# Function to calculate the new pose of the end effector given a time step and configuration


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
qAll = np.array(qArr)

# Hard code the values of q if there is not command line argument
#Check if q is the right size
if qAll.size != 15:
    print("Not Enough Input Arguments, q = ones, dq = 0.1, dt = 1\n\n")
    qAll = np.array([1, 1, 1, 1, 1, 1, 1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 0.1, 1]) #If not, assign values to q

# Split into q and dq
q = qAll[0:7]
dq = qAll[7:14]
dt = qAll[14]


# Compute the jacobian
geoJac = compute_geoJacobian(q)

# Split the time into small enough intervals for infinitesimal changes
tStep = 0.001

# Calculate the number of iterations
numIterations = dt / tStep

# Initial Configuration
init_ee = forwardDH(q)
currPose = init_ee
qInit = q

# Iterate through each time step
for i in range(int(numIterations)):
    
    # Get the initial end effector configuration
    Ri = currPose[0:3, 0:3]
    P0_ee = currPose[0:3, 3] 
    
    
    # Compute the jacobian based on the current configuration
    geoJac = compute_geoJacobian(q)
    
    # Apply the jacobian
    delX = np.matmul(geoJac, dq)
    
    # Get the angular and linear velocities
    dv = delX[0:3]
    dOmega = delX[3:6]
    
    # Get the change in angles for the orientation
    delAngles = dOmega * tStep
    
    # Get the change in position 
    delPos = dv * tStep
    
    # Create the infintesimal change in angles matrix
    RdAngle = np.array([[1, -delAngles[2], delAngles[1]], 
                        [delAngles[2], 1, -delAngles[0]],
                        [-delAngles[1], delAngles[0], 1]])
    
    # Calculate the new rotation matrix
    Rnew = np.matmul(RdAngle, Ri)
    
    # Calculat the new position
    Pnew = P0_ee + delPos
    
    # Get the new pose
    currPose[0:3, 0:3] = Rnew
    currPose[0:3, 3] = Pnew
    
    # Update the values of q for the next iteration
    q = q + dq * tStep
    


# Final configuration is the final iteration of currPose
finalPose = currPose

# Compare to the forward kinematics result
qFinal = qInit + dq * dt

# Forward kinematics with final joint configuration
finalPose_Check = forwardDH(qFinal)

# Output the result
print(finalPose)












