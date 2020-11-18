using Unitful, RFMicrowave



N = 3
g = EqualRipple05dB[N]
C = g[1:2:end-1]
L = g[2:2:end-1]
Rs = 1.0
RL = g[end]
R0 = 50u"Ω"
f0 = 1u"GHz"
Δ = 0.1

(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
@assert Rs == R0
(LC_series, LC_shunt) = lpf_proto_to_bpf(L, C, Δ, 2 * π * f0)
