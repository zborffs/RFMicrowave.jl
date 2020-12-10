using RFMicrowave, Unitful, LinearAlgebra, Luxor

# Given
f0 = 6.0u"GHz"
S = [0.61*exp(im*deg2rad(-170)) 0;2.24*exp(im*deg2rad(32)) 0.72*exp(im*deg2rad(-83))]

# Find
# Stability: K
Δ = ampΔ(S)
printComplex(Δ)
K = ampK(S)
printComplex(K)

if (abs(Δ) < 1 && K > 1)
	println("Unconditionally Stable")
else
	println("Potentially Stable")
end

CL = ampCircleCenter(S[2,2], S[1,1], Δ)
RL = ampCircleRadius(S[2,2], S[1,2], S[2,1], Δ)
Cs = ampCircleCenter(S[1,1], S[2,2], Δ)
Rs = ampCircleRadius(S[1,1], S[1,2], S[2,1], Δ)

U = ampU(S)
URange = ampURange(U)
URange_dB = ampURange_dB(U)

if abs(S[1,1]) < 1
	println("Stable Region for Γin contains origin")
else
	println("Stable region for Γin does not contain origin")
end

if abs(S[2,2]) < 1
	println("Stable Region for Γout contains origin")
else
	println("Stable region for Γout does not contain origin")
end

# Cs and CL for constant gain circle
GsMax = 1 / (1 - abs(S[1,1])^2)
GLMax = 1 / (1 - abs(S[2,2])^2)
Gs = 10^(1 / 10)
GL = 10^(2 / 10)

gs = Gs / GsMax
gl = GL / GLMax

Cs = gs * conj(S[1,1]) / (1 - (1-gs)*abs(S[1,1])^2)
Rs = (sqrt(1-gs) * (1-abs(S[1,1]^2))) / (1 - (1 - gs) * abs(S[1,1])^2)

CL = gl * conj(S[2,2]) / (1 - (1-gl) * abs(S[2,2])^2)
RL = (sqrt(1 - gl) * (1 - abs(S[2,2])^2)) / (1 - (1 - gl)*abs(S[2,2])^2)

# Verify smith chart with drawing
@png begin
	drawingScale = 1.0;
	testColor = "red";
	regularColor = "black";
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	# Draw Earth
	circle(O, 100, :stroke);
	circle(O, 1, :stroke);


	# Load-Circle
	CLPoint = Point(100 * real(CL), 100 * imag(CL))
	circle(CLPoint, 100 * RL, :stroke)
	sethue("green")
	line(O, CLPoint, :stroke)

	# Source-Circle
	sethue("black")
	CsPoint = Point(100 * real(Cs), 100 * imag(Cs))
	circle(CsPoint, 100 * Rs, :stroke)
	sethue("red")
	line(O, CsPoint, :stroke)
end 400 400 "problems/ps8/PS1.png"
