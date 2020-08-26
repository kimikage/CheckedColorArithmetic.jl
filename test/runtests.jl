using Pkg
Pkg.add(PackageSpec(name = "FixedPointNumbers", rev = "master"))

using CheckedColorArithmetic, Test

using ColorTypes
using FixedPointNumbers
using Base.Checked

@test   wrapping_add(Gray{N0f8}(0.6), Gray{N0f8}(0.6)) === Gray{N0f8}(0.196)
@test saturating_add(Gray{N0f8}(0.6), Gray{N0f8}(0.6)) === Gray{N0f8}(1.000)
@test_throws OverflowError checked_add(Gray{N0f8}(0.6), Gray{N0f8}(0.6))

@test   wrapping_add(AGray{N0f8}(0.2, 0.6), AGray{N0f8}(0.2, 0.6)) === AGray{N0f8}(0.4, 0.196)
@test saturating_add(AGray{N0f8}(0.2, 0.6), AGray{N0f8}(0.2, 0.6)) === AGray{N0f8}(0.4, 1.000)
@test_throws OverflowError checked_add(AGray{N0f8}(0.2, 0.6), AGray{N0f8}(0.2, 0.6))

@test   wrapping_add(RGB{N0f8}(0.0, 1.0, 0.6), RGB{N0f8}(1.0, 0.0, 0.6)) === RGB{N0f8}(1.0, 1.0, 0.196)
@test saturating_add(RGB{N0f8}(0.0, 1.0, 0.6), RGB{N0f8}(1.0, 0.0, 0.6)) === RGB{N0f8}(1.0, 1.0, 1.000)
@test_throws OverflowError checked_add(RGB{N0f8}(0.0, 1.0, 0.6), RGB{N0f8}(1.0, 0.0, 0.6))

@test   wrapping_add(ARGB{N0f8}(0.0, 1.0, 0.2, 0.6), ARGB{N0f8}(1.0, 0.0, 0.2, 0.6)) === ARGB{N0f8}(1.0, 1.0, 0.4, 0.196)
@test saturating_add(ARGB{N0f8}(0.0, 1.0, 0.2, 0.6), ARGB{N0f8}(1.0, 0.0, 0.2, 0.6)) === ARGB{N0f8}(1.0, 1.0, 0.4, 1.000)
@test_throws OverflowError checked_add(ARGB{N0f8}(0.0, 1.0, 0.2, 0.6), ARGB{N0f8}(1.0, 0.0, 0.2, 0.6))
