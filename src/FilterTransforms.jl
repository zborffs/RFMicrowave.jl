using Unitful

export lpf_proto_impedance_scale
function lpf_proto_impedance_scale(L, C, Rs, RL, R0)
	L = L * R0
	C = C / R0
	Rs = R0
	RL = R0 * RL
	return (L, C, Rs, RL)
end

export lpf_proto_freq_scale_lpf
function lpf_proto_freq_scale_lpf(L, C, ωc)
	L = L / ωc
	C = C / ωc
	return (L, C)
end

# Series inductors are replaced by caps, and shunt caps are replaced by inductors
export lpf_proto_to_hpf
function lpf_proto_to_hpf(L, C, ωc)
	Lret = 1 ./ (ωc * C)
	Cret = 1 ./ (ωc * L)
	return (Lret, Cret)
end

export lpf_proto_to_bpf
function lpf_proto_to_bpf(L, C, Δ, ω0)
	# Shunt caps become shunt LC resonator circuit
	LC_shunt = ((Δ / ω0) ./ C,  C ./ (Δ * ω0))

	# Series inductors become series LC resonator circuits
	LC_series = (L ./ (Δ * ω0), Δ ./ (L * ω0))
	return (LC_series, LC_shunt)
end

export lpf_proto_to_pbf
function lpf_proto_to_pbf(L, C, Δ, ω0)
	# Series inductors become parallel LC circuits
	LC_parallel = (Δ * L ./ ω0, 1 ./ (ω0 * Δ * L))

	# parallel caps become series LC circuits
	LC_series = (1 ./ (ω0 * Δ * C), Δ * C ./ ω0)
	return (LC_parallel, LC_series)
end


export richard_L_to_sc_stub
function richad_L_to_sc_stub(L)
	Z0 = L
	elec_length = 1 / 8
	return (Z0, elec_length)
end

export richard_C_to_oc_stub
function richard_C_to_oc_stub(C)
	Z0 = 1 / C
	elec_length = 1 / 8
	return (Z0, elec_length)
end
