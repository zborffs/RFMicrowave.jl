using RFMicrowave, Unitful, PrettyTables

# Question: Design a bandstop filter using three quarter-wave open-circuited
# stubs. The center frequency is 2.0 GHz, the bandwidth is 15%, and the
# impedance is 50 Ohms. Use an equal-ripple response with 0.5 dB ripple level.

# Given
# - Bandstop Filter (BSF)
# - Quarter-Wave Open-Circuited Filter
f0 = 2.0u"GHz"
N = 3
Z0 = 50u"Ω"
Δ = 0.15

# Step 1: Determine the g values
g = EqualRipple05dB[N]

# Step 2: Apply Equation to generate Z values (make sure the '.' is present)
Z0n = bandstop_coupled_resonator_impedance.(Δ, g)

# Step 3: Show results
data = hcat(g, Z0n)
header = ["g", "Z0n"]
pretty_table(data, header)
