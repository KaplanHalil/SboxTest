import AES_256 as cipher
from sage.crypto.sbox import SBox

sbox_hex=cipher.SBOX

# Convert to decimal
SBOX_DEC = [int(x) for x in sbox_hex]

# Create the S-box in SageMath
S = SBox(SBOX_DEC)

print("##### Autocorrelation table #####")

#print(S.autocorrelation_table())


print("##### Boomerang connectivity table #####")

#print(S.boomerang_connectivity_table())

print("Max value in BCT:",S.boomerang_uniformity())

print("##### DDT #####")

print(S.difference_distribution_table())