using Luxor

function circleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

function circleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end

S11 = 0.34 * exp(im * deg2rad(-140))
S12 = 0.09 * exp(im * deg2rad(76))
S21 = 4.3 * exp(im * deg2rad(75))
S22 = 0.47 * exp(im * deg2rad(-25))

Δ = S11 * S22 - S12 * S21

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
ampK(S11, S12, S21, S22, Δ)

# verify smith chart with drawing
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
end 400 400 "problems/quiz3/Problem1.png"

# Smith Charting
SmithChartR = 7.43
2 * Rs * SmithChartR # dimensions of circle
real(Cs) * SmithChartR
imag(Cs) * SmithChartR

2 * RL * SmithChartR
real(CL) * SmithChartR
imag(CL) * SmithChartR
