import AES_256 as cipher
from sage.crypto.sbox import SBox
from PIL import Image

sbox_hex = cipher.SBOX

# Convert to decimal
SBOX_DEC = [int(x) for x in sbox_hex]

S = SBox(SBOX_DEC)


# Check if the S-box is 1-1 (bijective)
def is_one_to_one(sbox):
    # Create a set of unique outputs
    unique_outputs = set(sbox)
    return len(unique_outputs) == len(sbox)

print("S is 1-1:", is_one_to_one(SBOX_DEC))  
# Purpose: Verify that every input maps to a unique output.
# Significance: A bijective S-box is necessary for ensuring reversibility in block cipher operations.
# Expected: True for cryptographically secure S-boxes.

# 1. Check if the S-box has a linear structure (weakness if True)
print("S is linear: ", S.has_linear_structure())  
# Purpose: Verify if the S-box is linear. 
# Significance: Linear S-boxes are insecure as they can be expressed as a linear function. 
# Expected: False.

# 2. Check if the S-box is balanced
print("S is balanced: ", S.is_balanced())  
# Purpose: Check if each output value occurs equally often.
# Significance: Balanced S-boxes ensure uniform output distribution, essential for security.
# Expected: True.

# 3. Find fixed points of the S-box (S(x) = x)
print("Fixed points of S:", S.fixed_points())  
# Purpose: Identify inputs that map to themselves.
# Significance: Fixed points can lead to cryptographic weaknesses.
# Expected: Few or no fixed points.

# 4. Check if the S-box is Almost Perfect Nonlinear (APN)
print("S is APN: ", S.is_almost_bent())  
# Purpose: Verify resistance to differential cryptanalysis.
# Significance: APN S-boxes are optimal for this purpose.
# Expected: True for optimal S-boxes. Rarely happen in block ciphers.

# 5. Check if the S-box is bent
print("S is bent: ", S.is_bent())  
# Purpose: Verify if the S-box has maximal non-linearity.
# Significance: Bent S-boxes resist linear cryptanalysis exceptionally well.
# Expected: False (most block cipher S-boxes are not strictly bent).

print("S is almost bent: ", S.is_almost_bent())

# 6. Check if the S-box is an involution (S(S(x)) = x)
print("S has an inverse: ", S.is_involution())  
# Purpose: Verify if encryption and decryption use the same S-box.
# Significance: Involutory S-boxes simplify implementation.
# Expected: Depends on the S-box design.

# 7. Check if the S-box is plateaued
print("S is plateaued: ", S.is_plateaued())  
# Purpose: Check if the Walsh spectrum takes on few distinct values.
# Significance: Plateaued S-boxes may have desirable cryptographic properties.
# Expected: True for some S-boxes.


print("Nonlinearity of S:", S.nonlinearity())

# 8. Maximal algebraic degree of the S-box
print("Maximal algebraic degree of all its component functions:", S.max_degree())  
# Purpose: Evaluate the highest degree of the S-box's Boolean functions.
# Significance: High degree ensures non-linearity and resistance to attacks.
# Expected: Close to n-1 for an n-bit S-box.

# 9. Minimal algebraic degree of the S-box
print("Minimal algebraic degree of all its component functions:", S.min_degree())  
# Purpose: Find the lowest algebraic degree among the component functions.
# Significance: Low degree might indicate weaknesses.
# Expected: Reasonably high value.

# 10. Maximal value in the Difference Distribution Table (DDT)
print("Max value in DDT:", S.differential_uniformity())  
# Purpose: Evaluate resistance to differential cryptanalysis.
# Significance: Lower values indicate stronger resistance.
# Expected: Small value (ideal is 2^(n-2)).

# 11. Maximal value in the Linear Approximation Table (LAT)
print("Max value in LAT:", S.linear_branch_number())  
# Purpose: Measure resistance to linear cryptanalysis.
# Significance: High branch numbers ensure better diffusion.
# Expected: High value.

# 12. Maximal value in the Boomerang Connectivity Table (BCT)
print("Max value in BCT:", S.boomerang_uniformity())  
# Purpose: Evaluate resistance to boomerang attacks.
# Significance: Lower values are better.
# Expected: Small value.

# 13. Branch number of the S-box
print("Branch number of S:", S.differential_branch_number())  
# Purpose: Evaluate the minimum number of active S-boxes in differential propagation.
# Significance: High branch number ensures good diffusion.
# Expected: High value.

# Helper function to display tables with detailed formatting
def pretty_table(matrix, label, max_size=16):
    nrows, ncols = matrix.nrows(), matrix.ncols()
    print(f"\n##### {label} #####")
    
    # Print column headers
    header = ["{:>5}".format(i) for i in range(min(max_size, ncols))]
    print("     " + " ".join(header) + (" ..." if ncols > max_size else ""))
    print("    " + "-" * (min(max_size, ncols) * 6 + (3 if ncols > max_size else 0)))
    
    # Print rows with indices
    for row_index in range(min(max_size, nrows)):
        row = matrix.row(row_index)
        formatted_row = " ".join(
            "{:>5}".format(int(x)) if x in ZZ else "{:>5.2f}".format(float(x)) for x in row[:max_size]
        )
        print(f"{row_index:>3} | {formatted_row}" + (" ..." if ncols > max_size else ""))
    
    # Indicate if rows are truncated
    if nrows > max_size:
        print("...")


# Display formatted tables
pretty_table(S.difference_distribution_table(), "Difference Distribution Table (DDT)")
pretty_table(S.linear_approximation_table(), "Linear Approximation Table (LAT)")
pretty_table(S.boomerang_connectivity_table(), "Boomerang Connectivity Table (BCT)")
pretty_table(S.autocorrelation_table(), "Autocorrelation Table (ACT)")
