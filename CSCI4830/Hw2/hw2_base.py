import roboticstoolbox as rtb
import sys
import numpy as np

n_joints=7
q = np.zeros((n_joints))
for i in range(n_joints):
    q[i] = float(sys.argv[i + 1])

panda_rtb = rtb.models.DH.Panda()
print(panda_rtb)
print(panda_rtb.q)

# panda_rtb.plot(q, block=True)

print(panda_rtb.jacob0(q))
panda_rtb.jacob0([0, 0, 0, 0, 0, 0, 0])
