using Unitful, RFMicrowave, PrettyTables

# Given
f0 = 2u"GHz"
N = 5
Z0 = 50u"Ω"

# Find
g = MaximallyFlat[N]
g0 = 1
Rs = (g0)
L = g[1:2:end-1]
C = g[2:2:end-1]
RL = g[end]

L, C, Rs, RL = lpf_proto_impedance_scale(L, C, Rs, RL, Z0)
L, C = lpf_proto_freq_scale_lpf(L, C, 2 * π * f0)
L = uconvert.(u"nH", L)
C = uconvert.(u"pF", C)

header = ["g", "Rs", "RL", "L", "C"]
gData = vcat([1.0], g)
RsData = vcat(Rs, repeat(['-'], length(g)))
RLData = vcat(repeat(['-'], length(g)), RL)

function LCData(X1, X2, gData)
	X1Data = Vector{Union{typeof(X1[1]), typeof('-')}}(undef, length(gData))
	X2Data = Vector{Union{typeof(X2[1]), typeof('-')}}(undef, length(gData))

	for i in 2:length(gData)-1
		if i % 2 == 0
			X1Data[i] = X1[convert(Int64, ceil(i/2))]
		else
			X1Data[i] = '-'
		end
	end

	for i in 2:length(gData)-1
		if i % 2 == 1
			X2Data[i] = X2[convert(Int64, floor(i/2))]
		else
			X2Data[i] = '-'
		end
	end

	X1Data[1] = '-'
	X1Data[end] = '-'
	X2Data[1] = '-'
	X2Data[end] = '-'

	return X1Data, X2Data # X1 is the first reactive element
end

LData, CData = LCData(L, C, gData)

data = hcat(gData, RsData, RLData, LData, CData)
pretty_table(data, header)
# OR
g = MaximallyFlat[N]
g0 = 1
Rs = (g0)
L = g[2:2:end-1]
C = g[1:2:end-1]
RL = g[end]

L, C, Rs, RL = lpf_proto_impedance_scale(L, C, Rs, RL, Z0)
L, C = lpf_proto_freq_scale_lpf(L, C, 2 * π * f0)
L = uconvert.(u"nH", L)
C = uconvert.(u"pF", C)

header = ["g", "Rs", "RL", "C", "L"]
gData = vcat([1.0], g)
RsData = vcat(Rs, repeat(['-'], length(g)))
RLData = vcat(repeat(['-'], length(g)), RL)

LData, CData = LCData(C, L, gData)

data = hcat(gData, RsData, RLData, LData, CData)
pretty_table(data, header)
