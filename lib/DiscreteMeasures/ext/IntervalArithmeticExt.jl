module IntervalArithmeticExt

using DiscreteMeasures, IntervalArithmetic

function DiscreteMeasures.clamp_domain(x::Interval, lb, ub)
    bounds = interval(lb, ub)
    return intersect_interval(x, bounds)
end

function DiscreteMeasures.clamp_weight(w::Interval{T}, maxw::T = one(T)) where {T}
    return clamp_domain(w, zero(T), maxw)
end

end
