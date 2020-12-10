using RFMicrowave, Unitful, PrettyTables

N = 3
g = EqualRipple05dB[N]
f0 = 2.5u"GHz"
Δ = 0.1
Z0 = 50u"Ω"

# Compute Js
J = bpf_cap_coupled_shunt_J(Δ, g; Z0)
JZ0 = Z0 * J

# Compute Cs
C = bpf_cap_coupled_shunt_C(J, 2 * π * f0)
C = uconvert.(u"pF", C)

# Compute ΔCs
ΔC = bpf_cap_coupled_shunt_ΔC(C)

# Compute Δls
Δl = bpf_cap_coupled_shunt_Δl(2 * π * f0, ΔC)
Δl = uconvert.(u"NoUnits", Δl)

# Compute ls
l = bpf_cap_coupled_ln.(2 * π * f0, ΔC)
l_deg = rad2deg.(l * 2 * π)

data1 = hcat(1:N+1, g, JZ0, C)
header1 = ["n", "g", "Z0 * J", "C"]
pretty_table(data1, header1)

data2 = hcat(1:N, ΔC, Δl, l_deg)
header2 = ["n", "ΔC", "Δl", "l (deg)"]
pretty_table(data2, header2)
