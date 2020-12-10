function circleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

function circleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end

S11 = 0.9 * exp(im * deg2rad(-154))
S12 = 0.25 * exp(im * deg2rad(-15))
S21 = 2.8 * exp(im * deg2rad(55))
S22 = 0.5 * exp(im * deg2rad(-115))

Δ = S11 * S22 - S12 * S21

CL = conj(S22 - Δ * conj(S11)) / (abs(S22)^2 - abs(Δ)^2)
CL = circleCenter(S22, S11, Δ)
RL = abs((S12 * S21) / (abs(S22)^2 - abs(Δ)^2))
RL = circleRadius(S22, S12, S21, Δ)

using Luxor

ΓLtest = 0.75 * exp(im * deg2rad(135))
# verify smith chart with drawing
@png begin
	drawingScale = 1.0;
	testColor = "red";
	regularColor = "black";
	origin();
	scale(1. * drawingScale, -1. * drawingScale);

	# Draw Earth
	circle(O, 100, :stroke);

	CLPoint = Point(100 * real(CL), 100 * imag(CL))
	circle(CLPoint, 100 * RL, :stroke)

	circle(O, 3, :stroke)
	ΓLtestPoint = Point(100 * real(ΓLtest), 100 * imag(ΓLtest))
	sethue(testColor)
	circle(ΓLtestPoint, 3, :stroke)

	ΓtPoint = Point(100 * real(Γt), 100 * imag(Γt))
	circle(ΓtPoint, 3, :stroke)
end 400 400 "problems/examples/Week13_1.png"

# Since abs(S11) > 1, the stable region is in the intesection of the two circles
# We wanna operate in the UNSTABLE region, i.e. we ought to pick the region
# containing the origin, even though that's the unstable region
ΓL = ΓLtest
Γin = S11 + S12 * ΓL * S21 / (1 - S22 * ΓL)

Zin = (1 + Γin) / (1 - Γin)
Z0 = 50
Rin = Z0 * real(Zin)
Xin = Z0 * imag(Zin)
Xs = -Xin
Rs = -Rin / 3

Γt = (Rs + im * Xs - Z0) / (Rs + im * Xs + Z0)

# Smith Charting
SmithChartR = 7.43
abs(CL) * SmithChartR * cos(angle(CL))
abs(CL) * SmithChartR * sin(angle(CL))

real(Γt) * SmithChartR
imag(Γt) * SmithChartR

2 * abs(ΓL) * SmithChartR
real(ΓL) * SmithChartR
imag(ΓL) * SmithChartR
