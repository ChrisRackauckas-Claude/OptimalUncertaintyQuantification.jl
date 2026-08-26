module SymbolicsExt
using Symbolics
using CanonicalMoments

@register_array_symbolic (alg::CanonicalMoments.EigvalSupportAlg)(M::AbstractMatrix{<:Real}) begin
    size = (size(M)[1],)
    eltype = eltype(M)
end

@register_array_symbolic (alg::CanonicalMoments.EigvecWeightAlg)(M::AbstractMatrix{<:Real}) begin
    size = size(M)
    eltype = eltype(M)
end

# `AbstractVecOrMat` is a `Union` alias, which `@register_array_symbolic` cannot
# introspect; `AbstractArray` covers both the vector and matrix cases.
@register_array_symbolic (alg::CanonicalMoments.EigvecWeightAlg)(
    M::AbstractMatrix{<:Real},
    λ::AbstractArray{<:Real},
) begin
    size = size(M)
    eltype = eltype(M)
end

# Registering the companion matrix constructor keeps it lazy for symbolic inputs
# while deferring to the numeric implementation otherwise.
@register_array_symbolic CanonicalMoments._companion_matrix(
    B::AbstractVector{<:Real},
    C::AbstractVector{<:Real},
) begin
    size = (length(B), length(B))
    eltype = Real
end

end
