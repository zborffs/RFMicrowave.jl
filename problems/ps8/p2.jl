using RFMicrowave, Unitful, LinearAlgebra, Luxor

# Given
f0 = 8.0u"GHz"
S = [0.52*exp(im*deg2rad(179)) 0.14*exp(im*deg2rad(-1));2.0*exp(im*deg2rad(20)) 0.42*exp(im*deg2rad(-129))]

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

# Verify smith chart with drawing
@png begin
	drawingScale = 1.0;
	testColor = "red";
	regularColor = "black";
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	# Draw Earth
	circle(O, 100, :stroke);

	# Load-Circle
	CLPoint = Point(100 * real(CL), 100 * imag(CL))
	circle(CLPoint, 100 * RL, :stroke)

	# Source-Circle
	CsPoint = Point(100 * real(Cs), 100 * imag(Cs))
	circle(CsPoint, 100 * Rs, :stroke)
end 400 400 "problems/ps8/PS1.png"

B1 = 1 + abs(S[1,1])^2 - abs(S[2,2])^2 - abs(Δ)^2
B2 = 1 + abs(S[2,2])^2 - abs(S[1,1])^2 - abs(Δ)^2
C1 = S[1,1] - Δ * conj(S[2,2])
C2 = S[2,2] - Δ * conj(S[1,1])
Γs_pos = (B1 + sqrt(B1^2 - 4 * abs(C1)^2+ 0.0 * im)) / (2 * C1)
Γs_neg = (B1 - sqrt(B1^2 - 4 * abs(C1)^2+ 0.0 * im)) / (2 * C1)
ΓL_pos = (B2 + sqrt(B2^2 - 4 * abs(C2)^2+ 0.0 * im)) / (2 * C2)
ΓL_neg = (B2 - sqrt(B2^2 - 4 * abs(C2)^2+ 0.0 * im)) / (2 * C2)

ΓL = ΓL_neg
Γs = Γs_neg

printComplex(Γs)
printComplex(ΓL)

GsMax = 1 / (1 - abs(Γs)^2)
G0 = abs(S[2,1])^2
GLMax = (1 - abs(ΓL)^2) / abs(1 - S[2,2] * ΓL)^2

GTMax = GsMax * G0 * GLMax
GTMax_dB = 10 * log10(GTMax)
