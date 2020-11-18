using RFMicrowave, Unitful
import PhysicalConstants.CODATA2014: μ_0, ε_0, c_0

export μstrip_A
function μstrip_A(Z0, ϵr)
	ustrip(Z0) / 60 * sqrt((ϵr + 1) / 2) + (ϵr - 1) / (ϵr + 1) * (0.23 + 0.11 / ϵr)
end

export μstrip_B
function μstrip_B(Z0, ϵr)
	377 * π / (2 * ustrip(Z0) * sqrt(ϵr))
end

# find W/d when W/d is less than 2
export μstrip_Wd_ls2
function μstrip_Wd_ls2(A)
	8 * exp(A) / (exp(2 * A) - 2)
end

# find W/d when W/d is greater than 2
export μstrip_Wd_gr2
function μstrip_Wd_gr2(B, ϵr)
	2 / π * (B - 1 - log(2 * B - 1) + (ϵr - 1) / (2 * ϵr) * (log(B - 1) + 0.39 - 0.61 / ϵr))
end

export μstrip_ϵe
function μstrip_ϵe(ϵr, W_d)
	(ϵr + 1) / 2 + (ϵr - 1) / (2 * sqrt(1 + 12 / W_d))
end

export μstrip_k0
function μstrip_k0(f0, μ, ϵ)
	uconvert(u"rad/m", 2 * π * f0 * sqrt(μ * ε))
end

export μstrip_αd
function μstrip_αd(k0, ϵr, ϵe, tanδ)
	k0 * ϵr * (ϵe - 1) * tanδ / (2 * sqrt(ϵe) * (ϵr - 1))
end

export μstrip_Rs
function μstrip_Rs(f0, μ, σ)
	uconvert(u"Ω", sqrt(π * f0 * μ / σ))
end

export μstrip_αc
function μstrip_αc(Rs, Z0, W)
	uconvert(u"m^-1",  Rs / (Z0 * W))
end

export μstrip_λ0
function μstrip_λ0(f0, ϵe)
	uconvert(u"m", c_0 / (f0 * sqrt(ϵe)))
end

export μstrip_β
function μstrip_β(f0, ϵe)
	uconvert(u"rad/m", 2 * π * f0 * sqrt(ϵe) / c_0)
end
