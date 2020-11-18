using RFMicrowave, Unitful

a = 22.86u"mm"
b = 10.16u"mm"
d = 2u"cm"
ϵr = 1

f0 = c_0 / (2 * π * sqrt(ϵr)) * sqrt((π / d)^2 + (π / a)^2)

uconvert(u"GHz", f0)
