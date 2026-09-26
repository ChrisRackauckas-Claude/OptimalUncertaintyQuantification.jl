using SciMLTesting, OptimalUncertaintyQuantification, JET, Test

# Intentional umbrella reexports: `using OptimalUncertaintyQuantification` is
# meant to surface the OUQBase API (and the CanonicalMoments algorithms OUQBase
# itself reexports). Owned and documented at the defining package; approved here
# so the façade QA does not treat them as accidental public leakage.
const INTENTIONAL_REEXPORTS = (
    Symbol("@random_variables"),
    :AdmissibleSet,
    :EigvalSupportAlg,
    :EigvecWeightAlg,
    :JuMPModel,
    :OUQBase,
    :OUQProblem,
    :OUQSystem,
    :OptimizationModel,
    :Oracle,
    :PolyRootsSupportAlg,
    :PolyWeightAlg,
    :StengerCanonicalMoments,
    :Symbolic,
    :WinklerExtremalMeasures,
    :constraints_map,
    :discrete_measure_map,
    :p_free_map,
    :random_variable_map,
    :raw_moments_map,
    :ℙ,
    :𝔼,
    :𝔼_,
)

run_qa(
    OptimalUncertaintyQuantification;
    explicit_imports = true,
    ei_kwargs = (;
        # `@reexport using OUQBase` necessarily brings the `OUQBase` module name into
        # scope; that re-export is the umbrella package's whole purpose, so the module
        # name is not a genuine implicit-import to clean up.
        no_implicit_imports = (; ignore = (:OUQBase,)),
    ),
    reexports_allow = INTENTIONAL_REEXPORTS,
)

@testset "Reexport surface" begin
    # Keep the allow-list honest: every approved name must actually be public on
    # the umbrella, so the list cannot drift into approving stale bindings.
    @testset "$name" for name in INTENTIONAL_REEXPORTS
        @test name in names(OptimalUncertaintyQuantification)
    end
end
