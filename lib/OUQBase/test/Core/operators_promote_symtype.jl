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

# Flood fixtures use ≳/≲ inequalities inside ℙ(...). Those wrap as Inequality
# objects that get_variables does not traverse without an explicit unwrap.
@testset "Probability expression variable discovery" begin
    rand_vars = @random_variables begin
        Independent(Q, bounds = (0.0, 1.0))
    end
    aset = AdmissibleSet(rand_vars, [𝔼(Q) ~ 0.5])
    @test isequal(OUQBase.underlying_random_variables(ℙ(Q > 0.5)), [Symbolics.value(Q)])
    @test OUQBase.get_ordered_group_names(ℙ(Q > 0.5), aset) == [:_Q]
    @test isequal(OUQBase.underlying_random_variables(ℙ(Q ≳ 0.5)), [Symbolics.value(Q)])
    @test OUQBase.get_ordered_group_names(ℙ(Q ≳ 0.5), aset) == [:_Q]
    @test isequal(OUQBase.underlying_random_variables(ℙ(Q ≲ 0.5)), [Symbolics.value(Q)])
    @test OUQBase.get_ordered_group_names(ℙ(Q ≲ 0.5), aset) == [:_Q]
end
