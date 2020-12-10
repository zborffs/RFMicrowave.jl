using RFMicrowave, Unitful, PrettyTables

# Design a Capacitive-Gap Coupled Resonator BPF with Maximally Flat Response
# f0 = 4 GHz, Z0=50 Ohm, BW = 12%, @least 12dB @ 3.6 GHz
# Find Electrical Lengths and Coupling Capacitor Values

# Given
f0 = 4u"GHz"
Z0 = 50u"Ω"
Δ = 0.12

# Step 1: Determine Filter Order from Chart
ω = 2 * π * 3.6u"GHz"
ω0 = 2 * π * f0
ω = 1 / Δ * (ω / ω0 - ω0 / ω)
x = abs(ω) - 1
N = 2

# Step 2: Determine g vales
g = MaximallyFlat[N]

# Step 3: Determine Z0 * J Values
J = bandpass_coupled_line_inv_const(Δ, g)
Z0J = Z0 * J

# Step 4: Determine B Values
B = inv_to_capacitive_susceptance.(J)

# Step 5: Determine C Values & convert to pF
C = uconvert.(u"pF", cap_susceptance_to_cap.(B, ω0))

# Step 6: Determine Electrical lengths in degrees
θ = cap_susceptance_to_elec_length(B)

θ_buf = vcat('-', θ)
data = hcat(g, Z0J, B, C, θ_buf)
header = ["g", "Z0 * J", "B", "C", "θ"]
pretty_table(data, header)
