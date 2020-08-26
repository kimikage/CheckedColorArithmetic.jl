module CheckedColorArithmetic

using ColorTypes
using FixedPointNumbers

import Base.Checked:
    checked_neg, checked_abs, checked_add, checked_sub, checked_mul, checked_div

import FixedPointNumbers:
    wrapping_neg, wrapping_abs, wrapping_add, wrapping_sub, wrapping_mul,
    saturating_neg, saturating_abs, saturating_add, saturating_sub, saturating_mul

const FixedPointColor = Union{AbstractGray{<:FixedPoint},
                              TransparentGray{<:AbstractGray, <:FixedPoint},
                              AbstractRGB{<:FixedPoint},
                              TransparentRGB{<:AbstractRGB, <:FixedPoint}}

wrapping_add(x::C, y::C) where {C <: FixedPointColor} = mapc(wrapping_add, x, y)
wrapping_sub(x::C, y::C) where {C <: FixedPointColor} = mapc(wrapping_sub, x, y)

saturating_add(x::C, y::C) where {C <: FixedPointColor} = mapc(saturating_add, x, y)
saturating_sub(x::C, y::C) where {C <: FixedPointColor} = mapc(saturating_sub, x, y)

function checked_add(x::C, y::C) where {C <: FixedPointColor}
    s = mapc(saturating_add, x, y)
    s === mapc(wrapping_add, x, y) || throw_overflowerror(:+, x, y)
    s
end

function checked_sub(x::C, y::C) where {C <: FixedPointColor}
    s = mapc(saturating_sub, x, y)
    s === mapc(wrapping_sub, x, y) || throw_overflowerror(:-, x, y)
    s
end

@noinline function throw_overflowerror(op::Symbol, @nospecialize(x), @nospecialize(y))
    io = IOBuffer()
    print(io, x, ' ', op, ' ', y, " overflowed")
    throw(OverflowError(String(take!(io))))
end

end # module
