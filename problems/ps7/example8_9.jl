using RFMicrowave, Unitful, PrettyTables

# Design a bandpass filter using capacitive coupled series resonators, with a
# 0.5 dB equal-ripple passband characteristic. The center frequency is 2.0 GHz,
# the bandwidth is 10%, and the impedance is 50 Ohms. At least 20 dB of
# attenuation is required at 2.2GHz

# Given
# - Bandpass Filter (BPF)
# - Capacitive Coupled Series Resonators
# - 0.5 dB Equal Ripple Response
f0 = 2.0u"GHz"
Δ = 0.1
Z0 = 50u"Ω"

# Step 1: Determine the filter's order
ω = uconvert(u"rad/s", 2 * π * 2.2u"GHz")
ω0 = uconvert(u"rad/s", 2 * π * f0)
ω = 1 / Δ * (ω / ω0 - ω0 / ω)
x = ω - 1

# Find (x, 20dB) in table 8.27 in textbook to determine N
N = 3

# Step 2: Determine g values
g = EqualRipple05dB[N]

# Step 3: Determine J * Z0 values
J = bandpass_coupled_line_inv_const(Δ, g)
JZ0 = Z0 * J

# Step 4: Determine B values
B = inv_to_capacitive_susceptance.(J)

# Step 5: Determine C values and convert to pF
C = uconvert.(u"pF", cap_susceptance_to_cap.(B, ω0))

# Step 6: Determine electrical lengths in degrees
θ = (rad2deg.(cap_susceptance_to_elec_length(B)))u"°"

# Step 7: Draw Data
θ_buf = vcat(θ, '-')
data = hcat(g, JZ0, B, C, θ_buf)
header = ["g", "J*Z0", "B", "C", "θ"]
pretty_table(data, header)
