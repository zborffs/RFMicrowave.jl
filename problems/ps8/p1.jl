using RFMicrowave, Unitful, LinearAlgebra, Luxor

# Given
f0 = 2.0u"GHz"
S = [0.88*exp(im*deg2rad(-115)) 0.029*exp(im*deg2rad(31));9.4*exp(im*deg2rad(110)) 0.328*exp(im*deg2rad(-67))]

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
