using SciMLTesting, OUQBase, JET, Test

# CanonicalMoments algorithms reexported so OUQBase users need not depend on
# CanonicalMoments directly; documented at CanonicalMoments.
const CANONICAL_MOMENTS_REEXPORTS = (
    :EigvalSupportAlg,
    :EigvecWeightAlg,
    :PolyRootsSupportAlg,
    :PolyWeightAlg,
)

run_qa(
    OUQBase;
    explicit_imports = true,
    ei_kwargs = (;
        # Explicit imports of names that are non-public in the upstream majors OUQBase
        # actually resolves (public declarations landed in later majors that [compat]
        # excludes).
        #   :BasicSymbolic/:Term/:symtype/:Operator - SymbolicUtils
        #   :value                                  - Symbolics
        all_explicit_imports_are_public = (;
            ignore = (:BasicSymbolic, :Operator, :Term, :symtype, :value),
        ),
        # Non-public qualified accesses into upstream packages; still non-public in the
        # resolved upstream majors:
        #   :BasicSymbolic/:isbinop/:promote_symtype - SymbolicUtils
        #   :evaluate/:geq/:leq                      - Symbolics
        #   :getdefault                              - ModelingToolkit
        #   :NoAD/:NullParameters                    - SciMLBase
        all_qualified_accesses_are_public = (;
            ignore = (
                :BasicSymbolic, :NoAD, :NullParameters, :evaluate, :geq, :getdefault,
                :isbinop, :leq, :promote_symtype,
            ),
        ),
    ),
    reexports_allow = CANONICAL_MOMENTS_REEXPORTS,
)
