using RFMicrowave, Unitful, PrettyTables

# Question:
# Design a maximally flat bandstop filter using four open-circuited quarter-wave
# stub resonators. The center frequency is 3 GHz, the bandwidth is 15%, and the
# impedance is 40 Ohms

# Given
# - Maximally Flat
# - Bandstop Filter (BSF)
# - Open-Circuited Quarter-Wave Stub
f0 = 3u"GHz"
Δ = 0.15
N = 4
Z0 = 40u"Ω"

# Step 1: Determine g values
g = MaximallyFlat[N]
Z0n = bandstop_coupled_resonator_impedance.(Δ, g; Z0=Z0)

data = hcat(g, Z0n)
header = ["g", "Z0n"]

pretty_table(data, header)
