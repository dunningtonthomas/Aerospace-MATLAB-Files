## Author: Thomas Dunnington
## Date Modified: 10/4/2023

# We will do the imports required for this notebook here

# numpy provides import array and linear algebra utilities
import numpy as np

# the robotics toolbox provides robotics specific functionality
import roboticstoolbox as rtb

# spatial math provides objects for representing transformations
import spatialmath as sm


# This is a variable rotation around the x-axis
rx_var = rtb.ET.Rx()

# This is a constant rotation around the x-axis by 90 degrees
rx_cons = rtb.ET.Rx(np.pi / 2)


# By printing each of the ET's we made, we can view them in a more readable format
print(rx_var)
print(rx_cons)


# We can calculate the transform resulting from the rx_cons ET using the .A method
transform = rx_cons.A()

# The .A method returns a numpy array
# Using the spatialmath package, we can create an SE3 object from the array
sm_transform = sm.SE3(transform)

# The spatialmath package provides great utility for working with transforms 
# and will print SE3s in a more intuitive way a plain numpy array

print(f"Numpy array SE3: \n{transform}")
print()
print(f"Spatialmath SE3: \n{sm_transform}")


# To calculate the transform resulting from the rx_var ET, 
# we must supply a joint coordinate when using the .A method

# Make the joint at 45 degrees
q = np.pi / 4
transform = rx_var.A(q)
sm_transform = sm.SE3(transform)
print(f"Resulting SE3 at 45 degrees: \n{sm_transform}")


# We can also create prismatic joints
# This is a variable translation around the y-axis
ty_var = rtb.ET.ty()

# This is a constant translation along the y-axis by 25 cm
ty_cons = rtb.ET.ty(0.25)

# View the ETs
print(ty_var)
print(ty_cons)


# We can calculate the transform resulting from the ty_cons ET using the .A method
transform = ty_cons.A()

# Create an SE3 object from the array
sm_transform = sm.SE3(transform)

print(f"SE3: \n{sm_transform}")


# To calculate the transform resulting from the ty_var ET, 
# we must supply a joint coordinate when using the .A method

# Make the joint at 15 cm
q = 0.15
transform = ty_var.A(q)
sm_transform = sm.SE3(transform)
print(f"Resulting SE3 at 15 cm: \n{sm_transform}")





#%%  Franka Emika Panda Example

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

# We can create and ETS in a number of ways

# Firstly if we use the * operator between two or more ETs, we get an ETS
ets1 = E1 * E2 * E3

# Secondly, we can use the ETS constructor and pass in a list of ETs
ets2 = rtb.ETS([E1, E2, E3])

# We can also use the * operator between ETS' and ETs to concatenate
ets3 = ets2 * E4
ets4 = ets2 * rtb.ETS([E4, E5])

print(ets1)
print(ets2)
print(ets3)
print(ets4)





# We can make an ETS representing a Panda by incorprating all 15 ETs into an ETS
panda = E1 * E2 * E3 * E4 * E5 * E6 * E7 * E8 * E9 * E10 * E11 * E12 * E13 * E14 * E15

# View the ETS
print(panda)
print()

# The ETS class has many usefull properties
# print the number of joints in the panda model
print(f"The panda has {panda.n} joints")

# print the number of ETs in the panda model
print(f"The panda has {panda.m} ETs")

# We can access an ET from an ETS as if the ETS were a Python list
print(f"The second ET in the ETS is {panda[1]}")

# When a variable ET is added to an ETS, it is assigned a jindex, which is short for joint index
# When given an array of joint coordinates (i.e. joint angles), the ETS will use the jindices of each
# variable ET to correspond with elements of the given joint coordiante array
print(f"The first variable joint has a jindex of {panda[1].jindex}, while the second has a jindex of {panda[2].jindex}")

# We can extract all of the variable ETs from the panda model as a list
print(f"\nAll variable liks in the Panda ETS: \n{panda.joints()}")




# Using the above methodolgy, we can calculate the forward kinematics of our Panda model
# First, we must define the joint coordinates q, to calculate the forward kinematics at
q = np.array([0, -0.3, 0, -2.2, 0, 2, 0.79])

# Allocate the resulting forward kinematics array
fk = np.eye(4)

# Now we must loop over the ETs in the Panda
for et in panda:
    if et.isjoint:
        # This ET is a variable joint
        # Use the q array to specify the joint angle for the variable ET
        fk = fk @ et.A(q[et.jindex])
    else:
        # This ET is static
        fk = fk @ et.A()

# Pretty print our resulting forward kinematics using an SE3 object
print(sm.SE3(fk))



# The ETS class has the .fkine method which can calculate the forward kinematics
# The .fkine methods returns an SE3 object
print(f"The fkine method: \n{panda.fkine(q)}")

# The .eval method also calculates the forward kinematics but returns an numpy array
# instead of an SE3 object (use this if speed is a priority)
print(f"The eval method: \n{panda.eval(q)}")










