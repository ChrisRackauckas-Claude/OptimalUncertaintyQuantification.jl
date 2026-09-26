using OUQBase
using Symbolics
using SymbolicUtils
using Test

# Regression: SymbolicUtils defines promote_symtype(::Operator, ::Type{T}),
# which is equally specific to OUQBase's promote_symtype(::𝔼_, x) when the
# second argument is a Type. Term construction of 𝔼(x) / ℙ(x) hits that path.
@testset "promote_symtype for 𝔼_ / ℙ_" begin
    @variables x
    ex = 𝔼(x)
    px = ℙ(x)
    @test SymbolicUtils.promote_symtype(𝔼, Real) === Real
    @test SymbolicUtils.promote_symtype(ℙ, Real) === Real
    @test !isnothing(ex)
    @test !isnothing(px)
end

@testset "underlying RVs and raw moment order" begin
    @variables Q
    @test isequal(only(OUQBase.underlying_random_variables(𝔼(Q) ~ 1.0)), Symbolics.value(Q))
    @test isequal(
        only(OUQBase.underlying_random_variables(𝔼(Q^2) ~ 1.0)), Symbolics.value(Q)
    )
    @test OUQBase.get_raw_moment_order(𝔼(Q) ~ 1.0, Q) == 1
    @test OUQBase.get_raw_moment_order(𝔼(Q^2) ~ 1.0, Q) == 2
end
