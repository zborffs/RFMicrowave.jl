using RFMicrowave
using Test
using Unitful

@testset "Bandstop Filter Design - Coupled Resonators" begin
	# Example 8.8 in Pozar
	Δ = 0.15
	Z0 = 50u"Ω"

	g1 = 1.5963
	g2 = 1.0967
	g3 = g1

	Z01 = bandstop_coupled_resonator_impedance(Δ, g1)
	@test unit(Z01) == u"Ω"
	@test isapprox(Z01, 265.9u"Ω"; atol=0.1u"Ω")
	Z02 = bandstop_coupled_resonator_impedance(Δ, g2)
	@test unit(Z02) == u"Ω"
	@test isapprox(Z02, 387.0u"Ω"; atol=0.1u"Ω")
	Z03 = bandstop_coupled_resonator_impedance(Δ, g3)
	@test unit(Z03) == u"Ω"
	@test isapprox(Z03, 265.9u"Ω"; atol=0.1u"Ω")
end

# Example 8.9
@testset "Bandpass Filter Design - Capacitively Coupled Series Resonators" begin
	f0 = 2u"GHz"
	Δ = 0.1
	Z0 = 50u"Ω"
	N = 3
	ω0 = 2 * π * f0

	g = EqualRipple05dB[N]
	J = bandpass_coupled_line_inv_const(Δ, g)
	B = inv_to_capacitive_susceptance.(J)
	C = cap_susceptance_to_cap.(B, ω0)
	C = uconvert.(u"pF", C)
	θ = rad2deg.(cap_susceptance_to_elec_length(B))

	@test isapprox(g[1], 1.5963; atol=0.0001)
	@test isapprox(g[2], 1.0967; atol=0.0001)
	@test isapprox(g[3], 1.5963; atol=0.0001)
	@test isapprox(g[4], 1.0000; atol=0.0001)

	@test isapprox(Z0 * J[1], 0.3137; atol=0.0001)
	@test isapprox(Z0 * J[2], 0.1187; atol=0.0001)
	@test isapprox(Z0 * J[3], 0.1187; atol=0.0001)
	@test isapprox(Z0 * J[4], 0.3137; atol=0.0001)

	@test isapprox(ustrip(B[1]), 6.96e-3; atol=0.01e-3)
	@test isapprox(ustrip(B[2]), 2.41e-3; atol=0.01e-3)
	@test isapprox(ustrip(B[3]), 2.41e-3; atol=0.01e-3)
	@test isapprox(ustrip(B[4]), 6.96e-3; atol=0.01e-3)

	@test isapprox(C[1], 0.554u"pF"; atol=0.001u"pF")
	@test isapprox(C[2], 0.192u"pF"; atol=0.001u"pF")
	@test isapprox(C[3], 0.192u"pF"; atol=0.001u"pF")
	@test isapprox(C[4], 0.554u"pF"; atol=0.001u"pF")

	@test isapprox(θ[1], 155.8; atol=0.1)
	@test isapprox(θ[2], 166.5; atol=0.1)
	@test isapprox(θ[3], 155.8; atol=0.1)
end

# Example 8.3
@testset "Low-Pass Filter Design Comparison" begin
	# Design a Maximally flat LPF with:
	# - cutoff frequency 2GHz
	# - impedance of 50 Ohms
	# - at  least 15 dB insertion loss at 3 GHz
	# Compute and plot the amplitude response and group delay for f = 0-4GHz
	# Compare to Equal-Ripple (3.0 dB ripple)

	# Step 1: Determine filter order from Figure 8.26 in textbook
	N = 5
	g = MaximallyFlat[N]
	C = g[1:2:end-1]
	L = g[2:2:end-1]
	Rs = 1.0
	RL = g[end]
	R0 = 50u"Ω"
	fc = 2u"GHz"

	(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
	@test Rs == R0
	(L, C) = lpf_proto_freq_scale_lpf(L, C, 2 * π * fc)
	C = uconvert.(u"pF", C)
	L = uconvert.(u"H", L)
	@test isapprox(C[1], 0.984u"pF"; atol=0.001u"pF")
	@test isapprox(L[1], 6.438u"nH"; atol=0.001u"nH")
	@test isapprox(C[2], 3.183u"pF"; atol=0.001u"pF")
	@test isapprox(L[2], 6.438u"nH"; atol=0.001u"nH")
	@test isapprox(C[3], 0.984u"pF"; atol=0.001u"pF")
	@test RL == 50u"Ω"
end

# Example 8.3
@testset "Bandpass Filter Design" begin
	# Design a BPF having 0.5 dB equal ripple response with N = 3.
	# f0 = 1 GHz, Δ = 0.1, impedance = 50 Ohms
	N = 3
	g = EqualRipple05dB[N]
	C = g[2:2:end-1]
	L = g[1:2:end-1]
	Rs = 1.0
	RL = g[end]
	R0 = 50u"Ω"
	f0 = 1u"GHz"
	Δ = 0.1

	(L, C, Rs, RL) = lpf_proto_impedance_scale(L, C, Rs, RL, R0)
	@test Rs == R0
	(LC_series, LC_shunt) = lpf_proto_to_bpf(L, C, Δ, 2 * π * f0)
	LC_series = (uconvert.(u"nH", LC_series[1]), uconvert.(u"pF", LC_series[2]))
	LC_shunt = (uconvert.(u"nH", LC_shunt[1]), uconvert.(u"pF", LC_shunt[2]))
	@test isapprox(LC_series[1][1], 127.0u"nH"; atol=0.1u"nH")
	@test isapprox(LC_series[2][1], 0.199u"pF"; atol=0.001u"pF")
	@test isapprox(LC_shunt[1][1], 0.726u"nH"; atol=0.001u"nH")
	@test isapprox(LC_shunt[2][1], 34.91u"pF"; atol=0.01u"pF")
	@test isapprox(LC_series[1][2], 127.0u"nH"; atol=0.1u"nH")
	@test isapprox(LC_series[2][2], 0.199u"pF"; atol=0.001u"pF")
end

# Example 8.10
@testset "Capacitively Coupled Shunt Resonators Bandpass Filter Design" begin
	N = 3
	g = EqualRipple05dB[N]
	f0 = 2.5u"GHz"
	Δ = 0.1
	Z0 = 50u"Ω"

	# Find everything about the line
	J = bpf_cap_coupled_shunt_J.(Δ, g; Z0)
end
