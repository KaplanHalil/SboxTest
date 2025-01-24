import AES_256 as cipher
from sage.crypto.sbox import SBox

sbox_hex=cipher.SBOX

# Convert to decimal
SBOX_DEC = [int(x) for x in sbox_hex]

# Create the S-box in SageMath
S = SBox(SBOX_DEC)

print("Max value in LAT:",S.linear_branch_number())

print("Fixed points of S:",S.fixed_points())

print("S is linear: ",S.has_linear_structure())

print("S is balanced: ",S.is_balanced())

print("S is APN: ",S.is_almost_bent())

print("S is bent: ",S.is_bent())

print("S is has an inverse: ",S.is_involution())

print("S is plateaued: ",S.is_plateaued())

print("Maximal algebraic degree of all its component functions",S.max_degree() )

print("Minimal algebraic degree of all its component functions",S.min_degree() )

print("##### Autocorrelation table #####")

#print(S.autocorrelation_table())


print("##### Boomerang connectivity table #####")

#print(S.boomerang_connectivity_table())

print("Max value in BCT:",S.boomerang_uniformity())

print("##### DDT #####")

#print(S.difference_distribution_table())

print("Max value in DDT:",S.maximal_difference_probability_absolute())

print("Branch number of S:",S.differential_branch_number())

print("##### LAT #####")

#print(S.linear_approximation_table())



#print("List of polynomials satisfying this S-box",S.polynomials())