module OptimalUncertaintyQuantification

using Reexport: @reexport
@reexport using OUQBase

# `@random_variables` expands to code that references `Symbolics.@variables`
# in the caller's scope (via `esc`), so `Symbolics` must be bound here for the
# precompile workload below to expand successfully.
using Symbolics: Symbolics

using PrecompileTools: @compile_workload, @setup_workload

@setup_workload begin
    @compile_workload begin
        random_vars = @random_variables begin
            Independent(Q, bounds = (0.0, 1.0))
        end
        admissible_set = AdmissibleSet(random_vars, [𝔼(Q) ~ 0.5])
        OUQSystem(;
            objective = 𝔼(Q),
            admissible_set,
            reduction_alg = WinklerExtremalMeasures(),
        )
    end
end

end # module
