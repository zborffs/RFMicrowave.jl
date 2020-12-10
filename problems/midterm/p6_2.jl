using Unitful, RFMicrowave

# Given
Zoe = 55.28u"Ω"
Zoo = 45.23u"Ω"

C = complex((Zoe - Zoo) / (Zoe + Zoo))
V1p = 1u"V"

V3n = C * V1p
V2n = (-im * sqrt(1 - C)) * V1p
printComplex(V2n)

V2p = V2n * (-1) * exp(-im * 2 * π * 0.3)
V4n = C * V2p
printComplex(V4n)
