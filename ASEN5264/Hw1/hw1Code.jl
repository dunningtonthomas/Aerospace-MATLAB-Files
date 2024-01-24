import DMUStudent.HW1

#------------- 
# Problem 3
#-------------

# See https://github.com/zsunberg/CU-DMU-Materials/blob/master/notebooks/030-Stochastic-Processes.ipynb for code that simulates a stochastic process.

#------------- 
# Problem 4
#-------------

# Here is a functional but incorrect answer for the programming question
function f(a, bs)
    # Vector to store the maximum values
    finalVec = [];

    # Iterate over the vector
    for tempVec in bs
        # Multiply
        mul = a * tempVec;

        # Determine if it is bigger
        if isempty(finalVec)    # First multiplication
            finalVec = mul;
        end

        # Sort
        i = 1;
        for (currMax, newMul) in zip(finalVec, mul)

            if newMul > currMax # Update the final vector if the current ith element is larger
                finalVec[i] = newMul;
            end
            i = i + 1;  # Update the iterator
        end
    end

    return oftype(bs[1], finalVec);
end



# You can can test it yourself with inputs like this
#a = [1.0 2.0; 3.0 4.0];
# @show a
#bs = [[1.0, 2.0], [5.0, 6.0], [3.0, 4.0]];
# test = f(a, bs);
# @show bs
#@show typeof(f(a, bs))

# This is how you create the json file to submit
#HW1.evaluate(f, "thomas.dunnington@colorado.edu");


