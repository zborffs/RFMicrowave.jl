using RFMicrowave, Unitful

k_sq = 0.003182621247244999

g3 = 1 + 2 * k_sq + 2 * sqrt(k_sq) * sqrt(1 + k_sq)

f(L) = 1 / (-16 * k_sq * RL) * (RL^2 * ((4 * k_sq) * (4 * RL)) / (L^2 * RL^2) + L^2 - 2 * (2 * RL^2 * sqrt(k_sq) * 2 * sqrt(RL)))

g1 = find_zero(f, 1.0)

g2 = sqrt((4 * k_sq * 4 * RL) / (L^2 * RL^2))

g = [g1, g2, g3]
L = g[1:2:end-1]
RL = g[end]
C = g[2:2:end-1]

Rs = 1.0
R0 = 50u"Ω"
Δ = 0.01

(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
(LC_series, LC_shunt) = lpf_proto_to_bpf(L, C, Δ, 2 * π * f0)
LC_series = (uconvert.(u"nH", LC_series[1]), uconvert.(u"pF", LC_series[2]))
LC_shunt = (uconvert.(u"nH", LC_shunt[1]), uconvert.(u"pF", LC_shunt[2]))
