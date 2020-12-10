function circleCenter(Sx, Sy, Δ)
	conj(Sx - Δ * conj(Sy)) / (abs(Sx)^2 - abs(Δ)^2)
end

function circleRadius(Sx, S12, S21, Δ)
	abs((S12 * S21) / (abs(Sx)^2 - abs(Δ)^2))
end

S11 = 2.18 * exp(im * deg2rad(-35))
S12 = 1.26 * exp(im * deg2rad(18))
S21 = 2.75 * exp(im * deg2rad(96))
S22 = 0.52 * exp(im * deg2rad(155))

Δ = S11 * S22 - S12 * S21

CL = conj(S22 - Δ * conj(S11)) / (abs(S22)^2 - abs(Δ)^2)
CL = circleCenter(S22, S11, Δ)
RL = abs((S12 * S21) / (abs(S22)^2 - abs(Δ)^2))
RL = circleRadius(S22, S12, S21, Δ)

using Luxor

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
end 400 400 "problems/examples/Week13_1.png"

# Since abs(S11) > 1, the stable region is in the intesection of the two circles
# We wanna operate in the UNSTABLE region, i.e. we ought to pick the region
# containing the origin, even though that's the unstable region
ΓL = 0.59 * exp(im * deg2rad(-104)) # this was arbitrarily picked

Γin = S11 + S12 * ΓL * S21 / (1 - S22 * ΓL)
