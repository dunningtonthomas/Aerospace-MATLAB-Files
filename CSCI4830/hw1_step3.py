
# numpy provides import array and linear algebra utilities
import numpy as np

import roboticstoolbox as rtb

# Use sys to read command line arguments
import sys

# %% Class Def
class DH:
    def eval_dh(self, q):        
        #Order goes tx -> rx -> tz -> rz
        # This function applies the DH parameters we formulated for the panda and evaluates with q
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
outputLine = sys.argv

# Parse command line
qArr = []
first = True
for i in outputLine:
    if first:
        first = False
        continue
    qArr.append(float(i))

# Convert to numpy array
q = np.array(qArr)

#Check if q is the right size
if q.size != 7:
    q = np.array([0, -0.3, 0, -2.2, 0, 2, 0.79]) #If not, assign values to q

# Visualize the result
pandaCheck = rtb.models.DH.Panda()
pandaCheck.plot(q, block=True)






