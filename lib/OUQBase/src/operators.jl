import Symbolics: value
import SymbolicUtils: term

struct 𝔼_ end

const 𝔼 = 𝔼_() # To get same object

# `term` (rather than constructing `Term{T}` directly) picks the SymVariant
# type parameter itself and infers the symbolic type via `promote_symtype`.
(::𝔼_)(x) = term(𝔼, x)
(::𝔼_)(x::Num) = Num(𝔼(value(x)))

SymbolicUtils.promote_symtype(::𝔼_, x) = x
# Disambiguates against SymbolicUtils's generic `promote_symtype(::Operator,
# ::Type{T}) where T`, which is equally specific to the untyped method above
# when called with a `Type` argument (e.g. `symtype(x) === Real`).
SymbolicUtils.promote_symtype(::𝔼_, ::Type{T}) where {T} = T
Base.nameof(::𝔼_) = :𝔼
SymbolicUtils.isbinop(::𝔼_) = false


#=
Note: The following idea doesn't work: one should not store the argument in the functor.
 Since P is also used to store a condition, it should not be a singleton.
We may want to have multiple P expressions each with their own condition.
This makes rule matching harder, we need to test all operators whose type is P.
struct ℙ <: Operator
    condition::Union{Equation, Inequality} #Can we have a vector{Equation} here
    ℙ(condition) = new(condition)
end
=#

struct ℙ_ end

const ℙ = ℙ_() # To get same object

(::ℙ_)(x) = term(ℙ, x)
(::ℙ_)(x::Num) = Num(ℙ(value(x)))

SymbolicUtils.promote_symtype(::ℙ_, x) = x
SymbolicUtils.promote_symtype(::ℙ_, ::Type{T}) where {T} = T
Base.nameof(::ℙ_) = :ℙ
SymbolicUtils.isbinop(::ℙ_) = false

# Indicator function
#= struct 𝟙_ <: Operator end

const 𝟙 = 𝟙_() # To get same object

(::𝟙_)(x) = Term{symtype(x)}(𝟙, Any[x])
(::𝟙_)(x::Num) = Num(𝟙(value(x)))

SymbolicUtils.promote_symtype(::𝟙_, x) = x
Base.nameof(::𝟙_) = :𝟙
SymbolicUtils.isbinop(::𝟙_) = false
 =#
