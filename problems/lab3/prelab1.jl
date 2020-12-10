using RFMicrowave, Unitful

# Given
# - BPF
f0 = 6u"GHz"
g = [0.6708, 1.0030, 0.6708, 1.0000]
Δ = 0.02
Z0 = 50u"Ω"

# Find Ls and Cs
Rs = 1.0
RL = g[end]
L = g[1:2:end-1]
C = g[2:2:end-1]

# Step 2: Impedance Scaling
L, C, Rs, RL = lpf_proto_impedance_scale(L, C, Rs, RL, Z0)

# Step 3: BPF transform
LC_series, LC_parallel = lpf_proto_to_bpf(L, C, Δ, 2 * π * f0)

LC_series = (uconvert.(u"nH", LC_series[1]), uconvert.(u"pF", LC_series[2]))
LC_parallel = (uconvert.(u"nH", LC_parallel[1]), uconvert.(u"pF", LC_parallel[2]))

# Given
# - BPF
# - Capacitively coupled series resonator
ω0 = uconvert(u"rad/s", 2 * π * f0)
J = bandpass_coupled_line_inv_const(Δ, g)
JZ0 = Z0 * J

#
B = inv_to_capacitive_susceptance.(J)
C = uconvert.(u"pF", cap_susceptance_to_cap.(B, ω0))
θ = (rad2deg.(cap_susceptance_to_elec_length(B)))u"°"

θ_buf = vcat(θ, '-')
data = hcat(g, JZ0, B, C, θ_buf)
header = ["g", "J*Z0", "B", "C", "θ"]
pretty_table(data, header)
