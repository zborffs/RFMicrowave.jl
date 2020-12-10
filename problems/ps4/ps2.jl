using RFMicrowave, Unitful

# Given
W = 1.2446u"mm"
H = 1.27u"mm"
ϵr = 9.8
f0 = 3u"GHz"

# Find Everything about TL
ϵeff, Z0, β, up = μstripValues(W, H, ϵr, f0)
uconvert(u"fF", μstripCoc(W, H, ϵeff, Z0))
