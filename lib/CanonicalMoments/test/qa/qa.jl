using SciMLTesting, CanonicalMoments, JET, Test

# Full DiscreteMeasures surface reexported so CanonicalMoments users get measures
# without a separate `using DiscreteMeasures`. Documented at DiscreteMeasures.
# `denominator`/`numerator` are Base bindings that CanonicalMoments extends for
# `StieltjesTransform` and re-exports as part of the public moment API.
const DISCRETE_MEASURES_REEXPORTS = (
    :DiscreteMeasure,
    :DiscreteMeasures,
    :ProductDiscreteMeasure,
    :clamp_domain,
    :clamp_weight,
    :denominator,
    :expectation,
    :marginals,
    :numerator,
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
