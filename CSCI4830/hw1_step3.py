
# numpy provides import array and linear algebra utilities
import numpy as np

import roboticstoolbox as rtb

# Use sys to read command line arguments
import sys


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


# Visualize the result
pandaCheck = rtb.models.DH.Panda()
pandaCheck.plot(q, block=True)

