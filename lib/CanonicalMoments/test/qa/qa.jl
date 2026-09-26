using SciMLTesting, CanonicalMoments, JET, Test

# Full DiscreteMeasures surface reexported so CanonicalMoments users get measures
# without a separate `using DiscreteMeasures`. Documented at DiscreteMeasures.
const DISCRETE_MEASURES_REEXPORTS = (
    :DiscreteMeasure,
    :DiscreteMeasures,
    :ProductDiscreteMeasure,
    :clamp_domain,
    :clamp_weight,
    :expectation,
    :marginals,
    :order,
    :support,
    :weights,
)

run_qa(
    CanonicalMoments;
    explicit_imports = true,
    ei_kwargs = (;
        # `@reexport using DiscreteMeasures` necessarily brings the `DiscreteMeasures`
        # module name (and its `DiscreteMeasure` export, used here) implicitly; the
        # re-export is intentional, so these are not implicit-imports to clean up.
        no_implicit_imports = (; ignore = (:DiscreteMeasures, :DiscreteMeasure)),
    ),
    reexports_allow = DISCRETE_MEASURES_REEXPORTS,
)
