# given
d = 15u"mm"
function coaxial_resonator_frequency(length, ϵr, n = 1)
	n * c_0 / (2 * length * sqrt(ϵr))
end

f1 = uconvert(u"GHz", coaxial_resonator_frequency(d, 1, 1))
f2 = uconvert(u"GHz", coaxial_resonator_frequency(d, 1, 2))

f0 = 10u"GHz"
λ = uconvert(u"m", c0 / f0)
β = 2 * π / λ

ΓL = exp(-2 * im * β * d)
printComplex(ΓL)

ω0 = 2 * π * f0
L = 3u"nH"
ZL = uconvert(u"NoUnits", im * ω0 * L / Z0)
zl = (ZL - 1) / (ZL + 1)
v = zl / ΓL
C = uconvert(u"pF", (v-1) / (-im * ω0 * Z0 - im * v * ω0 * Z0))
