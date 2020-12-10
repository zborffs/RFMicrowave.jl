using RFMicrowave, Unitful, PrettyTables

# Given
# -
N = 2
f0 = 3u"GHz"
Z0 = 50u"Ω"

# Find
# -
g = MaximallyFlat[N]
RL = g[end]
Rs = 1.0
C = g[1:2:end-1]
L = g[2:2:end-1]

L, C, Rs, RL = lpf_proto_impedance_scale(L, C, Rs, RL, Z0)
L, C = lpf_proto_freq_scale_lpf(L, C, 2 * π * f0)

L = uconvert.(u"nH", L)
C = uconvert.(u"pF", C)

ω0 = 2 * π * f0
Plr = 1 + 1 / (4 * RL) *((1 - RL)^2 + (R^2 * C^2 + L^2 - 2 * LC * R^2) * )
