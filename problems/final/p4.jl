# Given
f = 2u"GHz"
Z0 = 50u"Ω"
S = [0.65*exp(im*deg2rad(-141)) 0.02*exp(im*deg2rad(62)); 2.38*exp(im*deg2rad(53)) 0.72*exp(im*deg2rad(-67))]
Fmin = 2.5 # dB
Γopt = (0.8+3/100)*exp(im*deg2rad(145))
RN = 5u"Ω"

# Find
# Is it unconditionally stable
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

U = ampU(S)
URange = ampURange(U)
URange_dB = ampURange_dB(U)

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


# part 4

Γs = Γopt
ΓL = conj(S[2,2])
printComplex(ΓL)
Γin = S[1,1] + S[1,2] * S[2,1] * ΓL / (1 - S[2,2] * ΓL)
printComplex(Γin)
Γout = S[2,2] + S[2,1] * S[1,2] * Γs / (1 - S[1,1] * Γs)
printComplex(Γout)

GL = (1 - abs(ΓL)^2) / abs(1 - S[2,2]ΓL)^2
Gs = (1 - abs(Γs)^2) / abs(1 - Γs * Γin)
G0 = abs(S[2,1])^2
GT = GL * Gs * G0


# b
S = [0.894*exp(im*deg2rad(-60.6)) 0.02*exp(im*deg2rad(62.4)); 3.11*exp(im*deg2rad(123.6)) 0.781*exp(im*deg2rad(-27.6))]
Δ = ampΔ(S)

CL = ampCircleCenter(S[2,2], S[1,1], Δ)
RL = ampCircleRadius(S[2,2], S[1,2], S[2,1], Δ)
Cs = ampCircleCenter(S[1,1], S[2,2], Δ)
Rs = ampCircleRadius(S[1,1], S[1,2], S[2,1], Δ)
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
	CLPoint = Point(100 * real(ΓL), 100 * imag(ΓL))
	circle(CLPoint, 100 * abs(ΓL), :stroke)

	# Source-Circle
	CsPoint = Point(100 * real(Γs), 100 * imag(Γs))
	circle(CsPoint, 100 * abs(Γs), :stroke)
end 400 400 "problems/final/p4_b.png"

SmithChartR * 2 * abs(ΓL)
SmithChartR * real(ΓL)
SmithChartR * imag(ΓL)
