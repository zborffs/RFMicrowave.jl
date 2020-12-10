using RFMicrowave, Unitful, PrettyTables

# Given
# - LPF
# - Maximally Flat
f0 = 2.0u"GHz"
N = 5
Z0 = 50u"Ω"

# Step 1: Determine g values
g = MaximallyFlat[N]
RL = g[end]
C = g[1:2:end-1]
L = g[2:2:end-1]
Rs = 1.0
R0 = 50u"Ω"

# Step 2: Impedance + Freq. Transforms
(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, Z0)
L, C = lpf_proto_freq_scale_lpf(L, C, 2 * π * f0)
L = uconvert.(u"nH", L)
C = uconvert.(u"pF", C)
