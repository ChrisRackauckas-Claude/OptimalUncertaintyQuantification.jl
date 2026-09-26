using OptimalUncertaintyQuantification
import Symbolics
using Test

@testset "Umbrella module loads" begin
    @test OptimalUncertaintyQuantification isa Module
    # The umbrella re-exports OUQBase's public interface.
    @test isdefined(OptimalUncertaintyQuantification, :OUQSystem)
    @test isdefined(OptimalUncertaintyQuantification, :AdmissibleSet)
    # Re-exported names are available unqualified in the test scope.
    @test OUQSystem isa Type
    @test AdmissibleSet isa Type
    # `@random_variables` expands to `Symbolics.@variables` in the caller.
    # Scalar bounds must be numeric literals (see `@random_variables` docstring).
    random_vars = @random_variables begin
        Independent(Q, bounds = (0.0, 1.0))
    end
    @test haskey(random_vars, :_Q)
    @test OUQBase.getbounds(random_vars[:_Q]) == (0.0, 1.0)
end

@testset "@random_variables docstring scalar/vector bounds" begin
    # Matches the documented example in `OUQBase.@random_variables`.
    rv = @random_variables begin
        Independent(X, bounds = (0.0, 1.0))
        Independent([Y, Z], bounds = ((2.0, 3.0), (4.0, 5.0)))
    end
    @test collect(keys(rv)) == [:_X, :_YZ]
    @test OUQBase.getbounds(rv[:_X]) == (0.0, 1.0)
    @test OUQBase.getbounds(rv[:_YZ][1]) == (2.0, 3.0)
    @test OUQBase.getbounds(rv[:_YZ][2]) == (4.0, 5.0)
end
