using Unitful, LinearAlgebra

# Given
# - Parallel-coupled circuit
N = 3
Zoe = 55.28u"Ω"
Zoo = 45.23u"Ω"
L = 0.1 * N # wavelengths
V1_pos = 1

# Calculatethe output voltage at port 4 for
# a.) d = \lambda / 2
d = 1/2
C = (Zoe - Zoo) / (Zoe + Zoo)
Z0 = sqrt(Zoo * Zoe)

# b.) d = \lambda / 4
