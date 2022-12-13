"""
Use the `alloc_half_mms` from the `Allocations` package to allocate all gods and cake as if they were indivisible.
`num_pieces` is how many cuts to make in each cake.
"""
function alloc_half_mms(instance::Instance, num_pieces::Int=1)
    converted = to_Allocations(instance, num_pieces)

    # Allocate using the Allocation Package
    alloc = Allocations.alloc_half_mms(converted.additive, converted.counts)

    allocation = from_Allocations(alloc, instance, num_pieces)

    return allocation
end