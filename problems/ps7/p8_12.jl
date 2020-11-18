using RFMicrowave, Unitful

N = 3
g = MaximallyFlat[N]
f0 = 6u"GHz"
R0 = 50u"Ω"
RL = g[end]
Rs = 1.0
L = g[1:2:end-1]
C = g[2:2:end-1]

# Impedance Scaling
(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
