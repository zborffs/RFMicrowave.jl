function circleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

function circleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end

S11 = 0.67 * exp(im * deg2rad(-145))
S12 = 0.07 * exp(im * deg2rad(60))
S21 = 2.4 * exp(im * deg2rad(55))
S22 = 0.73 * exp(im * deg2rad(-65))

Δ = S11 * S22 - S12 * S21
abs(Δ)
rad2deg(angle(Δ))

CL = conj(S22 - Δ * conj(S11)) / (abs(S22)^2 - abs(Δ)^2)
CL = circleCenter(S22, S11, Δ)
RL = abs((S12 * S21) / (abs(S22)^2 - abs(Δ)^2))
RL = circleRadius(S22, S12, S21, Δ)

Cs = circleCenter(S11, S22, Δ)
Rs = circleRadius(S11, S12, S21, Δ)

if abs(S11) < 1
	println("Stable Region for Γin contains origin")
else
	println("Stable region for Γin does not contain origin")
end

if abs(S22) < 1
	println("Stable Region for Γout contains origin")
else
	println("Stable region for Γout does not contain origin")
end


function ampΔ(S11, S12, S21, S22)
	S11 * S22 - S12 * S21
end

function ampK(S11, S12, S21, S22, Δ)
	(1 - abs(S11)^2 - abs(S22)^2 + abs(Δ)^2) / (2 * abs(S12 * S21))
end

Δ = ampΔ(S11, S12, S21, S22)
K = ampK(S11, S12, S21, S22, Δ)

U = abs(S12) * abs(S21) * abs(S11) * abs(S22) / ((1 - abs(S11)^2) * (1 - abs(S22)^2))
lowerBound = 1 / (1 + U)^2
upperBound = 1 / (1 - U)^2

lowerBound_dB = 10 * log10(lowerBound)
upperBound_dB = 10 * log10(upperBound)


B1 = 1 + abs(S11)^2 - abs(S22)^2 - abs(Δ)^2
B2 = 1 + abs(S22)^2 - abs(S11)^2 - abs(Δ)^2
C1 = S11 - Δ * conj(S22)
C2 = S22 - Δ * conj(S11)
Γs_pos = (B1 + sqrt(B1^2 - 4 * abs(C1)^2+ 0.0 * im)) / (2 * C1)
Γs_neg = (B1 - sqrt(B1^2 - 4 * abs(C1)^2+ 0.0 * im)) / (2 * C1)
ΓL_pos = (B2 + sqrt(B2^2 - 4 * abs(C2)^2+ 0.0 * im)) / (2 * C2)
ΓL_neg = (B2 - sqrt(B2^2 - 4 * abs(C2)^2+ 0.0 * im)) / (2 * C2)









@png begin
	drawingScale = 1.0;
	testColor = "red";
	regularColor = "black";
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	# Draw Earth
	circle(O, 100, :stroke);

	CsPoint = Point(100 * real(Cs), 100 * imag(Cs))
	circle(CsPoint, 100 * Rs, :stroke)

	ClPoint = Point(100 * real(CL), 100 * imag(CL))
	circle(ClPoint, 100 * RL, :stroke)

	Γs_posPoint = Point(100 * real(Γs_pos), 100 * imag(Γs_pos))
	sethue(testColor)
	circle(Γs_posPoint, 3, :stroke)

	Γs_negPoint = Point(100 * real(Γs_neg), 100 * imag(Γs_neg))
	sethue(testColor)
	circle(Γs_negPoint, 3, :stroke)

	ΓL_posPoint = Point(100 * real(ΓL_pos), 100 * imag(ΓL_pos))
	sethue(testColor)
	circle(ΓL_posPoint, 3, :stroke)

	ΓL_negPoint = Point(100 * real(ΓL_neg), 100 * imag(ΓL_neg))
	sethue(testColor)
	circle(ΓL_negPoint, 3, :stroke)
end 400 400 "problems/quiz3/Problem1.png"

# for drawing on Powerpoint
using Unitful
SmithChartR = 7.43
# Gamma s circle
2 * Rs * SmithChartR
real(Cs) * SmithChartR
imag(Cs) * SmithChartR

2 * RL * SmithChartR
real(CL) * SmithChartR
imag(CL) * SmithChartR



Γs = Γs_neg
ΓL = ΓL_neg
Zs = Z0 * (Γs + 1) / (Γs - 1)
ZL = Z0 * (ΓL + 1) / (ΓL - 1)

Rs = 6.25
RL = 14.75
Zsp = Zs + Rs
ZLp = ZL + RL

Γsp = (Zsp - Z0) / (Zsp + Z0)
ΓLP = (ZLp - Z0) / (ZLp + Z0)
