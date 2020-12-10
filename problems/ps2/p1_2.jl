using Unitful, LinearAlgebra

function printComplex(z)
	println("$(abs(z)) ∠$(rad2deg(angle(z)))")
end

function VNp(VN, IN, Z0)
	(VN + Z0 * IN) / 2
end

function VNn(VN, IN, Z0)
	(VN - Z0 * IN) / 2
end

# Given
V1 = 10 * exp(im * deg2rad(90))u"V"
V2 = 8u"V"
I1 = 0.2 * exp(im * deg2rad(90))u"A"
I2 = 0.16 * exp(im * deg2rad(-90))u"A"

# Output
Zin1 = round(typeof(complex(1.0)u"Ω"), V1 / I1; digits=5)
Zin2 = round(typeof(complex(1.0)u"Ω"), V2 / I2; digits=5)

V1p = round(typeof(complex(1.0)u"V"), VNp(V1, I1, Zin1); digits=5)
V1n = VNn(V1, I1, Zin1)
V2p = VNp(V2, I2, Zin2)
V2n = VNn(V2, I2, Zin2)
