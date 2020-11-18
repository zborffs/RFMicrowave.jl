using RFMicrowave, Unitful

f0 = 6u"GHz"
l = 3u"cm"
ϵr = 1
Z0 = 100u"Ω"

# Determine the β of TL
λ = uconvert(u"m", coaxial_resonator_wavelength(f0, ϵr))
β = 2 * π / λ

Y0 = 1 / Z0
C = uconvert(u"pF", Y0 * cot(β * l) / (2 * π * f0))

R = 1e4u"Ω"

Y = 1 / R + im * (2 * π * f0 * C - Y0 * cot(β * l))
Z = uconvert(u"Ω", 1 / Y)
