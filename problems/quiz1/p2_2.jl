using Unitful, RFMicrowave, LinearAlgebra

# Given
Sa = [1/3+im*2/3 im*2/3; im*2/3 1/3-im*2/3]
Sb = [1/3-im*2/3 im*2/3; im*2/3 1/3+im*2/3]

# Find
# Is Sa lossless?
transpose(Sa) * conj.(Sa)
Ya = S_to_Y(Sa)

ABCDa = round.(S_to_ABCD(Sa);digits=5)
ABCD_15 = ABCD_TL(2 * π * 0.15)
ABCD_25 = ABCD_TL(2 * π * 0.25)

ABCDtot = ABCDa * ABCD_15 * ABCDa * ABCD_25 * ABCDa
Stot = ABCD_to_S(ABCDtot)
