```@meta
CurrentModule = OUQBase
```

# API

Public surface of `OUQBase`, also reexported by the
`OptimalUncertaintyQuantification` umbrella package.

## Operators

```@docs
𝔼
𝔼_
ℙ
```

## Problem construction

```@docs
@random_variables
AdmissibleSet
OUQSystem
OUQProblem
WinklerExtremalMeasures
StengerCanonicalMoments
```

## Accessors

```@docs
random_variable_map
constraints_map
discrete_measure_map
raw_moments_map
p_free_map
```

## Optimization backends

```@docs
JuMPModel
OptimizationModel
Oracle
Symbolic
```

## Canonical-moment algorithms (reexported)

These are defined in `CanonicalMoments` and reexported by `OUQBase` for
convenience. Their primary documentation lives in the CanonicalMoments manual.

```@docs
EigvalSupportAlg
EigvecWeightAlg
PolyRootsSupportAlg
PolyWeightAlg
```
