Z0 = 50u"Ω"
f0 = 2u"GHz"
L = 5u"nH"
C = 3u"pF"

# Find
ω = uconvert(u"rad/s", 2 * π * f0)
l2 = acot(1 / (ω * C * Z0))
